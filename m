Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760DEC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A212184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ndU9JZtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDKNA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:00:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45781 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfDKNA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:00:57 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so7196367wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o9hfX+awk8anQN4LGFHcQzLSZQ1q9T5oeKnDQ0qxXt0=;
        b=ndU9JZtteAeRvhCUCG8i7Z6JE6NL2Md23OtAYbM5H/dKcr7Bilj/ck780pZPFIctLZ
         f2CR7ZkrUFaoyOyI6OF0fieXHov02mqFQyAyWsXVp9vD4f3PJlAaVZEuESQ+kWOcqHpL
         CDOlQ1AVa29875Kohkl8iV5yHbmzDIK/Jf+78WOE6+acBhoMjakUh3yo7wPFAuLIULjD
         jzr6o8QjdwcyAi0Rx6KayNYn3Qe3p7XBtBG2HVeoV8WMTvnyRMuHUUwrNdMkddjMDDn6
         4NKffV3yweYimmw51ngkNhvfiz3hCU0rIJX9bOXdeutAO8i7zMooKKJ4qjEiMK4/YczQ
         DjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o9hfX+awk8anQN4LGFHcQzLSZQ1q9T5oeKnDQ0qxXt0=;
        b=t4jivBPo1gm6uY/KZgcU7qh80mfwh/60RZJaYykUA008JoyA5OiohioZaqx3teg1Sb
         Sz1E9VapFKCC2TCysvh4b/C8eybmcr5oBug7jAdRCVmXn3ywv5Pj2+rJQRWJ8sSIDw12
         tdDNtpPDaEL1qYHeGuskJP6ihcETNX5sohecZTeCm9lF/Hg5cpuUX/7vpmTCtEH9P9lW
         RJWNXu+EQOPPiVANgbmCQfaU4hAhYNhabGPofnRubVHuENO1FuKzL43+JsyPdZCsaWOX
         HJCRk0MBsnVSzM6iv1zgIQyJEEfyWbQBBPGNncX6AlR7XnFeXPrRa6HUd9ATd+sFXZMr
         ZGIg==
X-Gm-Message-State: APjAAAUwjHGRWJE/PQjb6yKRYBiDmHVdRs3bbn3ckSIQ3gzs9nHmulBi
        75l+xqn/LCFXj61sfAYBNHCRdyKxP3A=
X-Google-Smtp-Source: APXvYqzp07dNC/bEWcF78unl1171JEvuxkXAYzpeJeGswiSj4EKp7awAFkblgO7usdLjL4q9taeXRQ==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr24383259wru.299.1554987655452;
        Thu, 11 Apr 2019 06:00:55 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id o4sm8268489wmo.20.2019.04.11.06.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:00:54 -0700 (PDT)
Subject: Re: [PATCH v3 09/13] thermal: qoriq: Convert driver to use regmap API
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-10-andrew.smirnov@gmail.com>
 <52c33c26-47fa-04d2-0808-65a53fd2c804@linaro.org>
 <CAHQ1cqGbBXdQBagcKH211N0GkBzQzsutbu6=FMLLxZoL8pL8bA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dac3e90a-dd9f-56eb-faa2-c48d1fe380da@linaro.org>
Date:   Thu, 11 Apr 2019 15:00:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqGbBXdQBagcKH211N0GkBzQzsutbu6=FMLLxZoL8pL8bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2019 20:24, Andrey Smirnov wrote:

[ ... ]

>>> +static const struct regmap_range qiriq_yes_ranges[] = {
>>> +     regmap_reg_range(REGS_TMR, REGS_TSCFGR),
>>> +     regmap_reg_range(REGS_TTRnCR(0), REGS_TTRnCR(3)),
>>> +     /* Read only registers below */
>>> +     regmap_reg_range(REGS_TRITSR(0), REGS_TRITSR(15)),
>>> +};
>>> +
>>> +static const struct regmap_access_table qiriq_wr_table = {
>>> +     .yes_ranges     = qiriq_yes_ranges,
>>> +     .n_yes_ranges   = ARRAY_SIZE(qiriq_yes_ranges) - 1,
>>> +};
>>> +
>>> +static const struct regmap_access_table qiriq_rd_table = {
>>> +     .yes_ranges     = qiriq_yes_ranges,
>>> +     .n_yes_ranges   = ARRAY_SIZE(qiriq_yes_ranges),
>>> +};
>>
>> As the table are the same, it would make sense to fold both structure to
>> a single one (and s/qiriq/qoriq/ ?)
>>
> 
> Writable registers are a subset of readable registers and n_yes_ranges
> is different between the two. Not sure how I could fold the two into a
> single struct.

Right, never mind my comment.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

