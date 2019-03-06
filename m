Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846E7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A302206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uAch6plV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfCFVhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:37:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42205 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFVhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:37:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id b2so9437475pgl.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2vf15Ic7g8xBFgvPGfR2CXL2T3Ehbl3TcB+bdjrhEg=;
        b=uAch6plV3eeCsqHxLzYCUc3rWWKRH/c7zONsAHDXIlc9wcj+QyMY0lfWV5lJ2iE4HA
         HhoL8/B6sXWy5DY1F3CLyM5UYObNpInaIyIMdSvP6mVLzo0mpij/rWDZV5r7fCKpgpa2
         UU1uOzLr/Kg7P5i6HvuSEBq0+6h90GM6rIe3xwpG+NYoBaSrp3eif2jcPuI0xEc3fjCR
         l79CPQTO9tI2Zx9I+qLWvz2osi5SCNKnsMeNhWbKSfil2wbrmYtV6fYmk3cPv14OXWjU
         HxKYtYrMykMhs4T2Hyb+UfveATg1jZmgyxIU947gj+xmVfp7yOKF7wtOaZmRtKLCairG
         KWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2vf15Ic7g8xBFgvPGfR2CXL2T3Ehbl3TcB+bdjrhEg=;
        b=Y9rFrdx4NxPLW7dBtwNe8oc8V10fsBX0uRXDwGZUKX4dWi8Aa1CkSHtu5Qg5BSlun3
         o3aN2rDfAh7c/SAgMFzlQfNrOZFCcAYdohnCnXlixTrdtiK732re2Pv7CE12rudSKWIb
         n2/SVrNfYPdSbll8wAkgJ65UvZpf7/s7pNz6/TMnQvlcKE4PS4s7Lf+5ElafZ/jwTEnC
         yXk4ivdMwKVoEGzv26quE8V+MVsGJR/7/5sPWB/g2zY4UcVJ8qkRwSxbipYF5m8poZAk
         exx9ptFfivmiRTlukBTSSRdNUlj2hh+J0PqCCSRt26AKzub7jIBAfOsWHJ1fjQ34Rikb
         SSSw==
X-Gm-Message-State: APjAAAUZq0o+EGxF+YrRyq2Pw17EX8lL7yH0ceVZeC+/y4HqxvPBF2jV
        xtz6qjjELKv3IRaH3cu3u+4O3HnZU+b/VOfZi4JXSQ==
X-Google-Smtp-Source: APXvYqzLiQLhSIz5Zze60wWoKMfDzMmeBvQzyh837v5r9YS9u8DvkwoFPftBFvnImb8FKolsPX4os+5v76JutPOi5e8=
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr9136064plb.217.1551908261353;
 Wed, 06 Mar 2019 13:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20190302184929.28971-1-louis@kragniz.eu> <alpine.DEB.2.21.1903062059570.1646@nanos.tec.linutronix.de>
 <20190306203725.GA23373@gmail.com>
In-Reply-To: <20190306203725.GA23373@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Mar 2019 13:37:30 -0800
Message-ID: <CAKwvOdkjMv8xGTEagpbsbe3ky4eAXpUAXxkDUcZp9DN8xY5rYw@mail.gmail.com>
Subject: Re: [PATCH] x86/KASLR: always return a value from process_mem_region
To:     Louis Taylor <louis@kragniz.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        fanc.fnst@cn.fujitsu.com, bhe@redhat.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Jon Flatley <jflat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 12:38 PM Louis Taylor <louis@kragniz.eu> wrote:
>
> On Wed, Mar 06, 2019 at 09:02:47PM +0100, Thomas Gleixner wrote:
> > On Sat, 2 Mar 2019, Louis Taylor wrote:
> >
> > > When compiling with -Wreturn-type, clang warns:
> > >
> > > arch/x86/boot/compressed/kaslr.c:704:1: warning: control may reach end of
> > >       non-void function [-Wreturn-type]
> > >
> > > This function's return statement should probably have been placed
> > > outside the #endif, so move it there
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/360
> > > Signed-off-by: Louis Taylor <louis@kragniz.eu>
> >
> > This lacks a
> >
> > Fixes: commitsha1 (".....")
>
> Fixes: 690eaa532057 ("x86/boot/KASLR: Limit KASLR to extract the kernel in immovable memory only")
>
> Would you like me to resend with that tag?


Looks like it was added.
Looking at https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/boot,
it looks like part of the commit message got cut off. `#endif, so move
it there` is missing?
-- 
Thanks,
~Nick Desaulniers
