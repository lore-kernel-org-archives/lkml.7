Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD1FC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030A72081B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947492;
	bh=ulD0vVxQlhyjPEc/rD8TYddeF/qBdx2S7MVaT/wMcTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0maRTz1XDVUiWu3snGBNO2RBO6PozS0WQXQQZCW5TfVSzWg+Xtp79oZMIUPLT96JV
	 mjuDyShd59gI5UiXWTWjuGYlw+degWwzaWFpK0YMQ7hWNur1Sc8iQ8YlMWNzNqUIwO
	 DofLszRawqWJzN8R43/TY9daF1avRZ/C+Gfl/QPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfIHM6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:35670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbfIHMrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:47:22 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6505D218AC;
        Sun,  8 Sep 2019 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946841;
        bh=ulD0vVxQlhyjPEc/rD8TYddeF/qBdx2S7MVaT/wMcTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zmqq5yoe+f8j1ZnJimdMXMfgUWxJEdonf3pdrhZRsX8Xmr2xNSpttdW0xUItuaQuZ
         5d8UYSOFPSb5qTQXZ8QU5sPvdMzbJrp6Fe1z8f5Wwa78msj0nqDFY8SPykwFfMy7ZM
         k0z6sF7Zx1sisUq4SzMSaEL5wqs79qQ6eb6A01Po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/57] ibmveth: Convert multicast list size for little-endian system
Date:   Sun,  8 Sep 2019 13:41:44 +0100
Message-Id: <20190908121134.287965367@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index f70cb4d3c6846..40ad1e5032553 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1618,7 +1618,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	struct net_device *netdev;
 	struct ibmveth_adapter *adapter;
 	unsigned char *mac_addr_p;
-	unsigned int *mcastFilterSize_p;
+	__be32 *mcastFilterSize_p;
 	long ret;
 	unsigned long ret_attr;
 
@@ -1640,8 +1640,9 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
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
@@ -1658,7 +1659,7 @@ static int ibmveth_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	adapter->vdev = dev;
 	adapter->netdev = netdev;
-	adapter->mcastFilterSize = *mcastFilterSize_p;
+	adapter->mcastFilterSize = be32_to_cpu(*mcastFilterSize_p);
 	adapter->pool_config = 0;
 
 	netif_napi_add(netdev, &adapter->napi, ibmveth_poll, 16);
-- 
2.20.1



