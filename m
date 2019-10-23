Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55840CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18AB214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="D/CIKos7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfJWHId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:08:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36717 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbfJWHId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:08:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id u16so15147677lfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=myl9hp8GAdZ10Vh56qyy6JaHhxuDJ9OqLHFd3viE44w=;
        b=D/CIKos7wpo0yugt6OSXX7bSNd0uG+7P8UyKC6tUPLOGlg3lpLAmJCUCqZRgkpJSmQ
         /ua9qSJgNrl1LsDsy10IsXdPlR6Fv1rZxxYSOM/ZcCJ0mDG8jrtIdD8yFOK61FPzQ90u
         hFpSSl11Te5wvXzmj7gDzCd2zmJkM16v/LNQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=myl9hp8GAdZ10Vh56qyy6JaHhxuDJ9OqLHFd3viE44w=;
        b=auZ+0nNsUjphELbzrVkaqkNah6ga3hsQC494Qw08His/Voqg9FnDFUce/M8gWSy3xV
         7NDSvnTVkwteYMH0XnX2v+WtgC6pzZysJ4y9uGS40YH5tNj7xRoozHYn+S0N+YaoUYFo
         R3fUa4pMD6FnsjRGl4cL6t+t057iJIINs8tM5WQ1sWD+x48ThVasUVK2627oWy21TL75
         8S0UOWjUV81syVqC8EdxpamYCZA3rLn+yaP4nK5EgK042QbVRWQzeHyQ0gozYjCKUtvT
         S9CDai7DTW/tSw+Oypho8eF2cFWrfrhjQ8NQJ2nz54ZDScbWbyhBomihiVgNJHcKLYBK
         KG6g==
X-Gm-Message-State: APjAAAUxCPPhTCxwqQehlrTXAIMk0giVCW3Vgjzm4H1q8zEQb3GWNGA4
        oy9CkBlydYR4hMcaLW1p3MNRTQ==
X-Google-Smtp-Source: APXvYqwRZFXEAB1sX7Quxj/Hpyb451DS8Gl1oBwoo5NLaCgiUg7xN2GoprYTPQVnWp6BHkMtcSr9Mg==
X-Received: by 2002:a19:c354:: with SMTP id t81mr13587917lff.179.1571814509700;
        Wed, 23 Oct 2019 00:08:29 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r6sm9908883ljr.77.2019.10.23.00.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 00:08:29 -0700 (PDT)
Subject: Re: [PATCH 3/7] soc: fsl: qe: avoid ppc-specific io accessors
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191018125234.21825-4-linux@rasmusvillemoes.dk>
 <6ee121cf-0e3d-4aa0-2593-fcb00995e429@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <47d45f33-d5aa-b4b5-9b5f-2e86e309a206@rasmusvillemoes.dk>
Date:   Wed, 23 Oct 2019 09:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6ee121cf-0e3d-4aa0-2593-fcb00995e429@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2019 17.01, Christophe Leroy wrote:
> 
> 
> On 10/18/2019 12:52 PM, Rasmus Villemoes wrote:
>> In preparation for allowing to build QE support for architectures
>> other than PPC, replace the ppc-specific io accessors. Done via
>>
> 
> This patch is not transparent in terms of performance, functions get
> changed significantly.
> 
> Before the patch:
> 
> 00000330 <ucc_fast_enable>:
>  330:    81 43 00 04     lwz     r10,4(r3)
>  334:    7c 00 04 ac     hwsync
>  338:    81 2a 00 00     lwz     r9,0(r10)
>  33c:    0c 09 00 00     twi     0,r9,0
>  340:    4c 00 01 2c     isync
>  344:    70 88 00 02     andi.   r8,r4,2
>  348:    41 82 00 10     beq     358 <ucc_fast_enable+0x28>
>  34c:    39 00 00 01     li      r8,1
>  350:    91 03 00 10     stw     r8,16(r3)
>  354:    61 29 00 10     ori     r9,r9,16
>  358:    70 88 00 01     andi.   r8,r4,1
>  35c:    41 82 00 10     beq     36c <ucc_fast_enable+0x3c>
>  360:    39 00 00 01     li      r8,1
>  364:    91 03 00 14     stw     r8,20(r3)
>  368:    61 29 00 20     ori     r9,r9,32
>  36c:    7c 00 04 ac     hwsync
>  370:    91 2a 00 00     stw     r9,0(r10)
>  374:    4e 80 00 20     blr
> 
> After the patch:
> 
> 0000030c <ucc_fast_enable>:
>  30c:    94 21 ff e0     stwu    r1,-32(r1)
>  310:    7c 08 02 a6     mflr    r0
>  314:    bf a1 00 14     stmw    r29,20(r1)
>  318:    7c 9f 23 78     mr      r31,r4
>  31c:    90 01 00 24     stw     r0,36(r1)
>  320:    7c 7e 1b 78     mr      r30,r3
>  324:    83 a3 00 04     lwz     r29,4(r3)
>  328:    7f a3 eb 78     mr      r3,r29
>  32c:    48 00 00 01     bl      32c <ucc_fast_enable+0x20>
>             32c: R_PPC_REL24    ioread32be
>  330:    73 e9 00 02     andi.   r9,r31,2
>  334:    41 82 00 10     beq     344 <ucc_fast_enable+0x38>
>  338:    39 20 00 01     li      r9,1
>  33c:    91 3e 00 10     stw     r9,16(r30)
>  340:    60 63 00 10     ori     r3,r3,16
>  344:    73 e9 00 01     andi.   r9,r31,1
>  348:    41 82 00 10     beq     358 <ucc_fast_enable+0x4c>
>  34c:    39 20 00 01     li      r9,1
>  350:    91 3e 00 14     stw     r9,20(r30)
>  354:    60 63 00 20     ori     r3,r3,32
>  358:    80 01 00 24     lwz     r0,36(r1)
>  35c:    7f a4 eb 78     mr      r4,r29
>  360:    bb a1 00 14     lmw     r29,20(r1)
>  364:    7c 08 03 a6     mtlr    r0
>  368:    38 21 00 20     addi    r1,r1,32
>  36c:    48 00 00 00     b       36c <ucc_fast_enable+0x60>
>             36c: R_PPC_REL24    iowrite32be

True. Do you know why powerpc uses out-of-line versions of these
accessors when !PPC_INDIRECT_PIO, i.e. at least all of PPC32? It's quite
a bit beyond the scope of this series, but I'd expect moving most if not
all of arch/powerpc/kernel/iomap.c into asm/io.h (guarded by
!defined(CONFIG_PPC_INDIRECT_PIO) of course) as static inlines would
benefit all ppc32 users of iowrite32 and friends.

Is there some other primitive available that (a) is defined on all
architectures (or at least both ppc and arm) and (b) expands to good
code in both/all cases?

Note that a few uses of the the iowrite32be accessors has already
appeared in the qe code with the introduction of the qe_clrsetbits()
helpers in bb8b2062af.

Rasmus
