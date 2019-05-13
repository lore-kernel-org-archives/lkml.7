Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C02C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604E62086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sld5lvhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfEMIE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:04:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38270 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfEMIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:04:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so14084560wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FdczpF+HAtCkzG6jTzIfOqqlgewnqObJbWmhu1Fz2yM=;
        b=Sld5lvhmRWIvM91ctJtd//tpVz1uloPeXyHekhDCoKSGrt3JP/Vx+70r8vP1bQGcwR
         iuYJHi7x2/TnAnszH8u3hL9tssUToBtcKD1H102oNQG7gsGzal8StFurBHnmfiXuL9SQ
         mvtTiKabDcfh+hEcAcdmmdAgMcZ8CdtsRAtMGqvi87YqAHOpnlZ/EFiM2TzaRf+KYfte
         j0DKalgnO5CLWHl9KTE0y36Gue9BnTzanHx2T562Oiz9c1SaALAgOrPc2BVC5XPUq4LO
         cvk9NZ21aRi846aiVdo271IK0QwDfJlQdVDMGZmD1repraLSDKZoqcZBam+wb9qoPkMa
         hZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FdczpF+HAtCkzG6jTzIfOqqlgewnqObJbWmhu1Fz2yM=;
        b=FwPIt+yianXM5fVCGiMVbGiuu//UrByo4ckQoIqh9yQlNt4LU/Va8JyQTItoa6gCHG
         QYUX+5VuxAgwFTAQS2tsupM2VUfQUpOu3f5Um65UCWuHLOhCW6HA2cpNzioI/KvPJnf8
         UYHVngt6TO5aV9H7FwgD04ufboT0PLxPb50Uu8th0Vi6/kVDuyWReosel5zEI0JdQsqR
         q+4lls7tjtTWJdiOZe1kSS5Mtc4UAWuw4LT+oTt9TP1VPW6i5DNp/ec+RhIMx9pQuNtS
         /Y0ehzeOWXAbm1yKMHRj0W7l20nqBNahst7d9sY+0g36h+uKa6YpB6NH5gDz5vKy+U3t
         Rhgw==
X-Gm-Message-State: APjAAAVOLMgRD7JKtv/ZlhhCmQrYd5tbx/Qkd3RyZYihaqTO0Jy6XqQt
        JHePEHaULd+V/pLSGaR7B6a6/Q==
X-Google-Smtp-Source: APXvYqzvj8NuvJYWXTRnd2qzSR8XJHh9J+mCXfue5ISEeA4KA6HWrXpRsrTWXWt04RTsIrJWlms0Jw==
X-Received: by 2002:a5d:434c:: with SMTP id u12mr17399442wrr.92.1557734667055;
        Mon, 13 May 2019 01:04:27 -0700 (PDT)
Received: from [192.168.0.41] (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.googlemail.com with ESMTPSA id e8sm29815369wrc.34.2019.05.13.01.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 01:04:26 -0700 (PDT)
Subject: Re: [RFC 0/2] clocksource: davinci-timer: new driver
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        David Lechner <david@lechnology.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190417144709.19588-1-brgl@bgdev.pl>
 <CAMRc=MdhfEM_CndCjCkY9kWeu+3VPTA7tmTy5PH=2XforZ6aLw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <861538a7-9ee4-307d-433e-54e51a54fb98@linaro.org>
Date:   Mon, 13 May 2019 10:04:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdhfEM_CndCjCkY9kWeu+3VPTA7tmTy5PH=2XforZ6aLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2019 09:54, Bartosz Golaszewski wrote:
> śr., 17 kwi 2019 o 16:47 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Hi Daniel,
>>
>> as discussed - this is the davinci timer driver split into the clockevent
>> and clocksource parts.
>>
>> Since it won't work without all the other (left out for now) changes, I'm
>> marking it as RFC.
>>
>> The code has been simplified as requested, the duplicated enums and the
>> davinci_timer structure have been removed.
>>
>> Please let me know if that's better. I retested it on da850-lcdk, da830-evm
>> and dm365-evm.
>>
>> Bartosz Golaszewski (2):
>>   clocksource: davinci-timer: add support for clockevents
>>   clocksource: timer-davinci: add support for clocksource
>>
>>  drivers/clocksource/Kconfig         |   5 +
>>  drivers/clocksource/Makefile        |   1 +
>>  drivers/clocksource/timer-davinci.c | 342 ++++++++++++++++++++++++++++
>>  include/clocksource/timer-davinci.h |  44 ++++
>>  4 files changed, 392 insertions(+)
>>  create mode 100644 drivers/clocksource/timer-davinci.c
>>  create mode 100644 include/clocksource/timer-davinci.h
>>
>> --
>> 2.21.0
>>
> 
> Hi Daniel,
> 
> it's been almost a month so a gentle ping. Any comments on that?

Oh right, I've been distracted with other things, sorry for that. Let me
review it today.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

