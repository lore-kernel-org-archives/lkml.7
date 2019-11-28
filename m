Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E219C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5CC21741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSnjHIZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfK1NID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:08:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36748 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1NIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:08:01 -0500
Received: by mail-lf1-f67.google.com with SMTP id f16so20032758lfm.3;
        Thu, 28 Nov 2019 05:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=krNXawKjvmsjzjqthj9NXj7bfe5FbskescRB9lZYihk=;
        b=tSnjHIZ7j97iNLNhC41UhinPh2mT5Atv/vfAr5ybSsUYPEMDOtTbHmztohzwfPeqIg
         +2tKjSPjRELDo++Lq02YOOa6o8z3CAymvCywCv0BvFVhkm8kBIo38z0of0HWs0AuLUgz
         mwAGao+DAZFjEqArH9qtkkFJkOiNMues9lt46y8qkpRPjTLNAsaPwTR1qyBYRTH5SBHt
         lb6Ya8TbO0AmjGl9PglAvbxfvpOBIkWA+in104B511jp8vudrYBDXiFXI105G97UvM+/
         GcmIuZMJOtIYbsOTXYaX/OUP+YCjMZIWYFTRFGG2xWOI8zN+SWXNfJq4UFuxdrGrReV3
         blag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=krNXawKjvmsjzjqthj9NXj7bfe5FbskescRB9lZYihk=;
        b=OlYum3zbU0mXMKVhS3/dy7lOpiROBvDWYCGoS77K+LqQAr/VjLpPxPuCkXr7MUmWdv
         hU+2xPeVK3Xd4Vct4GlG0cEOuA96Aq7tQzlxLlqImF5Vd+6QdzaVbvgKA1ndylKeX5OG
         C0ohx3HSTIgQg2EgkQwvvQcpQrBQxMCrFhmOy0yW5vU4K8sHD4ttJq5HMHS2rTw5mlLx
         ovucClK/qQJc8S/7UhiOfC961nsmIUaD1Bh1c6R3EKzTQr1tgyTnYCnppJc1ZuJOLjQL
         NcrLvPF1zEcqlBKkgE+sjzeASzJl1T+3uvgWchQW/hYgaeTkTxB577Pmgk2a1lpnZWvg
         MNcw==
X-Gm-Message-State: APjAAAUrZa/tDj1tlH89cAQ2oWNYAg8hhW8I9lUrmnJRKrj6jnG67qiP
        yzg8Il78p6SOgeSuPIrV/BVVObdH
X-Google-Smtp-Source: APXvYqyU0ruuq7MNBoRPFjuANT53CWyKaDZOqBOtEWrGhT3SSbfuwQD2vC77eWfA+eC+xOPwhvQPIA==
X-Received: by 2002:ac2:43af:: with SMTP id t15mr9639796lfl.154.1574946476973;
        Thu, 28 Nov 2019 05:07:56 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id k25sm8596603ljg.22.2019.11.28.05.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:07:56 -0800 (PST)
Subject: Re: [PATCH v2 06/11] dt-bindings: clock: tegra: Remove pmc clock ids
 from clock dt-bindings
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <1574830773-14892-7-git-send-email-skomatineni@nvidia.com>
 <22ab4e93-bf94-5c73-b4b9-6cf36d329b97@gmail.com>
 <20191128121844.GA2300319@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d8dddf52-79a7-71cc-fb5b-32b8f4dbb9fd@gmail.com>
Date:   Thu, 28 Nov 2019 16:07:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128121844.GA2300319@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2019 15:18, Thierry Reding пишет:
> On Wed, Nov 27, 2019 at 05:32:30PM +0300, Dmitry Osipenko wrote:
>> 27.11.2019 07:59, Sowjanya Komatineni пишет:
>>> clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra pmc clocks.
>>>
>>> This patch removes ids for these clocks from Tegra clock dt-bindings.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>  include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
>>>  include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
>>>  include/dt-bindings/clock/tegra20-car.h         |  2 +-
>>>  include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
>>>  include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
>>>  5 files changed, 29 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
>>> index bb5c2c999c05..9175cd0571b5 100644
>>> --- a/include/dt-bindings/clock/tegra114-car.h
>>> +++ b/include/dt-bindings/clock/tegra114-car.h
>>> @@ -270,10 +270,10 @@
>>>  #define TEGRA114_CLK_AUDIO3 242
>>>  #define TEGRA114_CLK_AUDIO4 243
>>>  #define TEGRA114_CLK_SPDIF 244
>>> -#define TEGRA114_CLK_CLK_OUT_1 245
>>> -#define TEGRA114_CLK_CLK_OUT_2 246
>>> -#define TEGRA114_CLK_CLK_OUT_3 247
>>> -#define TEGRA114_CLK_BLINK 248
>>> +/* 245 */
>>> +/* 246 */
>>> +/* 247 */
>>> +/* 248 */
>>>  /* 249 */
>>>  /* 250 */
>>>  /* 251 */
>>> @@ -333,9 +333,9 @@
>>>  #define TEGRA114_CLK_AUDIO3_MUX 303
>>>  #define TEGRA114_CLK_AUDIO4_MUX 304
>>>  #define TEGRA114_CLK_SPDIF_MUX 305
>>> -#define TEGRA114_CLK_CLK_OUT_1_MUX 306
>>> -#define TEGRA114_CLK_CLK_OUT_2_MUX 307
>>> -#define TEGRA114_CLK_CLK_OUT_3_MUX 308
>>> +/* 306 */
>>> +/* 307 */
>>> +/* 308 */
>>>  #define TEGRA114_CLK_DSIA_MUX 309
>>>  #define TEGRA114_CLK_DSIB_MUX 310
>>>  #define TEGRA114_CLK_XUSB_SS_DIV2 311
>>> diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/dt-bindings/clock/tegra124-car-common.h
>>> index 0c4f5be0a742..90a0c5e7eb5f 100644
>>> --- a/include/dt-bindings/clock/tegra124-car-common.h
>>> +++ b/include/dt-bindings/clock/tegra124-car-common.h
>>> @@ -269,10 +269,10 @@
>>>  #define TEGRA124_CLK_AUDIO3 242
>>>  #define TEGRA124_CLK_AUDIO4 243
>>>  #define TEGRA124_CLK_SPDIF 244
>>> -#define TEGRA124_CLK_CLK_OUT_1 245
>>> -#define TEGRA124_CLK_CLK_OUT_2 246
>>> -#define TEGRA124_CLK_CLK_OUT_3 247
>>> -#define TEGRA124_CLK_BLINK 248
>>> +/* 245 */
>>> +/* 246 */
>>> +/* 247 */
>>> +/* 248 */
>>>  /* 249 */
>>>  /* 250 */
>>>  /* 251 */
>>> @@ -332,9 +332,9 @@
>>>  #define TEGRA124_CLK_AUDIO3_MUX 303
>>>  #define TEGRA124_CLK_AUDIO4_MUX 304
>>>  #define TEGRA124_CLK_SPDIF_MUX 305
>>> -#define TEGRA124_CLK_CLK_OUT_1_MUX 306
>>> -#define TEGRA124_CLK_CLK_OUT_2_MUX 307
>>> -#define TEGRA124_CLK_CLK_OUT_3_MUX 308
>>> +/* 306 */
>>> +/* 307 */
>>> +/* 308 */
>>>  /* 309 */
>>>  /* 310 */
>>>  #define TEGRA124_CLK_SOR0_LVDS 311 /* deprecated */
>>> diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindings/clock/tegra20-car.h
>>> index b21a0eb32921..fe541f627965 100644
>>> --- a/include/dt-bindings/clock/tegra20-car.h
>>> +++ b/include/dt-bindings/clock/tegra20-car.h
>>> @@ -131,7 +131,7 @@
>>>  #define TEGRA20_CLK_CCLK 108
>>>  #define TEGRA20_CLK_HCLK 109
>>>  #define TEGRA20_CLK_PCLK 110
>>> -#define TEGRA20_CLK_BLINK 111
>>> +/* 111 */
>>>  #define TEGRA20_CLK_PLL_A 112
>>>  #define TEGRA20_CLK_PLL_A_OUT0 113
>>>  #define TEGRA20_CLK_PLL_C 114
>>> diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
>>> index 44f60623f99b..a3d8d3e75728 100644
>>> --- a/include/dt-bindings/clock/tegra210-car.h
>>> +++ b/include/dt-bindings/clock/tegra210-car.h
>>> @@ -304,10 +304,10 @@
>>>  #define TEGRA210_CLK_AUDIO3 274
>>>  #define TEGRA210_CLK_AUDIO4 275
>>>  #define TEGRA210_CLK_SPDIF 276
>>> -#define TEGRA210_CLK_CLK_OUT_1 277
>>> -#define TEGRA210_CLK_CLK_OUT_2 278
>>> -#define TEGRA210_CLK_CLK_OUT_3 279
>>> -#define TEGRA210_CLK_BLINK 280
>>> +/* 277 */
>>> +/* 278 */
>>> +/* 279 */
>>> +/* 280 */
>>>  #define TEGRA210_CLK_SOR0_LVDS 281 /* deprecated */
>>>  #define TEGRA210_CLK_SOR0_OUT 281
>>>  #define TEGRA210_CLK_SOR1_OUT 282
>>> @@ -386,9 +386,9 @@
>>>  #define TEGRA210_CLK_AUDIO3_MUX 353
>>>  #define TEGRA210_CLK_AUDIO4_MUX 354
>>>  #define TEGRA210_CLK_SPDIF_MUX 355
>>> -#define TEGRA210_CLK_CLK_OUT_1_MUX 356
>>> -#define TEGRA210_CLK_CLK_OUT_2_MUX 357
>>> -#define TEGRA210_CLK_CLK_OUT_3_MUX 358
>>> +/* 356 */
>>> +/* 357 */
>>> +/* 358 */
>>>  #define TEGRA210_CLK_DSIA_MUX 359
>>>  #define TEGRA210_CLK_DSIB_MUX 360
>>>  /* 361 */
>>> diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
>>> index 3c90f1535551..20ef2462d9e1 100644
>>> --- a/include/dt-bindings/clock/tegra30-car.h
>>> +++ b/include/dt-bindings/clock/tegra30-car.h
>>> @@ -230,11 +230,11 @@
>>>  #define TEGRA30_CLK_AUDIO3 204
>>>  #define TEGRA30_CLK_AUDIO4 205
>>>  #define TEGRA30_CLK_SPDIF 206
>>> -#define TEGRA30_CLK_CLK_OUT_1 207 /* (extern1) */
>>> -#define TEGRA30_CLK_CLK_OUT_2 208 /* (extern2) */
>>> -#define TEGRA30_CLK_CLK_OUT_3 209 /* (extern3) */
>>> +/* 207 */
>>> +/* 208 */
>>> +/* 209 */
>>>  #define TEGRA30_CLK_SCLK 210
>>> -#define TEGRA30_CLK_BLINK 211
>>> +/* 211 */
>>>  #define TEGRA30_CLK_CCLK_G 212
>>>  #define TEGRA30_CLK_CCLK_LP 213
>>>  #define TEGRA30_CLK_TWD 214
>>> @@ -260,9 +260,9 @@
>>>  /* 297 */
>>>  /* 298 */
>>>  /* 299 */
>>> -#define TEGRA30_CLK_CLK_OUT_1_MUX 300
>>> -#define TEGRA30_CLK_CLK_OUT_2_MUX 301
>>> -#define TEGRA30_CLK_CLK_OUT_3_MUX 302
>>> +/* 300 */
>>> +/* 301 */
>>> +/* 302 */
>>>  #define TEGRA30_CLK_AUDIO0_MUX 303
>>>  #define TEGRA30_CLK_AUDIO1_MUX 304
>>>  #define TEGRA30_CLK_AUDIO2_MUX 305
>>>
>>
>> This a device-tree ABI breakage and I'm not sure that it's okay to break
>> older device-trees (Pixel C Smaug board), maybe some kind of fallback is
>> needed.
> 
> The Smaug support was never really official. I don't think anybody uses
> upstream on it "for real" because there's a very limited set of features
> that we do support. My understanding is that there is a community around
> Pixel C that runs their own forks with some more features and they have
> occasionally upstreamed bits and pieces of that.
> 
> So given how far behind we are with Smaug, I don't think breaking ABI
> stability is really a problem in this case.
> 
> Jon, we used to have a Smaug system in our internal upstream testing,
> but that's no longer the case. If we ever were to reinstate that
> testing, updating the DTB shouldn't be a problem, right? My recollection
> is that updating the DTB was always done hand in hand with the kernel
> update.

IIRC, T210 doesn't have support for SoC audio driver yet in upstream
kernel and thus Smaug only defined the audio codec in the device-tree,
which never got utilized.
