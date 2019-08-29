Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E88C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081EB233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102675;
	bh=gVurG7BIl7P94A8jKlwa4onRdMssNry3RH32zz0KsOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lX5XUNQ34L8TnHy0/GQMrq8T8ld6bREewb2Swd/RQCd53jIupvHrsdJuwJZUhlybK
	 Z94a8FN02VGceLZgovPs+YsGLA1hFDqYIhUwFlNeFusexB4LpAkk/A6rrk4d4fjLH2
	 YrLRiIJy3rRZXwsoXCFc0YM5XCCXC2poh4wwdKe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfH2SRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730164AbfH2SRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:17:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50922339E;
        Thu, 29 Aug 2019 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102663;
        bh=gVurG7BIl7P94A8jKlwa4onRdMssNry3RH32zz0KsOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YgnO7mN3d9Cx3RLLpu3uMmnJG6n2lHXQOuwwkyicvR5AuxmWdbvHB9ahGiz8dkF3i
         kfu/vjwXrISCOo6UGmYSOXGQ4wNTMwtYXIZdRNfaBKCmuWMSsYPyX+IQ/jpBDnIQfi
         0eETscgv0bsuaxvsPLSF6d42L76rLnDTh4hZuHsc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Falcon <tlfalcon@linux.ibm.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.9 04/16] ibmveth: Convert multicast list size for little-endian system
Date:   Thu, 29 Aug 2019 14:17:22 -0400
Message-Id: <20190829181736.9040-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181736.9040-1-sashal@kernel.org>
References: <20190829181736.9040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 66cf4710b23ab2adda11155684a2c8826f4fe732 ]

The ibm,mac-address-filters property defines the maximum number of
addresses the hypervisor's multicast filter list can support. It is
encoded as a big-endian integer in the OF device tree, but the virtual
ethernet driver does not convert it for use by little-endian systems.
As a result, the driver is not behaving as it should on affected systems
when a large number of multicast addresses are assigned to the device.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmveth.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 955f658f3b65f..de9897c8e9331 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1557,7 +1557,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	struct net_device *netdev;
 	struct ibmveth_adapter *adapter;
 	unsigned char *mac_addr_p;
-	unsigned int *mcastFilterSize_p;
+	__be32 *mcastFilterSize_p;
 	long ret;
 	unsigned long ret_attr;
 
@@ -1579,8 +1579,9 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		return -EINVAL;
 	}
 
-	mcastFilterSize_p = (unsigned int *)vio_get_attribute(dev,
-						VETH_MCAST_FILTER_SIZE, NULL);
+	mcastFilterSize_p = (__be32 *)vio_get_attribute(dev,
+							VETH_MCAST_FILTER_SIZE,
+							NULL);
 	if (!mcastFilterSize_p) {
 		dev_err(&dev->dev, "Can't find VETH_MCAST_FILTER_SIZE "
 			"attribute\n");
@@ -1597,7 +1598,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	adapter->vdev = dev;
 	adapter->netdev = netdev;
-	adapter->mcastFilterSize = *mcastFilterSize_p;
+	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	adapter->pool_config = 0;
 
 	netif_napi_add(netdev, &adapter->napi, ibmveth_poll, 16);
-- 
2.20.1

