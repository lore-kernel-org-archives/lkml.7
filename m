Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A49C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE68206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfHVHwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:52:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfHVHwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:52:21 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 073B2C057E9F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:52:21 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id d64so2594591wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 00:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7BKcrVO8Nhd+WXGWUEZTUpLjr5rNDrS+NAVt7gSeayI=;
        b=EY10/OMQcfCH+mRTScK/Hh1GWEoXGxVhBjC2qxXq+L075wgV4pHDVwOEmAbJWj6bFz
         sLZ5wKAEuH2mUuKbUQvByBkenlS6BN7ZBgIdroFh3IS74wSOcefkTxyoSI2VaCH05M8L
         LMnptInic52wHzlaoJWYCNysh55YNKa1YcPJx6m/ImZ2LFXk1cQiCe4co4Cm6fHvlEdq
         OrTb45udrz6cRGeuvF6Y/xASM5Kd0gCuFVX0PRpBKdzogaK7wUwbRm0lUM/KOHthtXVH
         gA90VRBHiRFV0Zg+jwJ8gg9eTzmVFXHmRNEtzIpqCvk/iKDoBwICF+DyVg8Ea4UG8olQ
         GYfg==
X-Gm-Message-State: APjAAAU1j+xjg7Naj8QKH4xEMbbtoDFS7XPWvPh+/F8vW+1LRNuBeagi
        Vp826zfuPcxoF+UOLGs3389PHuOJOTKccOzcn9mWDbYrRmKOKFjXW7G2aj+r6KBXRjm9gz2q87U
        /M6eW0D47z4PATyhDiGSDVo5Q
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr4324437wmh.122.1566460336705;
        Thu, 22 Aug 2019 00:52:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWuWvgDKAuh+xWDFJnsdBvnUFY6ufegdNELeez5PrP8mvCRsuw/nstCz8A23ZrVau0d9htVA==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr4324415wmh.122.1566460336454;
        Thu, 22 Aug 2019 00:52:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i5sm26461922wrn.48.2019.08.22.00.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 00:52:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/hyper-v: enable TSC page clocksource on 32bit
In-Reply-To: <alpine.DEB.2.21.1908212321320.1983@nanos.tec.linutronix.de>
References: <20190821095650.1841-1-vkuznets@redhat.com> <alpine.DEB.2.21.1908212316040.1983@nanos.tec.linutronix.de> <alpine.DEB.2.21.1908212321320.1983@nanos.tec.linutronix.de>
Date:   Thu, 22 Aug 2019 09:52:14 +0200
Message-ID: <877e75r61d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Wed, 21 Aug 2019, Thomas Gleixner wrote:
>
>> On Wed, 21 Aug 2019, Vitaly Kuznetsov wrote:
>> 
>> > There is no particular reason to not enable TSC page clocksource
>> > on 32-bit. mul_u64_u64_shr() is available and despite the increased
>> > computational complexity (compared to 64bit) TSC page is still a huge
>> > win compared to MSR-based clocksource.
>> > 
>> > In-kernel reads:
>> >   MSR based clocksource: 3361 cycles
>> >   TSC page clocksource: 49 cycles
>> > 
>> > Reads from userspace (unilizing vDSO in case of TSC page):
>> >   MSR based clocksource: 5664 cycles
>> >   TSC page clocksource: 131 cycles
>> > 
>> > Enabling TSC page on 32bits allows us to get rid of CONFIG_HYPERV_TSCPAGE
>> 
>> s/allows us/allows/
>> 
>> > as it is now not any different from CONFIG_HYPERV_TIMER.
>> > 
>> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> > ---
>> >  arch/x86/include/asm/vdso/gettimeofday.h |  6 +++---
>> >  drivers/clocksource/hyperv_timer.c       | 11 -----------
>> >  drivers/hv/Kconfig                       |  3 ---
>> >  include/clocksource/hyperv_timer.h       |  6 ++----
>> >  4 files changed, 5 insertions(+), 21 deletions(-)
>> 
>> Really nice cleanup as a side effect of adding functionality.
>
> That said, could you please rebase that on
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>
> as I just applied the TSC page patches there and this conflicts left and
> right.

Sure, v2 is coming!

-- 
Vitaly
