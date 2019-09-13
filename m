Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C40CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17BD20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 21:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uKHUA9Of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfIMVAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 17:00:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46735 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 17:00:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id f2so22203178pfk.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qWFRP6r+QcthL0/9k5f/qmXlvzs6Yi4utinllSaKdhc=;
        b=uKHUA9OfeZFOtDPMBaG8ABFamcL0E6ZgSe12UTOyu7NTXPJS0InoPih7FazTCnltw3
         8S1KB8v2/hccuwxELyANIsjd8rsz7Lx0u7axMppMa+PgJc36X+V3amfb/9eDyGMj5Afi
         UVwr8KC9NDiy7BeUbqZ2aWd4gC6DzHdyHhp/ejuqMKY5Xm2Gl858qWx/pOZTXOqz6ZD0
         sgnK7L9mSD4hNj6hMLvhbGfWVV13kTax+pgoj2eG2v1wbixFa+gUVCaSanXre2OxrEfH
         UgjXc8/dYAyt9L9Huc+u0lb7TlJH82VhaTpvwVM/i/jHhVIYNR+/0qg6OL3k13G3gJcd
         nOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qWFRP6r+QcthL0/9k5f/qmXlvzs6Yi4utinllSaKdhc=;
        b=p1dZa+Bh/sDMHm14Bu/Yuf6TbCBhMYZOkNVcI6YanWfomIAuaPN6regqr3AH5H38ll
         bN4sh8lw2GdlVfD6thC3N58y9n/qxvGSXETHTpou6eyaO+W0seImMthah49XCghKRsKe
         n+9Sko2y87aET2UjkWBja3y7wV1cZsEhBw1F2kEAPNfs3cFI22UVS3STelkb0s47jvmt
         aqTOeHdqtlsBKCpc1ktDI3XY0lQx9KcUaNrzkdo1q5vqGvhG0w1syRumRK+XnALoE60V
         S2ed7UMPyksHIU2gGe6ds2Aq5J26osUnVnDbL2F2wcMCHfo6/hKL7cgVz8nfttOrC59e
         skwg==
X-Gm-Message-State: APjAAAUt4hSkUoBr2rbrGWxSrd9hLTPx938Zd4AeJqK/sVJ0YN1jUcwN
        gYMV+D8opCj8D8IgEIwa3PD3zZbPEHV6J9nCP9Q=
X-Google-Smtp-Source: APXvYqy/Wu4hB2qYb/PCfrjJK2upePxcyrXR1jZRjIajbySQIQdT+bW02y09ftLTFXLrZuL1iXnk6alpUiq6B1EFjBc=
X-Received: by 2002:a63:1d2:: with SMTP id 201mr46274077pgb.307.1568408428277;
 Fri, 13 Sep 2019 14:00:28 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:00:16 -0700
In-Reply-To: <20190913210018.125266-1-samitolvanen@google.com>
Message-Id: <20190913210018.125266-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
Subject: [PATCH 2/4] x86: use the correct function type for sys32_(rt_)sigreturn
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct function type to avoid tripping Control-Flow
Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/ia32/ia32_signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 1cee10091b9f..878d8998ce6d 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -118,7 +118,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	return err;
 }
 
-asmlinkage long sys32_sigreturn(void)
+asmlinkage long sys32_sigreturn(const struct pt_regs *__unused)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
@@ -144,7 +144,7 @@ asmlinkage long sys32_sigreturn(void)
 	return 0;
 }
 
-asmlinkage long sys32_rt_sigreturn(void)
+asmlinkage long sys32_rt_sigreturn(const struct pt_regs *__unused)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe_ia32 __user *frame;
-- 
2.23.0.237.gc6a4ce50a0-goog

