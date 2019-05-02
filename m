Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD476C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7ED2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ocallahan-org.20150623.gappssmtp.com header.i=@ocallahan-org.20150623.gappssmtp.com header.b="itZm4mid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfEBVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:07:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38580 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:07:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id e18so3519613lja.5;
        Thu, 02 May 2019 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=McWTtx7Tp7tMDcpgUWURvLH3xAZpqNdcMywhax+H9u8=;
        b=itZm4midVgkaAhNA0r5PfpUHd/gPvPcK3n8NB1YcbOEZ483aEikD/V8xjhyy+P9+G3
         O7NWH6/7GmLn6LJLpEDCkVpkGs9kJ/xe/mv7xm8wikmwI4fYP7sz53GAq6W6EHAYb1HD
         GqBFjxVO0csXNMBnth+6rtohGNFewYALcIuzyvwgO3fM9P1Cf/LDHEdEHRym28VQKEfU
         HS1nlAec0MXtaXmT+tTwRyVPDIO7VWRcNB1+erwL//zEH8yVqp5XR08kdi5xnGhUODif
         ltBMyBk20L0/nvjVz/Sz0sBx+AUjiAvNW4mSXVxcvNqlGkxwD2PFsXFgAP7gq01Jbfdy
         UVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=McWTtx7Tp7tMDcpgUWURvLH3xAZpqNdcMywhax+H9u8=;
        b=eue556EcU4s35RA9GKOS3kSnIOvCKo5MxzeQcNq73qRz0KcKgri5oorwyUZf/ON/AM
         KDUIzp5YvgpImBrodYc3WoaFtFHtl3ibLtRCeHFH2jWeEKhQsMMg6l3CDfJW4eYKALoP
         gdMbDPtUoD2YTX7LAtAxaInAe1ymylbbdZg3SVkS3CBLVbxBLCZsnmAgxJAysUnm0m9z
         +lh+gAD3bysCkVS/ZmuGNfKnK374Ttr6w1u/tn/YQvVPPQonb8sp3K2m4GfLrh51Zb1j
         V87RnOVz4vbszjWVPnw0rXp/GcfGM17zMGf0Aycld6Av/dQcol9SigHPmRUpAF1GOxVg
         NmVg==
X-Gm-Message-State: APjAAAV5ebiD9NsGUD/LnJTqdzdYS6c1u1douWGZ24RuOoFxOXfn2iCN
        KPgFuzB8SuOvBDovCRNuTOeIIq423tR6zqqqpBM=
X-Google-Smtp-Source: APXvYqx6SA6ZIHrK/cbob827p2TujSQac7Gf4FVBIEMUw8EiLG7mK+9ScmPjMrhhS+WzT5pz6bIPktW8RUiWcpMHi5M=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr2765684lja.49.1556831268788;
 Thu, 02 May 2019 14:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com>
 <1556228754-12996-3-git-send-email-rppt@linux.ibm.com> <20190426083144.GA126896@gmail.com>
 <20190426095802.GA35515@gmail.com> <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com> <20190427104615.GA55518@gmail.com>
 <CAOp6jLa1Rs2xrhJ2wpWoFbJGHyB99OX9doQZc+dNqOSUMgURsw@mail.gmail.com> <20190502152016.GA51567@gmail.com>
In-Reply-To: <20190502152016.GA51567@gmail.com>
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Fri, 3 May 2019 09:07:37 +1200
Message-ID: <CAOp6jLYAksmUN2EzZmu9qOkUgPS0=8t0w1zgCWrmhhOf16Fr4Q@mail.gmail.com>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call isolation
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 3:20 AM Ingo Molnar <mingo@kernel.org> wrote:
> So what might work better is if we defined a Rust dialect that used C
> syntax. I.e. the end result would be something like the 'c2rust' or
> 'citrus' projects, where code like this would be directly translatable to
> Rust:
>
> void gz_compress(FILE * in, gzFile out)
> {
>         char buf[BUFLEN];
>         int len;
>         int err;
>
>         for (;;) {
>                 len = fread(buf, 1, sizeof(buf), in);
>                 if (ferror(in)) {
>                         perror("fread");
>                         exit(1);
>                 }
>                 if (len == 0)
>                         break;
>                 if (gzwrite(out, buf, (unsigned)len) != len)
>                         error(gzerror(out, &err));
>         }
>         fclose(in);
>
>         if (gzclose(out) != Z_OK)
>                 error("failed gzclose");
> }
>
>
> #[no_mangle]
> pub unsafe extern "C" fn gz_compress(mut in_: *mut FILE, mut out: gzFile) {
>     let mut buf: [i8; 16384];
>     let mut len;
>     let mut err;
>     loop  {
>         len = fread(buf, 1, std::mem::size_of_val(&buf), in_);
>         if ferror(in_) != 0 { perror("fread"); exit(1); }
>         if len == 0 { break ; }
>         if gzwrite(out, buf, len as c_uint) != len {
>             error(gzerror(out, &mut err));
>         };
>     }
>     fclose(in_);
>     if gzclose(out) != Z_OK { error("failed gzclose"); };
> }
>
> Example taken from:
>
>    https://gitlab.com/citrus-rs/citrus
>
> Does this make sense?

Are you saying you want a tool like c2rust/citrus that translates some
new "looks like C, but really Rust" language into actual Rust at build
time? I guess that might work, but I suspect your "looks like C"
language isn't going to end up being much like C (e.g. it's going to
need Rust-style enums-with-fields, Rust polymorphism, Rust traits, and
Rust lifetimes), so it may not be beneficial, because you've just
created a new language no-one knows, and that has some real downsides.

If you're inspired by the dream of transitioning to safer languages,
then I think the first practical step would be to identify some part
of the kernel where the payoff of converting code would be highest.
This is probably something small, relatively isolated, that's not well
tested, generally suspicious, but still in use. Then do an experiment,
converting it to Rust (or something else) using off-the-shelf tools
and manual labor, and see where the pain points are and what benefits
accrue, if any. (Work like https://github.com/tsgates/rust.ko might be
a helpful starting point.) Then you'd have some data to start thinking
about how to reduce the costs, increase the benefits, and sell it to
the kernel community. If you reached out to the Rust community you
might find some volunteers to help with this.

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
