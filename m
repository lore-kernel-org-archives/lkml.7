Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B13C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203FC214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 17:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Sjg8klS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfDVR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:28:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39916 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbfDVR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 13:28:04 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3MHIXa2009292
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:28:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ggkFPjU/Ne5UtSggqEaeg9mpDeASwYIDmOn8efG8i/Q=;
 b=Sjg8klS96z95lPkfZvb1uVAu9t+BpLLT5PMA0enSq0u2AKGnYpFqGk/bG09Z96FE8o44
 gUyfHeXwy9oejNED2421021fUwQqCNNummPpRS+413+6H5kAgkj+ZkIuiUIvacjmrndL
 xroJaemAWIG6e2fU3IHYMKnKD3op8evvbUM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2ryy3cqaf2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 10:28:03 -0700
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 22 Apr 2019 10:27:57 -0700
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id DFEF413A2728A; Mon, 22 Apr 2019 10:27:56 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <openbmc@lists.ozlabs.org>
CC:     Tao Ren <taoren@fb.com>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH net] net/ncsi: handle overflow when incrementing mac address
Date:   Mon, 22 Apr 2019 10:27:54 -0700
Message-ID: <20190422172754.1011894-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
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
The problem is fixed by detecting integer overflow when incrementing MAC
address and adding the carry bit (if any) to the next/left bytes of the
MAC address.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 net/ncsi/ncsi-rsp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index dc07fcc7938e..eb42bbdb7501 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -658,7 +658,8 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
 	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
-	int ret = 0;
+	int ret, offset;
+	u16 carry = 1;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
@@ -667,7 +668,12 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
 	/* Increase mac address by 1 for BMC's address */
-	saddr.sa_data[ETH_ALEN - 1]++;
+	offset = ETH_ALEN - 1;
+	do {
+		carry += (u8)saddr.sa_data[offset];
+		saddr.sa_data[offset] = (char)carry;
+		carry = carry >> 8;
+	} while (carry != 0 && --offset >= 0);
 	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-- 
2.17.1

