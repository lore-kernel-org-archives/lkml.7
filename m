Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C638C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE22176D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 14:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omqZoXv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfL0O4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 09:56:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35847 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbfL0O4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 09:56:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so27313051ljg.3;
        Fri, 27 Dec 2019 06:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mMhbjF4sdw6IBruolrJonIGubUPzHHDzsXDjRrBCUCg=;
        b=omqZoXv55HazeHZKqwEAy9vcvFTlhBPYQC6HCSmTNBrPHwNytAtXuF3WcSQtxaa90G
         EvUHS/OlVAaWcpoC8XDllYWQFJ3aZtOzm2hx4Y5lPPQBmP84hUw9PErbwaEDRCmb9tmC
         WYL+v1QUAyBVoR7EeUZt9y/xD1lZ23voUdsIVdw9FjrPpBE3ZArDXEMEl2IRh/KP074R
         Ofltzop5xc/MyKyl/Y/4gdBiRKciO6eN0O+7awKnAfzRlT6IE75dFE9cGAkKx2rgHqIo
         Refr9Atqr8nik2L9BMe7df3hWgicbykPgOK84Bk8ysBkyAPbt3VeK5DHVk/+YSoI4Veb
         w+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mMhbjF4sdw6IBruolrJonIGubUPzHHDzsXDjRrBCUCg=;
        b=JVIZF3JggcnIqWsM+gF30a+253nQ3xyBMOY0tkmGuSDOQnDAG+ipr4lwHVqHprwo70
         sdvCICKAjCQNIRnI8dbrA8fu0H9gheGummn0A7Etk1+Ki9wEpF91hBHg3buejJW5Z7il
         +w1ZRklkMjD/NtgZc2TX5FVUPY6qN+MF5vVtzen1AzuUXtQeR1g+sEkpJo9CanFB/WY/
         vdXFY8VAQAnpRZITjNRus6ePoD2iP6+/ivXocQvhpUoQohOpJaFNUTfzbdANd8Zz78P6
         l+gRCyhfwssMy7AMlxwLe4v9Sv5UArImLt46vbRL2Nq0XIFLhR4xgq/lOXi8fHwAcOqv
         zKMA==
X-Gm-Message-State: APjAAAVWLYjrO6meFAKixx4CAaSVnqjUJFJc81wqTVi3hbEgNRYiUgX+
        b9syUdOatOc2/PJmBkxqGTIPyawk
X-Google-Smtp-Source: APXvYqzmiNjImhddoEpTT+p+zT/wNvABFzH3OInO95NUeTFlRuU4S6budbHKhvPGsFy6LuYL3YEOMw==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr29527366ljo.86.1577458568951;
        Fri, 27 Dec 2019 06:56:08 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w1sm14583714lfe.96.2019.12.27.06.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 06:56:08 -0800 (PST)
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Mark Brown <broonie@kernel.org>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
 <20191225175736.GC27497@sirena.org.uk>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <856d8a92-0c24-6722-952c-06b86c706e97@gmail.com>
Date:   Fri, 27 Dec 2019 17:56:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191225175736.GC27497@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.12.2019 20:57, Mark Brown пишет:
> On Mon, Dec 23, 2019 at 12:14:34AM +0300, Dmitry Osipenko wrote:
>> 21.12.2019 01:26, Sowjanya Komatineni пишет:
>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>> through Tegra210 and currently Tegra clock driver does initial parent
>>> configuration for audio mclk "clk_out_1" and enables them by default.
> 
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

Ok

>>> -	clk_disable_unprepare(data->clk_cdev1);
>>> -	clk_disable_unprepare(data->clk_pll_a_out0);
>>> -	clk_disable_unprepare(data->clk_pll_a);
>>> +	if (__clk_is_enabled(data->clk_cdev1))
>>> +		clk_disable_unprepare(data->clk_cdev1);
> 
>> The root of the problem is that you removed clocks enabling from
>> tegra_asoc_utils_init().
> 
>> I'm not sure why clocks should be disabled during the rate-changing,
>> probably this action is not really needed.
> 
> I know nothing about this particular device but this is not that
> unusual a restriction for audio hardware, you often can't
> robustly reconfigure the clocking for a device while it's active
> due to issues in the hardware.  You often see issues with FIFOs
> glitching or state machines getting stuck.  This may not be an
> issue here but if it's something that's documented as a
> requirement it's probably good to pay attention.

I don't know details about that hardware either, maybe it is simply not
safe to change PLL_A rate dynamically and then CLK_SET_RATE_GATE could
be used.

If nobody knows for sure, then will be better to keep
tegra_asoc_utils_set_rate() unchanged.
