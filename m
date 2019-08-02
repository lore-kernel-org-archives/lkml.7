Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D6C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CAA20679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZKC6tyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394188AbfHBO0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:26:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45668 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfHBO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:26:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id m23so72957431lje.12;
        Fri, 02 Aug 2019 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=paaIbNir/NXEYjAZm+URauHUBEaBn2jQk4/QxgIRZ+o=;
        b=pZKC6tyyWabSE6TsKqa54hlpapPQfb7LgC4gz0bBydO8emtZjmttwbz+6rFxVSyS2T
         tWPkDTi5IqaQzgFPx4DvsoeHFCP8/3WaBEeV0QpNa1nI/LyC00XhW/z3HohK4GYmKwBU
         p+f0qmqoOPiSNurp2YFa4SJkJJBMSkwtzgrbtygNRlTz3m1/Q19Y3ZkEphFUUNYCJJ4c
         YfEF84E/QWWWQXh3rzXR943vi6Q8U6err0p8MkAFb8If28dJar+F4TN+86bqfGsQ1Gx6
         gVQ2w+2mSsGC4U0x+0Qcvmchb/N398hiMW56xFjobwREFu4nlKk8SdcT66Ps05dZ9ezH
         KWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=paaIbNir/NXEYjAZm+URauHUBEaBn2jQk4/QxgIRZ+o=;
        b=j/VjsiZz3eSxuhlI9vpQOqaZxoG86AAtqZ1biZ1iw8RQzxcg03HBoLvzO9k/7BlM/g
         UCDn2WiEOsfiJQU/4QHQwT+i1FRPsUhwmDIQrCrIe1KB9ez/lzWw4S3kbJz9ol4JVMW3
         VnqcV2kACGJZULLRLGOzLtl6HbfqIK3zf3OmPtsgRF0alhGX9PAlFhLJGAnwOHkZS0O+
         kfnIu5hbSL1ChjsGiocuXI27VEpGgGnQz7HWkdAbfbAM6DuL+4U2cB1pfTqT4hQIB2Fa
         krEnryKEVrGLHEhKUs7ZuE5V9nMTZ1+DX+tqvZK5HqLgQMWtf67E37SnAVeUVizF6lD3
         EmgA==
X-Gm-Message-State: APjAAAVXPT1GWs3U7CHz0G1IEMDaPkiv185MTtEPxSQqp4J5lk8B4amS
        UG4NiGG916+AaHBHZpuuCK93XW5+
X-Google-Smtp-Source: APXvYqwGvrtuWlVEebCedmJ17hnOi4Og3etQ4F1pMYoIqdinhoWnRFZFsTqQefSjID8BKgfP8y5/jQ==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr70064844ljw.76.1564756007452;
        Fri, 02 Aug 2019 07:26:47 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id q21sm12829914lfc.96.2019.08.02.07.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:26:46 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190730174020.15878-1-digetx@gmail.com>
 <20190802133846.GC3883@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <218c3d60-1a56-7ee8-840b-7d0559cd8c8e@gmail.com>
Date:   Fri, 2 Aug 2019 17:26:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802133846.GC3883@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.08.2019 16:38, Peter De Schrijver пишет:
> On Tue, Jul 30, 2019 at 08:40:19PM +0300, Dmitry Osipenko wrote:
>> The PCLK clock is running off SCLK, which is a critical clock that is
>> very unlikely to randomly change its rate. It is possible to get a
>> lockup if kernel decides to enter LP2 cpuidle from a clk-notifier, which
>> happens occasionally in a case of Tegra30 EMC driver that waits for the
>> clk-change event in the clk-notify handler, because CCF's 'prepare' mutex
>> in kept locked and thus clk_get_rate() wants to sleep with interrupts
>> being disabled.
>>
> 
> I don't think this is the right solution. Eventually we will want to
> scale sclk and pclk because the clock tree power of those is not
> insignificant. Maybe register a notifier which updates the PMC timer
> values when pclk changes?

I also had a thought about the notifier for pclk, but wasn't sure if
it's really worthwhile right now since there is no real use-case and
it's not obvious when such case will materialize. So, I'd say that
solution is correct but incomplete.

I'll make a v4 with the notifier, since you're asking about it. Thanks
for the review!
