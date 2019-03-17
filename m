Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071CCC10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FD120857
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygxzhKmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCQUwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:52:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38402 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCQUwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 16:52:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so14844151wrm.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ImStykA1Cqt5hSrINrJCrRttPabhMd5Ia+ev+7263U8=;
        b=ygxzhKmg6px0BqFso8CWJpWVNcuqx3tkmaWqMkfs7oySGzNPvDvcL4UVvX0i0QTZ/v
         EaM38XsYLOR+txScGIZbhzW8fZcPFTwJx4hEP6SFq7rzcPY3ZyBc9dv8lh5B+/Mgy1Fd
         7C+4otR3f+gutoAoXTKNqo3G/NzwHkqmfE360tEOI7JRXBmdO8xPIqKYcCvCBCbn8/n7
         WK0c7gPdtLchDfyyqYx7BVJ+ULEjKWbLWhbfrgk2f6veGOtyVBkSRNJib2Ic2LswafHp
         sLURrKopKkg3vuZRxDHOcKWiSNLfIbhAQsLA0NWB29GatkQASq5qx2bnnIPIkf4aSDwf
         DDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ImStykA1Cqt5hSrINrJCrRttPabhMd5Ia+ev+7263U8=;
        b=WFFN1/hLib+ovId6UK0O4RI4+bOD11h7JASD+sZ2qvy7sAg2x5tKDucvQSWRU9CDSv
         GP/LAuhVdshzI8JANwJXHdgQOyYLurvwRaOBkV6Hqf8f8l6x/6g5Fj7HmPs6VYHvrHaj
         OmWJRdEnameEE8vQS0QVG9xR2LA52TOgnlL7oh/K6EI7dj48QMCg1m8eLsgvs9U88Mqv
         hIUbUTfucOesVg4pOx8By5IzvfzS9YiSD7UyhbnHz6xPZXRJ6nByc2earBw47DALnUZS
         ovOPEEzoNCIk1cFP4bc1bBoxdtf7BkVwGg8MrMGDBC/C9Pz8PbSTjAXPIowsIaSL2Gtd
         dr/A==
X-Gm-Message-State: APjAAAW57+35gGB1hj9OVcjSu8k8nTnuCWZU9tv15rCoF0su/hZGUYGL
        eFO7d6+HqgbSRzVxf4oROvQi1Q==
X-Google-Smtp-Source: APXvYqxFT4g0TvoEUrXYcoIt7LZMTibQ+6Zdx1rKYMHwxnXM87+EnBRZhiz23pTbqTdNSCf3kRxS/Q==
X-Received: by 2002:a5d:53c9:: with SMTP id a9mr3832781wrw.59.1552855937275;
        Sun, 17 Mar 2019 13:52:17 -0700 (PDT)
Received: from [192.168.0.41] (48.208.130.77.rev.sfr.net. [77.130.208.48])
        by smtp.googlemail.com with ESMTPSA id w8sm6942862wmc.0.2019.03.17.13.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 13:52:16 -0700 (PDT)
Subject: Re: [PATCH 0/7] Timer & SPI support for Allwinner suniv F1C100s
To:     Icenowy Zheng <icenowy@aosc.xyz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
 <2485e6c52810df376a0df6eb7f749f35b7b19044.camel@aosc.xyz>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <177e2598-3491-03af-8638-c60e77cc4a34@linaro.org>
Date:   Sun, 17 Mar 2019 21:52:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2485e6c52810df376a0df6eb7f749f35b7b19044.camel@aosc.xyz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2019 18:39, Icenowy Zheng wrote:
> 在 2019-02-11一的 12:21 +0300，Mesih Kilinc写道：
>> This is followup series for F1C100s initial support patchset. 
>> All patches merged except patch 1 ~ 2 which is related to timer.
>> I am resending those since they are already have Acked tags.
> 
> Ping.
> 
> Could you please merge these timer-related patches?

Hi,

I acked the timer-related patches. If you resend the patches with my
acked-by I will consider them to go through the allwinner tree.

Do you want me to take 1 and 2 through my tree?



>> Our dt-bindings for F1C100s are merged, we can now use them at our 
>> device tree source - patch 3.
>>
>> Also this series add spi support and enables spi flash at Lichee-pi
>> Nano
>> in patch 4 ~ 7. This patches are based on Icenowy's work.
>>
>> Thanks!
>>
>> Mesih Kilinc (7):
>>   dt-bindings: timer: Add Allwinner suniv timer
>>   clocksource: sun4i: add a compatible for suniv
>>   ARM: dts: suniv: Add dt-binding headers for F1C100s
>>   dt-bindings: spi: Add Support for Allwinner F1C100s
>>   ARM: dts: suniv: Add SPI device-tree nodes
>>   ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of F1C100s
>>   ARM: dts: f1c100s: Activate SPI flash on Lichee Pi Nano
>>
>>  .../devicetree/bindings/spi/spi-sun6i.txt          |  5 +-
>>  .../bindings/timer/allwinner,sun4i-timer.txt       |  4 +-
>>  arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  | 13 ++++++
>>  arch/arm/boot/dts/suniv-f1c100s.dtsi               | 53
>> +++++++++++++++++++---
>>  drivers/clocksource/timer-sun4i.c                  |  5 +-
>>  5 files changed, 70 insertions(+), 10 deletions(-)
>>
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

