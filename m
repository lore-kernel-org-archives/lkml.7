Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80641C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BA521955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XR/oQdO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfGVQPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:15:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39620 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfGVQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:15:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MG8q1q149978;
        Mon, 22 Jul 2019 16:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=sNykf3duT3KzCBKfLuPVcEcJgxJJOt5PG7Ky6LhfGBg=;
 b=XR/oQdO9LakeOCRh/4OvsUlJDwl6jZsNIYKc4VPLBaFYaWTvoqTm3xXl7zb8Zb1QLXSU
 f6qV4NRSJg3v4vk9boMV5VkY2UXszzyDpb+4sF3KATZeTooaPBtPjtyABtph6jGEyJ1l
 NSwfXX3UtacfyWaojdFPZlwcJlQL7e11HvBDvcHpFVM8bmXiQbH1j2dvI6P2RypGz6fV
 ymYxBBjsQgFldbp8SWIZWOR0zQOHSXkqhqukb9W9AmF+M3XKVbnO79ljtEkzLB2uYXo4
 Iw2YpQz+B0Ytk1yoi8k0tGUANShgQl+3n9wde7G0e77BBMWitoqepyxGj+Baoz7Hcvl5 VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tuukqft2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 16:15:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MG8Knj034407;
        Mon, 22 Jul 2019 16:15:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tut9mbtt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 16:15:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6MGFH9E032465;
        Mon, 22 Jul 2019 16:15:18 GMT
Received: from jubi-laptop.us.oracle.com (/10.11.23.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 09:15:17 -0700
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        martin.petersen@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH RESEND] scsi: megaraid_sas: fix panic on loading firmware crashdump
Date:   Mon, 22 Jul 2019 09:15:24 -0700
Message-Id: <20190722161524.23192-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=740
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9325 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=786 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While loading fw crashdump in function fw_crash_buffer_show(),
left bytes in one dma chunk was not checked, if copying size
over it, overflow access will cause kernel panic.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 80ab9700f1de..3eef0858fa8e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3153,6 +3153,7 @@ fw_crash_buffer_show(struct device *cdev,
 		(struct megasas_instance *) shost->hostdata;
 	u32 size;
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
+	unsigned long chunk_left_bytes;
 	unsigned long src_addr;
 	unsigned long flags;
 	u32 buff_offset;
@@ -3176,6 +3177,8 @@ fw_crash_buffer_show(struct device *cdev,
 	}
 
 	size = (instance->fw_crash_buffer_size * dmachunk) - buff_offset;
+	chunk_left_bytes = dmachunk - (buff_offset % dmachunk);
+	size = (size > chunk_left_bytes) ? chunk_left_bytes : size;
 	size = (size >= PAGE_SIZE) ? (PAGE_SIZE - 1) : size;
 
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
-- 
2.17.1

