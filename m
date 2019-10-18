Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C7CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B284222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AgRnIqMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505018AbfJRIJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:09:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39040 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504985AbfJRIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:09:01 -0400
Received: by mail-io1-f68.google.com with SMTP id a1so6378781ioc.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/rqN9u0/2+ao+d3JFwKTj45TNXeBg3DCl+L7bcDO5L0=;
        b=AgRnIqMPI9/c78JU0tZ2ukpZmzDiY3JwBESuXLef+ZlyuwPVl0hWk/I4aTbZ37Yz2t
         wBXespQ6ClJkWurhzK8+z7L3vufj/oD3RDQaBgd+c/seJgwQQwIKdHefZrlyFJm1PCaP
         D8yAK7khexd85MvufOeWx+kF8/B+8jToNlCiBDxueaWGhck1V9xJ4TPeI5auXeWOPr7D
         /bsc8iL44mCKAVSzpqLdIvfiQe2wwwpzVWof8Jj3K1Dqhnqb2ZcckbrUGMk0ZRnFupa8
         GN/mgsOHEg6SeW83zbui+yitvxqgYKaHLceFXsigsvd3STC1fivnrdZuoJgP1eEir9aV
         7k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rqN9u0/2+ao+d3JFwKTj45TNXeBg3DCl+L7bcDO5L0=;
        b=iPqhCqpDg81SAHa8/xPYV1buvSOIA5hLCVHvUYb4oEmA0zWZGlaww/bCAUTZDTZ+ry
         /IvrOT9enkeqby910aDzqRycqukgREa33CLuXDrFMbnmCXjMXynhohErgkE21uYZrezx
         QwsG1U/zcnIDwSrg3MbhiLQSg5IIVhDkI+Xswwr7B2DEq1tqbOX6Euw4X+nPCcX1vQsG
         zIuUO4NuxVqGtl9cMuY+JAIonySEIQUYaKzKKdnkPgyGqGKOFdI1phzDcK+xbwD6Y9vy
         WmaBrlyrHU/D9vtD+GUymMZ4U43eT1BIpU6eUJIx1mz/nfaB04U3TQA9Hv1Q2GqcDL2B
         q6mA==
X-Gm-Message-State: APjAAAVp/qS/T0jnyItMuYXbYe/bp3v4ACvc4c4/VeMXhdf6AGl5qWSA
        8QYhB7X+E0Q2MlT4bLm9Jhfq4A==
X-Google-Smtp-Source: APXvYqxG7epqlIJRSyy/8bM9quGUJjMyJ24lYOlQwYCPAW5aHjJzro/76ki7t3mpduRVDdN14r7s+g==
X-Received: by 2002:a6b:5a09:: with SMTP id o9mr7397346iob.241.1571386140466;
        Fri, 18 Oct 2019 01:09:00 -0700 (PDT)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z86sm2121026ilf.73.2019.10.18.01.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:09:00 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 8/8] riscv: for C functions called only from assembly, mark with __visible
Date:   Fri, 18 Oct 2019 01:08:41 -0700
Message-Id: <20191018080841.26712-9-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018080841.26712-1-paul.walmsley@sifive.com>
References: <20191018080841.26712-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than adding prototypes for C functions called only by assembly
code, mark them as __visible.  This avoids adding prototypes that will
never be used by the callers.  Resolves the following sparse warnings:

arch/riscv/kernel/ptrace.c:151:6: warning: symbol 'do_syscall_trace_enter' was not declared. Should it be static?
arch/riscv/kernel/ptrace.c:175:6: warning: symbol 'do_syscall_trace_exit' was not declared. Should it be static?

Based on a suggestion from Luc Van Oostenryck.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 63e47c9f85f0..0f84628b9385 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -148,7 +148,7 @@ long arch_ptrace(struct task_struct *child, long request,
  * Allows PTRACE_SYSCALL to work.  These are called from entry.S in
  * {handle,ret_from}_syscall.
  */
-void do_syscall_trace_enter(struct pt_regs *regs)
+__visible void do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		if (tracehook_report_syscall_entry(regs))
@@ -172,7 +172,7 @@ void do_syscall_trace_enter(struct pt_regs *regs)
 	audit_syscall_entry(regs->a7, regs->a0, regs->a1, regs->a2, regs->a3);
 }
 
-void do_syscall_trace_exit(struct pt_regs *regs)
+__visible void do_syscall_trace_exit(struct pt_regs *regs)
 {
 	audit_syscall_exit(regs);
 
-- 
2.23.0

