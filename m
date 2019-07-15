Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC342171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 20:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+cgEQh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfGOUR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:17:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39584 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729844AbfGOURZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:17:25 -0400
Received: by mail-oi1-f196.google.com with SMTP id m202so13719643oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyAbd1BySBBCgH8Ay3NolC8f63BojC2gvrmUxKLo0R0=;
        b=c+cgEQh8jwM3YFAX0xOAib02DehoaJUvmYAHOQnQ6wVRWMla8ygCLoLaFlpk6W+Hix
         UFJC9YA0ujjg8pyEwqzJujHrmhpSfr2Wy0bX4/N/DBo6ATdVB9XkMtdXCbfyos98Qqpe
         C5S/PKMwaUInixcBHib3fysQeefvf/3OXFaUOMz4JFWc+or5Kp7rD2+xX7nEm8L26J50
         XkIkWCqYWfwGfY3HmxcQ0FquKMwrvAOxlmNgthExgivKB77ybsd7ZE8UNRSCpTwrnNlS
         r7IUAh9xzliUzuvune7USKc5BlKWFNGNwadDB3fjkz0QRyvCbElim38sMgI+pSH5wm8L
         LO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyAbd1BySBBCgH8Ay3NolC8f63BojC2gvrmUxKLo0R0=;
        b=QvNyVmEhmQEBizFGUSb05axZorsfKKnDvI3fOByWMsELfMtWLjDkeuC+pVITmFGyWB
         3lD1oFK5moF5M3a95/j/b1U1SjhCATiWvkUrfZhYVk8pNUASoJqHajgQ0dZDg5mUixOf
         1mDePvDXkMt13qlbkt7DhKd/+4Lx9jWLSKu7Wbq7rRikejf7rLcPuEQGoXsAasrQg2xi
         Xh2XLk6eRlGXPS//hfzzNYYiOHscV/gdQulWRBw+WzdrERhVkwydCEvGCfwjeQTT/403
         Kf1Oz6s8qJ7Cd5sd1KK7ZH4811Q1wpWQyRRfIz079+XcEbUUDQZU+COb2Aeofnpnv2Wd
         PVZA==
X-Gm-Message-State: APjAAAWbBAgedUSh4Wot3r2rFQcQh1WcO/qq4iWus+CwJLFmBoLMxidb
        jODtFQ6Vg3ps8IHFveX6k0wF1NejGczC/Vt5Dbw=
X-Google-Smtp-Source: APXvYqxOc28x9Lo0Bz4UjDEyqQTrxzWFN/t3iDIB4AuDixWXTXJwH/cpztZ2BeWV5la6UoGmdS8L9+nonwBOCBFcBys=
X-Received: by 2002:aca:fc8e:: with SMTP id a136mr14867080oii.104.1563221844553;
 Mon, 15 Jul 2019 13:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com>
 <20190713145909.30749-1-mike@fireburn.co.uk> <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de>
 <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com>
 <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de>
 <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com>
 <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 15 Jul 2019 13:16:48 -0700
Message-ID: <CAMe9rOqMqkQ0LNpm25yE_Yt0FKp05WmHOrwc0aRDb53miFKM+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be reserved
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mike Lothian <mike@fireburn.co.uk>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 3:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 15 Jul 2019, Thomas Gleixner wrote:
> > On Mon, 15 Jul 2019, Mike Lothian wrote:
> > > That build failure is from the current tip of Linus's tree
> > > If the fix is in, then it hasn't fixed the issue
> >
> > The reverted commit caused a build fail with gold as well. Let me stare at
> > your issue.
>
> So with gold the build fails in the reloc tool complaining about that
> relocation:
>
>   Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
>
> The commit does:
>
> +extern char __end_of_kernel_reserve[];
> +
>
>  void __init setup_arch(char **cmdline_p)
>  {
> +       /*
> +        * Reserve the memory occupied by the kernel between _text and
> +        * __end_of_kernel_reserve symbols. Any kernel sections after the
> +        * __end_of_kernel_reserve symbol must be explicitly reserved with a
> +        * separate memblock_reserve() or they will be discarded.
> +        */
>         memblock_reserve(__pa_symbol(_text),
> -                        (unsigned long)__bss_stop - (unsigned long)_text);
> +                        (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
>
> So it replaces __bss_stop with __end_of_kernel_reserve here.
>
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -368,6 +368,14 @@ SECTIONS
>                 __bss_stop = .;
>         }
>
> +       /*
> +        * The memory occupied from _text to here, __end_of_kernel_reserve, is
> +        * automatically reserved in setup_arch(). Anything after here must be
> +        * explicitly reserved using memblock_reserve() or it will be discarded
> +        * and treated as available memory.
> +        */
> +       __end_of_kernel_reserve = .;
>
> And from the linker script __bss_stop and __end_of_kernel_reserve are
> exactly the same. From System.map (of a successful ld build):
>
> ffffffff82c00000 B __brk_base
> ffffffff82c00000 B __bss_stop
> ffffffff82c00000 B __end_bss_decrypted
> ffffffff82c00000 B __end_of_kernel_reserve
> ffffffff82c00000 B __start_bss_decrypted
> ffffffff82c00000 B __start_bss_decrypted_unused
>
> So how on earth can gold fail with that __end_of_kernel_reserve change?
>
> For some unknown reason it turns that relocation into an absolute
> one. That's clearly a gold bug^Wfeature and TBH, I'm more than concerned
> about that kind of behaviour.
>
> If we just revert that commit, then what do we achieve? We paper over the
> underlying problem, which is not really helping anything.
>
> Aside of that gold still fails to build the X32 VDSO and it does so for a
> very long time....
>
> Until we really understand what the problem is, this stays as is.
>
> @H.J.: Any insight on that?
>

Since building a workable kernel for different kernel configurations isn't a
requirement for gold, I don't recommend gold for kernel.

-- 
H.J.
