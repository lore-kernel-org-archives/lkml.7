Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4336ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A252070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+yUAqFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbfJGTVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:21:36 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:50641 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:21:35 -0400
Received: by mail-pl1-f201.google.com with SMTP id y13so9214118plr.17
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1VVXgUvR9hWEet6YOYgZ2IeUcSu3A+eaEhovhtmPmIo=;
        b=U+yUAqFYeHHpdnN4YEdLlFF1AhG1b7N+2naMp7QDH4pwQHeswCujHlHYYJCUbyrG+3
         9T0y0iiz5pN9qNjelyooOAuvKV7Z+QqWeAZbFBDSaSfElxWf8R6rRlw0RWXd26JAonXm
         ejc1zRq4FBawp3Kpi5HNu5C82KsGULvUdeBYLbeRBscMRIn1/VClkN2DWU+eSsIGHOEi
         xlauBgsLhXw75OORMdN/3lIo9lGaK39bBLq9BrZX6rH1SOnNbhhqG/2SJcr6YnzlBk7o
         zvVrXRz6FryXXWr1urkVzWbt8K2cfzowghhrMpjsJ+4ymyOmMTlFGlK3/AHNJ7twW9ux
         4fRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1VVXgUvR9hWEet6YOYgZ2IeUcSu3A+eaEhovhtmPmIo=;
        b=FmACHStvZ8jDyJkwlsb0SI+HXTG3sdE8xcGYYsNj06iaqOeqRyIxmLw5EwziRmdo9J
         zfL8MrttKIYS8ioLfdzPY5kSCVrlcpy3U0cobLI3TTwaKT123IzO8QGV+qGUFrzxkRPc
         kPsiERvwmzbPAlhIkjsSUMGZlaHfCpchlZMapucY1GC+VFFm6s/vlH+ONxB5sviTPoXL
         wt9hB0DuWHYWOJGby78xoNyZ4mRme25Ezp3MIyuB6WmxxVbmVwgDsQZQmukItHpHv2zn
         qBI2FKPLy1VarXSB90Bule4I7vtwZGToKXsR+S0HkHqUzGzqsrLlEfzXaWcbIpJqb7fl
         P42g==
X-Gm-Message-State: APjAAAWQxT3BAGCshPyGzSwWcUI0PSrdntX4R2px50+AwOVWIqXbUpnu
        tGQik+iTk/w/nDaEDVOrMd4BnZytUN1EpVoIQWs=
X-Google-Smtp-Source: APXvYqxTl7q50f9e4Q7HvkTPiDHc+nE01KQDZLPBvfC0BpelR9V3gPGtcdxezE39V9fsz82yJ/1RS5ad8AOHbeLdDis=
X-Received: by 2002:a63:1a53:: with SMTP id a19mr32165157pgm.58.1570476093401;
 Mon, 07 Oct 2019 12:21:33 -0700 (PDT)
Date:   Mon,  7 Oct 2019 12:21:29 -0700
Message-Id: <20191007192129.104336-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] x86/cpu/vmware: use the full form of inl in VMWARE_PORT
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>, pv-drivers@vmware.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, Kees Cook <keescook@chromium.org>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM's assembler doesn't accept the short form inl (%%dx) instruction,
but instead insists on the output register to be explicitly specified:

  <inline asm>:1:7: error: invalid operand for instruction
          inl (%dx)
             ^
  LLVM ERROR: Error parsing inline asm

Use the full form of the instruction to fix the build.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/cpu/vmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 9735139cfdf8..46d732696c1c 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -49,7 +49,7 @@
 #define VMWARE_CMD_VCPU_RESERVED 31
 
 #define VMWARE_PORT(cmd, eax, ebx, ecx, edx)				\
-	__asm__("inl (%%dx)" :						\
+	__asm__("inl (%%dx), %%eax" :					\
 		"=a"(eax), "=c"(ecx), "=d"(edx), "=b"(ebx) :		\
 		"a"(VMWARE_HYPERVISOR_MAGIC),				\
 		"c"(VMWARE_CMD_##cmd),					\
-- 
2.23.0.581.g78d2f28ef7-goog

