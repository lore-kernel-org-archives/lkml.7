Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C0EC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82062086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CdmYZ+R4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391642AbfGHTf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:35:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38649 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfGHTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:35:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so15574231edo.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05kLYEGL6zDnQBrhitySxcjxpx75EpSey7IqCfc4g7Y=;
        b=CdmYZ+R4NaCTYLRuUqV+ZplTPmWNEeV78mk1RHz06cZF9hxn1tMkCUb6sT608+XxAH
         W6tND2hfmq3AihhktTKKTWACSInk5tBiNdZFydlpSd1vdcDTT7CNGoytTET5setApSqm
         bbuFAOK06rv05ILYMO0cypmbC6FbjA4I8Drac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05kLYEGL6zDnQBrhitySxcjxpx75EpSey7IqCfc4g7Y=;
        b=S8MyNqPRwdTpLskB4y6ClQHLlneHALiCCnsdq82GCD505YVQqyIR3eDoTtjFrtMiON
         ewAgT6ZBs6Qx/p9Alw/9At26AhQl334AFkRx9c4oP4gK3dDIDRxw1vKLyMQ0Uv7da+cZ
         7vrRwiwvagM7u8hP+rnshVV67P9dElMP1YocK14gXRvRGi8wQY+P7yRUOQHlKQmWdY0U
         1FJq1jfoHiQBuwksUsZLS1T5jXD7bQb/OE8VoB1wN9UeGsYpnfMuQ0DTAmZ5wp0mJMzd
         tOTRdnIADzKZmceUCGGCm0jNXvkevyoD600xYJhSC99K5IHe1A591Bia7ls49mqC0LT2
         NPKg==
X-Gm-Message-State: APjAAAUgpCVC1vXKmEyoIK+UWETQ7Bzf+Z1ftYWWuRJnq5vj3UIjdf1R
        DczK3jwJQOg8KT4NO2TyHnKpP3HMK7o=
X-Google-Smtp-Source: APXvYqx6D5smZvx9vfUvyLxdSfbA195B3cZs69hF8brb8545e1ANBhmtw5ko03MLbEntFX4hNQxyzQ==
X-Received: by 2002:aa7:d781:: with SMTP id s1mr22095324edq.20.1562614526452;
        Mon, 08 Jul 2019 12:35:26 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id j11sm3710864ejr.69.2019.07.08.12.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:35:25 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id g67so734097wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:35:25 -0700 (PDT)
X-Received: by 2002:a1c:e009:: with SMTP id x9mr17756743wmg.5.1562614525190;
 Mon, 08 Jul 2019 12:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190708190930.GA16215@avx2>
In-Reply-To: <20190708190930.GA16215@avx2>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Mon, 8 Jul 2019 12:35:13 -0700
X-Gmail-Original-Message-ID: <CAJcbSZELSRbcfPqE9DuBidM8stxY2DdjseSZgM_pCS1L3FEpcA@mail.gmail.com>
Message-ID: <CAJcbSZELSRbcfPqE9DuBidM8stxY2DdjseSZgM_pCS1L3FEpcA@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] x86/CPU: Adapt assembly for PIE support
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 12:09 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Thomas Garnier wrote:
> > -             "pushq $1f\n\t"
> > +             "movabsq $1f, %q0\n\t"
> > +             "pushq %q0\n\t"
> >               "iretq\n\t"
> >               UNWIND_HINT_RESTORE
> >               "1:"
>
> Fake PIE. True PIE looks like this:

I used movabsq in couple assembly changes where the memory context is
unclear and relative reference might lead to issues. It happened on
early boot and hibernation save/restore paths. Do you think a relative
reference in this function will always be accurate?

>
> ffffffff81022d70 <do_sync_core>:
> ffffffff81022d70:       8c d0                   mov    eax,ss
> ffffffff81022d72:       50                      push   rax
> ffffffff81022d73:       54                      push   rsp
> ffffffff81022d74:       48 83 04 24 08          add    QWORD PTR [rsp],0x8
> ffffffff81022d79:       9c                      pushf
> ffffffff81022d7a:       8c c8                   mov    eax,cs
> ffffffff81022d7c:       50                      push   rax
> ffffffff81022d7d:  ===> 48 8d 05 03 00 00 00    lea    rax,[rip+0x3]        # ffffffff81022d87 <do_sync_core+0x17>
> ffffffff81022d84:       50                      push   rax
> ffffffff81022d85:       48 cf                   iretq
> ffffffff81022d87:       c3                      ret
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
>
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -710,7 +710,8 @@ static inline void sync_core(void)
>                 "pushfq\n\t"
>                 "mov %%cs, %0\n\t"
>                 "pushq %q0\n\t"
> -               "pushq $1f\n\t"
> +               "leaq 1f(%%rip), %q0\n\t"
> +               "pushq %q0\n\t"
>                 "iretq\n\t"
>                 UNWIND_HINT_RESTORE
>                 "1:"
