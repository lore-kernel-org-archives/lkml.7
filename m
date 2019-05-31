Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE6DC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABD4269D7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnA32Q//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfEaScc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:32:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45823 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbfEaScc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:32:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id f20so15844921edt.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 11:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/qCEAxJby+Q3JZ8llKzwy+sZNSav6qCCM0ocEIgzH0k=;
        b=pnA32Q//XASMsJVTAIORwQ21Lho5quheH7a5SypaIQCMLMIGfEoFksi/ihA7ieW7oW
         0k2RRAe8q6vYgDPEe9tILYVo2DQ17b2LlwcGJ4Z2KokwZlydXvUaQ4jlSRyQsUf5qWtf
         BgR8MOc3fktLlLPSQz4/QtCmnYQc0IZAx1EI5CCqgDIpT5DiMGImyQaLU5Tugy8pCta4
         6mTeWQBBi5vm10k9BzI/xPMw/sV32PS7rBtcjVDxC+pM94/USalh2aDx9kPucMWBKsDn
         vYE2L1T8UAUjMXP5KyfJOvizbZ2vnogz3af3NAdB8nYpGXxKuh9tD6fzhmQcGysydUXi
         c6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/qCEAxJby+Q3JZ8llKzwy+sZNSav6qCCM0ocEIgzH0k=;
        b=VPyKXwpxN+buJPpzBLbEQdElGkS1IAzGaLIh23Aupl3vvvv+WaJZJ/yOfd9wA+m5zL
         yDau9Ed9A9HuL2C5k5+Sw4feUCbuboO2sobY2S7y945jT1Pddntq+GR/3K6Tj6vmAT8U
         6aOIuvhQB6qrP8qqMN7vSrc+Ij9eOqPh1wyzXsFm2u6zJeP0jjzzWJtrMLVWVIRVAQt9
         PmX+sg2oCKloHe95Es1BpcOW3DLC2yl/ylnLrXp8oFJTvSJbLp2X18bvI4D/LjTbtX+3
         hVc/MB0WVp6o/d1SrOD91IoQ5O2wnOEjg48agevyfUdEtYZnLFQWDOMIMULBDO7n/0P4
         gWcw==
X-Gm-Message-State: APjAAAVpQ+VNSFGbgs/6btN1KKNT4ES57KmfnuHNyd4q9QVM8H0sMEq9
        /veHnTque0f5kg6b4cCX7aI=
X-Google-Smtp-Source: APXvYqxfLxURqU5ciVrR3TSIjSt8BDjYXtDZo/7u98PKRRpTcl7yXsUg4F/tkPwh30o1QhOS6CWM4g==
X-Received: by 2002:a17:906:265b:: with SMTP id i27mr10809987ejc.147.1559327550493;
        Fri, 31 May 2019 11:32:30 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id n8sm1111182ejk.45.2019.05.31.11.32.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 11:32:29 -0700 (PDT)
Date:   Fri, 31 May 2019 11:32:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with
 CONFIG_CC_IS_GCC
Message-ID: <20190531183227.GA34102@archlinux-epyc>
References: <20190528235742.105510-1-natechancellor@gmail.com>
 <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 10:05:22AM +0200, Arnd Bergmann wrote:
> If I remember correctly, we also had the same issue with older versions
> of clang, possibly even newer ones. Shouldn't we check for a minimum
> compiler version when building with clang to ensure that the code is
> really vectorized?
> 
>        Arnd

Even on tip of tree, it doesn't look like vectorization happens
properly. With -S -Rpass-missed='.*' added to the xor-neon.c command:

/home/nathan/cbl/linux-next/include/asm-generic/xor.h:15:2: remark: the cost-model indicates that interleaving is not beneficial [-Rpass-missed=loop-vectorize]
/home/nathan/cbl/linux-next/include/asm-generic/xor.h:11:1: remark: List vectorization was possible but not beneficial with cost 0 >= 0 [-Rpass-missed=slp-vectorizer]
xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
^

So right now, it doesn't look like there is a minimum version for clang
and I don't think adding a warning for clang is productive (what is a
user supposed to do?)

Cheers,
Nathan
