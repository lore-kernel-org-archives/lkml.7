Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA76BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C9E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555455851;
	bh=KGI6zfv4XS1vX9sxXg3j+jWs/tFghKzs9b3P72zkUSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=txqQo09vwurqqBJqvrJVrIQp0+7swDenAuYmfMWxPEsZfmW3vyttiDUA7cGiwdhHZ
	 b0+Ad1tbQ4apuqW2hAPIvVWF9O0Jwi+UvVfx8U4lrGMEN/Y510FSCEZ3JWIYeCiMBW
	 ircYZ69eOm1h5YdQ/gzEcEpOJfTvvPSP8sIr39pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfDPXEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:04:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfDPXEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:04:10 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0379CB2;
        Tue, 16 Apr 2019 23:04:08 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:04:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Move brk out of mmap when doing direct
 loader exec
Message-Id: <20190416160407.0e398a086507b811d7e95bbf@linux-foundation.org>
In-Reply-To: <20190416042320.GA36924@beast>
References: <20190416042320.GA36924@beast>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019 21:23:20 -0700 Kees Cook <keescook@chromium.org> wrote:

> Commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE"),
> made changes in the rare case when the ELF loader was directly invoked
> (e.g to set a non-inheritable LD_LIBRARY_PATH, testing new versions of
> the loader), by moving into the mmap region to avoid both ET_EXEC and PIE
> binaries. This had the effect of also moving the brk region into mmap,
> which could lead to the stack and brk being arbitrarily close to each
> other. An unlucky process wouldn't get its requested stack size and stack
> allocations could end up scribbling on the heap.
> 
> This is illustrated here. In the case of using the loader directly, brk
> (so helpfully identified as "[heap]") is allocated with the _loader_
> not the binary. For example, with ASLR entirely disabled, you can see
> this more clearly:
> 
> $ /bin/cat /proc/self/maps
> 555555554000-55555555c000 r-xp 00000000 ... /bin/cat
> 55555575b000-55555575c000 r--p 00007000 ... /bin/cat
> 55555575c000-55555575d000 rw-p 00008000 ... /bin/cat
> 55555575d000-55555577e000 rw-p 00000000 ... [heap]
> ...
> 7ffff7ff7000-7ffff7ffa000 r--p 00000000 ... [vvar]
> 7ffff7ffa000-7ffff7ffc000 r-xp 00000000 ... [vdso]
> 7ffff7ffc000-7ffff7ffd000 r--p 00027000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffd000-7ffff7ffe000 rw-p 00028000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffe000-7ffff7fff000 rw-p 00000000 ...
> 7ffffffde000-7ffffffff000 rw-p 00000000 ... [stack]
> 
> $ /lib/x86_64-linux-gnu/ld-2.27.so /bin/cat /proc/self/maps
> ...
> 7ffff7bcc000-7ffff7bd4000 r-xp 00000000 ... /bin/cat
> 7ffff7bd4000-7ffff7dd3000 ---p 00008000 ... /bin/cat
> 7ffff7dd3000-7ffff7dd4000 r--p 00007000 ... /bin/cat
> 7ffff7dd4000-7ffff7dd5000 rw-p 00008000 ... /bin/cat
> 7ffff7dd5000-7ffff7dfc000 r-xp 00000000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7fb2000-7ffff7fd6000 rw-p 00000000 ...
> 7ffff7ff7000-7ffff7ffa000 r--p 00000000 ... [vvar]
> 7ffff7ffa000-7ffff7ffc000 r-xp 00000000 ... [vdso]
> 7ffff7ffc000-7ffff7ffd000 r--p 00027000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffd000-7ffff7ffe000 rw-p 00028000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> 7ffff7ffe000-7ffff8020000 rw-p 00000000 ... [heap]
> 7ffffffde000-7ffffffff000 rw-p 00000000 ... [stack]
> 
> The solution is to move brk out of mmap and into ELF_ET_DYN_BASE since
> nothing is there in this direct loader case (and ET_EXEC still far
> away at 0x400000). Anything that ran before should still work (i.e. the
> ultimately-launched binary already had the brk very far from its text,
> so this should be no different from a COMPAT_BRK standpoint). The only
> risk I see here is that if someone started to suddenly depend on the
> entire memory space above the mmap region being available when launching
> binaries via a direct loader execs which seems highly unlikely, I'd hope:
> this would mean a binary would _not_ work when execed normally.
> 
> Reported-by: Ali Saidi <alisaidi@amazon.com>
> Link: https://lkml.kernel.org/r/CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com
> Fixes: eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
> Signed-off-by: Kees Cook <keescook@chromium.org>

No cc:stable?
