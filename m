Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D66C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E6C20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696668;
	bh=ADigWx33rF4XyHxIEKHsXdqfJMUHpqFwLSqHQEu0hVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0OxC7MjsUQvoTRXI4CxcLoIJonZV39SA8+6ymNXVap/fQGmkcNW9lQHVM8kT5dirq
	 0j9WCX0rqYib3/nH0GikGa6J9wt7c3JTQ0090Bk/pnAnw6jc9mE7IoGHIe5fij8bEA
	 oadbIcmsuj5OFDNI3bcV3qtC7c6LCc3GZcO3Z1uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbfJJIhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbfJJIhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:37:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0BD20B7C;
        Thu, 10 Oct 2019 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696666;
        bh=ADigWx33rF4XyHxIEKHsXdqfJMUHpqFwLSqHQEu0hVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNEyCt2P73zS+2K4y/4+/eup+SEKoEV/KLsYrJuBg/lJHvrTLzyCHejeSPFlaHoor
         h9sgExYpUu1nMBSGOseJD+QfYR54DlUcV0fjsL0bBj2erADG/MlFO8Iv9FcgxAJgFk
         oFbwedJESpwE3NnDxochzSlBC5UVNGdLrInQUsY4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.3 001/148] s390/process: avoid potential reading of freed stack
Date:   Thu, 10 Oct 2019 10:34:22 +0200
Message-Id: <20191010083609.882111313@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

commit 8769f610fe6d473e5e8e221709c3ac402037da6c upstream.

With THREAD_INFO_IN_TASK (which is selected on s390) task's stack usage
is refcounted and should always be protected by get/put when touching
other task's stack to avoid race conditions with task's destruction code.

Fixes: d5c352cdd022 ("s390: move thread_info into task_struct")
Cc: stable@vger.kernel.org # v4.10+
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/process.c |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -184,20 +184,30 @@ unsigned long get_wchan(struct task_stru
 
 	if (!p || p == current || p->state == TASK_RUNNING || !task_stack_page(p))
 		return 0;
+
+	if (!try_get_task_stack(p))
+		return 0;
+
 	low = task_stack_page(p);
 	high = (struct stack_frame *) task_pt_regs(p);
 	sf = (struct stack_frame *) p->thread.ksp;
-	if (sf <= low || sf > high)
-		return 0;
+	if (sf <= low || sf > high) {
+		return_address = 0;
+		goto out;
+	}
 	for (count = 0; count < 16; count++) {
 		sf = (struct stack_frame *) sf->back_chain;
-		if (sf <= low || sf > high)
-			return 0;
+		if (sf <= low || sf > high) {
+			return_address = 0;
+			goto out;
+		}
 		return_address = sf->gprs[8];
 		if (!in_sched_functions(return_address))
-			return return_address;
+			goto out;
 	}
-	return 0;
+out:
+	put_task_stack(p);
+	return return_address;
 }
 
 unsigned long arch_align_stack(unsigned long sp)


