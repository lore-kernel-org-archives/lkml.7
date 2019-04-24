Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15049C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC521218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127886;
	bh=y2epICeCxunUyvQ61sIrcQaQndjGxnCY+evdR3Wqg7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dZHZSq06+WE7g6ZBd4+ty/EFt8F/6SWdAjdpJ2h/vIVcrLrn1lPeNv7xSVpf8U3VK
	 +uVHe+BF3DhpvuiICabdRxgKom0M1g8Jw+tnJxq5qGkZ/FcDE0GwHzCx/d/ygvsKQl
	 tchkRJzIoTkng/qbYalauyG0ZIr2MZAjsalrOYuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbfDXReH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:32936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391625AbfDXReD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:03 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EB72054F;
        Wed, 24 Apr 2019 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127242;
        bh=y2epICeCxunUyvQ61sIrcQaQndjGxnCY+evdR3Wqg7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HvlSDh1LuB7OkrjVos8g0FjEQQybW3g87FpNZulwytJok9BPwLPe/AdwDlUn5zvfD
         HEKFScMaTQFTsMiHj0Zyt+T80d0NZAatMc7m1KFn/IcEdr0jI/kY67Xtgw3wXS0FTD
         IQM7L+OOEgk4K3Kpiot2Vda5HYb9bV3BOZkDCx6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 002/115] failover: allow name change on IFF_UP slave interfaces
Date:   Wed, 24 Apr 2019 19:08:58 +0200
Message-Id: <20190424170925.052470047@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Si-Wei Liu <si-wei.liu@oracle.com>

[ Upstream commit 8065a779f17e94536a1c4dcee4f9d88011672f97 ]

When a netdev appears through hot plug then gets enslaved by a failover
master that is already up and running, the slave will be opened
right away after getting enslaved. Today there's a race that userspace
(udev) may fail to rename the slave if the kernel (net_failover)
opens the slave earlier than when the userspace rename happens.
Unlike bond or team, the primary slave of failover can't be renamed by
userspace ahead of time, since the kernel initiated auto-enslavement is
unable to, or rather, is never meant to be synchronized with the rename
request from userspace.

As the failover slave interfaces are not designed to be operated
directly by userspace apps: IP configuration, filter rules with
regard to network traffic passing and etc., should all be done on master
interface. In general, userspace apps only care about the
name of master interface, while slave names are less important as long
as admin users can see reliable names that may carry
other information describing the netdev. For e.g., they can infer that
"ens3nsby" is a standby slave of "ens3", while for a
name like "eth0" they can't tell which master it belongs to.

Historically the name of IFF_UP interface can't be changed because
there might be admin script or management software that is already
relying on such behavior and assumes that the slave name can't be
changed once UP. But failover is special: with the in-kernel
auto-enslavement mechanism, the userspace expectation for device
enumeration and bring-up order is already broken. Previously initramfs
and various userspace config tools were modified to bypass failover
slaves because of auto-enslavement and duplicate MAC address. Similarly,
in case that users care about seeing reliable slave name, the new type
of failover slaves needs to be taken care of specifically in userspace
anyway.

It's less risky to lift up the rename restriction on failover slave
which is already UP. Although it's possible this change may potentially
break userspace component (most likely configuration scripts or
management software) that assumes slave name can't be changed while
UP, it's relatively a limited and controllable set among all userspace
components, which can be fixed specifically to listen for the rename
events on failover slaves. Userspace component interacting with slaves
is expected to be changed to operate on failover master interface
instead, as the failover slave is dynamic in nature which may come and
go at any point.  The goal is to make the role of failover slaves less
relevant, and userspace components should only deal with failover master
in the long run.

Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Acked-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdevice.h |    3 +++
 net/core/dev.c            |   16 +++++++++++++++-
 net/core/failover.c       |    6 +++---
 3 files changed, 21 insertions(+), 4 deletions(-)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1484,6 +1484,7 @@ struct net_device_ops {
  * @IFF_FAILOVER: device is a failover master device
  * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
  * @IFF_L3MDEV_RX_HANDLER: only invoke the rx handler of L3 master device
+ * @IFF_LIVE_RENAME_OK: rename is allowed while device is up and running
  */
 enum netdev_priv_flags {
 	IFF_802_1Q_VLAN			= 1<<0,
@@ -1516,6 +1517,7 @@ enum netdev_priv_flags {
 	IFF_FAILOVER			= 1<<27,
 	IFF_FAILOVER_SLAVE		= 1<<28,
 	IFF_L3MDEV_RX_HANDLER		= 1<<29,
+	IFF_LIVE_RENAME_OK		= 1<<30,
 };
 
 #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
@@ -1547,6 +1549,7 @@ enum netdev_priv_flags {
 #define IFF_FAILOVER			IFF_FAILOVER
 #define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
 #define IFF_L3MDEV_RX_HANDLER		IFF_L3MDEV_RX_HANDLER
+#define IFF_LIVE_RENAME_OK		IFF_LIVE_RENAME_OK
 
 /**
  *	struct net_device - The DEVICE structure.
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1184,7 +1184,21 @@ int dev_change_name(struct net_device *d
 	BUG_ON(!dev_net(dev));
 
 	net = dev_net(dev);
-	if (dev->flags & IFF_UP)
+
+	/* Some auto-enslaved devices e.g. failover slaves are
+	 * special, as userspace might rename the device after
+	 * the interface had been brought up and running since
+	 * the point kernel initiated auto-enslavement. Allow
+	 * live name change even when these slave devices are
+	 * up and running.
+	 *
+	 * Typically, users of these auto-enslaving devices
+	 * don't actually care about slave name change, as
+	 * they are supposed to operate on master interface
+	 * directly.
+	 */
+	if (dev->flags & IFF_UP &&
+	    likely(!(dev->priv_flags & IFF_LIVE_RENAME_OK)))
 		return -EBUSY;
 
 	write_seqcount_begin(&devnet_rename_seq);
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -80,14 +80,14 @@ static int failover_slave_register(struc
 		goto err_upper_link;
 	}
 
-	slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
+	slave_dev->priv_flags |= (IFF_FAILOVER_SLAVE | IFF_LIVE_RENAME_OK);
 
 	if (fops && fops->slave_register &&
 	    !fops->slave_register(slave_dev, failover_dev))
 		return NOTIFY_OK;
 
 	netdev_upper_dev_unlink(slave_dev, failover_dev);
-	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
+	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_LIVE_RENAME_OK);
 err_upper_link:
 	netdev_rx_handler_unregister(slave_dev);
 done:
@@ -121,7 +121,7 @@ int failover_slave_unregister(struct net
 
 	netdev_rx_handler_unregister(slave_dev);
 	netdev_upper_dev_unlink(slave_dev, failover_dev);
-	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
+	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_LIVE_RENAME_OK);
 
 	if (fops && fops->slave_unregister &&
 	    !fops->slave_unregister(slave_dev, failover_dev))


