Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141C020879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdGbz448"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfEMLDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:03:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51382 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfEMLDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:03:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so13421125wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WRqvTnSf7OQ2cd1bvnl7SkQVvla7dUVQROgM13fu2Aw=;
        b=RdGbz448Xl7sbCh8S+513r/0nCFaMWckXqFBkpfJ72V37wRhZb+f3STpFIQ2D5Rqhw
         /IYuzb97jjx301h/PZvzs0bciuywl3H3jiZwlgBYkJI29c+wehU7Eg53Peizm+06DspM
         gb3rmhpJuts/UNqFqGYAoiYQj+xAQkGa6ys5qbgjxJnR4xVwasJt6rT0fRgBcqSLJMDx
         fLyTc7Y4LB7BxR8Bo+nU49dcOPBtW2cMBuGeDlDZqzo1MrSXx0QjZyv2PuuRz2P1FGce
         brpOQ2CSqM1AB538rLXFWYmXE7gyMVmwvgA9H/o4Yw2ZdcDwigK6PuaX8N+tRu54ukWi
         AMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WRqvTnSf7OQ2cd1bvnl7SkQVvla7dUVQROgM13fu2Aw=;
        b=V/Y1+mMSDH3QocpLunP0Cl7n6+A5cs1j08LCuMy4I0+MCEnU7sUe4iAsvJu7gdahRf
         O295dVfJfQbQEopOopFaTsX6AfX8JZbXsSxWfaXu7jURfM6phen0OJDCXQ7NGfZyFtSy
         JG1StgmoE5UENpG/4XBdxrsVMHXMK0JgRMXFgOpDqH5CidN0UGiS/ToTvYxidf9aralI
         qq1iMX0UoPdxmJkX+2dBJQAFjdDeXIpK4+X7gsKs+7u+u/lICzdszuVQIIOUgzIIqJ5F
         VfPlG9OzDUmphOS2fABGKIgGefy1ottriprIvPTdm+nldf3dXD0CKXRiB1ZBKPG0OX9z
         cmDA==
X-Gm-Message-State: APjAAAXY0lGDX10WL76UAK1grCdejBNidLh3n8iu093X2UricRZrHeYi
        MULRO25VdeFlBaPVUykUj4qhFw==
X-Google-Smtp-Source: APXvYqyMcyvajnlaKPXrE/pmTG3QcILUV6eHFGhXb6asxr+aZ6yhWgw3/7zqxDkBjJMlUHbVcKulYQ==
X-Received: by 2002:a1c:7ed2:: with SMTP id z201mr11867311wmc.113.1557745385424;
        Mon, 13 May 2019 04:03:05 -0700 (PDT)
Received: from [192.168.0.41] (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.googlemail.com with ESMTPSA id y1sm2199566wma.14.2019.05.13.04.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:03:04 -0700 (PDT)
Subject: Re: [PATCH 7/9] genirq/timings: Add selftest for circular array
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Robin Murphy <robin.murphy@arm.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Changbin Du <changbin.du@intel.com>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
 <20190513102953.16424-8-daniel.lezcano@linaro.org>
 <20190513105027.GQ9224@smile.fi.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b32ff71b-8541-e135-11f2-7455ebc2b8c6@linaro.org>
Date:   Mon, 13 May 2019 13:03:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513105027.GQ9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2019 12:50, Andy Shevchenko wrote:
> On Mon, May 13, 2019 at 12:29:51PM +0200, Daniel Lezcano wrote:
>> Due to the complexity of the code and the difficulty to debug it,
>> let's add some selftests to the framework in order to spot issues or
>> regression at boot time when the runtime testing is enabled for this
>> subsystem.
>>
>> This tests the circular buffer at the limits and validates:
>>  - the encoding / decoding of the values
>>  - the macro to browse the irq timings circular buffer
>>  - the function to push data in the circular buffer
> 
>>  kernel/irq/timings.c | 119 +++++++++++++++++++++++++++++++++++++++++++
> 
> Is it possible to have it in a separate C-file?

It is possible but I would like to keep the selftest in the same file in
order to keep all the structures and functions self-contained.

>> +config TEST_IRQ_TIMINGS
>> +	bool "IRQ timings selftest"
> 
>> +	default n
> 
> This is already default.

Right, thanks for the review.

>> +	depends on IRQ_TIMINGS
>> +	help
>> +	  Enable this option to test the irq timings code on boot.
>> +
>> +	  If unsure, say N.
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

