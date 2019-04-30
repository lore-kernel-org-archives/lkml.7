Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DA22147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zq29Lce4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfD3PYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:24:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40121 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfD3PYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:24:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id h11so4271827wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sfPiJtc0QJCi1p8F+pLfyW3kyCVBd6/w24lBML4INFs=;
        b=Zq29Lce4FbgANq8O/VR3G2DR2T0McxOvjAYNyFuGiseM6g0bFwbbKyg6YAdPZGaXB9
         qR42Am+otNkuxkoxLnvL3C11uwc87q2JORpiNTArbGaOX9lQsC0H619piV+BTkIJiBqk
         bv14v1HIcvXqUneiIi1i3MHBgnHpgH4Bn0gIhYWoe/SfR+wDasBlzzQmKA2elwrOAlYK
         yRqwj0wM5DdV4t42oN9NHi82sgsbC9HPX8bX7Zc05QL3xz6ypUgyaKckplMe5Mgje5RG
         KrlINFZ7i9Bhg9WVZ7ANpr5QqK1b4QC5i7Y7f627OU2rwVdTFFihabLo3nOatYM6Hw9a
         pP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sfPiJtc0QJCi1p8F+pLfyW3kyCVBd6/w24lBML4INFs=;
        b=Z0v8OcnOROd1GHDuFYzOGT6klvmTf4e95DLTjCh4VjEz5lqU8PnyMWFx/SkVXr6ijV
         Oz39iip3AAtdovufscybLas2IZnsxDeIUX67yEVcMU+l6Kb1z65zHE7I4peThYxFqXBo
         UjBJ9DbrM7lQtrYXilt8PEabNAlrhmRkUAdwtL0tB+cWxPEMTCYth4yLX/1hgXJ/L/Cg
         d5UAXZ1LOj6HssGG+xmAaSXUE0kBYPTuc3xu/jz+d2X6uHaM5ZK1vu/mtZ1tRW/Ilpui
         DXznvtLwRTT3QcxLdXGO2RPdxArrjbOPkkbymvbdZp4BxgHWNTgTr0jnNHsGDvm5koJs
         GuJg==
X-Gm-Message-State: APjAAAUpBahptyenPxS1pmgldZnShPEhWhYHR2Y5Zwv0Mig+T/Ym9JB8
        HOL60lJMruhcBwRAG4FX3Tc0xdcLGWg=
X-Google-Smtp-Source: APXvYqwZu73MRdHtNl6L5wzqWxZQM0gSV2O1ZuD0lDRbcOfSjsiOhySkIltHDNpgSln+Rq/Ek1lkSg==
X-Received: by 2002:a1c:a843:: with SMTP id r64mr1118747wme.45.1556637858428;
        Tue, 30 Apr 2019 08:24:18 -0700 (PDT)
Received: from [10.1.4.98] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s132sm3986240wms.10.2019.04.30.08.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:24:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: add a 'drive-strength-uA'
 property
To:     Rob Herring <robh@kernel.org>
Cc:     linus.walleij@linaro.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190418124758.24022-1-glaroque@baylibre.com>
 <20190418124758.24022-2-glaroque@baylibre.com> <20190430151243.GA6879@bogus>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <7d1743ca-f45a-133f-6130-c77059d27de2@baylibre.com>
Date:   Tue, 30 Apr 2019 17:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430151243.GA6879@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 4/30/19 5:12 PM, Rob Herring wrote:
> On Thu, Apr 18, 2019 at 02:47:55PM +0200, Guillaume La Roque wrote:
>> This property allow drive-strength parameter in uA instead of mA.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>> index cef2b5855d60..fc7018459aa2 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>> @@ -258,6 +258,7 @@ drive-push-pull		- drive actively high and low
>>  drive-open-drain	- drive with open drain
>>  drive-open-source	- drive with open source
>>  drive-strength		- sink or source at most X mA
>> +drive-strength-uA	- sink or source at most X uA
>>  input-enable		- enable input on pin (no effect on output, such as
>>  			  enabling an input buffer)
>>  input-disable		- disable input on pin (no effect on output, such as
>> @@ -326,6 +327,8 @@ arguments are described below.
>>  
>>  - drive-strength takes as argument the target strength in mA.
>>  
>> +- drive-strength-uA takes as argument the target strength in uA.
>> +
> We have standard unit suffixes defined in bindings/property-units.txt. 
> Use them please.


thanks for your feedback and sorry i don't see this doc.

According to it i will update patch series with drive-strength-microamp


> Rob
Guillaume
