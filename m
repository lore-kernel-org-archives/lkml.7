Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED42C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CFB2343B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GmxIp6vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfH3VQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:16:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33411 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfH3VQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:16:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so347436pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xmwWYOATsL2bKw+HC5S30we7ZKKvQz0E6r6R/UPw60=;
        b=GmxIp6vzjWBB7ErAyBkwTn2kplIDtoG9r9JTOFes4vqRAnKhmUkVlHg/FjUWMbYb2V
         Qf0OXkUFs52MXV09CB3vcRFeTYtOchpaDir2oLoeHqf6+WhkfXeJfVo41hL9b0mtjw6y
         hPP5662QMqpUs4xKprg5LPNYF79GlfJsUUGK5jibiJNXJQT7fw9jcSmO2uqDJDqUm41N
         sZwo9prFBeKSX9cPYLwHSf6/xE7KJCIjgOL9fmZExkzowCInTViFz923V2LvQoI5q21x
         xphfkxsggmRN6z0EpRqHvz6+dGVKxB+1lBCRyiLe6OCdUybXPAxj2T721pjHIC6CXfwx
         Hqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xmwWYOATsL2bKw+HC5S30we7ZKKvQz0E6r6R/UPw60=;
        b=sW8NrV2Cx2tfBO3B9Y7gnNZH9mYF+AIHowooZCbHJ5Jnx1H6JWTHvh+ky/mmZhWwrn
         ADDqp8gvgEe9yGKtPhtixj8RVSQ+fDF90Y/j0BCgknLq6Lnrre5Pk4rlvp6VCbN8ljF3
         PZb955I0CBzaSXAN/JIlsY1ojeX88bfANGuYDETB6hmjJ0kAgOC/CJF+xNGVG+x0K45U
         moMQn50/aDzFO+LV830eObyta0yAiogQz/olh5MHFQCm9fHRs4EnSWq02g/8FAAnh/i4
         yBWHl2pFtydCxkTsEWNWf/23Fl+pIo5FtZmSukEU0aWqNSaAU5tV7fKXVHrM2osp2rsq
         EcTA==
X-Gm-Message-State: APjAAAXMRGp7PxaydqSDfawGddZWVXlFfdy1BX7LL8m6nzXtOxhb/w1y
        SmBmDshZzwfH9BSxLQsXozCswjzS9hwIDpnZ0HDjaw==
X-Google-Smtp-Source: APXvYqzL4yUTG5cGxPBGrubDgFucuFYyaDYAkIFzHwYqdQb3h6E7G5Pt93QyEtg58JS0se6jUCFoMEVDzYQyYXAvSus=
X-Received: by 2002:a65:690b:: with SMTP id s11mr12545004pgq.10.1567199767599;
 Fri, 30 Aug 2019 14:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190829062635.45609-1-natechancellor@gmail.com>
 <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
 <20190829193432.GA10138@archlinux-threadripper> <885bb20c11f0cb004e5eeda7b0ca6d16@agner.ch>
 <CAKwvOdm-9T5Mmys93VMK8HLUgPJa2HOpcmG96SAvH2EGLA=3Nw@mail.gmail.com>
 <20190830172824.GA119107@archlinux-threadripper> <CAKwvOdksu_L+e52awkd=ffkaasCZeBjKcFU4nvU7q7reEzF2WA@mail.gmail.com>
In-Reply-To: <CAKwvOdksu_L+e52awkd=ffkaasCZeBjKcFU4nvU7q7reEzF2WA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Aug 2019 14:15:56 -0700
Message-ID: <CAKwvOdnUsmGg0V5GXeo9WR-hfOUQ_3_8-9t8n4ZKS8=inpxRHA@mail.gmail.com>
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 2:13 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Aug 30, 2019 at 10:28 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index a43fc753aa53..23c2bf0fbd30 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -115,6 +115,10 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
> >  CFLAGS_ABI     +=-funwind-tables
> >  endif
> >
> > +ifeq ($(CONFIG_CC_IS_CLANG),y)
> > +CFLAGS_ABI     +=-meabi gnu

Needs a space.  `+=-`.
-- 
Thanks,
~Nick Desaulniers
