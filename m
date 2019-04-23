Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F8AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA555218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 05:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f0SX9uln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfDXFO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 01:14:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60096 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbfDXFO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 01:14:29 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O5ENWx003881
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 22:14:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=FKM86vzGVWMsHvjlcaHnvMjzrwLXYOENyblxu5Zhi2w=;
 b=f0SX9ulnzjlPagikhdDxMKJRzRo4yrdz1V8J/hi1Jj7/0FMWToqhMsLKJ+vXR3L434g4
 4Q/lmF+66FxObV+sdkQG3s3EMi8/9dMFTzjSXmz/WoepGbaPF7zjYvKjsurqMW5M6Q04
 0YNE7u6cMcQv9kjkhHfC+jE2ErdEUzi4G9k= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s24kek627-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 22:14:27 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 23 Apr 2019 22:14:27 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id C2A9C13BA5DE1; Tue, 23 Apr 2019 14:20:49 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     "David S . Miller" <davem@davemloft.net>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH net v2 2/2] net/ncsi: handle overflow when incrementing mac address
Date:   Tue, 23 Apr 2019 14:20:48 -0700
Message-ID: <20190423212048.1984122-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously BMC's MAC address is calculated by simply adding 1 to the
last byte of network controller's MAC address, and it produces incorrect
result when network controller's MAC address ends with 0xFF.

The problem can be fixed by calling "net_addr_inc" function to increment
MAC address; besides, the MAC address is also validated before assigning
to BMC.

Fixes: cb10c7c0dfd9 ("net/ncsi: Add NCSI Broadcom OEM command")
Signed-off-by: Tao Ren <taoren@fb.com>
---
 net/ncsi/ncsi-rsp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Changes in v2:
 - increment MAC address by calling net_addr_inc function.
 - validate MAC address before assigning to BMC.

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index dc07fcc7938e..802db01e3075 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
+#include <linux/etherdevice.h>
 #include <linux/skbuff.h>
 
 #include <net/ncsi.h>
@@ -667,7 +668,10 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
 	/* Increase mac address by 1 for BMC's address */
-	saddr.sa_data[ETH_ALEN - 1]++;
+	eth_addr_inc((u8 *)saddr.sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		return -ENXIO;
+
 	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-- 
2.17.1

