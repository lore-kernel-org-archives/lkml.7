Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E570C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC2A20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 09:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="exE8Y1oT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfHFJfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 05:35:54 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:54321 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 05:35:53 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x769ZhHZ019760;
        Tue, 6 Aug 2019 18:35:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x769ZhHZ019760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565084144;
        bh=uL6OYZ4zlr7BfKybaaiPyH6gXvNHQoG/WQhnslApeZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=exE8Y1oTDo5uqNNeCt+rv8wg8ZFRjllEmfQkNyHQaPAvqnBjnjSDeqlR29Fb3t0p7
         MqqolrVX9cHWYFZr0WLG6+blZPKNeK2bEyOeeNNPTICOk9yVdujcVivP9TtRB39OqP
         xWzLzmw6k69R+g8KRmM2oAJNDLrmQBpPIuL7gqOwbRhGlStAjlJV/NBMrQ+mBJUjrC
         YRPh7esP2aBonETR6g7aTSGz7xwVWHe1vV1ez/foORpHN5KLF4jB49xKbUirW/AfkX
         TSvXeUlWEQzo+4tvZ1pNDIocj5rWiQu9BvmZDr4+BTWHXxrjZfccIFIVaUIEToZQFo
         LIikVRhjjVw4A==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id j8so33365059uan.6;
        Tue, 06 Aug 2019 02:35:43 -0700 (PDT)
X-Gm-Message-State: APjAAAW6tXqGP5whiA6dN2361xsV9E560jMEfhGo/gz69MriWHhYUvMY
        5VQcVbQkFNt8+nvA0AQkz74I7MwfWACQhr2/PiY=
X-Google-Smtp-Source: APXvYqxdz7ZZTh4TQw1mKMR2HrN8MTf/3srOKUirZvvoYJw1gC4fLwkl4Y9G3omhiV4qizS4do2eATB+ilPERMM9p4s=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr1615365uad.121.1565084142657;
 Tue, 06 Aug 2019 02:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190806043729.5562-1-yamada.masahiro@socionext.com> <CAK8P3a2POcb+AReLKib513i_RTN9kLM_Tun7+G5LOacDuy7gjQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2POcb+AReLKib513i_RTN9kLM_Tun7+G5LOacDuy7gjQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 6 Aug 2019 18:35:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvsUB1a0LJvtJXKZZv2fiHAMrojKbF82--C4yQs=k35w@mail.gmail.com>
Message-ID: <CAK7LNARvsUB1a0LJvtJXKZZv2fiHAMrojKbF82--C4yQs=k35w@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: re-implement detection of CONFIG options
 leaked to user-space
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Aug 6, 2019 at 6:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 6, 2019 at 6:38 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > I was playing with sed yesterday, but the resulted code might be unreadable.
> >
> > Sed scripts tend to be somewhat unreadable.
> > I just wondered which language is appropriate for this?
> > Maybe perl, or what else? I am not good at perl, though.
>
> I like the sed version, in particular as it seems to do the job and
> I'm not volunteering to write it in anything else.
>
> > Maybe, it will be better to fix existing warnings
> > before enabling this check.
>
> Yes, absolutely.
>
> > If somebody takes a closer look at them, that would be great.
>
> Let's see:

Thanks for looking into these!

If possible, could you please send patches to fix them?
We can start with low-hanging fruits to reduce the number of warnings.

Thank you.

-- 
Best Regards
Masahiro Yamada
