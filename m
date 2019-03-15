Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF084C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C85A218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PqODsijp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfCOJbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:31:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38389 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:31:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id a188so5289482wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GG2tyPVfPOwNtG8WrVnhUz4AOGb8TAauH9hKZw5Lpm0=;
        b=PqODsijpegmKYTqU/NqpZAOs+X2Q5aBubIrdgfjXs28+xYCHa3bpmRCqXr4hCpnz2J
         y2NWBtNapiM8LHi1WOPUJ9ORIMrqtllVBjwK6rtj8AGLoge6EXwuowkDmL9kPg9PV142
         7R/vsQ0C4b4EHuH7AS4b5SVlAyl4r3oh85gR/EijHRi9y+wm6SVs9PFW34JzeM0U+Unq
         RV3Upd2TkekKtHypC/FHN+5oyRTIsvH6szjAoe/hiLaofLl6b/Jv9Prc+Bp8tO6VUNIC
         UWhq1aJk3/bT27QnhequXaEMNRji6SAjZT5SLPVfQhkl6o3ITpRkKXiLGCrkxy6Bmsur
         /8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GG2tyPVfPOwNtG8WrVnhUz4AOGb8TAauH9hKZw5Lpm0=;
        b=UGp5cCg+7LfySiwwgdhqxWBN+6aqi1QoUIlfMjBfz40k6nG7dlJDHRPFGhi8L/L2Dp
         uV8MNl0rAgO4sD+X1qmEn4JFK2D0zvJnbSfTMkhljVE3M+GbM3UvHSn5tLn+aY83vmAu
         XtAxESV+zpp6pL+zS63lYmluhUU2O6XIE7pQper5emWquUUMoAafEzauPSPsg8byz/3B
         8KDXtkFmzrdm01WaN8wcetD5IbUAZ/jtvowjzWbXVohioS/aL07iwipVYTJQj81X5ITi
         V+b+9HJjV+vhqjL+ynLgU85BzjrgQ2pNXPgjvzlBd+FvOCKRlsL2c/3ZZn7pvMn/bK0L
         R2Tw==
X-Gm-Message-State: APjAAAWXt8kks9Nfk/FT2InqvciRa8ngZAPPynjpa5gk+aUDIrVZAwiA
        i5G+4IswIoyrF15rAovj4lJMBw==
X-Google-Smtp-Source: APXvYqxb+tmifCG7gv9OhFb73TOo2STxGIjpH9cLvTU51mXa4bCF/OajiUSVmaLJp1cKSRfvMR6I2w==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr1378309wml.108.1552642274440;
        Fri, 15 Mar 2019 02:31:14 -0700 (PDT)
Received: from [10.2.4.163] (aputeaux-684-1-31-143.w90-86.abo.wanadoo.fr. [90.86.86.143])
        by smtp.gmail.com with ESMTPSA id u3sm1045820wrq.86.2019.03.15.02.31.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 02:31:13 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "ptitiano@baylibre.com" <ptitiano@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <56e96a3a-4901-c79c-e91d-6b6a0690e5b7@baylibre.com>
Date:   Fri, 15 Mar 2019 10:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aisheng

On 3/15/19 3:39 AM, Aisheng Dong wrote:
> +Jacky and Leonard, Ranjani
> 
> Hi Alexandre,
> 
>> From: Alexandre Bailon [mailto:abailon@baylibre.com]
>>
>> This series implements busfreq, a framework used in MXP's tree to scale the
>> interconnect and dram frequencies.
>> In the vendor tree, device's driver request for a performance level, which is
>> used to scale the frequencies.
>> This series implements it using the interconnect framework.
>> Devices' driver request for bandwidth which is use by busfreq to determine a
>> performance level, and then scale the frequency.
>>
>> Busfreq is quite generic. It could be used for any i.MX SoC.
>> A busfreq platform driver just have to define a list of interconnect nodes, and
>> some OPPs.
>>
> 
> It's really great to see this patch series.
> And it should be the correct direction we're heading to upstream busfreq support.
> 
>> This series is sent as RFC mostly because the current support of i.MX SoC won't
>> benefit of busfreq framework, because the clocks' driver don't support
>> interconnect / dram frequency scaling.
>> As exemple, this series implements busfreq for i.MX8MM whose upstreaming
>> is in progress. Because this relies on ATF to do the frequency scaling, it won't
>> be hard make it work.
>>
> 
> How can I test this patch series?
> Any additional patches you can share with us?
> Or what else we need to do to test it? We can help with it.
Many other patches will be required to test the series.
There are a couple of patches that updates i.MX device drivers to 
request for bandwidth (does similar thing as bus_freq_request and 
bus_freq_release).
In addition, a patch to that allow to scale the DRAM
frequency using CCF is required. I'm still working on this patch. It 
works correctly on 4.14, but since I rebased it on linux-next/master, it 
stopped to work. I'm trying to fix it now.
I will share all this patches ASAP.

Best Regards,
Alexandre
> 
> Regards
> Dong Aisheng
> 
>> As exemple, this series implements busfreq for Alexandre Bailon (3):
>>    drivers: interconnect: Add a driver for i.MX SoC
>>    drivers: interconnect: imx: Add support of i.MX8MM
>>    dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
>>
>>   .../bindings/interconnect/imx8mm.txt          |  24 +
>>   drivers/interconnect/Kconfig                  |   1 +
>>   drivers/interconnect/Makefile                 |   1 +
>>   drivers/interconnect/imx/Kconfig              |  17 +
>>   drivers/interconnect/imx/Makefile             |   2 +
>>   drivers/interconnect/imx/busfreq-imx8mm.c     | 132 ++++
>>   drivers/interconnect/imx/busfreq.c            | 570
>> ++++++++++++++++++
>>   drivers/interconnect/imx/busfreq.h            | 123 ++++
>>   include/dt-bindings/interconnect/imx8mm.h     |  37 ++
>>   9 files changed, 907 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/interconnect/imx8mm.txt
>>   create mode 100644 drivers/interconnect/imx/Kconfig  create mode
>> 100644 drivers/interconnect/imx/Makefile  create mode 100644
>> drivers/interconnect/imx/busfreq-imx8mm.c
>>   create mode 100644 drivers/interconnect/imx/busfreq.c
>>   create mode 100644 drivers/interconnect/imx/busfreq.h
>>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>>
>> --
>> 2.19.2

