Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D137206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Q8TEcZp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfDDSrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:47:23 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:16048 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729456AbfDDSrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1554403635; x=1585939635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=blPiuQw5mEA1nphC4CI7CGPcz/CtVQvVInVQvGTr75M=;
  b=Q8TEcZp2hUHRbQClnJBFM6nG+TQeuKdWkiHXjhdsxmM2X5YbZ+v+RAxl
   Va+f/U9yUxB91fqJDOf+rd/l38gf3GUZ+fsk+KduuuXGs9QL9mEDTUvIZ
   sqcyEA+tTPoGkXBS68vZfbIyaBgoZkPNFJiWx3ayC+6bZ/Yhvc1NjsQOS
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EABQAuTqZchyWd50NlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBZQKBKYJRJ4wsXaUNgXoOAQGEbAKFTiI8AgwBAQMBAQkBAwIBAQIQAQE?=
 =?us-ascii?q?BFQkIKS+COikBgmgCAQMSFVIQUVcZIoMAgXaiEz0Cb4EBiQcBAQGBazOKL4E?=
 =?us-ascii?q?wAQGGaYRIgVc/hGGEDYEEhRQDkl2TDQcCgk8EkScCGIF1klqfPwIEAgQFAhW?=
 =?us-ascii?q?BfQmBWHCDPIIkjkYhATKOG4JNAQE?=
X-IPAS-Result: =?us-ascii?q?A2EABQAuTqZchyWd50NlHAEBAQQBAQcEAQGBZQKBKYJRJ?=
 =?us-ascii?q?4wsXaUNgXoOAQGEbAKFTiI8AgwBAQMBAQkBAwIBAQIQAQEBFQkIKS+COikBg?=
 =?us-ascii?q?mgCAQMSFVIQUVcZIoMAgXaiEz0Cb4EBiQcBAQGBazOKL4EwAQGGaYRIgVc/h?=
 =?us-ascii?q?GGEDYEEhRQDkl2TDQcCgk8EkScCGIF1klqfPwIEAgQFAhWBfQmBWHCDPIIkj?=
 =?us-ascii?q?kYhATKOG4JNAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2019 13:47:14 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34ISMQ6043163;
        Thu, 4 Apr 2019 14:47:16 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2rnn028y88-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 14:47:15 -0400
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.60,309,1549951200"; 
   d="scan'208";a="337561725"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     linux-usb@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hayeswang@realtek.com,
        sjg@google.com, campello@google.com,
        Ryan Hong <Ryan.Hong@Dell.com>, Crag Wang <Crag.Wang@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v2 1/2] r8152: remove extra action copying ethernet address
Date:   Thu,  4 Apr 2019 13:46:52 -0500
Message-Id: <1554403613-5970-2-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554403613-5970-1-git-send-email-mario.limonciello@dell.com>
References: <1554403613-5970-1-git-send-email-mario.limonciello@dell.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=750 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This already happens later on in `rtl8152_set_mac_address`

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/usb/r8152.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 86c8c64..dc1bfff 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1212,7 +1212,6 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
 		goto amacout;
 	}
 	memcpy(sa->sa_data, buf, 6);
-	ether_addr_copy(tp->netdev->dev_addr, sa->sa_data);
 	netif_info(tp, probe, tp->netdev,
 		   "Using pass-thru MAC addr %pM\n", sa->sa_data);
 
-- 
2.7.4

