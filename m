Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFFCC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3612A20989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwR7hrH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfE1MaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:30:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40355 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfE1MaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:30:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so11394199pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 05:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wbDGMNbYYQdX+Pxgd0vXZtreujx15Q0l3ZduS6F2GKM=;
        b=DwR7hrH4XP5l1bRLMyG3fcNleGVYoVC/tS84AWJhif6ykzugPG+ekI1PwCGTXaDGO8
         iTfiaOapH9jFQ7MnE8/KcTEt2ffoZKpH7zOQc/D4xQnLu+E4LZ9z9KEMZjrfbXCtiqvi
         dXSo0KyVluHT4kR9p4Riuh7neCVjt4H6ufTo9SAZdKNFKDi6TGRnISCWIPDa0LxGrR5t
         u0dFfncicOOMqrvABG40tZX2m1uKuzIPunjA4FE+mpJpSuDhT8XckfWZ/xkxmOU4Bw3z
         Ri/A/ZUxxMQV4cVycg9pQb2xP9SncyAkEvNCfbSLdx2Gh8LkL2w32g2uPcUiV7kODABg
         EqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wbDGMNbYYQdX+Pxgd0vXZtreujx15Q0l3ZduS6F2GKM=;
        b=SqgzMWfY801uHi3fmZR5hAnYHoMUiUqSFM/Ti1MeUTAHnbYNZXAqYhmvCzXchrRwWs
         1IwiPSjjwV9fTGILpfTGRdFD6qKya+8100BCpuTf4FvClEHkDZYwmczUhkT/lMtwQz5d
         Sqo6nZNjSRrFvITih5gNOI2TKt2gPuDvvxoLd8WjB5YYQigQXcVl+8/j7cWnHCZeXYcN
         0X4HXT4Cx9PMGY6ezsXUrc4Dfi1dNd34TrornPZO7HNmpzqmqfPKQ/ffJpgTmmh5R6cy
         FCirIaImcvq6f41UHMYddTYEbC+GHd1ebM6ImNqIFwqcR6XLOhXzsgB+51snhRiu5GJd
         zeaQ==
X-Gm-Message-State: APjAAAU067FXkeRwHz4eoytGJasjHIfTAG5fIthxFy802ib6HaEUyude
        rh2iovueHYiG6OGz9IA/sIA=
X-Google-Smtp-Source: APXvYqwWncBkj10LXWl+MumT21W1v1+iisFqPYQvOkVpMdzhh53zR0Fpx8rd0FLH6RVrACMt4bE7ow==
X-Received: by 2002:a62:ab0a:: with SMTP id p10mr44367366pff.143.1559046621476;
        Tue, 28 May 2019 05:30:21 -0700 (PDT)
Received: from xy-data.openstacklocal (ecs-159-138-22-150.compute.hwclouds-dns.com. [159.138.22.150])
        by smtp.gmail.com with ESMTPSA id y12sm1434787pgi.10.2019.05.28.05.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 05:30:20 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     will.deacon@arm.com, linux@armlinux.org.uk, mark.rutland@arm.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] perf: Fix oops when kthread execs user process
Date:   Tue, 28 May 2019 20:31:29 +0800
Message-Id: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a kthread calls call_usermodehelper() the steps are:
  1. allocate current->mm
  2. load_elf_binary()
  3. populate current->thread.regs

While doing this, interrupts are not disabled. If there is a perf
interrupt in the middle of this process (i.e. step 1 has completed
but not yet reached to step 3) and if perf tries to read userspace
regs, kernel oops.

Fix it by setting abi to PERF_SAMPLE_REGS_ABI_NONE when userspace
pt_regs are not set.

See commit bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs
user process") for details.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 arch/arm/kernel/perf_regs.c   | 3 ++-
 arch/arm64/kernel/perf_regs.c | 3 ++-
 arch/x86/kernel/perf_regs.c   | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 05fe92a..78ee29a 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -36,5 +36,6 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs_user_copy)
 {
 	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
+	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
+			 PERF_SAMPLE_REGS_ABI_NONE;
 }
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac61..ac19d19 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -58,5 +58,6 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs_user_copy)
 {
 	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
+	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
+			 PERF_SAMPLE_REGS_ABI_NONE;
 }
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 07c30ee..fa79d6d 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -102,7 +102,8 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs_user_copy)
 {
 	regs_user->regs = task_pt_regs(current);
-	regs_user->abi = perf_reg_abi(current);
+	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
+			 PERF_SAMPLE_REGS_ABI_NONE;
 }
 #else /* CONFIG_X86_64 */
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_DS) | \
-- 
2.7.4

