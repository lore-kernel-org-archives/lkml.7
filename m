Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C27C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D102525775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="su5Hjy8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfE3H4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:56:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39900 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3H4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:56:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U7mlNM049054;
        Thu, 30 May 2019 07:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=nmmfilcgBZH9BqOY/WIuIaoFLAVPuz8Rl7m+poEdBWU=;
 b=su5Hjy8RbZi5FXmU9nvLnvAA0nfFKMzaBdiFuHQ1rz1S5Uvq0v6HtHqFjzcue0WfPZm0
 +ZW0McT52kYhoe/vsJUfjL54oXCJYYik/Y+sFUKO7iVf5V4BpuL5BfOeJAGJm+v1ahoz
 aAPjvAPdSiwIitrxlnD7a1X1rr8df5odwHozh1iEGNgljxHp76xOQWwizdu8yDg4AKVH
 hvISaePzEOY3rw6M0uX33ESoeS7q9c5oYk5IAM4i4Dv2UEPCw9nTqq2OZZ4p5bKg8QvG
 oKLGHZr6CG7n2BDNqKdCnSNiGYjZ3SAUPKs85p5wPs7a0JhEeR+EilAOpQcOTTlv9jDI 1g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7dppkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 07:55:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U7prMn102700;
        Thu, 30 May 2019 07:53:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2srbdxupyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 07:53:29 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U7rN9N003456;
        Thu, 30 May 2019 07:53:25 GMT
Received: from z2.cn.oracle.com (/10.182.69.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 00:53:23 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     srinivas.eeda@oracle.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH] x86/mm/tlb: Do partial TLB flush when possible
Date:   Wed, 29 May 2019 15:56:44 +0800
Message-Id: <1559116604-23105-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small optimization to stale TLB flush, if there is one new TLB
flush, let it choose to do partial or full flush. or else, the stale
flush take over and do full flush.

Add unlikely() to info->freed_tables check as freeing page tables
is relatively less.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Srinivas Eeda <srinivas.eeda@oracle.com>
Cc: x86@kernel.org

---
 arch/x86/mm/tlb.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 91f6db9..63a8125 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -569,6 +569,17 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 		return;
 	}
 
+	if (unlikely(f->new_tlb_gen <= local_tlb_gen &&
+	    local_tlb_gen + 1 == mm_tlb_gen)) {
+		/*
+		 * For stale TLB flush request, if there will be one new TLB
+		 * flush coming, we leave the work to the new IPI as it knows
+		 * partial or full TLB flush to take, or else we do the full
+		 * flush.
+		 */
+		trace_tlb_flush(reason, 0);
+		return;
+	}
 	WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);
 	WARN_ON_ONCE(f->new_tlb_gen > mm_tlb_gen);
 
@@ -577,7 +588,8 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 * This does not strictly imply that we need to flush (it's
 	 * possible that f->new_tlb_gen <= local_tlb_gen), but we're
 	 * going to need to flush in the very near future, so we might
-	 * as well get it over with.
+	 * as well get it over with in case we know there will be more
+	 * than one outstanding TLB flush request.
 	 *
 	 * The only question is whether to do a full or partial flush.
 	 *
@@ -609,9 +621,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	 *    local_tlb_gen all the way to mm_tlb_gen and we can probably
 	 *    avoid another flush in the very near future.
 	 */
-	if (f->end != TLB_FLUSH_ALL &&
-	    f->new_tlb_gen == local_tlb_gen + 1 &&
-	    f->new_tlb_gen == mm_tlb_gen) {
+	if (f->end != TLB_FLUSH_ALL && local_tlb_gen + 1 == mm_tlb_gen) {
 		/* Partial flush */
 		unsigned long nr_invalidate = (f->end - f->start) >> f->stride_shift;
 		unsigned long addr = f->start;
@@ -703,7 +713,7 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (unlikely(info->freed_tables))
 		smp_call_function_many(cpumask, flush_tlb_func_remote,
 			       (void *)info, 1);
 	else
-- 
1.8.3.1

