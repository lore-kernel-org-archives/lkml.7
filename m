Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE17C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 15:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D412467E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9ArH6XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLGPry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 10:47:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45437 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfLGPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 10:47:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id d20so10836429ljc.12;
        Sat, 07 Dec 2019 07:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cgXqxnQNU1KfFpmIH+l98eU9BRN3KG1bcuyxtlJ2Sto=;
        b=G9ArH6XS3kkAJ444AD/6nMO2JlGQXBaRpaNbcSJTkxT8qruObCDonZqvDrTWcYsFUz
         f+tdjKmVMMiOxPZp3Fonwg5u4+K+JVaCdoziAsTORCqTB7Tf3UXtbt1ehWRz1b06ZOAi
         RzKY4sB1gJjOPcu4YZ5wdy1UaikSzskUWkY3TLwLQNQIH+38s48XKCYY0AI0NZgnVQyN
         lcQ+Mh9ebt+uiKRj4EJVfYKBHR87d8HKum7xBcNzrzbM0+Mp1vUmCgfgyk3gNjxQjsgX
         j2ExgRNvdq4WdH3bQL7LyMQlU9yw9AVLBTBaBgM7gvBmDXTzsSW47Kr3VDm553ySyBJJ
         RVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cgXqxnQNU1KfFpmIH+l98eU9BRN3KG1bcuyxtlJ2Sto=;
        b=pHIYUUtFP5o80vGwW2PfFDB2juQ28QkGl/Hn6Bsqu4AY6GgXi4vx1NFztEB/tUnKxV
         Bv/pJCuf830/iKc3VEnfilIEz8BIRUdexUoP4XTrpx03mFE6WpVavuob1j+LW3st1Cpg
         IoA+OLelnMzgrLELw2Pu49W2cnTHsZ+En00yHgFfx2Emw/L654kHI44Fvhu/b0oYURp/
         4SuHn7EmkbXoMyyknX38NgPP10Mq54ZIABJ4u9AQ9VzXRFIolGVkPZHC49bBgqk6NqaB
         on/XaAzsp0xS7E9qbpspQp7LYnPrwTeo7tI6ugNmTOWMFBGpGwWFgQVSEjbZZ/kBUiau
         iolQ==
X-Gm-Message-State: APjAAAVKQW73vMm7IWY5FkgChAgPXqt9tjBj4hUgIiA4978VfJ47cMSF
        Suvgqv7WR87Coc338gSoDRs=
X-Google-Smtp-Source: APXvYqzuRtjp1TNY2b/7foipfb48ltiMBODXYMY3RNu5TTuhDLO59LuRTWCEhwpkpHeb5auvUtSZgw==
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr9513889ljg.82.1575733671384;
        Sat, 07 Dec 2019 07:47:51 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id a27sm8159790lfo.38.2019.12.07.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 07:47:50 -0800 (PST)
Subject: Re: [PATCH v3 03/15] soc: tegra: Add Tegra PMC clock registrations
 into PMC driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-4-git-send-email-skomatineni@nvidia.com>
 <7cf4ff77-2f33-4ee5-0e09-5aa6aef3e8be@gmail.com>
Message-ID: <ad3a6743-4b36-fa25-9cc7-72803038ecc5@gmail.com>
Date:   Sat, 7 Dec 2019 18:47:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <7cf4ff77-2f33-4ee5-0e09-5aa6aef3e8be@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2019 17:28, Dmitry Osipenko пишет:
> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>> Tegra210 and prior Tegra PMC has clk_out_1, clk_out_2, clk_out_3 with
>> mux and gate for each of these clocks.
>>
>> Currently these PMC clocks are registered by Tegra clock driver using
>> clk_register_mux and clk_register_gate by passing PMC base address
>> and register offsets and PMC programming for these clocks happens
>> through direct PMC access by the clock driver.
>>
>> With this, when PMC is in secure mode any direct PMC access from the
>> non-secure world does not go through and these clocks will not be
>> functional.
>>
>> This patch adds these clocks registration with PMC as a clock provider
>> for these clocks. clk_ops callback implementations for these clocks
>> uses tegra_pmc_readl and tegra_pmc_writel which supports PMC programming
>> in secure mode and non-secure mode.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---

[snip]

>> +
>> +static const struct clk_ops pmc_clk_gate_ops = {
>> +	.is_enabled = pmc_clk_is_enabled,
>> +	.enable = pmc_clk_enable,
>> +	.disable = pmc_clk_disable,
>> +};
> 
> What's the benefit of separating GATE from the MUX?
> 
> I think it could be a single clock.

According to TRM:

1. GATE and MUX are separate entities.

2. GATE is the parent of MUX (see PMC's CLK_OUT paths diagram in TRM).

3. PMC doesn't gate EXTPERIPH clock but could "force-enable" it, correct?

[snip]
