Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D4AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45B3206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEl4LoXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbfHASfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:35:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46034 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfHASfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:35:32 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so70303798lje.12;
        Thu, 01 Aug 2019 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjRiJ9NneUsRSBR2+BUXWJ16yOBtzQQw7Ff/gk35AkQ=;
        b=OEl4LoXIGMNfX/oVXHLUSK4V8WwDnOGFIA1EZ3zvsRpZOTKelSRATjCeEDHHS40vuv
         kooUTnSiDk+WfsI4Nh2LFui6ich+ngM9W15/s9w4QsyEoAtY9aXCwB+UIWFUmWNqJ0bq
         90h8WwOHjUAAEsmcPeyTzuV4FwCeInRHC2+ejGV93PR0vX3CgSgR06CNCt/PDfhhHVzN
         9LAgdKZYBTKg0RUZ11Hw/RcgFTpw4KTyaonvRxEIoTbpD+yjETis6+QADGIEmPOuqzeH
         zxQlK48MbRCpAl1mkWBL9WcSruAotxkPiNxOx7oPgmMqvk30ML4RCq0iNDiuI7Bm1/aS
         pNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjRiJ9NneUsRSBR2+BUXWJ16yOBtzQQw7Ff/gk35AkQ=;
        b=WIr5EyCrVqzZQX2rttuTTR8rEuecjJw9Wl1PbDAcqf1zek5EtwkvdFJE0OEUhwpRq+
         Iw+kQ09YPO1jYm1xhZuEgnsLFW2XqNwAzTjKEmX0z8JuzWEGlFGK5B05pS9FHTvD+wUQ
         mPgrBete+TwbMFClb8Y1+gSoOuD+ZVs8TmY5bFfna/B4+7VCYcIfsvEVN7zZyyy6asak
         iUJ7xfL1kfBZlhWSXl/Xu/oWyUXBxEBr/OjRMb4/MKOpxPIZicaFJYPlDCUizr6OdxoW
         19GLJKByPjoxMZtS8wIZf3HavAscqKeB48koMMungw+OaHpMQ3XrzFO/zKQ5MCYKjX0u
         d8aA==
X-Gm-Message-State: APjAAAXCfv6jcxzeVKxnurebgbX7ruHl37q9oUfFmVKA0vabFzxItn/X
        ZO7fYP+4a7NZudrlDLUMWvXlmaq4
X-Google-Smtp-Source: APXvYqxvdaGk4aTz3QPLiAh1nJkebpUkjumTvGwmmHWzlNUPfMhjue1gTCS+g1owbwthaVrAB3H5FA==
X-Received: by 2002:a2e:8591:: with SMTP id b17mr42020234lji.71.1564684528945;
        Thu, 01 Aug 2019 11:35:28 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id u15sm14778186lje.89.2019.08.01.11.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 11:35:28 -0700 (PDT)
Subject: Re: [PATCH v9 11/15] dt-bindings: memory: Add binding for NVIDIA
 Tegra30 External Memory Controller
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190730165618.10122-1-digetx@gmail.com>
 <20190730165618.10122-12-digetx@gmail.com>
 <CAL_JsqJgENCznrnYX8ARia2sNKJ7XxYRzzavk5qoePPYzYAQvA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f323db8e-c551-8a56-20df-16d3c633ed4b@gmail.com>
Date:   Thu, 1 Aug 2019 21:35:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJgENCznrnYX8ARia2sNKJ7XxYRzzavk5qoePPYzYAQvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.08.2019 21:11, Rob Herring пишет:
> On Tue, Jul 30, 2019 at 10:58 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Add device-tree binding for NVIDIA Tegra30 External Memory Controller.
>> The binding is based on the Tegra124 EMC binding since hardware is
>> similar, although there are couple significant differences.
>>
>> Note that the memory timing description is given in a platform-specific
>> form because there is no detailed information on how to convert a
>> typical-common DDR timing into the register values. The timing format is
>> borrowed from downstream kernel, hence there is no hurdle in regards to
>> upstreaming of memory timings for the boards.
>>
>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../nvidia,tegra30-emc.yaml                   | 341 ++++++++++++++++++
>>  1 file changed, 341 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
>> new file mode 100644
>> index 000000000000..6865cfb16e59
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
>> @@ -0,0 +1,341 @@
>> +# SPDX-License-Identifier: (GPL-2.0)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra30-emc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra30 SoC External Memory Controller
>> +
>> +maintainers:
>> +  - Dmitry Osipenko <digetx@gmail.com>
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +
>> +description: |
>> +  The EMC interfaces with the off-chip SDRAM to service the request stream
>> +  sent from Memory Controller. The EMC also has various performance-affecting
>> +  settings beyond the obvious SDRAM configuration parameters and initialization
>> +  settings. Tegra30 EMC supports multiple JEDEC standard protocols: LPDDR2,
>> +  LPDDR3, and DDR3.
>> +
>> +properties:
>> +  compatible:
>> +    const: nvidia,tegra30-emc
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
>> +      Physical base address.
> 
> Same comment here.
> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description:
>> +      EMC clock.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      EMC General interrupt.
>> +
>> +  nvidia,memory-controller:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      Phandle of the Memory Controller node.
>> +
>> +patternProperties:
>> +  "^emc-timings-[0-9]+$":
>> +    type: object
>> +    properties:
>> +      nvidia,ram-code:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          Value of RAM_CODE this timing set is used for.
>> +
>> +    patternProperties:
>> +      "^timing-[0-9]+$":
>> +        type: object
>> +        properties:
>> +          clock-frequency:
>> +            description:
>> +              Memory clock rate in Hz.
>> +            minimum: 1000000
>> +            maximum: 900000000
>> +
>> +          nvidia,emc-auto-cal-interval:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description:
>> +              Pad calibration interval.
> 
> Any value 0 - 4G is valid?

No, this is in microseconds and the maximum is 2 seconds.

>> +
>> +          nvidia,emc-mode-1:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description:
>> +              Mode Register 1.
>> +
>> +          nvidia,emc-mode-2:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description:
>> +              Mode Register 2.
>> +
>> +          nvidia,emc-mode-reset:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description:
>> +              Mode Register 0.
>> +
>> +          nvidia,emc-zcal-cnt-long:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description:
>> +              Number of EMC clocks to wait before issuing any commands after
>> +              sending ZCAL_MRW_CMD.
> 
> Valid range?

I'll add all the ranges in the next revision.

>> +
>> +          nvidia,emc-cfg-dyn-self-ref:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description:
>> +              Dynamic self-refresh enabled.
> 
> Sounds like a boolean?
> 
>> +
>> +          nvidia,emc-cfg-periodic-qrst:
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            description:
>> +              FBIO "read" FIFO periodic resetting enabled.
> 
> boolean?

Yes, and it looked to me that it should be okay since that's what T124
binding uses and it makes the properties parsing in the driver's code a
bit neater :) I'll change them to booleans in the next revision to make
it clear.
