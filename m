Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C6BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1193E2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nu/rimeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfCYHsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:48:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49940 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729829AbfCYHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:48:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P7iTLW109622;
        Mon, 25 Mar 2019 07:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=ZzPP1Q80oZYXtz0DutAUmGdavzK5I/DAdFRhvpBi/eM=;
 b=Nu/rimeZrMg2HU+cGodSq5FaEKEwCpYVIwt4WSPLbLUSzWmiYYEJWrEpL9uah90YhnLU
 IN35a+FhszNgYnRml5kVhsOollNO3Jos2bpEPCW4lDZceQzVyvqgGHaGmKPdi8cJAhJm
 ++nS95w322ZmjnYn/7Ykqa+gtEp2WsGE4o0SoR+NuVtaSGHjCyNSE7nItsLJMKDMIuQz
 tRmzp1q1zmyyQ64B1TDtiMoiuQo7rcGFb/kKaQ4lw82+ZIOVjfIzU4MYvv2ryJrw3MnV
 zjgAjLigBNxFz3yQOrTymmkrh51gTqjTjOVjjfKpCN5TxF90jLE93Oo/ZonWSypHPkwM aQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2re6dj2c02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:48:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P7mBuk023690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:48:11 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2P7mAi6002238;
        Mon, 25 Mar 2019 07:48:10 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 00:48:10 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ses: fix some risks of out of bound access
Date:   Mon, 25 Mar 2019 15:40:02 +0800
Message-Id: <1553499602-27810-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=881 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some places with risk of accessing out of bound of the
buffer allocated from slab, even it could corrupt the memory.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/ses.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
index 0fc3922..42e6a1f 100644
--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -520,6 +520,7 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 	struct ses_device *ses_dev = edev->scratch;
 	int types = ses_dev->page1_num_types;
 	unsigned char *hdr_buf = kzalloc(INIT_ALLOC_SIZE, GFP_KERNEL);
+	unsigned char *page1_end = ses_dev->page1 + ses_dev->page1_len;
 
 	if (!hdr_buf)
 		goto simple_populate;
@@ -556,6 +557,11 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 	type_ptr = ses_dev->page1_types;
 	components = 0;
 	for (i = 0; i < types; i++, type_ptr += 4) {
+		if (type_ptr > page1_end - 2) {
+			sdev_printk(KERN_ERR, sdev, "Access out of bound of page1"
+					"%p page1_end %p\n", page1_end, type_ptr);
+			break;
+		}
 		for (j = 0; j < type_ptr[1]; j++) {
 			char *name = NULL;
 			struct enclosure_component *ecomp;
@@ -566,10 +572,15 @@ static void ses_enclosure_data_process(struct enclosure_device *edev,
 				} else {
 					len = (desc_ptr[2] << 8) + desc_ptr[3];
 					desc_ptr += 4;
-					/* Add trailing zero - pushes into
-					 * reserved space */
-					desc_ptr[len] = '\0';
-					name = desc_ptr;
+					if (desc_ptr + len >= buf + page7_len) {
+						desc_ptr = NULL;
+					} else {
+
+						/* Add trailing zero - pushes into
+						 * reserved space */
+						desc_ptr[len] = '\0';
+						name = desc_ptr;
+					}
 				}
 			}
 			if (type_ptr[0] == ENCLOSURE_COMPONENT_DEVICE ||
@@ -693,7 +704,13 @@ static int ses_intf_add(struct device *cdev,
 	/* begin at the enclosure descriptor */
 	type_ptr = buf + 8;
 	/* skip all the enclosure descriptors */
-	for (i = 0; i < num_enclosures && type_ptr < buf + len; i++) {
+	for (i = 0; i < num_enclosures; i++) {
+		if (type_ptr >= buf + len) {
+			sdev_printk(KERN_ERR, sdev, "Overflow the buf len = %d\n", len);
+			err = -EINVAL;
+			goto err_free;
+		}
+
 		types += type_ptr[2];
 		type_ptr += type_ptr[3] + 4;
 	}
-- 
2.7.4

