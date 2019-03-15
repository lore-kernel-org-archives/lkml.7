Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED66218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qttjRic1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfCOQys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:54:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41469 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfCOQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:54:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id p1so10296329wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 09:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pXeZMnL43+Lsa/ffo/nYk6kVF563RsBvvUL09b37Wks=;
        b=qttjRic1kG4VhDMuMfhx7d9HCnBCE6tbysXUuTi8KtZmvM8YF0T9dM3HnTNLf13byR
         o76o6wREjaBZA14OlIZJ+GTWB0dSImWtTIJp9S9D6HnZG+K/n2rQgIqKEMxaMxY6U0if
         CGiGVwR/2tGsiL9IYw2BaGFmE/j9TFKmzVc5e8uZIHpBr8t/GO3flV+QWsDVEfsx7f4t
         ozRN9jwnQvIkgzYDYwLpizwjcU7psVfi5T1s1p/46IJe8GkHkDmi1o5NngXUGLsWFtKN
         C11b9N9Q25e6UZrRJ6ruateBuf4qZGoOvTVeCcVfWZRnTAfAOG+djLBrv8f4SN8gp98+
         U5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pXeZMnL43+Lsa/ffo/nYk6kVF563RsBvvUL09b37Wks=;
        b=IiERokaCtO+PDdLIlCF+dcGd7ClF+F/t4BdBgCHY2fPG6YbRkDgCVJTNZncjjk1hCA
         l9DGCsbIt9gjageKdMSF2vN7ZocoOLkVz2Wm8u554rZPjjGaopUH892FIyCvcLWjYlo7
         e6wtFX6Vat6mG6DADusp5ZbpLi1r7jyrxoRHYBjD5FpRGNb/aNf6CkcemUbW6Wg3FAFk
         moW2VqNZ6hMsCqCx5PNSjzJB99GH+FIBMHoVgoytPbV/H6vFAzpeGuIBIDudcgWBGmqy
         7gtxH/8RvStpoWQeYzci4NaIPljH/BilwY1iDTRN9npdvPSmme+MZoekjaNZK2byVX+p
         0GAQ==
X-Gm-Message-State: APjAAAWy4qV9zdq1lcZZePwqL/5n9/d4b9K6djUn4RckWmr1e+J+HxK4
        /uY9Lw093NAKi3SU1vnXx86dqSe0ja4=
X-Google-Smtp-Source: APXvYqz2oOQj2N11YZUYi7CjBMA19+hdHalS7BvNh7GZIFe3g1N8cBabnQk5dmRRU2zuGQT9EoDCOQ==
X-Received: by 2002:a5d:66c2:: with SMTP id k2mr1678734wrw.312.1552668885066;
        Fri, 15 Mar 2019 09:54:45 -0700 (PDT)
Received: from [10.2.4.163] (aputeaux-684-1-31-143.w90-86.abo.wanadoo.fr. [90.86.86.143])
        by smtp.gmail.com with ESMTPSA id z12sm3632276wmf.31.2019.03.15.09.54.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 09:54:43 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Patrick Titiano <ptitiano@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Emilio Lopez <emilio@elopez.com.ar>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <ccaione@baylibre.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <8af96425-a6f5-0114-7abb-c2a67b952e1b@baylibre.com>
Date:   Fri, 15 Mar 2019 17:55:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAEG3pNA+U1tw4sWq9i2cTni6QKQkLyd3qyZXd2i8M7WFDF4ZsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,
On 3/15/19 5:17 PM, Michael Turquette wrote:
> Hi Alex,
> 
> Some nitpick review comments below.
> 
> On Wed, Mar 13, 2019 at 12:33 PM Alexandre Bailon <abailon@baylibre.com> wrote:
>>
>> This series implements busfreq, a framework used in MXP's
> 
> s/MXP/NXP/
> 
>> tree to scale the interconnect and dram frequencies.
>> In the vendor tree, device's driver request for a
>> performance level, which is used to scale the frequencies.
>> This series implements it using the interconnect framework.
>> Devices' driver request for bandwidth which is use by busfreq
>> to determine a performance level, and then scale the frequency.
>>
>> Busfreq is quite generic. It could be used for any i.MX SoC.
>> A busfreq platform driver just have to define a list of
>> interconnect nodes, and some OPPs.
>>
>> This series is sent as RFC mostly because the current support
>> of i.MX SoC won't benefit of busfreq framework, because the
>> clocks' driver don't support interconnect / dram frequency
>> scaling.
> 
> In your v2 cover letter could you post a link to a git branch that has
> everything integrated that is needed to test the series? I guess this
> is similar to what Aisheng asked for already.
I will do it.
> 
>> As exemple, this series implements busfreq for i.MX8MM whose
>> upstreaming is in progress. Because this relies on ATF to
>> do the frequency scaling, it won't be hard make it work.
> 
> It's not clear to me whether this series actual scales the dram
> frequency based on what you said above. Is it just theoretical or do
> you have it working with a pile of out-of-tree patches? Would be good
> to include that pile of patches in your integration branch that I
> suggested above.
The current series only introduce busfreq generic driver, and the 
busfreq driver for the imx8mm.
As is, the imx8mm driver will just be loaded, but do nothing because
none of the drivers have been updated to request bandwidth using the 
interconnect framework.
In addition, the current clock driver of imx8mm doesn't allow dram 
frequency scaling, so if busfreq driver tries, it will fail (should be 
harmless because any other clocks should restored to their previous rate).

My intent was to sent a first draft o busfreq, to get some feedback, 
before to send a more complete, and fully functional series.

Thanks,
Alexandre
> 
> Thanks,
> Mike
> 
>>
>> As exemple, this series implements busfreq for
>> Alexandre Bailon (3):
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
>>   drivers/interconnect/imx/busfreq.c            | 570 ++++++++++++++++++
>>   drivers/interconnect/imx/busfreq.h            | 123 ++++
>>   include/dt-bindings/interconnect/imx8mm.h     |  37 ++
>>   9 files changed, 907 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interconnect/imx8mm.txt
>>   create mode 100644 drivers/interconnect/imx/Kconfig
>>   create mode 100644 drivers/interconnect/imx/Makefile
>>   create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
>>   create mode 100644 drivers/interconnect/imx/busfreq.c
>>   create mode 100644 drivers/interconnect/imx/busfreq.h
>>   create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>>
>> --
>> 2.19.2
> 
> 
> 

