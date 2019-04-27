Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDCDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F47206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfD0PZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:25:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34810 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbfD0PZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:25:54 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP3B-0000zL-IK; Sat, 27 Apr 2019 16:15:37 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004RV-Gc; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Davidlohr Bueso" <dbueso@suse.de>,
        "Vineet Gupta" <vgupta@synoipsys.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.150449511@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 049/202] arc: do not export symbols in troubleshoot.c
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

commit be2a7fce397d82b7dc3fdbc61fb0bdab118e65ca upstream.

print_task_path_n_nm() is local to this file, its only user being
show_regs().  Mark the function static and avoid the EXPORT_SYMBOL.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Vineet Gupta <vgupta@synoipsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16 as dependency of commit ab6c03676cb1
 "ARC: show_regs: lockdep: avoid page allocator..."]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arc/kernel/troubleshoot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -52,7 +52,7 @@ static void show_callee_regs(struct call
 	print_reg_file(&(cregs->r13), 13);
 }
 
-void print_task_path_n_nm(struct task_struct *tsk, char *buf)
+static void print_task_path_n_nm(struct task_struct *tsk, char *buf)
 {
 	struct path path;
 	char *path_nm = NULL;
@@ -77,7 +77,6 @@ void print_task_path_n_nm(struct task_st
 done:
 	pr_info("Path: %s\n", path_nm);
 }
-EXPORT_SYMBOL(print_task_path_n_nm);
 
 static void show_faulting_vma(unsigned long address, char *buf)
 {

