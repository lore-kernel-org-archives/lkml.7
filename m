Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A2C32751
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243DF216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBknxIUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbfHFRZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:25:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37798 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHFRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:25:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76H9Ipb161050;
        Tue, 6 Aug 2019 17:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Wehduxv3rRQK2E7/irEvOjIfxwzfa7zL656bjo3lVcY=;
 b=hBknxIUazqQ/wOMEAxX01bZsUVuXvxlyO1N+0qKl94WEryTvqPeXObRSc32gqFSQAL62
 UQOkmWB0thwiyDWYfW+Dxcjp2iUJid2d0EFP9GF5inTIXcNtpipmO4fOfb/1e15sAo8x
 3cO1kTl99VB5L813rDMfLXILyzoqiU7wpcxdqG2/5BQVco6f/Jm00YTqz+Ibg/LHzzJd
 XfgVKP1rMsj2IsWSZcKvp0oJTFREKswS+eGx2UQKed2eH8qea+yZxJECWPhh6cYP2w2p
 q/A/4BZRbg+8u2RYrbxP5Yk+niKSUA+fD7A3T8SfEkj+xkAElK8rSSgHwUXkt1bguqBf dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u527pqgqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 17:25:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76H8NZp068899;
        Tue, 6 Aug 2019 17:25:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u7666qy69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 17:25:51 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x76HPooi011529;
        Tue, 6 Aug 2019 17:25:50 GMT
Received: from brm-x32-03.us.oracle.com (/10.80.150.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 10:25:50 -0700
From:   Jane Chu <jane.chu@oracle.com>
To:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nvdimm@lists.01.org
Subject: [PATCH v4 1/2] mm/memory-failure.c clean up around tk pre-allocation
Date:   Tue,  6 Aug 2019 11:25:44 -0600
Message-Id: <1565112345-28754-2-git-send-email-jane.chu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
References: <1565112345-28754-1-git-send-email-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=940
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add_to_kill() expects the first 'tk' to be pre-allocated, it makes
subsequent allocations on need basis, this makes the code a bit
difficult to read. Move all the allocation internal to add_to_kill()
and drop the **tk argument.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 mm/memory-failure.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d9cc660..51d5b20 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -304,25 +304,19 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
 /*
  * Schedule a process for later kill.
  * Uses GFP_ATOMIC allocations to avoid potential recursions in the VM.
- * TBD would GFP_NOIO be enough?
  */
 static void add_to_kill(struct task_struct *tsk, struct page *p,
 		       struct vm_area_struct *vma,
-		       struct list_head *to_kill,
-		       struct to_kill **tkc)
+		       struct list_head *to_kill)
 {
 	struct to_kill *tk;
 
-	if (*tkc) {
-		tk = *tkc;
-		*tkc = NULL;
-	} else {
-		tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
-		if (!tk) {
-			pr_err("Memory failure: Out of memory while machine check handling\n");
-			return;
-		}
+	tk = kmalloc(sizeof(struct to_kill), GFP_ATOMIC);
+	if (!tk) {
+		pr_err("Memory failure: Out of memory while machine check handling\n");
+		return;
 	}
+
 	tk->addr = page_address_in_vma(p, vma);
 	tk->addr_valid = 1;
 	if (is_zone_device_page(p))
@@ -341,6 +335,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
 			page_to_pfn(p), tsk->comm);
 		tk->addr_valid = 0;
 	}
+
 	get_task_struct(tsk);
 	tk->tsk = tsk;
 	list_add_tail(&tk->nd, to_kill);
@@ -432,7 +427,7 @@ static struct task_struct *task_early_kill(struct task_struct *tsk,
  * Collect processes when the error hit an anonymous page.
  */
 static void collect_procs_anon(struct page *page, struct list_head *to_kill,
-			      struct to_kill **tkc, int force_early)
+				int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -457,7 +452,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 			if (!page_mapped_in_vma(page, vma))
 				continue;
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill, tkc);
+				add_to_kill(t, page, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -468,7 +463,7 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
  * Collect processes when the error hit a file mapped page.
  */
 static void collect_procs_file(struct page *page, struct list_head *to_kill,
-			      struct to_kill **tkc, int force_early)
+				int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -492,7 +487,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 			 * to be informed of all such data corruptions.
 			 */
 			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, vma, to_kill, tkc);
+				add_to_kill(t, page, vma, to_kill);
 		}
 	}
 	read_unlock(&tasklist_lock);
@@ -501,26 +496,17 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 
 /*
  * Collect the processes who have the corrupted page mapped to kill.
- * This is done in two steps for locking reasons.
- * First preallocate one tokill structure outside the spin locks,
- * so that we can kill at least one process reasonably reliable.
  */
 static void collect_procs(struct page *page, struct list_head *tokill,
 				int force_early)
 {
-	struct to_kill *tk;
-
 	if (!page->mapping)
 		return;
 
-	tk = kmalloc(sizeof(struct to_kill), GFP_NOIO);
-	if (!tk)
-		return;
 	if (PageAnon(page))
-		collect_procs_anon(page, tokill, &tk, force_early);
+		collect_procs_anon(page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, &tk, force_early);
-	kfree(tk);
+		collect_procs_file(page, tokill, force_early);
 }
 
 static const char *action_name[] = {
-- 
1.8.3.1

