Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB78924AE5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 15:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRS+FtGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfFDPBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:01:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34902 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfFDPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 11:01:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so16724333lfg.2;
        Tue, 04 Jun 2019 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8SlFAHiJu+3aR6xJ/URjkVb8/c7nAggXJg7wPI6sVIs=;
        b=gRS+FtGPWu/slOwa2+pvby4OuvlyjPvkH219eej5UmPXyY9Q+PELPiRrFsiBbw7l0R
         cVo7yiQlduLboGpYX7rbBFoytsEpkU8ZiiXxY5Nz5PPC8WxKIzhZc2F1jgKgH5dZlKZU
         3ee2n4JlEaO5y7b+KYUowm+PO0oqPdbuQmpe1pajGlPixdWIj2uVYJHjH32nSUl5LRQw
         sLEfDkPMdXom4wgJo8CybACtBz4f6k0vk2NZOJEUqRRXu3AHHUpXOKEKhVSY+seI8sTF
         JJP4wNGYqu2k+8Z9LelrPFBrQDSN67ZzDq5l9hNo2f2W+oPuznZLJ4WKJHSNBn6/x/XL
         1wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8SlFAHiJu+3aR6xJ/URjkVb8/c7nAggXJg7wPI6sVIs=;
        b=CvXYcchbHXzgKNx5+UIkr99fajfzLWVVGRi5j7dlPlbSJL1UaM2yCf92cPy4qJGF3f
         t2Qd2N3nX0SNMRcrQZH8vK4UPzl9ha45PmgFFaqo9rMVC08wMpCOS/ou0Y3Efqw0JLcE
         I7d05i2zyVfFpBfDx33e3/9guL1QxxqqGrKVZfqpgx2/urnoZqyKcjYowf+U4q7wA4X2
         wSpHvUSpOKCekuZsWn+d+JWCcMLY3Zg6QTgsshLt/gy+ygQfEkP8MoB4RkrFLcdLA4f+
         2Jv49YbiMdbGis3nxwGyWTfKI25I2ugXAwMIXvLkh59OU9jM0qFW4jVDm6cGBNcfiHM+
         RUjQ==
X-Gm-Message-State: APjAAAVniwX9dfcBKMOTUgOeiyMRFD7F0q+Cvc5et55J66cMOBrCi+oV
        UzUz62TVBCAqq2CK81RkmbyyfLv4
X-Google-Smtp-Source: APXvYqwwaXwprzQvym5GUuKakkyyMXKPYDJCI2pVof7ziH0bNPHSFfE/S0cmKpJ4NlsPxAxfxHEkfA==
X-Received: by 2002:ac2:44a4:: with SMTP id c4mr16666587lfm.116.1559660469741;
        Tue, 04 Jun 2019 08:01:09 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id i188sm2562664lji.4.2019.06.04.08.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 08:01:08 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] NVIDIA Tegra clocksource driver improvements
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190603185948.30438-1-digetx@gmail.com>
 <20190604133355.GE29894@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <93d3f559-d42a-9a3b-50b5-b91471261c34@gmail.com>
Date:   Tue, 4 Jun 2019 18:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604133355.GE29894@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.06.2019 16:33, Peter De Schrijver пишет:
> On Mon, Jun 03, 2019 at 09:59:38PM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series primarily unifies the driver code across all Tegra SoC
>> generations. In a result the clocksources are allocated per-CPU on
>> older Tegra's and have a higher rating than the arch-timer where
>> appropriate, the newer Tegra210 is getting support for microsecond
>> clocksource and the driver's code is getting much cleaner.
>>
>> The series was extensively tested on Tegra20 and Tegra30.
>>
>> Changelog:
>>
>> v4: In the comment to v3 Peter De Schrijver pointed out that arch-timer
>>     isn't affected by DVFS changes and thus it is preferred over tegra-timer
>>     on [T114, T210). Added new patch to address that: "Lower clocksource
>>     rating for some Tegra's".
>>
>>     Daniel Lezcano suggested that it will be worthwhile to rename driver's
>>     source file as driver now covers more SoC generations than it initially
>>     did. Hence the new "Rename timer-tegra20.c to timer-tegra.c" patch.
>>
>> v3: Fixed compilation on ARM64. Turned out that it doesn't have the
>>     delay-timer, thanks to Nicolas Chauvet for the report.
>>
>>     Added new "Support COMPILE_TEST universally" patch for better
>>     compile-test coverage.
>>
>> v2: Rebased on recent linux-next. Now all of #ifdef's are removed from the
>>     code due to the recent patch that generalized persistent clocksource.
>>
>>     Couple other minor cosmetic changes.
> 
> Series Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
> 

Thanks!
