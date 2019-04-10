Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC70C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED4B20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9RNT0R8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfDJF3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:29:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44341 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfDJF3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:29:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so796994pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 22:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiT1nli0EEPkRjkLmrVuD5/q5F8HGDNYQaGn1cIJnZg=;
        b=Y9RNT0R8q4+7K13nGwE1i0K19CeWbTb+0k2tJy+UbmKv6MCGIYGEZCpLko/qb5NNpc
         E0LMqKXAktnbWwp7lmrewnNDAQ7JhItnY5ZIK9n+8bIlSqQpA0A5a7+Bg+sDaPXZzh03
         JVQwMA+PgOHDdtIdHxXLTwiqL/i2B83xf48dXy5tZnxAumjkgUJkBYdODShsvgSHIkma
         ZI0bGu0g6lZ+DWucdDXwiOKeaQDnOYk9ssMKUBj4S8/eiQoZFXsMGKTA+1RwnGgn/gMh
         Vln4tSM+xtrXYZQfd/nZUCiHS/WMfM+U/Gzn9wwi1AkqmACrq0tSUx2RtJSNVhff/uFw
         HWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiT1nli0EEPkRjkLmrVuD5/q5F8HGDNYQaGn1cIJnZg=;
        b=VmgnkFEOYnIOJTE5VkuHaaQBQfBxZoqfdjMGEeXyUPMPng3y9IeEQhoZ1PjQco91/K
         45CEMKWU6jxTKrkqO8B19Pc6qr58sAEvEGb7+9Pbvm9syizGzbq90EHAq1erytXKKqXf
         FQN1YNgB5w2W6pU0Yxm9k68aeHh/zxffg7qGT6SPD3tMdTxdjBLvJEpEgb3wmpRflhKK
         6JrN04Y76zaS7fXC1XQTHHG0WJbyYwnEnFN1k5BYATbQlNvu8Ri/yJ2TDJsFHUiq47os
         dQHDKAiUS/gSAfCPwNJAZY4ZjbLedZibd9oHck/eMrAt3Kt/5VM5HkcCebv4gtNG57iU
         n1Uw==
X-Gm-Message-State: APjAAAV9jZ/5gPj1TwjaGBEqU2KBQ42q8SlB5fIX3NPbsFnmuyrQGw3n
        mxt5RG6zw6eSHJM8vWwAM9jtrw==
X-Google-Smtp-Source: APXvYqxT504WyIg4m9hiA+vbIogotuilOk+WK3T4b9anX/SLmBa3bwEsAqVn81a2dJrbbifh7vpU4A==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr41802992pfb.150.1554874159726;
        Tue, 09 Apr 2019 22:29:19 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id g73sm62433138pfd.185.2019.04.09.22.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 22:29:18 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:59:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "ptitiano@baylibre.com" <ptitiano@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/3] Add support of busfreq
Message-ID: <20190410052915.jrb67qmpwnmy4ird@vireshk-i7>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <56e96a3a-4901-c79c-e91d-6b6a0690e5b7@baylibre.com>
 <VI1PR04MB55334013173D78F365CA5E19EE440@VI1PR04MB5533.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB55334013173D78F365CA5E19EE440@VI1PR04MB5533.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-03-19, 17:17, Leonard Crestez wrote:
> On 3/15/19 11:31 AM, Alexandre Bailon wrote:
> >>> This series is sent as RFC mostly because the current support of i.MX SoC won't
> >>> benefit of busfreq framework, because the clocks' driver don't support
> >>> interconnect / dram frequency scaling.
> >>> As exemple, this series implements busfreq for i.MX8MM whose upstreaming
> >>> is in progress. Because this relies on ATF to do the frequency scaling, it won't
> >>> be hard make it work.
> 
> >> How can I test this patch series?
> >> Any additional patches you can share with us?
> >> Or what else we need to do to test it? We can help with it.
> 
> > Many other patches will be required to test the series.
> > There are a couple of patches that updates i.MX device drivers to
> > request for bandwidth (does similar thing as bus_freq_request and
> > bus_freq_release).
> 
> The interconnect framework asks for bandwidth in bytes/second but in NXP 
> tree most requests are of the form "request_bus_freq(BUS_FREQ_HIGH);". 
> In many cases (ethernet) it doesn't seem you can calculate a specific 
> bandwidth usefully.
> 
> Instead of asking for "infinite bandwidth zero latency" to force 
> everything to "high" it would be nicer to "request an opp".
> 
> Power-domain bindings mentioned that consumer-devices can specify a 
> "required-opps" property but I've found zero users in tree. Maybe some 
> helpers could be written to parse that property and automatically 
> request ICC opp on device suspend/resume via device-links?

Documentation/devicetree/bindings/power/qcom,rpmpd.txt is using it currently in
mainline.

> I know that stuff was written for genpd but it looks like a very good 
> fit to me.

Yes, the very first user is genpd but we have designed it with an open mind and
so it shouldn't be difficult to make use of it at other places.

There is some WIP which you can look at :

- Introduce OPP bandwidth bindings
  lore.kernel.org/lkml/20190313090010.20534-1-georgi.djakov@linaro.org

- DVFS in the OPP core
  https://lore.kernel.org/lkml/20190320094918.20234-1-rnayak@codeaurora.org

-- 
viresh
