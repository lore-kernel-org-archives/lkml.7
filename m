Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA678C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FFD20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128632;
	bh=aWDgZ1ZkB58kfQsuASQL7ZzpZ2LQFvm9YX4FzT5Ia3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f+FYO55ZzCkCw+WK+sd0LgihtvSiYLgXU0LGyFmwtqDVDw8DVgrmzVU7CrV4MT2RP
	 07Ugfp921r7EqPbocPFSlQLfO3QCB4FED7jmvzNCpSd+I2yrOXrwOfFWPl/JXVvEWV
	 zmMik/AufWVmYw1azDDe0CeTHmkcJ4uf1h7nQz08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbfDXR0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390169AbfDXR0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:26:12 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17BB5206BA;
        Wed, 24 Apr 2019 17:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126771;
        bh=aWDgZ1ZkB58kfQsuASQL7ZzpZ2LQFvm9YX4FzT5Ia3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZJZoHQyQ1IwmyQZUpvRXmJHp0oT1dEgMBXu8iF8y/P9SI+DoQer6twhee3jtlhAm
         eQflCgMIK/g4gIbI3+9rZkVsNw+DVPURu9ZaQIj/RcS2cIdZ1MV5/0jKqn6l1ciZ+s
         5Zh1OyCX/0bv5Q2frv1XjgLaJbt3YbCmyEkaW0+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matteo Croce <mcroce@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 11/70] net: thunderx: raise XDP MTU to 1508
Date:   Wed, 24 Apr 2019 19:09:31 +0200
Message-Id: <20190424170908.927531295@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit 5ee15c101f29e0093ffb5448773ccbc786eb313b ]

The thunderx driver splits frames bigger than 1530 bytes to multiple
pages, making impossible to run an eBPF program on it.
This leads to a maximum MTU of 1508 if QinQ is in use.

The thunderx driver forbids to load an eBPF program if the MTU is higher
than 1500 bytes. Raise the limit to 1508 so it is possible to use L2
protocols which need some more headroom.

Fixes: 05c773f52b96e ("net: thunderx: Add basic XDP support")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -29,6 +29,13 @@
 #define DRV_NAME	"thunder-nicvf"
 #define DRV_VERSION	"1.0"
 
+/* NOTE: Packets bigger than 1530 are split across multiple pages and XDP needs
+ * the buffer to be contiguous. Allow XDP to be set up only if we don't exceed
+ * this value, keeping headroom for the 14 byte Ethernet header and two
+ * VLAN tags (for QinQ)
+ */
+#define MAX_XDP_MTU	(1530 - ETH_HLEN - VLAN_HLEN * 2)
+
 /* Supported devices */
 static const struct pci_device_id nicvf_id_table[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_CAVIUM,
@@ -1702,8 +1709,10 @@ static int nicvf_xdp_setup(struct nicvf
 	bool bpf_attached = false;
 	int ret = 0;
 
-	/* For now just support only the usual MTU sized frames */
-	if (prog && (dev->mtu > 1500)) {
+	/* For now just support only the usual MTU sized frames,
+	 * plus some headroom for VLAN, QinQ.
+	 */
+	if (prog && dev->mtu > MAX_XDP_MTU) {
 		netdev_warn(dev, "Jumbo frames not yet supported with XDP, current MTU %d.\n",
 			    dev->mtu);
 		return -EOPNOTSUPP;


