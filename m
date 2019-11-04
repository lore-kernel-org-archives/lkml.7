Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D7FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C07121744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TrDTWGfM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfKDID5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:03:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39542 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfKDID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:03:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id 195so11473032lfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 00:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LxAxNMBVL+dSGienin6qaCrk7en5CTrpwUxUJmlZZRg=;
        b=TrDTWGfMBfFjlWZ8uZDUT0w3BNWxwNGte+a8IpvcI6chs9MWID54loPeAyScghAAh8
         c7UhsZiHgMWlgfVzsY3JlounwUiaxX53oS0f2R2DthwMn0wijXA35T62J9fbrpjvwxSd
         vvkuLYbB2jATrla63DCyxhxyaqfj/lNl8Jy6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LxAxNMBVL+dSGienin6qaCrk7en5CTrpwUxUJmlZZRg=;
        b=OApv2XTCuOtSg731uSsxyx7z3hM+y3iH5SfLcXdNAP2vfQYKxzZKnGj86V/nknoD/R
         i0Hvh72rjtCHDMdXzQBnVglGsYyJaoP456fNsqSY2+r4ChEUBmGzN1LokDlNm3T2lb8q
         FDBPIHNelzsuwyKhMk0gVf2AOwULD3E2MPxfOxVbO8X0Kgzv4hVXf+iJ+0kZnxPCSGSz
         /D25wRlDUZX9Iu+kbqn48R38nr6QKiS00QBiV97mZDs36dOVbE4XPtPyw02UrhMGhogr
         Num2T3FaiLbo81phuE9E5mRCzbT5rGA+OHz1ePB8QHnRuQZ5IC7SzCyXE4XBEXluAVSq
         ATEw==
X-Gm-Message-State: APjAAAU0U4f2KoEPBOa5WIwZk81eKf+4JM4Su/hZJnEMzRKUn4FOAJKa
        cFrL7eOPjVv2J6GZdtuPg9eJSw==
X-Google-Smtp-Source: APXvYqwZ6WMPtJAcL4H1FSM0qke7qolXLVZOH2UexXvXSedbKeL3kV7Vji/MC2YFBHtLQv0vvrHfxw==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr3316354lfl.51.1572854634877;
        Mon, 04 Nov 2019 00:03:54 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e2sm6742553lfc.2.2019.11.04.00.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 00:03:54 -0800 (PST)
Subject: Re: [PATCH v3 31/36] serial: ucc_uart: stub out soft_uart_init for
 !CONFIG_PPC32
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, linux-serial@vger.kernel.org
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-32-linux@rasmusvillemoes.dk>
 <53c1c463-53fc-2005-3b62-a6f430815b45@c-s.fr>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <6d1e4a08-4107-753f-8701-d3acb44b0104@rasmusvillemoes.dk>
Date:   Mon, 4 Nov 2019 09:03:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <53c1c463-53fc-2005-3b62-a6f430815b45@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2019 17.27, Christophe Leroy wrote:
> 
> 
> Le 01/11/2019 à 13:42, Rasmus Villemoes a écrit :
>> The Soft UART hack is only needed for some PPC-based SOCs. To allow
>> building this driver for non-PPC, guard soft_uart_init() and its
>> helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.
> 
> I don't like too much ifdefs in C files, especially arch specific ifdefs
> in generic drivers.

Me neither. However,

> How do we get the QE version on ARM ?
> 
> Wouldn't it be cleaner to create a helper for getting the QE version,
> which would be defined in an arch specific header file, calling
> mfspr(SPRN_SVR) on powerpc and whatever needed on arm ?

First, that would mean we'd have to introduce "depends on PPC32 || ARM"
rather than drop "depends on PPC32". Second, the way the SOC version is
being used to construct the name of the microcode blob seems very
ppc-specific, so I don't see how one can reasonably define an interface
that would work for all architectures. But it's also kind of moot since
the ARM SOCs don't need this workaround.

IMO, having to add qe-specific code to arch/ is a cure worse than the
disease. I'd much rather add arch-specific code to qe.

Rasmus
