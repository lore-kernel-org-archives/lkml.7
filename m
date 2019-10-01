Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ECBECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3328E2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbfJAPrR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:47:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42414 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfJAPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:47:17 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iFKMs-0007gU-T7
        for linux-kernel@vger.kernel.org; Tue, 01 Oct 2019 15:47:15 +0000
Received: by mail-pl1-f197.google.com with SMTP id q3so6825078pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 08:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RGtmeDaWQ2PLOrLjjSWHp10RVFNcjpR+uy+qIs5ilhg=;
        b=n/48/qaXI4SZHkLqQXulSG11XfHOvBTTvHoCoQQV6ou80/EF3LUU3KALg8N+g1m6xK
         GxnaY+E06tbCMaxeGFXIQl4Hc29BIWuvSnmQYE2wAcpn4R0A5xKFLyeA86rFKMlpDZDp
         yPr3jSbJN93M3JtlE9MN24y5cQhAjmd08bsl1SoSgqZLfnQNZFDzg2imzALAt8BsYVmA
         OTHL88p5lDk5mwIVlG4SvbTms7nghsDz66YXGhhvvwO6BudX1cpyn2RYC0DMI/02tYaz
         dTCYbtQtcWpyTDzckvLTWtat0ib4mE3luZjtlaoLAzkeZmxPgkayVEa3/XQ/VxPP/4Wn
         OKTA==
X-Gm-Message-State: APjAAAWik4KFy9QPWCDZWK6YJ2GzAANnsVNXYna2K9uToezPQ4dXhIkf
        e496FEemCnb6xaMpnMkYQ+sadR7GgUZME3Vvq4Wyt0cTMJS9V+9nZGo1dl6hi7vLLpH7F3Q7rON
        cAR4XtqfpZ+CFF9N+Hs+iq9pOlOTm+7g/yu0Ir7JgYw==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr25665308pla.55.1569944833597;
        Tue, 01 Oct 2019 08:47:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzTmBDzmDD5Gq/M0Nmo1P95MkWgmVx0tHs01qpaU8vuAmvr5uRPm8Pme+CeE8oxEIlpGWsSA==
X-Received: by 2002:a17:902:2e:: with SMTP id 43mr25665282pla.55.1569944833294;
        Tue, 01 Oct 2019 08:47:13 -0700 (PDT)
Received: from 2001-b011-380f-3c42-1844-8b0c-6a55-1ec2.dynamic-ip6.hinet.net (2001-b011-380f-3c42-1844-8b0c-6a55-1ec2.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:1844:8b0c:6a55:1ec2])
        by smtp.gmail.com with ESMTPSA id 127sm20201005pfy.56.2019.10.01.08.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 08:47:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Subject: Re: [PATCH] x86/hpet: Disable HPET on Intel Coffe Lake
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <alpine.DEB.2.21.1908292143300.1938@nanos.tec.linutronix.de>
Date:   Tue, 1 Oct 2019 23:47:09 +0800
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, harry.pan@intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A863DF08-2275-4FEA-9A0D-44C5D4807458@canonical.com>
References: <20190829091232.15065-1-kai.heng.feng@canonical.com>
 <alpine.DEB.2.21.1908291351510.1938@nanos.tec.linutronix.de>
 <793CCD4F-35E0-46B9-B5D4-3D3233BA5D35@canonical.com>
 <alpine.DEB.2.21.1908292143300.1938@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3594.4.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> On Aug 30, 2019, at 03:45, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Thu, 29 Aug 2019, Kai-Heng Feng wrote:
>> at 20:13, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> On Thu, 29 Aug 2019, Kai-Heng Feng wrote:
>>> 
>>>> Some Coffee Lake platforms have skewed HPET timer once the SoCs entered
>>>> PC10, and marked TSC as unstable clocksource as result.
>>> 
>>> So here you talk about Coffee Lake and in the patch you use KABYLAKE.
>> 
>> Coffeelake has the same model number as Kabylake.
> 
> Yeah, just a bit more text explaining that would be helpful.
> 
>>>> +static const struct x86_cpu_id hpet_blacklist[] __initconst = {
>>>> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_MOBILE },
>>>> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_DESKTOP },
>>> 
>>> So this disables HPET on all Kaby Lake variants not just on the affected
>>> Coffee Lakes. I know that I rejected the initial patch with the random
>>> stepping cutoff...
>>> 
>>> https://lore.kernel.org/lkml/alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de
>>> 
>>> In the other attempt to 'fix' this I asked for clarification, but silence
>>> from Intel after this:
>>> 
>>> https://lore.kernel.org/lkml/alpine.DEB.2.21.1905182015320.3019@nanos.tec.linutronix.de
>>> 
>>> Can Intel please provide some useful information about this finally?
>> 
>> Hopefully Intel can provide more info.
>> 
>> I know we should find the root cause rather than stopping at "it’s a firmware
>> bug”, but users are already affected by this issue [1].
>> Is there any better short-term workaround?
> 
> Not really. And if Intel stays silent, I'm just going to apply it as is
> along with a stable tag.

Seems like there's still no updates from Intel. Can we have this patch in v5.4?

Kai-Heng

> 
> Thanks,
> 
> 	tglx

