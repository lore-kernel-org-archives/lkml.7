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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA5C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5E4218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH9UZMJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfGCAsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:48:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32798 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfGCAsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:48:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so506297ljg.0;
        Tue, 02 Jul 2019 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TWJCP/fEaymOaFdQkCML59yLiwgz6iUoELvQxqYUfdQ=;
        b=dH9UZMJPZrX5saPr6Hul/qtlv0mwSa063rtp6m+Tu60V+c485syc2p1FuguZnRteDM
         0nWzpSUQwXX5DV+zihGpxnjUGbv+Hp9/D17TLC8PAWZ1ubFv7Mx2JjGyX2PS23I2EvPt
         smy0gAB495gfjp0DvpCgSh6vRcvwLoXJehHbl7K0Qll+YwtuGDj9QGsOV5P/zAsesU33
         DkAAP2ioEA8C7I4ic3uqQYPDnl+bBd6ux3EeepIulDI8+rohzwK/DetuQm2iHnqUy3tj
         zn+ngimK5MtEezkEDFTeZw/S+zIy6Tb7BAl48UKaiTQ61V+w3gh1KphREG4bamRJ0821
         WjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TWJCP/fEaymOaFdQkCML59yLiwgz6iUoELvQxqYUfdQ=;
        b=FQn1Pm+1SZ79fbTJkaIc/qqb4tCqAfSakBeYxmd9mLMvt+rnF4RospZjCNPn5uhmdA
         UqqqfIddNByI7EOygKVs3DXZU7UnodiJVNf3qpNKg4zTsxKUCHzHREMxWrREVkIKi1FI
         F1kXWqo8Yhk16flmh48MS2HuZJe1/hD1ggN9OZfjiE2azG3Mc9pF96sZn4hbMSYd+xWS
         klNLQyccSowdUQOnWeTyoVxva8sDJtvLh2fA3EEpua9OXu4UDen/chUe556GlwBm2ISC
         emVoPS4lbbgywF8UR7uepHwKBziAxkVR5y5LEJ6/MZP2Tjqympo8HeJ1e40Y3f+sqFcg
         Agzw==
X-Gm-Message-State: APjAAAVlLHaB6wg9ycuWWbxMUxwduf42nwx9Y9GNrOvv65tzFLbqe4Wf
        iBgQNpdUik+Q5q8sIcwfh7cqrqX9
X-Google-Smtp-Source: APXvYqxJj59E+oUMQaEbbY269e+VK0l4af2KOAsx0cebioGvo9ypvyjI6QKvyFE8oJfNsZmIp6/YFQ==
X-Received: by 2002:a2e:9f57:: with SMTP id v23mr20122353ljk.138.1562114928255;
        Tue, 02 Jul 2019 17:48:48 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id v15sm102810lfq.86.2019.07.02.17.48.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 17:48:47 -0700 (PDT)
Subject: Re: [PATCH v6 07/15] dt-bindings: memory: tegra30: Convert to
 Tegra124 YAML
From:   Dmitry Osipenko <digetx@gmail.com>
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
Message-ID: <d98f16ee-ac43-8f1e-d324-d6e2cfccf3c8@gmail.com>
Date:   Wed, 3 Jul 2019 03:48:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ba299725-b65b-ce7d-6376-a26918cc985b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.07.2019 22:30, Dmitry Osipenko пишет:
> 01.07.2019 22:11, Rob Herring пишет:
>> On Sun, Jun 30, 2019 at 3:04 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>
>> "Convert" implies you delete the old binding doc.
> 
> Yes, unfortunately the deletion got lost by accident after rebase and it was already
> too late when I noticed that. Will be fixed in the next revision.
> 
>>> The Tegra30 binding will actually differ from the Tegra124 a tad, in
>>> particular the EMEM configuration description. Hence rename the binding
>>> to Tegra124 during of the conversion to YAML.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  .../nvidia,tegra124-mc.yaml                   | 149 ++++++++++++++++++
>>>  1 file changed, 149 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>> new file mode 100644
>>> index 000000000000..d18242510295
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>> @@ -0,0 +1,149 @@
>>> +# SPDX-License-Identifier: (GPL-2.0)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title:
>>> +  NVIDIA Tegra124 SoC Memory Controller
>>> +
>>> +maintainers:
>>> +  - Jon Hunter <jonathanh@nvidia.com>
>>> +  - Thierry Reding <thierry.reding@gmail.com>
>>> +
>>> +description: |
>>> +  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controller.
>>> +  These are interleaved to provide high performance with the load shared across
>>> +  two memory channels. The Tegra124 Memory Controller handles memory requests
>>> +  from internal clients and arbitrates among them to allocate memory bandwidth
>>> +  for DDR3L and LPDDR3 SDRAMs.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: nvidia,tegra124-mc
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +    description:
>>> +      Physical base address.
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +    description:
>>> +      Memory Controller clock.
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: mc
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +    description:
>>> +      Memory Controller interrupt.
>>> +
>>> +  "#reset-cells":
>>> +    const: 1
>>> +
>>> +  "#iommu-cells":
>>> +    const: 1
>>> +
>>> +patternProperties:
>>> +  ".*":
>>
>> Please define a node name or pattern for node names.
> 
> There was no pattern specified in the original binding. But I guess the existing
> upstream device-trees could be used as the source for the pattern.

Actually it looks like the use of explicit pattern is not really a good idea because
device-tree could have node named in a way that it doesn't match the pattern and hence
dtbs_check silently skips the non-matching nodes. Is there any way to express that
non-matching nodes shall be rejected?
