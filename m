Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECA8C19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C292083B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 00:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbfHBABR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 20:01:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390508AbfHBABQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 20:01:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NvAYL107313;
        Thu, 1 Aug 2019 20:00:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u49bthghp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 20:00:59 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x71Nx1od110677;
        Thu, 1 Aug 2019 20:00:58 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u49bthgh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Aug 2019 20:00:58 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7200uEg021477;
        Fri, 2 Aug 2019 00:00:57 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2u0e87hkec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Aug 2019 00:00:57 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7200ujJ53608828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Aug 2019 00:00:56 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6B7BAC066;
        Fri,  2 Aug 2019 00:00:56 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52CDAAC069;
        Fri,  2 Aug 2019 00:00:55 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.147])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Aug 2019 00:00:55 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Dennis Zhou <dennis@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/1] block: Use bits.h macros to improve readability
Date:   Thu,  1 Aug 2019 21:00:41 -0300
Message-Id: <20190802000041.24513-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applies some bits.h macros in order to improve readability of
linux/blk_types.h.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 include/linux/blk_types.h | 55 ++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 95202f80676c..31c8c6d274f6 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/bvec.h>
 #include <linux/ktime.h>
+#include <linux/bits.h>
 
 struct bio_set;
 struct bio;
@@ -101,13 +102,13 @@ static inline bool blk_path_error(blk_status_t error)
 #define BIO_ISSUE_SIZE_BITS     12
 #define BIO_ISSUE_RES_SHIFT     (64 - BIO_ISSUE_RES_BITS)
 #define BIO_ISSUE_SIZE_SHIFT    (BIO_ISSUE_RES_SHIFT - BIO_ISSUE_SIZE_BITS)
-#define BIO_ISSUE_TIME_MASK     ((1ULL << BIO_ISSUE_SIZE_SHIFT) - 1)
+#define BIO_ISSUE_TIME_MASK     GENMASK_ULL(BIO_ISSUE_SIZE_SHIFT - 1, 0)
 #define BIO_ISSUE_SIZE_MASK     \
-	(((1ULL << BIO_ISSUE_SIZE_BITS) - 1) << BIO_ISSUE_SIZE_SHIFT)
-#define BIO_ISSUE_RES_MASK      (~((1ULL << BIO_ISSUE_RES_SHIFT) - 1))
+	GENMASK_ULL(BIO_ISSUE_RES_SHIFT - 1, BIO_ISSUE_SIZE_SHIFT)
+#define BIO_ISSUE_RES_MASK      GENMASK_ULL(64, BIO_ISSUE_RES_SHIFT)
 
 /* Reserved bit for blk-throtl */
-#define BIO_ISSUE_THROTL_SKIP_LATENCY (1ULL << 63)
+#define BIO_ISSUE_THROTL_SKIP_LATENCY   BIT_ULL(63)
 
 struct bio_issue {
 	u64 value;
@@ -131,7 +132,7 @@ static inline sector_t bio_issue_size(struct bio_issue *issue)
 static inline void bio_issue_init(struct bio_issue *issue,
 				       sector_t size)
 {
-	size &= (1ULL << BIO_ISSUE_SIZE_BITS) - 1;
+	size &= GENMASK_ULL(BIO_ISSUE_SIZE_BITS - 1, 0);
 	issue->value = ((issue->value & BIO_ISSUE_RES_MASK) |
 			(ktime_get_ns() & BIO_ISSUE_TIME_MASK) |
 			((u64)size << BIO_ISSUE_SIZE_SHIFT));
@@ -270,7 +271,7 @@ typedef __u32 __bitwise blk_mq_req_flags_t;
  * meaning.
  */
 #define REQ_OP_BITS	8
-#define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
+#define REQ_OP_MASK	GENMASK(REQ_OP_BITS - 1, 0)
 #define REQ_FLAG_BITS	24
 
 enum req_opf {
@@ -329,25 +330,25 @@ enum req_flag_bits {
 	__REQ_NR_BITS,		/* stops here */
 };
 
-#define REQ_FAILFAST_DEV	(1ULL << __REQ_FAILFAST_DEV)
-#define REQ_FAILFAST_TRANSPORT	(1ULL << __REQ_FAILFAST_TRANSPORT)
-#define REQ_FAILFAST_DRIVER	(1ULL << __REQ_FAILFAST_DRIVER)
-#define REQ_SYNC		(1ULL << __REQ_SYNC)
-#define REQ_META		(1ULL << __REQ_META)
-#define REQ_PRIO		(1ULL << __REQ_PRIO)
-#define REQ_NOMERGE		(1ULL << __REQ_NOMERGE)
-#define REQ_IDLE		(1ULL << __REQ_IDLE)
-#define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
-#define REQ_FUA			(1ULL << __REQ_FUA)
-#define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
-#define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
-#define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
-#define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
-#define REQ_HIPRI		(1ULL << __REQ_HIPRI)
-
-#define REQ_DRV			(1ULL << __REQ_DRV)
-#define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_FAILFAST_DEV	BIT_ULL(__REQ_FAILFAST_DEV)
+#define REQ_FAILFAST_TRANSPORT	BIT_ULL(__REQ_FAILFAST_TRANSPORT)
+#define REQ_FAILFAST_DRIVER	BIT_ULL(__REQ_FAILFAST_DRIVER)
+#define REQ_SYNC		BIT_ULL(__REQ_SYNC)
+#define REQ_META		BIT_ULL(__REQ_META)
+#define REQ_PRIO		BIT_ULL(__REQ_PRIO)
+#define REQ_NOMERGE		BIT_ULL(__REQ_NOMERGE)
+#define REQ_IDLE		BIT_ULL(__REQ_IDLE)
+#define REQ_INTEGRITY		BIT_ULL(__REQ_INTEGRITY)
+#define REQ_FUA			BIT_ULL(__REQ_FUA)
+#define REQ_PREFLUSH		BIT_ULL(__REQ_PREFLUSH)
+#define REQ_RAHEAD		BIT_ULL(__REQ_RAHEAD)
+#define REQ_BACKGROUND		BIT_ULL(__REQ_BACKGROUND)
+#define REQ_NOWAIT		BIT_ULL(__REQ_NOWAIT)
+#define REQ_NOUNMAP		BIT_ULL(__REQ_NOUNMAP)
+#define REQ_HIPRI		BIT_ULL(__REQ_HIPRI)
+
+#define REQ_DRV			BIT_ULL(__REQ_DRV)
+#define REQ_SWAP		BIT_ULL(__REQ_SWAP)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
@@ -415,7 +416,7 @@ static inline int op_stat_group(unsigned int op)
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
 #define BLK_QC_T_SHIFT		16
-#define BLK_QC_T_INTERNAL	(1U << 31)
+#define BLK_QC_T_INTERNAL	BIT(31)
 
 static inline bool blk_qc_t_valid(blk_qc_t cookie)
 {
@@ -429,7 +430,7 @@ static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
 
 static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
 {
-	return cookie & ((1u << BLK_QC_T_SHIFT) - 1);
+	return cookie & GENMASK(BLK_QC_T_SHIFT - 1, 0);
 }
 
 static inline bool blk_qc_t_is_internal(blk_qc_t cookie)
-- 
2.20.1

