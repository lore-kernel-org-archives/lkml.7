Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A3C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49904208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 23:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9293YwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfHIXEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 19:04:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34719 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfHIXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 19:04:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so40328482pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVPbxJaD3UlTGSiEOIZnak9eRubpnpMnGIk5QeEIN+Q=;
        b=g9293YwYxXJryipILr2+zXdVfXatyrkrTb/IzcI3rZ1q3fqq6Gtoo4ldo161Z9T+rA
         2N2g+3COGSj95G2zAX8qpvuotntayqC2MNMvxKjaISGQ9bKCTuyUHuX0Vf8q/qIqYhkB
         r9jo85pV/pPT8Dn3T8wNSorE1SmYP4VIXHE/1fpfXz2DJvfk/5d6hshJSy1LL8Sws5L8
         BAtgKqvqWKs+RGdYl9cgoHfvuh29ka7tsItcUYvRWTVOzXb0pFC+UeRPNuWBAlBxyWRg
         vweNmtESL/VsS0nT/zfB/MPekfOlPnmL1e1MOU5eyDekcq5BK8JvIrtfB5fLtns1jnsx
         YFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVPbxJaD3UlTGSiEOIZnak9eRubpnpMnGIk5QeEIN+Q=;
        b=qjH5k4IWuJ52jH+Y9gU7XpI1opTIwaugVchDjoHdMRkCqdcdgHKakVvQBlZ3eQB6yJ
         d1M9YaXRdSagvsysrAgJa/80IYXmQ5/Vxrv2ijzrqHUexmIIXbx3GBpAAl+DedDAD6WQ
         cMYh4H7RWO/5be256Racx/oYV5pGSEIprwObSKm/YV2sU9lz8aa2pg6zYG18yu05XNw1
         1343qwW6mH25CPdzvee08KoFU0u5u1TkadGAhYfX+JRDcu1uDv7j7lQOdnLUQyVK9t7k
         WbW2i05kFGC7Q3nHhX0NcIwUbTfvQPDOHceZrJYMvC8f7m2RWPs5Ai3LXjM0H3+fdyZX
         mU4Q==
X-Gm-Message-State: APjAAAUUd6DBJXEwDMPHaA/oFenPgAphW/GG1wvVRc3iQHRVSQjmpz3j
        IH6qDb0hf/dVHvq2eNRxwNmCpiHEqE/oh+bb+46NbQ==
X-Google-Smtp-Source: APXvYqxIdynaf7el6ANmPjYETdxQfGvIvf+ISN44zp62Bdl74RT7D+4P5DY4IGKzGZjQaOLisIhmwR2tIPEkbYFh2iQ=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr5630058pjt.123.1565391854648;
 Fri, 09 Aug 2019 16:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
 <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
In-Reply-To: <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 9 Aug 2019 16:04:03 -0700
Message-ID: <CAKwvOd=n_8i6+9K=g2OK2mAqubBZZHhmJrDM0=FtT_m0e0D5sQ@mail.gmail.com>
Subject: Re: checkpatch.pl should suggest __section
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 3:58 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-08-09 at 15:21 -0700, Nick Desaulniers wrote:
> > Hi Joe,
> > While debugging:
> > https://github.com/ClangBuiltLinux/linux/issues/619
> > we found a bunch of places where __section is not used but could be,
> > and uses a string literal when it probably should not be.
> >
> > Just a thought that maybe checkpatch.pl could warn if
> > `__attribute__((section` appeared in the added diff, and suggest
> > __section? Then further warn to not use `""` for the section name?
>
> Hmm, that makes me wonder about the existing __section uses
> _with_ a quote are actually in the proper sections.
>
> $ git grep -n -P '\b__section\s*\(\s*"'
> arch/arm64/kernel/smp_spin_table.c:22:volatile unsigned long __section(".mmuoff.data.read")
> arch/s390/boot/startup.c:49:static struct diag210 _diag210_tmp_dma __section(".dma.data");
> include/linux/compiler.h:27:                            __section("_ftrace_annotated_branch")   \
> include/linux/compiler.h:63:            __section("_ftrace_branch")             \
> include/linux/compiler.h:121:#define __annotate_jump_table __section(".rodata..c_jump_table")
> include/linux/compiler.h:158:   __section("___kentry" "+" #sym )                        \
> include/linux/compiler.h:301:   static void * __section(".discard.addressable") __used \
> include/linux/export.h:107:     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
> include/linux/srcutree.h:127:           __section("___srcu_struct_ptrs") = &name

I'm going through and fixing all of these now.  Thinking about sending
one treewide fix to akpm.

>
> Maybe there should also be a __section("<foo>") test too.

I think so.  Some of the trickier ones are ones that use the
stringification C preprocessor operator.  I need to think more about
these.

>
> Anyway, how about:
> ---
>  scripts/checkpatch.pl | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1cdacb4fd207..8e6693ca772c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5901,6 +5901,15 @@ sub process {
>                              "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
>                 }
>
> +# Check for __attribute__ section, prefer __section (without quotes)
> +               if ($realfile !~ m@\binclude/uapi/@ &&
> +                   $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
> +                       my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> +                       my $new = substr($old, 1, -1);
> +                       WARN("PREFER_SECTION",
> +                            "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr);
> +               }
> +

I can't read Perl, but this looks pretty good.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
