Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAECC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD89720882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcYq/9ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfDDQcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:32:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43884 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:32:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so2407423oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NFh4YxrBNusOZTSxb2ekQrpb7I533NMEY5D6LfRJ9/E=;
        b=BcYq/9IDHgFTIcXhMKpqmo1iL020nulDn7BvmRk0sNxt2gxBy4OrNE/KVNP/MNpCaE
         2wXG4iqWYa8qAm2chb7yoYHN+SaCaWGEmIA6OpEagl1GFzjMCkUTeJzv86OXMEXgq8h3
         RIU8wWSVXpG099Ym7AQLF18Z9Xi6hp7jcXJsPfSZ+YINqrAR8JmzGXMDBytAiLCEBdXd
         CfoEoCo9j9NrZkTPIf8wpdF/XeTTldgqc0I5Gr8zOIDqwYcTx1NeUl190oOqG5fCLZGS
         WZTWJN7ZtDXc31oHfOkI1mU8lTZe8dL0LDnjbgLqvIkKK0sfhgRBbj6dsG76NoEhSM1a
         c/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NFh4YxrBNusOZTSxb2ekQrpb7I533NMEY5D6LfRJ9/E=;
        b=f7WQ2Mq3TZ2Uq3bKCLIKnq3jtcWDVV00mWTIwMc04X4cVzhcnHuQAsH3vCLkBHJst9
         EJTt01JHWYMGxsXXE3Chxw25pWEfKxVrGTvsj1tyYXWbzp9DqBcVz4Y2c6QYoxP6AJuP
         Mg4Rc8tmTB15kaxoGV9j9Bnu0tf/t/rspAOhS64j3z1KpYRfem4zFmWZM+G2Rwp6Qpom
         WOfnuuaBFOOxiafWrZxYYDBQ2nCPZRHDoMpEJ4mwv2qLRb16ho4tOVDOjD7eFm51FLfx
         wyoqUIKrDtTEFK1+rwzjz2EwbgdicAcyiyUwapxCw5UTzrcDFgSksumZeJr4eKaunsuZ
         0SKg==
X-Gm-Message-State: APjAAAVNYOinNTFeiD7CQMCdaUDendaAYIl+scGppwUo0e5GviQ4Pd1o
        BiZaslyXC5zoMoKTsYf0NyKqUA4Zx/cbX9RKTs/YIw==
X-Google-Smtp-Source: APXvYqwZhgkY24XZ6PjJcXPzeC7gJLt4OImgkzOR+uEJB7AWbd3gCKfl0eNOGtwGeN9976gOag4fS58pVEwjmKvMCwU=
X-Received: by 2002:aca:dcd7:: with SMTP id t206mr4202551oig.68.1554395523106;
 Thu, 04 Apr 2019 09:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190404111128.131157-1-jannh@google.com> <20190404162753.GG22539@zn.tnic>
In-Reply-To: <20190404162753.GG22539@zn.tnic>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 4 Apr 2019 18:31:37 +0200
Message-ID: <CAG48ez1wPdCZE07SeK_=yL3gWRnekLm3+YP3rvyw2YL_3+uNJw@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode: Refactor Intel microcode loading
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 6:28 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Apr 04, 2019 at 01:11:28PM +0200, Jann Horn wrote:
> > This changes generic_load_microcode() to use the iov_iter API instead of
> > an open-coded version. This allows us to avoid explicitly casting between
> > user and kernel pointers.
> >
> > Because the iov_iter API makes it hard to read the same location twice, as
> > a side effect, this also fixes a double-read of the microcode header (which
> > could e.g. lead to out-of-bounds reads in microcode_sanity_check()).
> > Not that it matters much, only root can do this anyway...
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I have tested that with this patch applied, microcode loading still works
> > both via "iucode-tool -k" and via
> > /sys/devices/system/cpu/microcode/reload.
>
> Yeah, this cannot have worked because I think I broke it recently and
> you'd need this:

Uuuh. I *definitely* tested this. I ran this yesterday evening on my
home machine, on top of commit
14c741de93861749dfb60b4964028541f5c506ca from Linus' tree, plus two
cherry-picked fixes for drm/ttm. I specifically made sure that I had
the old microcode version before reloading these ways and I had the
new version after reloading. And the verbose dmesg logs also looked
okay.

> ---
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 5260185cbf7b..8a4a7823451a 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -418,8 +418,9 @@ static int do_microcode_update(const void __user *buf, size_t size)
>                 if (ustate == UCODE_ERROR) {
>                         error = -1;
>                         break;
> -               } else if (ustate == UCODE_OK)
> +               } else if (ustate == UCODE_NEW) {
>                         apply_microcode_on_target(cpu);
> +               }
>         }
>
>         return error;
> ---
>
> Regardless, I'll take care of it. Thanks a lot for doing this cleanup,
> it looks really cool and nicely clean - exactly how I envisioned it. :-)
>
> I'll test it more later with the above fix and apply it.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
