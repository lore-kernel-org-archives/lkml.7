Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA36C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E8C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3GcnMgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfC0Rth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:49:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfC0Rth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:49:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so899875wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnWXHAD/NFAuMF2vCNye6GO2QmX0l3AyMwH90a2R2w8=;
        b=s3GcnMgbwGumooIHwxpyhJu5FqfaOV5QM9XS5euz/d5up4nLZ0eYScZF/s6N+sWrxO
         tuV2EKXYp+YsBXN6dKqyEoAEvhN5hAYq2QoTN/r7rt+XJeF/xRsyJrQio0hfetfrTuVR
         jlN+1fZ4srKUyDJzKMLIJKkhE4n+K0NRxkBPiwnZnxwU/tPTjqng7FE/sq/8oVsCyWff
         dzwraaFrURaiyVmtBgpkuwfD1XZWwSIDBMEQ8P+NaYwlKSVip64KzQhoIXVuDseDcCSL
         LMSe8hfGlAkz3TKXiePMYQ9EarK83AcdMerzo3NRxISlE6KjHl9tSzG+rv8rJY2R3PVi
         M64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnWXHAD/NFAuMF2vCNye6GO2QmX0l3AyMwH90a2R2w8=;
        b=PDYrCPwCKUiXXI8rUsMN7KmmRpJ+zwonD07DyHS+D0p+HVEMmUXzmfeasJsHmW3k8K
         PEigGtUVw2D/nWZ7rIjx3t9KSOkgJil8G3h26zTyGCaWaFccBamkCLXmRfL08eMwEorN
         TweX21y+KRXdIvuoK9JjJK4o1b7GxkHCvGzAfpFkVglzIXB0/wNbGCBfYascjJunDg5y
         gfgyn1M0EIoz+kVShG5Rz/hajPnPTLdmeZQu2xenJQgz0west1GdYQ8gB0Z+SShFKkwF
         yonWpV0oCRZmYQ6mnoT1U6vQTDS52H1meUsmXP5eNQaaLRa6oGio28GC4MmH4N78U9Ga
         2bFA==
X-Gm-Message-State: APjAAAVMo4alFEUnZGUdl9YJTrbEXGKisMw5EEBhDavoJiPcHa7Z7ysI
        Y6KS2p2zLmj7m7TTQOZX5B+JmQ==
X-Google-Smtp-Source: APXvYqwaWaEWPjm5Ed6MTnrsVdMiFO2SB8w/6iiplLv79diYpKxMcw37jzqq2TzUn+lPCtuy/3Gyew==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr20425532wmc.70.1553708974596;
        Wed, 27 Mar 2019 10:49:34 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y3sm907697wmi.27.2019.03.27.10.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 10:49:33 -0700 (PDT)
Subject: Re: [PATCH v4 00/11] ARM: davinci: modernize the timer support
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190318121100.28132-1-brgl@bgdev.pl>
 <ee3034e0-7037-3055-749c-ca3897078e10@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1148f076-09d4-18cb-b18c-abd5fc5216a6@linaro.org>
Date:   Wed, 27 Mar 2019 18:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ee3034e0-7037-3055-749c-ca3897078e10@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,


On 27/03/2019 16:36, Sekhar Nori wrote:
> Hi Daniel, Thomas,
> 
> On 18/03/19 5:40 PM, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This series removes the legacy timer code from mach-davinci in favor of
>> a new clocksource driver it introduces.
>>
>> Patch 1 adds a new clocksource driver for davinci.
>>
>> Patch 2 enables the new driver for device-tree based systems.
>>
>> Patch 3 adds a WARN_ON() to the machine code of all davinci boards
>> which is triggered if clk_get() for the timer clock fails. This is needed
>> as the new driver expects the clock to be functional and doesn't check it.
>>
>> Patches 4-5 and 7-10 switch the board files to using the new
>> clocksource driver while patch 6 moves some necessary defines to
>> a different place since we'll be removing the file that contains them.
>>
>> Patch 11 removes legacy timer code.
> 
> The series looks good to me. With your ack on 1/11, I would like to
> merge the series through ARM SoC tree.

ok, will do the review asap.

 -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

