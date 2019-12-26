Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A1206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2L/XU4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLZWXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:23:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50861 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfLZWXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:23:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so6800066wmb.0;
        Thu, 26 Dec 2019 14:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3QNwTc3GGOSdCXQ9t4Oj8oCFjhCPFnlMMq+lcFhaEVc=;
        b=E2L/XU4/xHdrN/H4yf61b8k/WvCWU+9naQOqymE5fohMiQ2ApT9pU61dihedVzFaMz
         OmKyvkg0dNcLHiafQX7Q44mYwO1yaziKzIYXnZDhaVQa9qBO73LVMar9EmzQhiwUglgW
         VwIqfNzXTVjs2xI/d+ySuTHXKyjKSCd/DqPVgE2tt1ir/8jCT+6sXbsBl1GCyTaEEmmu
         +EH4dGBEKKGs/kXGXwleQEgPfPiOah/rh7dt+W/WzQTooCn9gQLNljxpDHHkgiX0DosJ
         JewSZKxarK/YXpfCnpU7TM9y3d9ovolZblqNMmnNvXbpTmCCgU1K8dp+Zcf/3YrmXl5p
         dBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3QNwTc3GGOSdCXQ9t4Oj8oCFjhCPFnlMMq+lcFhaEVc=;
        b=cdoRKXzgPNBgm+1Vs/ywfal0+OHUSJ/A1cJ64pfqyVUS2SerC+C5V8Y42JvwdhgbLe
         Gr9n1E7zUg6qCxA/AbagFy0XkuqLmDTVk05Ix5DpMtFgXrUv1cIl34PODVjBEHP5X6hQ
         QVr/4LLU8eFGDVMDnsKrWLDAbFWYDCxAzOiqMh7LMZD2F1BnXnA/4h1aroY97CrKEP/M
         IYCO64bsSOJd/u2aIQDIqHp2kKJqyuTt7pwYhUBrMnwqUWYXn9wgwxm6b13JmOtFhrJc
         M0qF2o5csCtYYT0AFKVPEmQQU9ncBJDMPTmupK/ltfel68PNL/GrI2O4O9gArIQhECye
         ovVA==
X-Gm-Message-State: APjAAAVU5kLSm1Inn9lXbfa5KERCo/FbeRoN4bUWvh0DzWxCENV7KCCh
        /qR06ACN6633wsEYe0EHBFRkFquC31cbSQ==
X-Google-Smtp-Source: APXvYqwvBrW52R/uUv9V0//RKTj/actbSLV9Ka4Rnm1P7CWPkrlBuWD31V7Z8EjQZHvgMcK+TgFFhA==
X-Received: by 2002:a1c:1b44:: with SMTP id b65mr14898669wmb.11.1577399018370;
        Thu, 26 Dec 2019 14:23:38 -0800 (PST)
Received: from [192.168.0.104] (p5B3F7018.dip0.t-ipconnect.de. [91.63.112.24])
        by smtp.gmail.com with ESMTPSA id x7sm32117123wrq.41.2019.12.26.14.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 14:23:37 -0800 (PST)
Subject: Re: [PATCH v3 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
To:     Maxime Ripard <mripard@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191222204507.32413-1-sravanhome@gmail.com>
 <20191222204507.32413-3-sravanhome@gmail.com>
 <20191223105028.amtzf62yjdpdsfrt@hendrix.home>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <ec7d8937-724e-946c-0569-da685223d21d@gmail.com>
Date:   Thu, 26 Dec 2019 23:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191223105028.amtzf62yjdpdsfrt@hendrix.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/19 11:50 am, Maxime Ripard wrote:

> On Sun, Dec 22, 2019 at 09:45:05PM +0100, Saravanan Sekar wrote:
>> Add device tree binding information for mpq7920 regulator driver.
>> Example bindings for mpq7920 are added.
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   .../bindings/regulator/mpq7920.yaml           | 143 ++++++++++++++++++
>>   1 file changed, 143 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
>> new file mode 100644
>> index 000000000000..d173ba1fb28d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
>> @@ -0,0 +1,143 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/mpq7920.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Monolithic Power System MPQ7920 PMIC
>> +
>> +maintainers:
>> +  - Saravanan Sekar <sravanhome@gmail.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "pmic@[0-9a-f]{1,2}"
>> +  compatible:
>> +    enum:
>> +      - mps,mpq7920
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  mps,time-slot:
>> +    description:
>> +      each regulator output shall be delayed during power on/off sequence which
>> +      based on configurable time slot value, must be one of following corresponding
>> +      value 0.5ms, 2ms, 8ms, 16ms
>> +    allOf:
>> +      - $ref: "/schemas/types.yaml#/definitions/uint8"
>> +      - enum: [ 0, 1, 2, 3 ]
>> +      - default: 0
>> +
>> +  mps,fixed-on-time:
>> +     description:
>> +       select power on sequence with fixed time output delay mentioned in
>> +       time-slot reg for all the regulators.
>> +     type: boolean
>> +
>> +  mps,fixed-off-time:
>> +     description:
>> +        select power off sequence with fixed time output delay mentioned in
>> +        time-slot reg for all the regulators.
>> +     type: boolean
> I'm not sure what this fixed-on-time and fixed-off-time property is

the time slot register holds the time interval of Vout when enable the
each regulator.
fixed-on-time property is to specify each regulator shares same time
interval mention in time slot register.
variable on-time defines the factor or multiples of value in time slot
register.


> supposed to be doing. Why not just get rid of the time slot property,
> and set the power on / power off time in fixed-on-time /
> fixed-off-time property?

1. if fixed-on-time is needed with default time slot register settings,
then time slot property is not needed
2. if variable time is needed with modified time slot, then both
variable time factor & time slot property is needed,
Hope above explanations answers the necessary of all the above property

>
>> +  mps,inc-off-time:
>> +     description: |
>> +        mutually exclusive to mps,fixed-off-time an array of 8, linearly increase
>> +        output delay during power off sequence based on factor of time slot/interval
>> +        for each regulator.
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - minimum: 0
>> +       - maximum: 15
>> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
> You should check the size of the array too, but if it's a property of
> the regulators, why not have it in the regulators node?

the node regulators & sub-node of regulators are parsed (initdata) by
regulator framework during regulator registration,
so it would be redundant parsing all the node if mentioned under each
regulator node and this is optional. If you still not
convinced I will change.

>> +  mps,inc-on-time:
>> +     description: |
>> +        mutually exclusive to mps,fixed-on-time an array of 8, linearly increase
>> +        output delay during power on sequence based on factor of time slot/interval
>> +        for each regulator.
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - minimum: 0
>> +       - maximum: 15
>> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
>> +
>> +  mps,switch-freq:
>> +     description: |
>> +        switching frequency must be one of following corresponding value
>> +        1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8"
>> +       - enum: [ 0, 1, 2, 3 ]
>> +       - default: 2
>> +
>> +  mps,buck-softstart:
>> +     description: |
>> +        An array of 4 contains soft start time of each buck, must be one of
>> +        following corresponding values 150us, 300us, 610us, 920us
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - enum: [ 0, 1, 2, 3 ]
>> +       - default: [ 1, 1, 1, 1 ]
>> +
>> +  mps,buck-ovp:
>> +     description: |
>> +        An array of 4 contains over voltage protection of each buck, must be
>> +        one of above values
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - enum: [ 0, 1 ]
>> +       - default: [ 1, 1, 1, 1 ]
>> +
>> +  mps,buck-phase-delay:
>> +     description: |
>> +        An array of 4 contains phase delay of each buck must be one of above values
>> +        corresponding to 0deg, 90deg, 180deg, 270deg
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - enum: [ 0, 1, 2, 3 ]
>> +       - default: [ 0, 0, 1, 1 ]
>> +
>> +  regulators:
>> +    type: object
>> +    description:
>> +      list of regulators provided by this controller, must be named
>> +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
>> +      The valid names for regulators are
>> +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5
> For the third times now, the names should be validated using
> propertyNames.

Not sure did I understand your question correctly.
all the node name under regulators node are parsed by regulator
framework & validated against
name in regulator descriptors.

>
> Maxime


Thanks,

Saravanan

On 23/12/19 11:50 am, Maxime Ripard wrote:
> On Sun, Dec 22, 2019 at 09:45:05PM +0100, Saravanan Sekar wrote:
>> Add device tree binding information for mpq7920 regulator driver.
>> Example bindings for mpq7920 are added.
>>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   .../bindings/regulator/mpq7920.yaml           | 143 ++++++++++++++++++
>>   1 file changed, 143 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
>> new file mode 100644
>> index 000000000000..d173ba1fb28d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
>> @@ -0,0 +1,143 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/mpq7920.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Monolithic Power System MPQ7920 PMIC
>> +
>> +maintainers:
>> +  - Saravanan Sekar <sravanhome@gmail.com>
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "pmic@[0-9a-f]{1,2}"
>> +  compatible:
>> +    enum:
>> +      - mps,mpq7920
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  mps,time-slot:
>> +    description:
>> +      each regulator output shall be delayed during power on/off sequence which
>> +      based on configurable time slot value, must be one of following corresponding
>> +      value 0.5ms, 2ms, 8ms, 16ms
>> +    allOf:
>> +      - $ref: "/schemas/types.yaml#/definitions/uint8"
>> +      - enum: [ 0, 1, 2, 3 ]
>> +      - default: 0
>> +
>> +  mps,fixed-on-time:
>> +     description:
>> +       select power on sequence with fixed time output delay mentioned in
>> +       time-slot reg for all the regulators.
>> +     type: boolean
>> +
>> +  mps,fixed-off-time:
>> +     description:
>> +        select power off sequence with fixed time output delay mentioned in
>> +        time-slot reg for all the regulators.
>> +     type: boolean
> I'm not sure what this fixed-on-time and fixed-off-time property is
> supposed to be doing. Why not just get rid of the time slot property,
> and set the power on / power off time in fixed-on-time /
> fixed-off-time property?
>
>> +  mps,inc-off-time:
>> +     description: |
>> +        mutually exclusive to mps,fixed-off-time an array of 8, linearly increase
>> +        output delay during power off sequence based on factor of time slot/interval
>> +        for each regulator.
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - minimum: 0
>> +       - maximum: 15
>> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
> You should check the size of the array too, but if it's a property of
> the regulators, why not have it in the regulators node?
>
>> +  mps,inc-on-time:
>> +     description: |
>> +        mutually exclusive to mps,fixed-on-time an array of 8, linearly increase
>> +        output delay during power on sequence based on factor of time slot/interval
>> +        for each regulator.
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - minimum: 0
>> +       - maximum: 15
>> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
>> +
>> +  mps,switch-freq:
>> +     description: |
>> +        switching frequency must be one of following corresponding value
>> +        1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8"
>> +       - enum: [ 0, 1, 2, 3 ]
>> +       - default: 2
>> +
>> +  mps,buck-softstart:
>> +     description: |
>> +        An array of 4 contains soft start time of each buck, must be one of
>> +        following corresponding values 150us, 300us, 610us, 920us
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - enum: [ 0, 1, 2, 3 ]
>> +       - default: [ 1, 1, 1, 1 ]
>> +
>> +  mps,buck-ovp:
>> +     description: |
>> +        An array of 4 contains over voltage protection of each buck, must be
>> +        one of above values
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - enum: [ 0, 1 ]
>> +       - default: [ 1, 1, 1, 1 ]
>> +
>> +  mps,buck-phase-delay:
>> +     description: |
>> +        An array of 4 contains phase delay of each buck must be one of above values
>> +        corresponding to 0deg, 90deg, 180deg, 270deg
>> +     allOf:
>> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
>> +       - enum: [ 0, 1, 2, 3 ]
>> +       - default: [ 0, 0, 1, 1 ]
>> +
>> +  regulators:
>> +    type: object
>> +    description:
>> +      list of regulators provided by this controller, must be named
>> +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
>> +      The valid names for regulators are
>> +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5
> For the third times now, the names should be validated using
> propertyNames.
>
> Maxime
