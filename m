Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D862DC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB842087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoMORwzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfG3RlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:41:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43950 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbfG3RlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:41:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17so38325218ljk.10;
        Tue, 30 Jul 2019 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mo4Ga+8mpxjTSU2D+A1EeShdvnCMvljYCgf2KvE04w=;
        b=EoMORwzuhk3NRLEjQ2uTtxduvaJjWKYuIUUwhSmV0VI3cXX7P8OQbs99XOiaw7wd+V
         Pm3rw1F8fbosIAFNidbpVErSmAtfCOAAXBUz7/4upmGwvF8KgauioZZ+3KYbRTkbyw5s
         qj90L0zeh/RN+CesUvFBuu7RunzF2eAlZ3EoGycAEOOPUVkeadYKW5BMSFtKEiE12HIs
         jzQAaeUIDOrwS3NIoPa4sXJH+AdfBzslZjTqcdIxs4oG9f1EWH56ssiaeXssIrvub71y
         KPom5xaRaoMuIaaR9J7FqaxwpOunahvONCBJUePmkuaHVolUAjKhGKu1TGruEg5iV6J+
         ioMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mo4Ga+8mpxjTSU2D+A1EeShdvnCMvljYCgf2KvE04w=;
        b=S6m1vXVep9RevrHXITCSypHoF+RoAsVStHp38LrYFO+mhEtxYiZgD5pCkU0SVr/Hd3
         pUNk0xQeybPaWpBFj5sCc+7M/uEjcLbYqjxl+EmoQQ8iG35WdJ9d8qbp7zznSrFhCskA
         0zF/+rT1Z1eYtt1eIvlevqhSGxBCHVqr8043mGZeePjIw+JYyECDfkEoxf3moDpOXjSs
         IGwrQUGUvMEGbc09Y02vrBJ+U666zKPgpO0Eu1lWAJs2G7Iv0ATBoX8ZaUUBTMUZ1Ak8
         okGnwgX6C8886T7KWrhUmL5YVdDqnz0y2LZpiGnXE9zHxtcOThLwmGh1/vl5zWsyNjaK
         OpDg==
X-Gm-Message-State: APjAAAVSy2tykIxPHInwMpGDVTRMT9nDlqRebB7SzUqYlPvxVN1TNm40
        cUEFUekEHGwNCJpR2oDz2s4pdLAl
X-Google-Smtp-Source: APXvYqzS5ppW/dTvIDr7a/OZHu40bdimurRO2Vnj4fqDdOJPiigMEZTM+7Zv6n4JaTpXgRxJ43H6QQ==
X-Received: by 2002:a2e:3602:: with SMTP id d2mr3253681lja.112.1564508458168;
        Tue, 30 Jul 2019 10:40:58 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id 24sm15424438ljs.63.2019.07.30.10.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 10:40:57 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] soc/tegra: pmc: Query PCLK clock rate at probe
 time
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190723023511.24542-1-digetx@gmail.com>
 <20190725093644.GJ12715@pdeschrijver-desktop.Nvidia.com>
 <f7879942-0875-1f27-5870-3f8414c2148d@gmail.com>
 <7e76b679-1a65-fa14-2cc6-2b27ece8131c@gmail.com>
Message-ID: <0a24e723-ca4e-7b51-33a2-74eff141e1ce@gmail.com>
Date:   Tue, 30 Jul 2019 20:40:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7e76b679-1a65-fa14-2cc6-2b27ece8131c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.07.2019 16:07, Dmitry Osipenko пишет:
> 25.07.2019 14:15, Dmitry Osipenko пишет:
>> 25.07.2019 12:36, Peter De Schrijver пишет:
>>> On Tue, Jul 23, 2019 at 05:35:10AM +0300, Dmitry Osipenko wrote:
>>>> The PCLK clock is running off SCLK, which is a critical clock that is
>>>> very unlikely to randomly change its rate. It's also a bit clumsy (and
>>>> apparently incorrect) to query the clock's rate with interrupts being
>>>> disabled because clk_get_rate() takes a mutex and that's the case during
>>>> suspend/cpuidle entering.
>>>>
>>>
>>> SCLK and PCLK certainly can change rate at runtime, although the code to
>>> handle this hasn't reached upstream yet.
>>
>> Okay, maybe this patch is indeed not very worthwhile then. I'm leaving
>> it up to you, guys, to decide.
>>
> 
> I now recalled what was the initial reason for this patch because
> happened to bump into the problem once again.. it's really problematic
> to call clk_get_rate() with the disabled preemption because some clk
> notifier handler may block (EMC) and cause reschedule, hence the CCF
> 'prepare' mutex is kept locked during of CPUIDLE driver entering LP2
> state and thus causing system lockup, since scheduling with the disabled
> interrupts obviously won't work well.
> 
> So this patch actually is needed to be applied or some other solution
> have to be provided. Since PCLK rate currently isn't altering anywhere
> in the kernel, I'd suggest to imply apply this series. Please let me
> know if you have any objections. I may re-iterate this patch with an
> extended commit message, describing the resolved problem in a more
> details, if necessary.
> 

I'll send v3 with a changed commit's message, please take a look at it.
