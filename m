Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA09C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2500421D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 17:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l+S6NaNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfIZRP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:15:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33214 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfIZRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:15:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id i30so1934314pgl.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+JG8A7SjQ+Vx6Ru6p1cEyj9M2766YNYqq1t5+xFB2EY=;
        b=l+S6NaNu7O4cU0rqTtvHIRMLaNLPmEYM1T2C/ErSXlwsw1xZ8hSARn4UBBjyOYONIA
         fC6ZO3TnCqBXaPfNJQ6Np0n/bcNUfEFrsoc/CCYNgmCuIFudBWtlO8kZKuzP0ukUQIm/
         n2kMLDR1WD9AZUqlHcHIDiupcBzgk1U1i/hjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+JG8A7SjQ+Vx6Ru6p1cEyj9M2766YNYqq1t5+xFB2EY=;
        b=MDDRP8YByvukrmvtRFlPEbbXHBR4JsPb8jnTUvKDbtygF19cDDwi+VQlmmeRfdZ0Fc
         NTc5BuQPD10hvkdPBUuroOou0b9FzYHTzrG/H05cKLcbN5opoFVXsOQIrXMs363vVasW
         bcrMifrqxg02sgPRkERqphuiupL9m3yuoeiMx1HVYVihKl5wsw972q3vLQBgojCkKff2
         flcRCilMAUk92XLrHjrYc05Cp8tp5KLOYu+B+0eAU28DaXvw5ui+Rs+CEbjv4dkVkS+A
         n9QgcBNFewdxOSDSNt0rlqDYVqV/xtVt1rHf/QT7KiwYRO8ESBjh2tkNPZxQVghABoVK
         5QjQ==
X-Gm-Message-State: APjAAAWg/QyldElZk3ubEHOeQ0vHkRsDD7iREzzzHy+zG2GrASe0aMIl
        xu+N62kmYfopBLo4+e84ymtcLA==
X-Google-Smtp-Source: APXvYqzVnFgaDIZy+yUxA8dcKNfP1MNSK8RBHlxbDimCQhpbcdlVfN8kp/yhZXDGUKvar1oth05ncA==
X-Received: by 2002:a63:d608:: with SMTP id q8mr4497953pgg.422.1569518127349;
        Thu, 26 Sep 2019 10:15:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 8sm2779166pgd.87.2019.09.26.10.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:15:26 -0700 (PDT)
Date:   Thu, 26 Sep 2019 10:15:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Richard Kojedzinszky <richard@kojedz.in>,
        linux-kernel@vger.kernel.org, Ali Saidi <alisaidi@amazon.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] binfmt_elf: Do not move brk for INTERP-less ET_EXEC
Message-ID: <201909261012.96DE554A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When brk was moved for binaries without an interpreter, it should have
been limited to ET_DYN only. In other words, the special case was an
ET_DYN that lacks an INTERP, not just an executable that lacks INTERP.
The bug manifested for giant static executables, where the brk would end
up in the middle of the text area on 32-bit architectures.

Reported-by: Richard Kojedzinszky <richard@kojedz.in>
Fixes: bbdc6076d2e5 ("binfmt_elf: move brk out of mmap when doing direct loader exec")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Richard, are you able to test this? I'm able to run the gitea binary
with this change, and my INTERP-less ET_DYN tests (from the original
bug) continue to pass as well.
---
 fs/binfmt_elf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index cec3b4146440..ad4c6b1d5074 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1121,7 +1121,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		 * (since it grows up, and may collide early with the stack
 		 * growing down), and into the unused ELF_ET_DYN_BASE region.
 		 */
-		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
+		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) &&
+		    loc->elf_ex.e_type == ET_DYN && !interpreter)
 			current->mm->brk = current->mm->start_brk =
 				ELF_ET_DYN_BASE;
 
-- 
2.17.1


-- 
Kees Cook
