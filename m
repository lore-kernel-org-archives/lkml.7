Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6CAC2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71722208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 22:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lrPzsUsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfL0WoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:44:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27636 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbfL0WoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 17:44:10 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBRMdrDJ020386
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 14:44:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=PBpHMpBlV1Aa9DOQjEjFsW6rz8psMCEge3KgMqaCmYA=;
 b=lrPzsUsN8trOHVNY/3K3rUSVazEB/JfWYylLxGWtz8UBx1T5S2IgdDF5lWcb28SxDj02
 dq3UXpVLJodTut6uO83M1g1lKv8guIA1NL/JgEuJ8lAg8fRsZrHX3Cbjm9NOir6UoP9u
 6akT/qzOWLJQ4tQnmbc6z6sa+h9pebUgrZs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2x4wu7wqpv-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 14:44:09 -0800
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 27 Dec 2019 14:44:07 -0800
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 32C8418FE1EBC; Fri, 27 Dec 2019 14:44:06 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>, <joel@jms.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <sdasari@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [net-next PATCH] net/ncsi: Fix gma flag setting after response
Date:   Fri, 27 Dec 2019 14:43:49 -0800
Message-ID: <20191227224349.2182366-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-27_07:2019-12-24,2019-12-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=831 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912270181
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gma_flag was set at the time of GMA command request but it should
only be set after getting successful response. Movinng this flag
setting in GMA response handler.

This flag is used mainly for not repeating GMA command once
received MAC address.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 net/ncsi/ncsi-manage.c | 3 ---
 net/ncsi/ncsi-rsp.c    | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 70fe02697544..e20b81514029 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -764,9 +764,6 @@ static int ncsi_gma_handler(struct ncsi_cmd_arg *nca, unsigned int mf_id)
 		return -1;
 	}
 
-	/* Set the flag for GMA command which should only be called once */
-	nca->ndp->gma_flag = 1;
-
 	/* Get Mac address from NCSI device */
 	return nch->handler(nca);
 }
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index d5611f04926d..a94bb59793f0 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -627,6 +627,9 @@ static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
 	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET], ETH_ALEN);
+	/* Set the flag for GMA command which should only be called once */
+	ndp->gma_flag = 1;
+
 	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
@@ -671,6 +674,9 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
 	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
 		return -ENXIO;
 
+	/* Set the flag for GMA command which should only be called once */
+	ndp->gma_flag = 1;
+
 	ret = ops->ndo_set_mac_address(ndev, &saddr);
 	if (ret < 0)
 		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-- 
2.17.1

