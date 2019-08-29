Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658ADC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE722070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH2OPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:15:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfH2OPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:15:45 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i3LBF-0003Tp-Tp
        for linux-kernel@vger.kernel.org; Thu, 29 Aug 2019 14:13:42 +0000
Received: by mail-pf1-f197.google.com with SMTP id w30so2604395pfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=GYvTdCfNIJLEcLEkMMRAs0zx2HzNWruXtOTwWsJt6vs=;
        b=abwSaSpZqebjwHdPv9/4ps72SU4ZLzImo5DolK+Csax72fiFHLJ8FN/90K1bi9zlRz
         l46VL2LQ7396aO/LlPuLtx7NHkLnhsF5vcUrVPhPy9dGtS+Rf25Kpz4BjtvZZO0Rva2+
         oZk62u0ZLcRzyf9CmcalHXyIGd/QX2qcTuMIR8wR4jts79I140fP9Cvmb15uk1ByCAGp
         q6gIEVEMb2swwWJLwswkHnUVGgPjTNi9XlPR1Ad0f6sRkrl9ShLYKgTTDBMCRO+/0HrY
         CAADs8vZsjGvphCWSxRWCkONNEEl8JgUkqREScAQ6ZKTicJ20Wb6O0S09QwxAWqttGiz
         uLng==
X-Gm-Message-State: APjAAAX9tq43/gZVgRFWdmOunFY//dp9M0VxYyB5/RUl7WjvmS82nzhZ
        F3EmHKA31+q/OsFMZxyIZays6liFrOmtmQbJRzYI13Jy6v2GdjoqXrQE2WKf3ZmNrVZ72IGTj+o
        U5sVbV1ZdQdXFbKDZm8yV+J72UTKwgAXacHsfax/Aog==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr10186221plu.133.1567088020649;
        Thu, 29 Aug 2019 07:13:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzG8az5f+H61s4CqgSdjR3nbpHUIAS23J32uOtPQjF70pRytAWrQUSbH0WgnbNSEVsjwoCXfQ==
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr10186190plu.133.1567088020335;
        Thu, 29 Aug 2019 07:13:40 -0700 (PDT)
Received: from 2001-b011-380f-3c42-c1f6-ed57-34d8-2c76.dynamic-ip6.hinet.net (2001-b011-380f-3c42-c1f6-ed57-34d8-2c76.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:c1f6:ed57:34d8:2c76])
        by smtp.gmail.com with ESMTPSA id m125sm3373273pfm.139.2019.08.29.07.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 07:13:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] x86/hpet: Disable HPET on Intel Coffe Lake
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <alpine.DEB.2.21.1908291351510.1938@nanos.tec.linutronix.de>
Date:   Thu, 29 Aug 2019 22:13:32 +0800
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, harry.pan@intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Transfer-Encoding: 8bit
Message-Id: <793CCD4F-35E0-46B9-B5D4-3D3233BA5D35@canonical.com>
References: <20190829091232.15065-1-kai.heng.feng@canonical.com>
 <alpine.DEB.2.21.1908291351510.1938@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 20:13, Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 29 Aug 2019, Kai-Heng Feng wrote:
>
>> Some Coffee Lake platforms have skewed HPET timer once the SoCs entered
>> PC10, and marked TSC as unstable clocksource as result.
>
> So here you talk about Coffee Lake and in the patch you use KABYLAKE.

Coffeelake has the same model number as Kabylake.

>
>> Harry Pan identified it's a firmware bug [1].
>>
>> To prevent creating a circular dependency between HPET and TSC, let's
>> disable HPET on affected platforms.
>>
>> [1]:  
>> https://lore.kernel.org/lkml/20190516090651.1396-1-harry.pan@intel.com/
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203183
>
> Please use Link:// for reference not [1] and not Bugzilla:

Ok.

>
>> +static const struct x86_cpu_id hpet_blacklist[] __initconst = {
>> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_MOBILE },
>> +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_DESKTOP },
>
> So this disables HPET on all Kaby Lake variants not just on the affected
> Coffee Lakes. I know that I rejected the initial patch with the random
> stepping cutoff...
>
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de
>
> In the other attempt to 'fix' this I asked for clarification, but silence
> from Intel after this:
>
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.1905182015320.3019@nanos.tec.linutronix.de
>
> Can Intel please provide some useful information about this finally?

Hopefully Intel can provide more info.

I know we should find the root cause rather than stopping at "it’s a  
firmware bug”, but users are already affected by this issue [1].
Is there any better short-term workaround?

[1] https://bugzilla.kernel.org/show_bug.cgi?id=204537

Kai-Heng

>
> Thanks,
>
> 	tglx


