Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90BAC2D0C5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD90C222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ulz7/dF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLLBn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:43:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38950 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfLLBn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:43:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so372656lfb.6;
        Wed, 11 Dec 2019 17:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k3MT7+L3kNReQ0aWj6ky2KsiTx1YfA3d7iiuzNpuvhM=;
        b=Ulz7/dF+kPJTSCqiGltQdo8sS30X4xoZfoyGQsNApxOE66T6t3UCN8p/TfQqzO7qIZ
         HWe/sNp2OzuTk3l+8gt3Arx2UpV/BGQmlswxT7spwdqu3zrkTxSpJYvphoZEZxmyIxop
         LaDSPwDjiveJJBVrVJPTbv36fxKUrO93aCoD4t3zk2ohI5ja5Pof0Fp0q7lcJGNNFyA8
         m2RbiNhh3jGnlgHqh9uD5MnEe00FJ1NKOHfZYqjK43UaGSqoQHv9htySiVVCVDYacxDX
         r+fdQBd6Ra6aNPeK73GIeT9VGPANBF1/Dtd1hOiekU6ZE2rewxuEK9ungY4D2QtbaSY/
         a65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3MT7+L3kNReQ0aWj6ky2KsiTx1YfA3d7iiuzNpuvhM=;
        b=LiYExBzxUgbA5dw4dJQ8G5Atzb+zuVxOHHxVBk9Cacr8rWEYVLSo+2bKmKLriqKMSq
         9nNuGTaPc7dv2O3nNZeOx6Mj+NESJGUeHB6HmuFgs7bi6nG+2BJmn2GbaeTyj+zFEf9B
         uXR9AeM90QXpwnbJ49XxgQYJTIEJiv6ohi2CEthsyKj2j2Wg4vNtKZJJycqKA3+aQ3J8
         YBW0/Z1ej14EVJOibshC/0YCczWsSLOkRL/ax5mrS6sNPwp0hICBfCBbRYUUT1+uheUs
         1+OViGsu7O0gvh5ZLqBj+VneBx6vU4xxS+I8Fu25cA3npE26/J6X8NutcXk4tYIpAUnA
         mqnQ==
X-Gm-Message-State: APjAAAXtEcoqvgdgjW+OIerjwFn1BQhqAILrYPH/mIi++LEB+yXLiCNm
        YpLqtnXQzYNYG/ylP6J+6H0=
X-Google-Smtp-Source: APXvYqz7aTD5v1Yosyuc0A6maHQLW08mG0PaBCEDjujtH7miw7vNqCc+VqmwSEbFKuQSiaGRS/LpQQ==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr4140344lfl.185.1576115035025;
        Wed, 11 Dec 2019 17:43:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i4sm2327370lji.0.2019.12.11.17.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:43:54 -0800 (PST)
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
References: <ad3a6743-4b36-fa25-9cc7-72803038ecc5@gmail.com>
 <dc7a057a-0bed-0e6f-0987-edcfec47f867@gmail.com>
 <288a1701-def6-d628-26bc-a305f817bdb1@gmail.com>
 <78644d45-2ae3-121f-99fc-0a46f205907d@nvidia.com>
 <b35916e1-c6ee-52ca-9111-5ae109437b6e@nvidia.com>
 <ccb715cc-c927-ea91-a26e-24d6eeeeef1a@gmail.com>
 <ee1d39d4-9a57-da9b-fce6-8130dac1d2fd@nvidia.com>
 <49da77dc-b346-68eb-9ef8-42cfb3221489@nvidia.com>
 <3f1c9325-3017-62be-1e3b-82fd28540fdf@nvidia.com>
 <6fcbff3d-8695-7cd0-60de-6eb523b6964c@gmail.com>
 <20191211151028.GZ28289@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0930a710-174b-859b-294c-e9f81f6a3b5e@gmail.com>
Date:   Thu, 12 Dec 2019 04:43:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191211151028.GZ28289@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.12.2019 18:10, Peter De Schrijver пишет:
> On Tue, Dec 10, 2019 at 08:41:56PM +0300, Dmitry Osipenko wrote:
> 
> ..
> 
>>>
>>> PMC clock gate is based on the state of CLKx_ACCEPT_REQ and FORCE_EN
>>> like explained above.
>>>
>>> CLKx_ACCEPT_REQ is 0 default and FORCE_EN acts as gate to enable/disable
>>> EXTPERIPH clock output to PMC CLK_OUT_1/2/3.
>>
>> [and to enable OSC as well]
>>
>>> So I believe we need to register as MUX and Gate rather than as a single
>>> clock. Please confirm.
>>
>> 1. The force-enabling is applied to both OSC and EXTERN sources of
>> PMC_CLK_OUT_x by PMC at once.
>>
>> 2. Both of PMC's force-enabling and OSC/EXTERN selection is internal to PMC.
>>
>> Should be better to define it as a single "pmc_clk_out_x". I don't see
>> any good reasons for differentiating PMC's Gate from the MUX, it's a
>> single hardware unit from a point of view of the rest of the system.
>>
>> Peter, do you have any objections?
> 
> The reason to have separate gate and mux clocks, is to preserve compatibility
> with existing users.
> Otherwise the current users would need to figure out if there's a
> single clock or 2 clocks to configure. I don't think adding that code in
> each user is worth it only to have a sligthly nicer modelling of the
> hardware.

Could you please clarify what do you mean by the "existing users"?
AFAIK, nothing in kernel uses mux clocks.
