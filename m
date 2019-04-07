Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E7DC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6A20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 10:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LTeLSoEf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfDGKRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 06:17:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46298 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfDGKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 06:17:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so12815004wrw.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=5lcB7Wch1bi7eOnQ+uFbKmPRUk4kHkGbfW5/BeV2uIc=;
        b=LTeLSoEfp7pdTE4fl5R9s8skKop8jQpclNFb9vNaPwmyXQjSp3Gd1wxIk9jQFVcbx/
         YfRVEoRpGreZRn+bg+VZJtpbB3ysNUUnE1r2S9TPzapoyIAkOXowxINbOKtAEzOHE9Gy
         HrZqQ+0Y+mZfQQURpeRT+1/AnDgs5A3DbRrkCkymG+q8uA+UjgfW+yrNRPP9dqRvoIkD
         u+tFG2Z0hIGZVqfx/ObCmMMG6l7gyl9i1MM4FCssvT67vu79Rf0xsDBX+TyoyzOWkgt/
         MR2dT/NegM6NDWuhCM++9TK4CCTXxRB4E4nDnOt1z2j0qqBgPgRkh+NXPANiLG934rTq
         Ni2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=5lcB7Wch1bi7eOnQ+uFbKmPRUk4kHkGbfW5/BeV2uIc=;
        b=fsdx2WNxkt03pBWoOZI2xVRqYoR7SxN1rkihH1aQUPe0H9YQB5h5LCeci0bCMR8hod
         Q6AUaeR9vJZV/RUV1KttVH3ZEA/cOJnm3DjnF1KBlcWGLA9ng7yI06tNRwrPGJUjdZLM
         xTO1Ina7BxelECvhjEXxW2CZ5wGtmucbiBoEybC0Y9ZO//EhTHXnQUpraKOEoa2oWYl0
         T9o6til0JrBGNkUDMJqxC9x8ZwFRjTMElauOyxTLmxsEj1ssjFE0DDBJFgb065PGKiR3
         5SId9pA1JvVDzVJJihnQCfBCTLffzrN0a1evLXPUsj//KZ0sOgrSMxaexHXUwTR6qzIg
         4G+A==
X-Gm-Message-State: APjAAAWxC4eTfYoD8SdeqaafAOx4GmhyegoLppfjoKCjgfTsjD5GdCFw
        mt7F0QAxSQkbe2ybEqTbUIfdIw==
X-Google-Smtp-Source: APXvYqzncw2UHqVoDvNK6OpljP9VBbV8193ABL+UI/ScYWvn2NrE2koim6mNu8NcM2bNTgGA/7ucZw==
X-Received: by 2002:adf:b6a3:: with SMTP id j35mr13980118wre.25.1554632220509;
        Sun, 07 Apr 2019 03:17:00 -0700 (PDT)
Received: from [192.168.1.77] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a17sm7881057wmg.40.2019.04.07.03.16.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Apr 2019 03:16:59 -0700 (PDT)
Message-ID: <5CA9CE1A.6060109@baylibre.com>
Date:   Sun, 07 Apr 2019 12:16:58 +0200
From:   Neil Armstrong <narmstrong@baylibre.com>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     robh@kernel.org
CC:     Steven Price <steven.price@arm.com>, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] dt-bindings: gpu: add bindings for the ARM Mali Bifrost
 GPU
References: <20190401080949.14550-1-narmstrong@baylibre.com> <1640dd7b-3576-d9ce-0641-6b6a64a87275@arm.com> <d26f1ce9-c56c-5e51-37f5-0689aa198dc0@baylibre.com>
In-Reply-To: <d26f1ce9-c56c-5e51-37f5-0689aa198dc0@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le 01/04/2019 13:24, Neil Armstrong a écrit :
> On 01/04/2019 12:00, Steven Price wrote:
>> On 01/04/2019 09:09, Neil Armstrong wrote:
>>> Add the bindings for the Bifrost family of ARM Mali GPUs.
>>>
>>> The Bifrost GPU architecture is similar to the Midgard family,
>>> but with a different Shader Core & Execution Engine structures.
>>>
>>> Bindings are based on the Midgard family bindings, but the inner
>>> architectural changes makes it a separate family needing separate
>>> bindings.
>>>
>>> The Bifrost GPUs are present in a number of recent SoCs, like the
>>> Amlogic G12A Family, and many other vendors.
>>> The Amlogic vendor specific compatible is added to handle the
>>> specific IP integration differences and dependencies.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>> ---
>>>  .../bindings/gpu/arm,mali-bifrost.txt         | 92 +++++++++++++++++++
>>>  1 file changed, 92 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>>>
>>> Changes since v3:
>>> - Added note about discoverable model/revision
>>> - Enforced fixed defined irq order
>>> - Fixed typo in accommodate
>>>
>>> Changes since v2:
>>> - moved to a single compatible since HW is fully discoverable
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>>> new file mode 100644
>>> index 000000000000..711c9ead17a2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.txt
>>> @@ -0,0 +1,92 @@
>>> +ARM Mali Bifrost GPU
>>> +====================
>>> +
>>> +Required properties:
>>> +
>>> +- compatible :
>>> +  * Since Mali Bifrost GPU model/revision if fully discoverable by reading
>>                                              ^^
>> s/if/is/

Should I still send a v5 to fixing this typo ? I can fix it while applying it.

Neil

> 
> Thanks for pointing this.
> 
>>
>>> +    some determined registers, must contain the following:
>>> +    + "arm,mali-bifrost"
>>> +  * which must be preceded by one of the following vendor specifics:
>>> +    + "amlogic,meson-g12a-mali"
>>> +
>>> +- reg : Physical base address of the device and length of the register area.
>>> +
>>> +- interrupts : Contains the three IRQ lines required by Mali Bifrost devices,
>>> +  in the following defined order.
>>> +
>>> +- interrupt-names : Contains the names of IRQ resources in this exact defined
>>> +  order: "job", "mmu", "gpu".
>>
>> Is there any point in having "interrupt-names" if we're fixing the
>> order? Although I guess it helps match the Midgard bindings.
> 
> Exact.
> 
> Neil
> 
>>
>> Steve
>>
>>> +
>>> +Optional properties:
>>> +
>>> +- clocks : Phandle to clock for the Mali Bifrost device.
>>> +
>>> +- mali-supply : Phandle to regulator for the Mali device. Refer to
>>> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
>>> +
>>> +- operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
>>> +  for details.
>>> +
>>> +- resets : Phandle of the GPU reset line.
>>> +
>>> +Vendor-specific bindings
>>> +------------------------
>>> +
>>> +The Mali GPU is integrated very differently from one SoC to
>>> +another. In order to accommodate those differences, you have the option
>>> +to specify one more vendor-specific compatible, among:
>>> +
>>> +- "amlogic,meson-g12a-mali"
>>> +  Required properties:
>>> +  - resets : Should contain phandles of :
>>> +    + GPU reset line
>>> +    + GPU APB glue reset line
>>> +
>>> +Example for a Mali-G31:
>>> +
>>> +gpu@ffa30000 {
>>> +	compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
>>> +	reg = <0xffe40000 0x10000>;
>>> +	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
>>> +		     <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
>>> +		     <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
>>> +	interrupt-names = "job", "mmu", "gpu";
>>> +	clocks = <&clk CLKID_MALI>;
>>> +	mali-supply = <&vdd_gpu>;
>>> +	operating-points-v2 = <&gpu_opp_table>;
>>> +	resets = <&reset RESET_DVALIN_CAPB3>, <&reset RESET_DVALIN>;
>>> +};
>>> +
>>> +gpu_opp_table: opp_table0 {
>>> +	compatible = "operating-points-v2";
>>> +
>>> +	opp@533000000 {
>>> +		opp-hz = /bits/ 64 <533000000>;
>>> +		opp-microvolt = <1250000>;
>>> +	};
>>> +	opp@450000000 {
>>> +		opp-hz = /bits/ 64 <450000000>;
>>> +		opp-microvolt = <1150000>;
>>> +	};
>>> +	opp@400000000 {
>>> +		opp-hz = /bits/ 64 <400000000>;
>>> +		opp-microvolt = <1125000>;
>>> +	};
>>> +	opp@350000000 {
>>> +		opp-hz = /bits/ 64 <350000000>;
>>> +		opp-microvolt = <1075000>;
>>> +	};
>>> +	opp@266000000 {
>>> +		opp-hz = /bits/ 64 <266000000>;
>>> +		opp-microvolt = <1025000>;
>>> +	};
>>> +	opp@160000000 {
>>> +		opp-hz = /bits/ 64 <160000000>;
>>> +		opp-microvolt = <925000>;
>>> +	};
>>> +	opp@100000000 {
>>> +		opp-hz = /bits/ 64 <100000000>;
>>> +		opp-microvolt = <912500>;
>>> +	};
>>> +};
>>>
>>
> 
