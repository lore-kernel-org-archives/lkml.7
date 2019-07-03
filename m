Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460BEC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12980218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLHtnmEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfGCOFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:05:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43484 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:05:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so2546141ljv.10;
        Wed, 03 Jul 2019 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZG2UMgdDAV2oBx4LVT6IwYAPv5J7xFdj5LWkwxMiZXY=;
        b=bLHtnmEAF5ZvaXPGQOuCRooghIah73EC/ySluBdo8Lbxhv6TkdN7TfpCNQPQ6p4ne0
         XdEo/oLl1aHia6gzSIEBdlS8xz4scZnWvrDGuF3jyGuOy4ryf3xDg9KJxomuUoKeOk9T
         /k4v4XAZBHqKeahgjLy7EbkHo4REGuZUjLHTPkNjfLcvV5jKs+Afb0xXAZIoz8/b48r5
         dNqgJHN6Xr9j5akdJ2mGX/qx1JI+YQ4EjnHvoEdqlt/U+3+fKemnJzqeo4ob4qyBbsEg
         pOjnWBqPM7rsJU0uzeoZcFhYiOtzo8SpeV1yalAFrsBey8Zb7GbazbtFSM8AVK1NtW0Z
         XCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZG2UMgdDAV2oBx4LVT6IwYAPv5J7xFdj5LWkwxMiZXY=;
        b=IlvRG7kfhHmCtaBccIMQzmquHxxqg6jdL8mr3wXY8QSuVEt1JXIplGs+j44c0jISPI
         6AKMUJzkns0cNdSjHkiY2YMzXJz7cWXENwpy2LDiM2aoZgVaUiLm1/sKStX4KKu5z5oc
         FSADanq6vBsy+VDeZ0ZEi/4bnNnIYYWGuM844Ti96Py8hflMmrPyiySxlvHi5z5LSJjK
         gsgKNH87YhvpJHEUTIwCQxN2E0+w/C7eEB3rb9SqiXG+3VbMbCT3trXx+s2R/5J+go4Z
         9IIDLLJBP5aJKKinJuq5NcgCvm0N1bJj+jVlxAMtM3iYawywWPBMeJFYQ8/ycZHAHOb3
         qNHw==
X-Gm-Message-State: APjAAAW1l3DI0egKkWnzZrgvaEYnnJtyK5jO/c5VSrO7sjSPNlCM+izW
        LK3Pk7MjRPds+aQ4Ni1h/OPd3GJo
X-Google-Smtp-Source: APXvYqw1MsZOHp0+5AV+cKjF9JNTP/sQsStMZ1Ql/RyUNFlCwQE83BtnATOAyep+C3N642uR6wF6pQ==
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr2846579ljn.25.1562162715557;
        Wed, 03 Jul 2019 07:05:15 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id z12sm411215lfg.67.2019.07.03.07.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 07:05:14 -0700 (PDT)
Subject: Re: [PATCH v6 07/15] dt-bindings: memory: tegra30: Convert to
 Tegra124 YAML
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
References: <20190630210019.26914-1-digetx@gmail.com>
 <20190630210019.26914-8-digetx@gmail.com>
 <CAL_JsqJq5iwQcbUixMWK819OTof8DzrZ3UMhByc1pTAFTdwnjg@mail.gmail.com>
 <ba299725-b65b-ce7d-6376-a26918cc985b@gmail.com>
 <d98f16ee-ac43-8f1e-d324-d6e2cfccf3c8@gmail.com>
 <CAL_Jsq+-cuqVf60MbaNTz3jCUQkEpU8EgUe1xyOzHLsM5zjjEg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7d24fa15-0bd0-2ae6-7951-36826956a24f@gmail.com>
Date:   Wed, 3 Jul 2019 17:05:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+-cuqVf60MbaNTz3jCUQkEpU8EgUe1xyOzHLsM5zjjEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.07.2019 16:22, Rob Herring пишет:
> On Tue, Jul 2, 2019 at 6:48 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 01.07.2019 22:30, Dmitry Osipenko пишет:
>>> 01.07.2019 22:11, Rob Herring пишет:
>>>> On Sun, Jun 30, 2019 at 3:04 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>
>>>>
>>>> "Convert" implies you delete the old binding doc.
>>>
>>> Yes, unfortunately the deletion got lost by accident after rebase and it was already
>>> too late when I noticed that. Will be fixed in the next revision.
>>>
>>>>> The Tegra30 binding will actually differ from the Tegra124 a tad, in
>>>>> particular the EMEM configuration description. Hence rename the binding
>>>>> to Tegra124 during of the conversion to YAML.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  .../nvidia,tegra124-mc.yaml                   | 149 ++++++++++++++++++
>>>>>  1 file changed, 149 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..d18242510295
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>>>> @@ -0,0 +1,149 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title:
>>>>> +  NVIDIA Tegra124 SoC Memory Controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Jon Hunter <jonathanh@nvidia.com>
>>>>> +  - Thierry Reding <thierry.reding@gmail.com>
>>>>> +
>>>>> +description: |
>>>>> +  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controller.
>>>>> +  These are interleaved to provide high performance with the load shared across
>>>>> +  two memory channels. The Tegra124 Memory Controller handles memory requests
>>>>> +  from internal clients and arbitrates among them to allocate memory bandwidth
>>>>> +  for DDR3L and LPDDR3 SDRAMs.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: nvidia,tegra124-mc
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +    description:
>>>>> +      Physical base address.
>>>>> +
>>>>> +  clocks:
>>>>> +    maxItems: 1
>>>>> +    description:
>>>>> +      Memory Controller clock.
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: mc
>>>>> +
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +    description:
>>>>> +      Memory Controller interrupt.
>>>>> +
>>>>> +  "#reset-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  "#iommu-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +patternProperties:
>>>>> +  ".*":
>>>>
>>>> Please define a node name or pattern for node names.
>>>
>>> There was no pattern specified in the original binding. But I guess the existing
>>> upstream device-trees could be used as the source for the pattern.
>>
>> Actually it looks like the use of explicit pattern is not really a good idea because
>> device-tree could have node named in a way that it doesn't match the pattern and hence
>> dtbs_check silently skips the non-matching nodes. Is there any way to express that
>> non-matching nodes shall be rejected?
> 
> additionalProperties: false
> 
> It's not ideal because you have to list all properties and can't
> combine multiple schema, but that's getting addressed in json-schema
> draft8. That shouldn't matter for you in this case though.

Works like a charm! Thank you very much.
