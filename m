Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E73DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D6020675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVwtD8NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfCFAsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:48:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38806 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfCFAsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:48:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id n125so7040781pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 16:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2s/7acSUCtYOlRxTJysPz2Rut01nG49rOQn+xSRqMiM=;
        b=DVwtD8NY9jB4TQAL79Hc2X+FGQ0d6H/cOE0OHfJ31Q/F+W+MMccAVWBPVCTS+GtCCm
         rn9FQsaOwTfNxyQsrkfKSi3AO7dRrY2Z2iI6u2arfCu9QPAmNtJdb+RJeBHOher9Wlgh
         BxJob+WrfNWq3w1fCrqry3cmUkNK3qhILMFrS0/aBDl+6Le1tUi1xO3wybvyw5WIoOgj
         +coPWTfGuECq46oyYpILOBIPJ6QIuILwyQmd+cObqBVt26IB6mq2P8VMqRoeE7MFl6hU
         K2UytxJBmhcCFfJ15VdjIW6KczQBUlGdWLjiiX83xrtzIWxjzOsjxUIRqgw+Fy2RG4nT
         8ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2s/7acSUCtYOlRxTJysPz2Rut01nG49rOQn+xSRqMiM=;
        b=mrdD4D1xC00qmDPuC2Eq3JmGvktxKDzSM4ej2NYLo2Hv1PVVpKYo8+HCMl3biJ6Crv
         i17hFu3Gj8DbBiUk8TDkn2T7F9oPXKHxkjWXaIt9NmwKMMhTZO07o/gpRQ3NRHfrG7do
         GidBAFGtjJR4rMSDQGRDHSp4WrM11zU60Ru9tO2vocK9ltGSGkqHVNvHfQgpSBD/JvDC
         GAjxnVvLAlDF8apOnSgvUpH3A5dSaXEa8b8+RnR0/CtGX9KdNTZNNlme5+0jVUpJKFOV
         EFjdfbNElzxWkgsd6yWS6Spl+o15p/WwkwxkJADaT5bremPdkGQF5XQAwJ+YUGvxTj6j
         aYOQ==
X-Gm-Message-State: APjAAAU6VQ3rfrbXqvT3J6Sry9LbF6tKDE9KhaXjmlzmumGLCXqlEqZs
        0W+Mafcf69UveUs6JUv8HR0F84CYCM3pxlA9WyCLGw==
X-Google-Smtp-Source: APXvYqz0kJJrit4Cw+dZKCckjNC+PHn0ESVoIFo4MNX7yY9StX4dq88PoJTYi1/5es3/sFLmSoxiR9tgBQcYvU4qfiE=
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr4082690pld.238.1551833286730;
 Tue, 05 Mar 2019 16:48:06 -0800 (PST)
MIME-Version: 1.0
References: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
 <cdf451c0-3947-9be1-3bee-2366577c4c5f@arm.com>
In-Reply-To: <cdf451c0-3947-9be1-3bee-2366577c4c5f@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Mar 2019 16:47:55 -0800
Message-ID: <CAKwvOdnb58nGXdweWTobGjqry7=9ZmfnMWnjTn8uHKt=Z5iabQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: drop unnecessary WASM
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        LKML <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Peter Smith <Peter.Smith@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 3:39 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Stefan,
>
> On 2019-03-05 10:18 pm, Stefan Agner wrote:
> > The W macro for generating wide instructions when targeting Thumb-2
> > is not required for the preload data instructions (pld, pldw) since
> > they are only available as wide instructions. The GNU assembler seems
> > to work with or without the .w appended when compiling an Thumb-2
> > kernel. However, Clang's integrated assembler does not consider the
> > .w variants as valid instructions:
> >
> >    ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
> >                            "pldw.w\t%a0 \n"
> >                             ^
> >    <inline asm>:2:1: note: instantiated into assembly here
> >    pldw.w  [r0]
> >    ^
> >    1 error generated.
>
> Have you filed a bug against Clang for that? Something like "pldwal.w"

Yes; please.  For each deficiency you find, please file a bug.  We're
working on identifying what's missing from Clang's integrated
assembler support.  Given the list of issues, it's easier to estimate
how much effort is needed, which helps us allocate resources towards
fixing those issues better.

It would be good to know if pldw.w is valid under UAL or not.

Hopefully, the ARM kernel team can stress the importance of assembler
support for their ISA to their LLVM team.
-- 
Thanks,
~Nick Desaulniers
