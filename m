Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979AAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6E820665
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCZGiqc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391469AbfEXM5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:57:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46620 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391124AbfEXM5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:57:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id o11so416778pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 05:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CD4kioQVFgkBRKMteVuyQoGT6FFB+zqtbCWCvWtVQrA=;
        b=iCZGiqc7A98iuHiHAe2YmyId2jJEvMj/+NWdDb7CZwhV/OLqooo0COa+F27AijWSpN
         Amvi9XDjTzPRQQtGkdaH2+tV2HmEZA5etc0/LBzyc2JjqR/K8RlspkdeOP2zyEcaiByv
         VFCxcL345JvYDa/4StowIM8D/V+Etho0NQetcrPHXboDHlppb8oIXhUI+tYFEnrfsOne
         eQus7q/DxX0acsfLzjTKvIavjp57/0bggMLIDrJLGkdLeY8RnBsvD1WyG1+u5gWLxJxV
         h1en81sp+S5U+iv1wfl08bLhXe+zvLmNCWzyeo5SY7tt9sogCIIlSRxtDrGHWk6kvLcD
         M8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CD4kioQVFgkBRKMteVuyQoGT6FFB+zqtbCWCvWtVQrA=;
        b=RnW8jN5kqeTF30sZNKPsF64xxUmWusYaz6ySwDFNVPK5PxchL5ItjmHcs97qt/ml5F
         /5Bm0fYL4FhOqDeU48hbWi4g1ueXjBfvm00omqmnqjmPBwtzbF3iloz6CrYSvCLe+mZm
         /bPwPKyDsq3TNuVrvFESoP8khcdWWQCuNMLkdg8gyQn0VHRRDX1BJdTtDxZchOpZkFhV
         pbQv/P59rsjXXk1UMwSj76m+4nqXuZDE4z6dqsxUpHnWg1av5Ns3Wt+5aU+IPgr35tCV
         xZ3ywFap5ziXpo82WADH6cYNbP2H3LpUnDROG4qEdYNE7qKI56EJ2KhHMjkFp6rE0j0I
         ZHDw==
X-Gm-Message-State: APjAAAV3zAgpD5yjNDQ+68mwR5wtoQmCEqMcurSTa44R/zZJCCsdDwZV
        4he+WfjaQje0kFkXip8NKcQqXTXH9w4HbQ==
X-Google-Smtp-Source: APXvYqyRLpirLUto0XRsows3I8LALg4tGOIdNLiduUoq6G334B+V/enK/r4xWf8YVmq2uh9tRuTVtA==
X-Received: by 2002:a17:90a:840a:: with SMTP id j10mr9302028pjn.29.1558702654560;
        Fri, 24 May 2019 05:57:34 -0700 (PDT)
Received: from tom-pc.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id p13sm4228796pfq.69.2019.05.24.05.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 May 2019 05:57:34 -0700 (PDT)
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
To:     oleg@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Dianzhang Chen <dianzhangchen0@gmail.com>
Subject: [PATCH] x86: fix possible spectre-v1 in ptrace_get_debugreg()
Date:   Fri, 24 May 2019 20:57:02 +0800
Message-Id: <1558702622-15143-1-git-send-email-dianzhangchen0@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The n in ptrace_get_debugreg() is indirectly controlled by userspace via syscall: ptrace(defined in kernel/ptrace.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
The n can be controlled from: ptrace -> arch_ptrace -> ptrace_get_debugreg.

Fix this by sanitizing n before using it to index thread->ptrace_bps.

Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
---
 arch/x86/kernel/ptrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4b8ee05..3f8f158 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -24,6 +24,7 @@
 #include <linux/rcupdate.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
@@ -644,7 +645,8 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
 	unsigned long val = 0;
 
 	if (n < HBP_NUM) {
-		struct perf_event *bp = thread->ptrace_bps[n];
+		struct perf_event *bp =
+			thread->ptrace_bps[array_index_nospec(n, HBP_NUM)];
 
 		if (bp)
 			val = bp->hw.info.address;
-- 
2.7.4

