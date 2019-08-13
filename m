Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C49C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E773220844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P58NEDX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfHMPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:17:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43034 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbfHMPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:17:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so4002478pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 08:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V7Vc4h0uj52QiwgSeM0HPukUmZe8eSiGizdlDL0MsZc=;
        b=P58NEDX0lnVGsZU02FJGgu1WCftMbcsmAGAcXiE7Xb3cVlW6g9TV9PSHnrWt3vN+Dt
         diFNATsZYO0/dQY4zcCvxfHVeAM1Dr+hofEa35Ujsw80oCfT7a2jVP1Snuvw0nnqduYi
         w0ZT+GGbOKqN62X0k3yhwSn+srvND/prdhLP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V7Vc4h0uj52QiwgSeM0HPukUmZe8eSiGizdlDL0MsZc=;
        b=S6PIBuWi8WhAwhqmxP1xmc85HLNZSxFGsIvke4pXJvG+FDMU9SDsIPwzZPJCNhW1BO
         Y9uLWXfD/FtXVgFnh4uVX9ls5WZSJSeIScN1KL6HnUmIP/YsS5caizmeljuVs2ryHaMy
         J1A4Hr+YozuxaRYRL6vKnEhPoOUW77U8EcI6T9uVXZwGJbicLy96ur0VM0H7bkjvV+fr
         Kjncw1r3gSkbkActTjwLWgSW2fyxMptoDqXlDWaRmq2GplIUsJMA+dbwcOrAP/nMUBYE
         5rxdrRkJPhZ9Od0h1ck+UE8+YGpMj53n43Jz0ii196Xt4le66K98jZmTRcQ5FLeKDztB
         S0Ig==
X-Gm-Message-State: APjAAAV1Iai97hbW3Le5OKSnzgqBnaEKY5GWvsgGwT9dysGeV2DT8YGg
        hfuUfSrV3OAOSqG45JNAxPQVxAW7GSA=
X-Google-Smtp-Source: APXvYqzdtns2c4giPlmpu+B6bbvmjTOe7WdwtgrBU07H2NoFsZCpTEecyrlJ+ul2Mk/0Vd0UPiLCVg==
X-Received: by 2002:a62:f24b:: with SMTP id y11mr15994459pfl.0.1565709428876;
        Tue, 13 Aug 2019 08:17:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o32sm1850120pje.9.2019.08.13.08.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 08:17:07 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:17:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] kbuild: Parameterize kallsyms generation and correct
 reporting
Message-ID: <201908130815.33BA0DE322@keescook>
References: <201908121448.4D023D7@keescook>
 <CAK7LNASSkD3SzS5do1REjTe8n7RqUKsLGc2XwWJ7PKJ-z18Oig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASSkD3SzS5do1REjTe8n7RqUKsLGc2XwWJ7PKJ-z18Oig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:00:05AM +0900, Masahiro Yamada wrote:
> On Tue, Aug 13, 2019 at 6:49 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > When kallsyms generation happens, temporary vmlinux outputs are linked
> > but the quiet make output doesn't report it, giving the impression that
> > the prior command is taking longer than expected.
> >
> > Instead, report the KSYM step before the temporary linking. While at it,
> > this consolidates the repeated "kallsyms generation step" into a single
> > function and removes the existing copy/pasting.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Hmm, I did not notice this.

He either until I was getting link errors from MODINFO :)

> How about showing the link stage explicitly?
> (Is it too verbose?)
> 
>   MODINFO modules.builtin.modinfo
>   LD      .tmp_vmlinux1
>   KSYMS   .tmp_kallsyms1.o
>   LD      .tmp_vmlinux2
>   KSYMS   .tmp_kallsyms2.o
>   LD      vmlinux
>   SORTEX  vmlinux

I'm fine with this -- it's probably the right thing to do since getting
vmlinux link errors fro KSYMS probably doesn't make sense either. ;)

> If this verbosity is OK,
> you can move 'info LD  ${2}' into vmlinux_link()

Done.

> Anyway, I like the clean-ups in this patch.
> 
> This is just my personal preference, but
> may I ask two cosmetic changes?
> 
> [1] Could you move kallsyms_step()
>     between  kallsyms() and mksysmap() ?
>     I want to collect function definitions
>     to the top of the script.
> 
> [2] Could you shorten 'kallsymso_previous'
>     to 'kallsymso_prev' ?

Sounds good. v2 sent.

-- 
Kees Cook
