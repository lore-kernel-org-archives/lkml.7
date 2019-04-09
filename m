Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA0DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A4C2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 23:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqVcx5wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfDIXfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:35:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43368 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfDIXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 19:35:09 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so310362lja.10;
        Tue, 09 Apr 2019 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWeYLM3rxJzPGlnKtrpsD9DliBwRs8NRe3bcbb4uxqg=;
        b=XqVcx5wo8OBRGYaAwrpVdO+dFWVY+W61RR4oVH1KTrT5lDqDjLoSsEK/4YVexk8rBG
         fSE2DTB170CS2tjtlSHv/eu+qvLtVWYqhIPjoiXXsJ6SljtoiTDr55us1T6cn8TMaxx1
         6jGSiMeaRy7UKMixzWcgmthKN0BE2739sEVu6dOa3Vp0WYMHbocD3MS34ywc18f/irHH
         M0kDFhEI23uPhbzzqlMh08sXNeEdqdzCL3m9wNoJCfg9941ke6sgGic5WVhwE5gr6+VW
         f9mVFJR77+2r1hqcTGvk8MMPK1WdilWgCAZF0Jo5C5mDqtVMWffe+1Ry+rT4F7Vspfpa
         idWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWeYLM3rxJzPGlnKtrpsD9DliBwRs8NRe3bcbb4uxqg=;
        b=l0x0mj3Jt37N9CqBfSxRZaPHoYZFWMVE9lOXH036ADPhL5JEzt7K1EqDr9DmryN0f7
         hhU8MTKlL9AHLsa5jNfeotjQdAEKaEDz0lwc4YOe+He+jOlixV7CgZvVazOafZK04h/T
         J3mZzgO6KTYBVkp/Muineci58QAjMByxmnyuR3IdA/rysy0aUU/dgWWTcJj7ZX7QJ3Cs
         clhLYH02iiEXK0UAysGilqunAuiYOMKjUiWwk52pWiPHClTwqIW07WDhSl3fGGQG2bgA
         0scztHKclm3MZ8k7njxo87O40qh1pvf/3GkPWKktOH8uFRV8pWnqEpVGCqeiEvrrzf/a
         /LYQ==
X-Gm-Message-State: APjAAAWnEH8sXm5G0l4d82BL+ba0h5Xz+4NB/8np4nKDQpJnRjyrToPo
        dfXov5XAfgk4lbc4CEOqBgYB1D+3n9dOpUHa88k=
X-Google-Smtp-Source: APXvYqzvcSMLYwm0uwjInbDfn6BUM8tYLD6JGxGrVa02YHX+Kg3nConQkk1IYV2wjpcJX6jTd+aIYVY3GsbyXHUFJxo=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr22176366ljg.103.1554852906651;
 Tue, 09 Apr 2019 16:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554485409.git.rdna@fb.com> <CAG48ez2D=fUX6_MDf5WD39av65FSQ1OF7v7gG5pqZLqgU9RAUw@mail.gmail.com>
 <20190409230432.GA59615@rdna-mbp> <CAG48ez0-B_m6ruMiMp+hVgxmw1dZVtiKGqPWtaFP5esOQTjr9A@mail.gmail.com>
In-Reply-To: <CAG48ez0-B_m6ruMiMp+hVgxmw1dZVtiKGqPWtaFP5esOQTjr9A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Apr 2019 16:34:55 -0700
Message-ID: <CAADnVQ+88HOEM+aJycPd_dWu=rizeNMfQucC+f5refHOTepBGQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/21] bpf: Sysctl hook
To:     Jann Horn <jannh@google.com>
Cc:     Andrey Ignatov <rdna@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Roman Gushchin <guro@fb.com>, Kernel Team <Kernel-team@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 4:22 PM Jann Horn <jannh@google.com> wrote:
>
> But there's a reason why user namespaces are all-or-nothing on these
> things. If the kernel does not explicitly make a sysctl available to a
> container, the sysctl has global effects, and therefore probably
> shouldn't be exposed to anything other than someone with
> administrative privileges across the whole system. If the kernel does
> make it available to a container, the sysctl's effects are limited to
> the container (or otherwise it's a kernel bug).
>
> Can you give examples of sysctls that you want to permit using from
> containers, that wouldn't be accessible in a user namespace?

I think this discussion has started with incorrect
assumptions about the goal of the patch set.
There is no _security_ part here.
The sysctl hook is to prevent silly things to be done by chef
and apps. Most interesting sysctls need root anyway.
The root can detach all progs and do its thing.
Consider tcp_mem sysctl. We've seen it's been misconfigured
and caused performance issues. bpf prog can track what is
being written, alarm, etc.
User namespaces are not applicable here.
