Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72DBC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78BD28113
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IazKRBbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfFCLPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:15:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41919 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfFCLPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:15:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so10429815pfq.8;
        Mon, 03 Jun 2019 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PjN0az7QArZrmsQJmkJ/5qpl3C88tEWYXS2nv4TfJWw=;
        b=IazKRBbRUmNjd+gZlH5rp0qxNAmfOqEDWyGOMhd76X7RWoJHjElGBr+iSEFeGn1/OO
         cjakAu0KPqFAaPfY1vl9Bs2C3d5Pii6nahyStziKn23bxL5kAoOTkBQwlQSTOGP/jV1J
         NqupfknUl95GuA0/CygMocoDIS5vb6ypSCRd5j0Jm4c+uudwzJ7TNfD95NMHV3cmtccA
         ecm4pyGUVL6wbEVFyYXTrfJmX1qAfqK1elVZKywYkCYQngjWApAHyjXvP4SXKLQH1N0L
         3JsHSjGgDUOeqgTuFzIenuTjV+qFIZXYJWlc2Vd/Sv360sQXJnDbhRfKI/v/EBh5EU/V
         6/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PjN0az7QArZrmsQJmkJ/5qpl3C88tEWYXS2nv4TfJWw=;
        b=LwxCfBNlFTSmtl7FK1YftFhZYt8C3a+nuBOcngRYtL6dqM2aFr1oHhJHL0PgjCFvPi
         qZ+do4nnXsjoTt7OeV64IO2blwRRsLUpT4X8MnCUV+I99AuLIHSXm4flwLIThBr6G/Fy
         WvGZVSxckILpYRE+TeN9S5rkUD8fI+4Np/LjEi13jWGGRBqmN4BXwQX2Tjzuq/8tN9RL
         4VZkUC12p/4GiT+6NjGOQyTpD7VCMy4HYH6QSD1Zr6T4gyzJbJ0NinuWgiiTX1DVCE4u
         Ye5VYsKnmAc10f0RMNnMOwfM1F51oFl2VymQ8iY2//GOXriBijSYq8b4cosdrjFvbqDJ
         j42g==
X-Gm-Message-State: APjAAAUtRsB3NbvCf7qqEcM75tQzzuWskNcPX86kzbY8C3mEFRT1AKRA
        taOWCKkbRBCRf2rKRlDNfoKXJDe3
X-Google-Smtp-Source: APXvYqyYR0rkdfaRHRBoN/HdEUkdmu++yT+gsYMx2ivIlYIvESf8Gq0dsf869wpgQTC/jYrpquSZxw==
X-Received: by 2002:a63:4045:: with SMTP id n66mr27322540pga.386.1559560510231;
        Mon, 03 Jun 2019 04:15:10 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id v23sm15989449pff.185.2019.06.03.04.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 04:15:09 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] NVIDIA Tegra clocksource driver improvements
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Chauvet <kwizart@gmail.com>
References: <20190524153253.28564-1-digetx@gmail.com>
 <20190531082634.GA6070@pdeschrijver-desktop.Nvidia.com>
 <c686aae8-3be0-805e-265b-a7f16f2a6c02@gmail.com>
 <20190603071750.GA29894@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fafaaba1-1d77-f8fa-1a62-d1dd70fd8d52@gmail.com>
Date:   Mon, 3 Jun 2019 14:14:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603071750.GA29894@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.06.2019 10:17, Peter De Schrijver пишет:
> On Fri, May 31, 2019 at 03:33:41PM +0300, Dmitry Osipenko wrote:
>> 31.05.2019 11:26, Peter De Schrijver пишет:
>>> On Fri, May 24, 2019 at 06:32:45PM +0300, Dmitry Osipenko wrote:
>>>> Hello,
>>>>
>>>> This series primarily unifies the driver code across all Tegra SoC
>>>> generations. In a result the clocksources are allocated per-CPU on
>>>> older Tegra's and have a higher rating than the arch-timer, the newer
>>>> Tegra210 is getting support for microsecond clocksource and the driver's
>>>> code is getting much cleaner. Note that arch-timer usage is discouraged on
>>>> all Tegra's due to the time jitter caused by the CPU frequency scaling.
>>>
>>> I think the limitations are more as follows:
>>>
>>> Chip	timer		suffers cpu dvfs jitter		can wakeup from cc7
>>> T20	us-timer	No				Yes
>>> T20	twd timer	Yes				No?
>>> T30	us-timer	No				Yes
>>> T30	twd timer	Yes				No?
>>> T114	us-timer	No				Yes
>>> T114	arch timer	No				Yes
>>> T124	us-timer	No				Yes
>>> T124	arch timer	No				Yes
>>> T210	us-timer	No				Yes
>>> T210	arch timer	No				No
>>> T210	clk_m timer	No				Yes
>>>
>>> right?
>>
>> Doesn't arch timer run off the CPU clock? If yes (that's what I
>> assumed), then it should be affected by the DVFS. Otherwise I'll lower
>> the clocksource's rating for T114/124/132.
>>
> 
> No. It doesn't. This is the big change between A9 and later CPUs. 

Thank you for the clarification, I'll add a patch to lower the rating
where appropriate.
