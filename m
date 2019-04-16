Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D8C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2D320674
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WJJG0Npc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfDPEXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:23:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfDPEXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:23:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so9717732pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 21:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1CrB2HP13L0GNgTn3HfNwJPzGCmxfUyYWocS/1tA8rE=;
        b=WJJG0NpcCTyxyZbH8Yt0BgM7gAsu1X9DReuk1W9HY0LMq8CSiwtklsX0iuEa4eBr6h
         7kLxjmiGv0hIt7luQM+Ag5I2T5HJUpKgLqZMgFX1tj6VaZj+leTat3UF+T8tGZL0VOqZ
         utkxBEwoQwGB9y1i3m4Cd70jRXkXso/NDtXPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1CrB2HP13L0GNgTn3HfNwJPzGCmxfUyYWocS/1tA8rE=;
        b=fMcppCeUpyM+9B1cWBGtiRF6IqcQX/WXYbt753Suyh0hsA/QDSvrZiuOOjirMx/7Et
         AjsAzx1ppz/AZhw9amK/eXFkHC+50VhsH85XCJKxWWrgRKBHucdVCR+T9n9R/lf1Mmz8
         ecDbqIj4/FAop//Pu+dDJQDubMykeIswRt1zpeHb8HBwbLvSL3HFULu/Z5oH+13xs1ME
         WOtP9cIS44Q36zxlXj6dR3V04Jd6Tti+Y1BCH/S0g8B8seDz0BaU609ShMpj0/6kP9wD
         oA/sCbOlmgz/+42w/O0X3LxyKkaGjMXcUIVja6IChmvQCfs1hXhLaOA53K3DhBc8iKOc
         wtHg==
X-Gm-Message-State: APjAAAUceRykC2yCEcfnQPR5cohLkrb8WAtlDC0OgsmmWPDsFjy5QJ0z
        3JgMncaRvzRWcvSNqU7cafyR2jXOkVE=
X-Google-Smtp-Source: APXvYqzsIBv+cdgOlY8SZTDTYhgKrnvL+0taDPQqzRo6dwpos5YGT3yRQ9Fd10haO4j3oxGC9XkniA==
X-Received: by 2002:a63:5b24:: with SMTP id p36mr29407282pgb.84.1555388602586;
        Mon, 15 Apr 2019 21:23:22 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a129sm104594830pfa.152.2019.04.15.21.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 21:23:21 -0700 (PDT)
Date:   Mon, 15 Apr 2019 21:23:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf: Move brk out of mmap when doing direct loader
 exec
Message-ID: <20190416042320.GA36924@beast>
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
nothing is there in this direct loader case (and ET_EXEC still far
away at 0x400000). Anything that ran before should still work (i.e. the
ultimately-launched binary already had the brk very far from its text,
so this should be no different from a COMPAT_BRK standpoint). The only
risk I see here is that if someone started to suddenly depend on the
entire memory space above the mmap region being available when launching
binaries via a direct loader execs which seems highly unlikely, I'd hope:
this would mean a binary would _not_ work when execed normally.

Reported-by: Ali Saidi <alisaidi@amazon.com>
Link: https://lkml.kernel.org/r/CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com
Fixes: eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7d09d125f148..cdaa33f4a3ef 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1131,6 +1131,15 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	current->mm->end_data = end_data;
 	current->mm->start_stack = bprm->p;
 
+	/*
+	 * When executing a loader directly (ET_DYN without Interp), move
+	 * the brk area out of the mmap region (since it grows up, and may
+	 * collide early with the stack growing down), and into the unused
+	 * ELF_ET_DYN_BASE region.
+	 */
+	if (!elf_interpreter)
+		current->mm->brk = current->mm->start_brk = ELF_ET_DYN_BASE;
+
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
 		current->mm->brk = current->mm->start_brk =
 			arch_randomize_brk(current->mm);
-- 
2.17.1


-- 
Kees Cook
