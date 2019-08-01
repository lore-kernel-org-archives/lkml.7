Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C4FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA1120838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P53KB114"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387868AbfHARwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:52:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39681 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHARwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:52:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so21357695wrt.6;
        Thu, 01 Aug 2019 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ohZJTOM9nVguGoUhqHGSECOaLDP5lg21SOn4QPD4lfg=;
        b=P53KB114bPG4EgaBgRyfA3chKoU/3otrIw46KCIzWQYQyEjpuTgm7aKrzm3F6hlNcr
         ZKrzO1WkViwDHpdg8FrMm2opE5i09jVNlWH4xvy/ODETlwapOVfP66Vv+nbndxRSZP0z
         vULLgTsl0WMEwlEOpgl7x3OL4eeXjWoiR1JiRO2jR2T6Tqrjl/tvXXTvHRddAW1oNlkU
         tehcL615KbtvXZ005vtfrdHZ+RXH27wqTRx37KhDOmnBBMV+856nn15CxT8AOU6kYBDO
         n1DQjQsvjE/dyC1iRK1dub9H9OXET80d3ma8e+jL7x2AgOPThJyIM9BIxkW8d8axYAhX
         MM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ohZJTOM9nVguGoUhqHGSECOaLDP5lg21SOn4QPD4lfg=;
        b=fESp1MmTR6ST+U9Bgd9aa+SWn8emqVCUrgVJ8ShaOLiqd+7Cso54/wLlJu+Y9RQ2MY
         1tz0NSkpGTNvyxo3Wo6tYXVg7PJjwSGjQdlKejR/Y0sEU7gMRlx7LlVtlv+Ks/50qBvW
         WZ1KoPen4TJwCy73QW/Ebyia/WpCTLZKl/Fzfaoech731pkZoRlZs8ITUuvGY7HA3pwL
         BYy4rGrApRzISBcvvsV4cWethZWNF3vZL+E6OCQFbKmvnMTIH6tj8JNUCuTPHiL4LYCB
         gPd9fyN2T6MYzi1Q8j8mkm6PhhsNFYzrKBZKnRZRauwWasHA6sSivhDBu975rPgfNyEx
         mk6g==
X-Gm-Message-State: APjAAAUHPAb2jAud7FeqDC+ReD6+vNEk9eN1acpLV28BOz68Gec5pIDI
        H9WzHlHrYp7yKasLq+wfbq5mtDGI
X-Google-Smtp-Source: APXvYqy7rbdIRAr9veyqwHhwvbVMP3sLU2JgLWFf9cF5qovNnJfXY0HHf9fvnVxMh2KbS00eyEeV3Q==
X-Received: by 2002:adf:e708:: with SMTP id c8mr40718094wrm.25.1564681935229;
        Thu, 01 Aug 2019 10:52:15 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id j33sm155544226wre.42.2019.08.01.10.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 10:52:14 -0700 (PDT)
Subject: Re: [PATCH v9 09/15] dt-bindings: memory: tegra30: Convert to
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
References: <20190730165618.10122-1-digetx@gmail.com>
 <20190730165618.10122-10-digetx@gmail.com>
 <CAL_JsqL_LA+cW2GbCMdzRTFuv2oKE3pzyOm2UwdzLVLyVTnmNw@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <58e25c92-a61d-54f1-e784-ed85804236d7@gmail.com>
Date:   Thu, 1 Aug 2019 20:52:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL_LA+cW2GbCMdzRTFuv2oKE3pzyOm2UwdzLVLyVTnmNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.08.2019 19:25, Rob Herring пишет:
> On Tue, Jul 30, 2019 at 10:58 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> The Tegra30 binding will actually differ from the Tegra124 a tad, in
>> particular the EMEM configuration description. Hence rename the binding
>> to Tegra124 during of the conversion to YAML.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../nvidia,tegra124-mc.yaml                   | 158 ++++++++++++++++++
>>  .../memory-controllers/nvidia,tegra30-mc.txt  | 123 --------------
>>  2 files changed, 158 insertions(+), 123 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>> new file mode 100644
>> index 000000000000..2e2a116f1911
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>> @@ -0,0 +1,158 @@
>> +# SPDX-License-Identifier: (GPL-2.0)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NVIDIA Tegra124 SoC Memory Controller
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
> 
> You don't really need a description when there's only 1 item. Same on
> the others below.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Okay, I'll change that in the next revision. I also assume that the r-b
applies to all three patches, otherwise please let me know. Thanks!

