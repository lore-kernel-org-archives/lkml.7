Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54496C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B12085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfENOaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:30:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726060AbfENOaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:30:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EENMfj111756
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:30:22 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sfwuww20f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:30:15 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Tue, 14 May 2019 15:30:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 15:29:59 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EETwkn40108172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 14:29:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 977DB11C052;
        Tue, 14 May 2019 14:29:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31F7211C04A;
        Tue, 14 May 2019 14:29:57 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 May 2019 14:29:57 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Tue, 14 May 2019 17:29:56 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm/gup: continue VM_FAULT_RETRY processing event for pre-faults
Date:   Tue, 14 May 2019 17:29:55 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19051414-0020-0000-0000-0000033C94E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051414-0021-0000-0000-0000218F5139
Message-Id: <1557844195-18882-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When get_user_pages*() is called with pages = NULL, the processing of
VM_FAULT_RETRY terminates early without actually retrying to fault-in all
the pages.

If the pages in the requested range belong to a VMA that has userfaultfd
registered, handle_userfault() returns VM_FAULT_RETRY *after* user space
has populated the page, but for the gup pre-fault case there's no actual
retry and the caller will get no pages although they are present.

This issue was uncovered when running post-copy memory restore in CRIU
after commit d9c9ce34ed5c ("x86/fpu: Fault-in user stack if
copy_fpstate_to_sigframe() fails").

After this change, the copying of FPU state to the sigframe switched from
copy_to_user() variants which caused a real page fault to get_user_pages()
with pages parameter set to NULL.

In post-copy mode of CRIU, the destination memory is managed with
userfaultfd and lack of the retry for pre-fault case in get_user_pages()
causes a crash of the restored process.

Making the pre-fault behavior of get_user_pages() the same as the "normal"
one fixes the issue.

Fixes: d9c9ce34ed5c ("x86/fpu: Fault-in user stack if copy_fpstate_to_sigframe() fails")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/gup.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 91819b8..c32ae5a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -936,10 +936,6 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 			BUG_ON(ret >= nr_pages);
 		}
 
-		if (!pages)
-			/* If it's a prefault don't insist harder */
-			return ret;
-
 		if (ret > 0) {
 			nr_pages -= ret;
 			pages_done += ret;
@@ -955,8 +951,12 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 				pages_done = ret;
 			break;
 		}
-		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
-		pages += ret;
+		/*
+		 * VM_FAULT_RETRY triggered, so seek to the faulting offset.
+		 * For the prefault case (!pages) we only update counts.
+		 */
+		if (likely(pages))
+			pages += ret;
 		start += ret << PAGE_SHIFT;
 
 		/*
@@ -979,7 +979,8 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		pages_done++;
 		if (!nr_pages)
 			break;
-		pages++;
+		if (likely(pages))
+			pages++;
 		start += PAGE_SIZE;
 	}
 	if (lock_dropped && *locked) {
-- 
2.7.4

