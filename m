Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428EDC10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025EC2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm9aOc8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfDWBXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:23:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35176 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDWBXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:23:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so6702561pgf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 18:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fkbGept4dle3jXov/J8e9kHDjQ838J637e+8bBLYvds=;
        b=Mm9aOc8dhgp44x/yo6qeG5f+x8gdQGjuiz1OjaIEPHrSjry23tUai3RT+L0VqSbwaI
         ayY5NVmTFYZTxdi8kds0k7uEkRMQChBr/j2ZzNIsv0LF/GTASqbmOv2wbbja4CMYrhjh
         ksVT1rhk58WHCQ9nzSD6jQlPKrVYcyd3inejLSfN1iW5onZ8RowTzP/x66kSmsa2uGJP
         rnBjOtAb0rOIgsUnvIVj75UpqLz3ovZhUiUvM93YfWnSD8mUsc6H015ps+hPLD74j4nb
         QNsYKmPkWXWpsnpIcqod8mxAyYngFnQUU7zb4wCjjyLrPfr2NqdkTEa77RFHW3Bbtihe
         xSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fkbGept4dle3jXov/J8e9kHDjQ838J637e+8bBLYvds=;
        b=aa+BYdfwDjuNOT4RxLilx3/MR0coZMWnanUL7peHYhF++e9wHUjD3A9YjpQIw+pHwJ
         uP8mMjJAdqvBnzieC9foJteU1y9UKdZ6AeUqA0IlAs3dJhOHWS89MmLpNraI5uAOzdU+
         jKBy9We9JxPjEgabeYU0+vTyUS3vjieE+EnbCRQASyUn50Yel38rEb6lN9xfpQVHle1j
         FODcG7R7z1sCAqYm3WvprO7jqPJxpmenDpxxkNaPqK9bCPtT3F67uOy7c+Hn8F4U0Ky5
         5zE3QlQRHAI4OCWCvb6bkuQgqmSylgJaNeWDPtHkvj9xhCwFO3RyJNpxgvfgU1CpHXzu
         /Z+g==
X-Gm-Message-State: APjAAAUbf70gVUf9jM8twpCcdadaG5zizuaRLo5dAdlGsf3vxmW99ZQU
        56bkyy4+GzkiwdAPIi4qURPb/Fnd
X-Google-Smtp-Source: APXvYqzSi5rrUCQeDOKg4Gew7Y3dhPlaWEZWLXc4Qs2pwJCgixA9vDKl3FdsPUAmzB4KHlfl0WNMhA==
X-Received: by 2002:a65:6088:: with SMTP id t8mr22099113pgu.2.1555982629633;
        Mon, 22 Apr 2019 18:23:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k79sm37892538pfj.28.2019.04.22.18.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 18:23:48 -0700 (PDT)
Subject: Re: [PATCH v2] binfmt_elf: Move brk out of mmap when doing direct
 loader exec
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
References: <20190422225727.GA21011@beast>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e41905e-50c2-ccf0-9218-f4beb75a0904@roeck-us.net>
Date:   Mon, 22 Apr 2019 18:23:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422225727.GA21011@beast>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/19 3:57 PM, Kees Cook wrote:
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
> nothing is there in the direct loader case (and ET_EXEC is still far
> away at 0x400000). Anything that ran before should still work (i.e. the
> ultimately-launched binary already had the brk very far from its text, so
> this should be no different from a COMPAT_BRK standpoint). The only risk
> I see here is that if someone started to suddenly depend on the entire
> memory space lower than the mmap region being available when launching
> binaries via a direct loader execs which seems highly unlikely, I'd hope:
> this would mean a binary would _not_ work when exec()ed normally.
> 
> (Note that this is only done under CONFIG_ARCH_HAS_ELF_RANDOMIZATION when
> randomization is turned on.)
> 
> Reported-by: Ali Saidi <alisaidi@amazon.com>
> Link: https://lkml.kernel.org/r/CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com
> Fixes: eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: limit effect to only architectures that are expecting it! (Gunter)

This patch applies cleanly on top of next-20190418, and the crashes
observed with my xtensa boot tests no longer occur. I didn't test
any other architectures.

I don't know the base of Andrew's modification - the code snipped he says
isn't there anymore is still present in next-20190418.

Guenter
