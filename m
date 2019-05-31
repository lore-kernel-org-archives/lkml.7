Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126DCC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BC326E3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 19:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfEaTVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 15:21:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36449 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfEaTVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 15:21:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id u12so2288081qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 12:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/Axm/7nwcI4RwJavi+sPMZhETGsmjoJsyzXG1wGn6A=;
        b=Oa769bV0E57o/mFwm4rFI6VesZYTPFlBeqxErtPkLpIKz2lD4B4olOfEECo9pwj5oe
         bfaPfP2QcMn7dBXg1aFjqM8KqsJ4mDBA5HWTItjp2kjmSq7YHdrIRNLgGd3isihYMbnR
         snIvyUjthS41VCeIp19Hdio0Mhcn23fhJEz9JNE1d1o5d9TE7BqDrdMCUTTGRDqorhEY
         8PyowO3EUEkiB9LQpF54ZccGwgvHZYBfvjiG9GqF4nz5vmX4fQmyuDogGD09pT5Bysk6
         jJzLIiZwj49uvkf/SQhI9hO0yhTtOufs8UqpTYVHpsaU8kLVihQjUrRiBxBTVZhTxMr7
         t9sw==
X-Gm-Message-State: APjAAAX+msaovHPKy/VGbrlk+YAZBKE2H5/PG7jN/OtQDO/uUC6XTlro
        5XYI6rD1aj+yvciO2egBS4tmjGYyzxGm5VsWI/A=
X-Google-Smtp-Source: APXvYqyS23Wu08rwAwTAr7AC8VlLnPp9u0Vb33101ni/Pz03jgR03uZyOBHxcpJpF5Jqjr3IrXxtdoc2pUBXgXv8QRI=
X-Received: by 2002:ac8:2433:: with SMTP id c48mr10515168qtc.18.1559330489729;
 Fri, 31 May 2019 12:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190528235742.105510-1-natechancellor@gmail.com>
 <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com> <20190531183227.GA34102@archlinux-epyc>
In-Reply-To: <20190531183227.GA34102@archlinux-epyc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 21:21:13 +0200
Message-ID: <CAK8P3a1-_KRvoeK4w0b8775izox8fRm=NGJC=yicDRn7J5UW2Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with CONFIG_CC_IS_GCC
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 8:32 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, May 31, 2019 at 10:05:22AM +0200, Arnd Bergmann wrote:
> > If I remember correctly, we also had the same issue with older versions
> > of clang, possibly even newer ones. Shouldn't we check for a minimum
> > compiler version when building with clang to ensure that the code is
> > really vectorized?
> >
> >        Arnd
>
> Even on tip of tree, it doesn't look like vectorization happens
> properly. With -S -Rpass-missed='.*' added to the xor-neon.c command:
>
> /home/nathan/cbl/linux-next/include/asm-generic/xor.h:15:2: remark: the cost-model indicates that interleaving is not beneficial [-Rpass-missed=loop-vectorize]
> /home/nathan/cbl/linux-next/include/asm-generic/xor.h:11:1: remark: List vectorization was possible but not beneficial with cost 0 >= 0 [-Rpass-missed=slp-vectorizer]
> xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
> ^
>
> So right now, it doesn't look like there is a minimum version for clang
> and I don't think adding a warning for clang is productive (what is a
> user supposed to do?)

I see. If we don't have a vectorized version of the xor module with
clang, I would suggest dropping your patch then, and instead adding
a Kconfig dependency on CC_IS_GCC, until clang is able to do it right.

       Arnd
