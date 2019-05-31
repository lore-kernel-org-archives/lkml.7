Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA79FC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC9B26EEB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 20:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv43EpmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfEaU0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 16:26:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42372 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfEaU0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 16:26:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id g24so6692552eds.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gkdrhj+L2y9Un3DqIxCBN2IczH3NAgr/P0YLMvWGg3k=;
        b=Xv43EpmEIYCOnqrcH6IC1jp47hvR8jTZmpsuMilbWt6IoPWH1ceBQLdNcwW1Ar1Tfc
         BaL/lNspAs5IRQaUY2ITsepMDgaj4bX36mXu8JbEV2gn5MfxqziePZ1goCdh5rxF2xRA
         ephcT0SA8NIjA9rlqzcqsDfFXVSRJ4VndZuCK5rnmo2R7Pa8KPARwxESCUxVSjFOQ1bw
         nn6Bxa61HWZ7m7UPLW9L54TSAB8QXfwRo79eIgjevEGPWCKOOxgF3+WGb9v93fCtZ3wH
         8Y6Ye6iZTLO/yFY9AUWH/B6+RJj7c9Q/h8j3uw1AQaxu4kNzFkHkNhvxFovkT2M13MWh
         GCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gkdrhj+L2y9Un3DqIxCBN2IczH3NAgr/P0YLMvWGg3k=;
        b=tXJ1GZhzw5BiIgC13sg92xyCgSabkdg+JS5m5wVc1rQO+G2RSye4lA8I2qGCGU1j6J
         v1FZXgpBJ7fjf3HFIgP9wEKn7OoukosIIzL4rtgkW7JPjxkbrncnW1mHLNENAR7rW20c
         Ay+mNWnBzt1RKTnagBWzzBLudbwDsh4074gOZvH0wuqzpTmdf1fVyr5sEGHxPhNb55wR
         dNlgWudp1lGV/cS8B7SlPrQLHo8IV+m+kgit2694dRNsiZkjtXuE63pvrXpmojoLyFzq
         wGK7gGOv+0LxvU5ugm0zgk4RhFtMhysnxVkQ2ZoOWvTtNebMiotH3lZkDgbZDzaOhcX5
         95ow==
X-Gm-Message-State: APjAAAVzcHQrvYKI6yuUobnji9kUna1Lin3nh6compUUmwfPkJN1ey+e
        qkAbQIg94Y/jwenv2/Btx/w=
X-Google-Smtp-Source: APXvYqxixZFEj5U32gsuL97OYf945hk0gTpmJ868WJqXPlesOklKj4GB4h8NEuJIo6Ibi7k6Kx9AYA==
X-Received: by 2002:a17:906:a94c:: with SMTP id hh12mr11415070ejb.143.1559334368623;
        Fri, 31 May 2019 13:26:08 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id i45sm1892124eda.67.2019.05.31.13.26.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 13:26:07 -0700 (PDT)
Date:   Fri, 31 May 2019 13:26:05 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with
 CONFIG_CC_IS_GCC
Message-ID: <20190531202605.GA78113@archlinux-epyc>
References: <20190528235742.105510-1-natechancellor@gmail.com>
 <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com>
 <20190531183227.GA34102@archlinux-epyc>
 <CAK8P3a1-_KRvoeK4w0b8775izox8fRm=NGJC=yicDRn7J5UW2Q@mail.gmail.com>
 <CAKwvOdkyk3qLMPquSZqXCFauTADJU5X9qJi_fhJqbUuCYBH-6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkyk3qLMPquSZqXCFauTADJU5X9qJi_fhJqbUuCYBH-6Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 01:06:13PM -0700, Nick Desaulniers wrote:
> On Fri, May 31, 2019 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > clang, I would suggest dropping your patch then, and instead adding
> 
> I disagree.  The minimum version of gcc required to build the kernel
> is 4.6, so the comment about older versions of gcc is irrelevant and
> should be removed.
> 
> Nathan's -Rpass warnings are warning that vectorization was not
> calculated to be profitable **for 1 of the 4 functions** by LLVM.
> Surely we wouldn't disable NEON opts for XOR because 1 of 4 was not
> vectorized?

Well I kept it short but clang warns that all of the loops are not
profitable.

However, the config option for xor-neon.c is CONFIG_XOR_BLOCKS, which
also controls the arm64 implementation. We wouldn't want to disable it
for clang altogether if it works on arm64 fine.

If it turns out to be broken for both, I suppose I would be okay with
disabling CONFIG_XOR_BLOCKS for clang but it should be done in a
separate patch as this one should be applied regardless of clang working
or not (because this warning will appear again when clang is fixed).

Cheers,
Nathan
