Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAEEC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30364218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVoE2GyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfDXJaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:30:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36372 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDXJaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:30:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so9012259plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jS8sA5wVvAstEMBPfxsjXr3lvFTcs0TzZqWL7gM79Nw=;
        b=bVoE2GyTwPZO7/bsB1UtAykhVesT02vmZE7yOcPQYEvY2yKhHMsjFiKyA5CABbiYkH
         3s6swu7SZSM8VrzmdeMqXYi+6MwxdyIF2b53WHv7/5oZg3XibbxWZkr2tznB3EI4nP9t
         7JYAQnBNdZBDJV/IhJ+KpevyqetCOUyrurL3tXgh8pi7uJ7SeUrqvVDHAtxA3D49UmA/
         ofd6csttFFZDzTLrcYQn+QAtvJ5uSuhczjxgN4YMIoG+VTTQQFPmXJ1isDlflWK6gAU2
         hRaTUXak13JtonP4AH0vR1DOoWi5yCk0PTCuS2EWspp9Ugn9NTJZS7qAXtc8LrQ2EfX4
         xJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jS8sA5wVvAstEMBPfxsjXr3lvFTcs0TzZqWL7gM79Nw=;
        b=tIVpfVqaC8hBZP12Fil9iOknWtwC4aUFkDhwpnTtRQO7ewkY90wzoh+K8/lMY5FwRX
         W9i4ZKvrMSXk3wVPp+lN6Q0oeqhp4HKsZJjadsA0wc8+upOjZjjpgJuoLw4eg1N659zQ
         zGSJJNgGjGvBUzzRXHIfST8FbmvyaOarjM5arYgDIpyLXDO28b52cKaXcbOkqUMXEKVT
         LeGm2CpN51G2j7HvVGDSktCutiP4UzdcH8Iremqaq4Zd+O7VTkkIhw1H1dCnfIh7D3Kj
         xQQAtmb80BDRsMeXEtg8rOY+mo4wgE52NMhExXuIuktVfwYkqc4NUyo4SgmoUbtznUT+
         H2Cg==
X-Gm-Message-State: APjAAAXZddUpOwJ6RjItl4zD/k2c51bchTN2WXDfVtkF+AEEvDaGPzfl
        ip6ARhJ/TTDI8aHyEc7CfkFwOw==
X-Google-Smtp-Source: APXvYqyvJbo01zmJtkIrttWV5J+5l51q8sH4KWYsVBjaJbuocJCDqsEwJfUW759839TNhvJEt02FQw==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1mr30844272plb.221.1556098218762;
        Wed, 24 Apr 2019 02:30:18 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id j12sm22427245pgg.79.2019.04.24.02.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 02:30:17 -0700 (PDT)
Date:   Wed, 24 Apr 2019 15:00:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Christian Neubert <christian.neubert.86@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190424093015.rcr5auamfccxf6ei@vireshk-i7>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
 <20190318112844.GA1708@apalos>
 <87h8c0s955.fsf@FE-laptop>
 <20190318122113.GA4834@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318122113.GA4834@apalos>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-03-19, 14:21, Ilias Apalodimas wrote:
> Hi Gregory, 
> 
> > >> 
> > > [   14.909524] clk_pm_cpu_set_parent old=28004840 -> val=0x6000000 load_level=0
> > > [   14.916424] clk_pm_cpu_set_parent old=2E004840 -> val=0x600 load_level=1
> > > [   14.923315] clk_pm_cpu_set_parent old=8880A8C0 -> val=0x6000000 load_level=2
> > > [   14.930572] clk_pm_cpu_set_parent old=8E80A8C0 -> val=0x600 load_level=3
> > >
> > >
> > > Let me know if you need anything else
> > 
> > Could you show me the output of "cat /sys/kernel/debug/clk/clk_summary"
> > 
> root@localhost ~ # cat /sys/kernel/debug/clk/clk_summary
>                                  enable  prepare  protect                                duty
>    clock                          count    count    count        rate   accuracy phase  cycle
> ---------------------------------------------------------------------------------------------
>  xtal                                 2        3        0    25000000          0     0  50000
>     i2c_1                             0        0        0    25000000          0     0  50000
>     i2c_2                             0        0        0    25000000          0     0  50000
>     avs                               0        0        0    25000000          0     0  50000
>     TBG-B-S                           2        2        0  1000000000          0     0  50000
>        cpu                            0        0        0   200000000          0     0  50000
>        usb32_ss_sys                   1        1        0   125000000          0     0  50000
>        usb32_usb2_sys                 0        0        0   100000000          0     0  50000
>        gbe_125                        0        0        0   125000000          0     0  50000
>           gbe0_125                    0        0        0   125000000          0     0  50000
>           gbe1_125                    0        0        0   125000000          0     0  50000
>        gbe_core                       1        1        0   250000000          0     0  50000
>           gbe_bm                      0        0        0   250000000          0     0  50000
>           gbe0_core                   1        1        0   250000000          0     0  50000
>           gbe1_core                   0        0        0   250000000          0     0  50000
>        eip97                          0        0        0   500000000          0     0  50000
>        trace                          0        0        0  1000000000          0     0  50000
>        ddr_fclk                       0        0        0   125000000          0     0  50000
>        pwm                            0        0        0    50000000          0     0  50000
>        tscem_tmx                      0        0        0  1000000000          0     0  50000
>        sec_dap                        0        0        0   100000000          0     0  50000
>        sec_at                         0        0        0   200000000          0     0  50000
>     TBG-A-S                           0        0        0  1600000000          0     0  50000
>        sdio                           0        0        0   400000000          0     0  50000
>        ddr_phy                        0        0        0   400000000          0     0  50000
>        mmc                            0        0        0   400000000          0     0  50000
>     TBG-B-P                           0        0        0   500000000          0     0  50000
>        gbe_50                         0        0        0    50000000          0     0  50000
>           gbe0_50                     0        0        0    50000000          0     0  50000
>           gbe1_50                     0        0        0    50000000          0     0  50000
>     TBG-A-P                           0        1        0   800000000          0     0  50000
>        counter                        0        0        0   160000000          0     0  50000
>        sqf                            0        1        0   200000000          0     0  50000
>        tscem                          0        0        0   200000000          0     0  50000
>        sata_host                      0        0        0   200000000          0     0  50000
> root@localhost ~ # 
> 
> > Also, during this week-end, Christian suggested that the issue might
> > come from the AVS support.
> > 
> > Could you disable it and check you still have the issue?
> > 
> > For this, you just have to remove the avs node in
> > arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.
> Sure. You'll have to wait for a week though. Currently on a trip. I'll run that
>  once i return

@Ilias: Can you please try this now and confirm to Gregory ?

-- 
viresh
