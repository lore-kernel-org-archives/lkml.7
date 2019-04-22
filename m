Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D8C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375020685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PWU4bKJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfDVW5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:57:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38422 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfDVW5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:57:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so6405548pfo.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=De7vDkdkI0IK/PB1OnL5OZWwEe1H5bkUm3rmMeiD75o=;
        b=PWU4bKJLT6NvEomy706M0ypX/vgWZKGi63KG7M7utM7Huj3Nbzs1+AJ3O9NuLmFelq
         8QW0hB91kvvzyRZQjrHh+AaVCAWfBKrV3rel4wGJPg9e0s/senigZ9igq2VUMX/UEWQl
         vX+rP+gWHaudfLVesxpSLsbymNAIq3GxdGowc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=De7vDkdkI0IK/PB1OnL5OZWwEe1H5bkUm3rmMeiD75o=;
        b=T1hRdvA7QzIO1XuIHxaLPfAeH8FCT88wxtaIkRU5L0h9Eim/2+Dk4h4RCuiAaB9PTE
         R+jdeet9/GOoQ9T04o+Jm/l34m+lYmaGPNEu2S9EuUCT/R0us1lsIttBhfBy90RaOSPn
         wT3hwCy2hvi9sqK/xbjQMS3VgJz1ZbDjzq5Wewr8FTnjJz0a3qO4V5GvCRj9u9GpyU1v
         AwcTG91XWy5umTvw76Chlt9jV/HIJ8gERUCR65uaQ4POMC8dqJ+t8sBGw5OJmh1j6DkM
         72ZCNi+0qLqBOy2S5bS06uDtVYLyFqX7NBrbvm0A0LKwwBuuHSQy7lVfZoK1VoO3k+vj
         a9Lw==
X-Gm-Message-State: APjAAAW8qDd86t1ejaPTlGRYsFCdNkvg/ykT5Ov5URupXMm3PKX6jHgO
        qglxgF8fYE01Hwx4fc2yw4VYmw==
X-Google-Smtp-Source: APXvYqzs9bj/Dh0/j+mMuCtE+5/8Qb+2ffodtXjWNbhLbGvh/+tHUyHH1iDqNqxOYIcDpRHPNZAHvA==
X-Received: by 2002:a62:415d:: with SMTP id o90mr23036440pfa.236.1555973849956;
        Mon, 22 Apr 2019 15:57:29 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h189sm27896633pfc.125.2019.04.22.15.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 15:57:28 -0700 (PDT)
Date:   Mon, 22 Apr 2019 15:57:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ali Saidi <alisaidi@amazon.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] binfmt_elf: Move brk out of mmap when doing direct loader
 exec
Message-ID: <20190422225727.GA21011@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE"),
made changes in the rare case when the ELF loader was directly invoked
(e.g to set a non-inheritable LD_LIBRARY_PATH, testing new versions of
the loader), by moving into the mmap region to avoid both ET_EXEC and PIE
binaries. This had the effect of also moving the brk region into mmap,
which could lead to the stack and brk being arbitrarily close to each
other. An unlucky process wouldn't get its requested stack size and stack
allocations could end up scribbling on the heap.

This is illustrated here. In the case of using the loader directly, brk
(so helpfully identified as "[heap]") is allocated with the _loader_
not the binary. For example, with ASLR entirely disabled, you can see
this more clearly:

$ /bin/cat /proc/self/maps
555555554000-55555555c000 r-xp 00000000 ... /bin/cat
55555575b000-55555575c000 r--p 00007000 ... /bin/cat
55555575c000-55555575d000 rw-p 00008000 ... /bin/cat
55555575d000-55555577e000 rw-p 00000000 ... [heap]
...
7ffff7ff7000-7ffff7ffa000 r--p 00000000 ... [vvar]
7ffff7ffa000-7ffff7ffc000 r-xp 00000000 ... [vdso]
7ffff7ffc000-7ffff7ffd000 r--p 00027000 ... /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffd000-7ffff7ffe000 rw-p 00028000 ... /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffe000-7ffff7fff000 rw-p 00000000 ...
7ffffffde000-7ffffffff000 rw-p 00000000 ... [stack]

$ /lib/x86_64-linux-gnu/ld-2.27.so /bin/cat /proc/self/maps
...
7ffff7bcc000-7ffff7bd4000 r-xp 00000000 ... /bin/cat
7ffff7bd4000-7ffff7dd3000 ---p 00008000 ... /bin/cat
7ffff7dd3000-7ffff7dd4000 r--p 00007000 ... /bin/cat
7ffff7dd4000-7ffff7dd5000 rw-p 00008000 ... /bin/cat
7ffff7dd5000-7ffff7dfc000 r-xp 00000000 ... /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7fb2000-7ffff7fd6000 rw-p 00000000 ...
7ffff7ff7000-7ffff7ffa000 r--p 00000000 ... [vvar]
7ffff7ffa000-7ffff7ffc000 r-xp 00000000 ... [vdso]
7ffff7ffc000-7ffff7ffd000 r--p 00027000 ... /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffd000-7ffff7ffe000 rw-p 00028000 ... /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffe000-7ffff8020000 rw-p 00000000 ... [heap]
7ffffffde000-7ffffffff000 rw-p 00000000 ... [stack]

The solution is to move brk out of mmap and into ELF_ET_DYN_BASE since
nothing is there in the direct loader case (and ET_EXEC is still far
away at 0x400000). Anything that ran before should still work (i.e. the
ultimately-launched binary already had the brk very far from its text, so
this should be no different from a COMPAT_BRK standpoint). The only risk
I see here is that if someone started to suddenly depend on the entire
memory space lower than the mmap region being available when launching
binaries via a direct loader execs which seems highly unlikely, I'd hope:
this would mean a binary would _not_ work when exec()ed normally.

(Note that this is only done under CONFIG_ARCH_HAS_ELF_RANDOMIZATION when
randomization is turned on.)

Reported-by: Ali Saidi <alisaidi@amazon.com>
Link: https://lkml.kernel.org/r/CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com
Fixes: eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: limit effect to only architectures that are expecting it! (Gunter)
---
 fs/binfmt_elf.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index fe5668a1bbaa..8cec7a97bfb7 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1131,16 +1131,18 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
-	/*
-	 * When executing a loader directly (ET_DYN without Interp), move
-	 * the brk area out of the mmap region (since it grows up, and may
-	 * collide early with the stack growing down), and into the unused
-	 * ELF_ET_DYN_BASE region.
-	 */
-	if (!interpreter)
-		current->mm->brk = current->mm->start_brk = ELF_ET_DYN_BASE;
-
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+		/*
+		 * For architectures with ELF randomization, when executing
+		 * a loader directly (i.e. no interpreter listed in ELF
+		 * headers), move the brk area out of the mmap region
+		 * (since it grows up, and may collide early with the stack
+		 * growing down), and into the unused ELF_ET_DYN_BASE region.
+		 */
+		if (IS_ENABLED(CONFIG_ARCH_HAS_ELF_RANDOMIZE) && !interpreter)
+			current->mm->brk = current->mm->start_brk =
+				ELF_ET_DYN_BASE;
+
 		current->mm->brk = current->mm->start_brk =
 			arch_randomize_brk(current->mm);
 #ifdef compat_brk_randomized
-- 
2.17.1


-- 
Kees Cook
