Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D63BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2008321721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prz9JSr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfGATaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:30:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39762 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGATaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:30:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so14400790ljh.6;
        Mon, 01 Jul 2019 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2eFfHmfd9U9AMnKFnD7g9eg9q57yzBinw/q4+GoLBk=;
        b=prz9JSr0Ix/WEdo4cL4SdYm7c5EuCT+Kyz0mYTOybz6lg9vOtPNg0KBN36C+D7A+95
         pVxPfXyCS9zSpZ6W40JayIh0zBBAU4KZ5/P2M71D96mxyMyVnooItQXuadtMCJKUNf6q
         9xVN9KI872oKfQyBGV2HpNrjMVnPCzfWNcixCp5s/42qk/AHIkBGxq77H8nBlpCeTcU6
         kqeSOAjzzN9PSAddCq9fFyrLSNYhzFB+gUQT4aZqbln4aS2zOQ0EZNjcDuFlf5nOK1Sc
         tA1fzcbbC12A3APOFXZDkPZR/V3023ZoVSgKHtlMaYNsc1Ye/qh+LCgtFS/cTdXnZVx2
         S6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2eFfHmfd9U9AMnKFnD7g9eg9q57yzBinw/q4+GoLBk=;
        b=HuZo0TIQc74oEbt3gVbMDmXYNV/j2knojVVhqEVt3Ezg8xcU+tRHf+0LTQ1qLLTos1
         HW0W/rrntYXgFPocTl2G91/rtKjUhvZ+/3FyFjJ3OdnBDEz9p7XgLomAfUsH4ivTcGQq
         oM+20H4MTeiHjirIgnjzJKQYwuCWkqtJmO8VCBDtKIWIAbZHbkDPhajdbh/9ORxK/dI7
         Qm/Xqv2Rwe5pWYohbcIwOAdNN9cg+YCajl2BjKEQdstG89SmV8x29XhmTZKzH/TxHUwv
         hgwx6KjJVQtfpF5fl5dhU4h4fIl1tAMVw1Z1eegofACny0gmGIgEzdnnqPTKsHIiymOt
         DsGw==
X-Gm-Message-State: APjAAAWh3dFBhF6qcjFQWsjpXmcN+hchnN8qMwTLl5z1e51OkFg5XPt9
        kVbvDYjWcrPVX/U+Urd0Z8Ql13mP
X-Google-Smtp-Source: APXvYqyt7pIhGs2lNgfb9Ej2qDR5BG2Vm8qXWoVDPEMZd8CXonitUT2Jb1OUibTRNSj7RCOuN90Yaw==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr3513670ljj.170.1562009418517;
        Mon, 01 Jul 2019 12:30:18 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id u18sm2582661lfe.65.2019.07.01.12.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:30:17 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ba299725-b65b-ce7d-6376-a26918cc985b@gmail.com>
Date:   Mon, 1 Jul 2019 22:30:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJq5iwQcbUixMWK819OTof8DzrZ3UMhByc1pTAFTdwnjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.07.2019 22:11, Rob Herring пишет:
> On Sun, Jun 30, 2019 at 3:04 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
> 
> "Convert" implies you delete the old binding doc.

Yes, unfortunately the deletion got lost by accident after rebase and it was already
too late when I noticed that. Will be fixed in the next revision.

>> The Tegra30 binding will actually differ from the Tegra124 a tad, in
>> particular the EMEM configuration description. Hence rename the binding
>> to Tegra124 during of the conversion to YAML.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../nvidia,tegra124-mc.yaml                   | 149 ++++++++++++++++++
>>  1 file changed, 149 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>> new file mode 100644
>> index 000000000000..d18242510295
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>> @@ -0,0 +1,149 @@
>> +# SPDX-License-Identifier: (GPL-2.0)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title:
>> +  NVIDIA Tegra124 SoC Memory Controller
>> +
>> +maintainers:
>> +  - Jon Hunter <jonathanh@nvidia.com>
>> +  - Thierry Reding <thierry.reding@gmail.com>
>> +
>> +description: |
>> +  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controller.
>> +  These are interleaved to provide high performance with the load shared across
>> +  two memory channels. The Tegra124 Memory Controller handles memory requests
>> +  from internal clients and arbitrates among them to allocate memory bandwidth
>> +  for DDR3L and LPDDR3 SDRAMs.
>> +
>> +properties:
>> +  compatible:
>> +    const: nvidia,tegra124-mc
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description:
>> +      Physical base address.
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description:
>> +      Memory Controller clock.
>> +
>> +  clock-names:
>> +    items:
>> +      - const: mc
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description:
>> +      Memory Controller interrupt.
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  "#iommu-cells":
>> +    const: 1
>> +
>> +patternProperties:
>> +  ".*":
> 
> Please define a node name or pattern for node names.

There was no pattern specified in the original binding. But I guess the existing
upstream device-trees could be used as the source for the pattern.

>> +    properties:
>> +      nvidia,ram-code:
>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> +        description:
>> +          Value of RAM_CODE this timing set is used for.
>> +
>> +    patternProperties:
>> +      ".*":
> 
> Same here.
> 
>> +        properties:
>> +          clock-frequency:
>> +            description:
>> +              Memory clock rate in Hz.
> 
> No constraints? Anything from 0 to 4GHz works?

Okay, will add the min/max. I'm not sure what is the exact upper freq limit, probably
~1GHz.
