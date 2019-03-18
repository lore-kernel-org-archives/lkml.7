Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D8220854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDBMklCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCRMVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:21:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37234 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfCRMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:21:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15so16794130wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9/cen8CVbo+znHQQsAo4qiCUTF1XfHWG/NaxmxJ1qA=;
        b=wDBMklCl7RpOVCjc4ngbvw0XsaKizFRJBjb5z0hbRirLt9fxoDM5jEEnJ+wwyaitGb
         mJbswo+LQ2PRFIeofidt7OddFbSXT25jMMgnPgElUe9B8LU9EDVxaXn5e9sAgd0e7htC
         9EpL5T7QrfepvX08Ha5yWSdw3BmGhI6vagX8qufmj1mw5z3XJ6kJ9I+JX2rEVahNF9NJ
         GpANQ9jZ9KxCODkGvcc6CahonZzfmDJ8jLIfpunY1xsPPSh+u692389SMAmMZJixBdlt
         NQ8Jp0iw+lCmFQaQjjxJdf1Xr9/HBXVhtC9C4GxD90CEbmU+Q+Dny8vTBG8SDY0V/3jO
         W3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9/cen8CVbo+znHQQsAo4qiCUTF1XfHWG/NaxmxJ1qA=;
        b=iSDBnBwQnb927zTIqKoXxiT2t6dZ4sY9MXB073BkDQe7YTTnBSEFS+Xi8cc69FtSHR
         ewVEVUce7ZJMy7G/ZjjqtT4t1YgymmI8F4E5e+UGxK+UkS965z3IN05+L2XrmymkHiYo
         sVxJUTHdXI6je9g0Hc7nuxqQiifqMi+CNr+/7OI71aAsImdMAAwQu4zfaXzGESxQFSp9
         vrccD44zVrQ1bfcH05tzng/L2gSARjHjwvcdYBoTugGTGOS1x96Jxb0OwmBuBQR4ICh1
         CZwdhmSLZmlGDYRomKx5LtIjGcL0xEwi/5Fbh9U95i03A/YF3UId6KXKAtae5MUDx/Gg
         SfmA==
X-Gm-Message-State: APjAAAX1nRlyZmLmYa5j4HGDUUgTN9SOZLUHn3fnRN3qr7ZbrcnqllDb
        t+t4msJcWjquusSjuBKUEwdyog==
X-Google-Smtp-Source: APXvYqzpKQOS80Qxf1vky/6E7HcreVeX3wYaRUt2pyU2wLKMDXuf64WO0snBlm7gZFseK74TPVB2gg==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr5405071wrv.296.1552911677983;
        Mon, 18 Mar 2019 05:21:17 -0700 (PDT)
Received: from apalos (ppp-94-64-206-130.home.otenet.gr. [94.64.206.130])
        by smtp.gmail.com with ESMTPSA id y7sm15413322wmi.34.2019.03.18.05.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:21:17 -0700 (PDT)
Date:   Mon, 18 Mar 2019 14:21:13 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Christian Neubert <christian.neubert.86@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for
 cpu clocks
Message-ID: <20190318122113.GA4834@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com>
 <20190314121541.GB19385@apalos>
 <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com>
 <20190314134428.GA24768@apalos>
 <874l85v8p6.fsf@FE-laptop>
 <20190318112844.GA1708@apalos>
 <87h8c0s955.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8c0s955.fsf@FE-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory, 

> >> 
> > [   14.909524] clk_pm_cpu_set_parent old=28004840 -> val=0x6000000 load_level=0
> > [   14.916424] clk_pm_cpu_set_parent old=2E004840 -> val=0x600 load_level=1
> > [   14.923315] clk_pm_cpu_set_parent old=8880A8C0 -> val=0x6000000 load_level=2
> > [   14.930572] clk_pm_cpu_set_parent old=8E80A8C0 -> val=0x600 load_level=3
> >
> >
> > Let me know if you need anything else
> 
> Could you show me the output of "cat /sys/kernel/debug/clk/clk_summary"
> 
root@localhost ~ # cat /sys/kernel/debug/clk/clk_summary
                                 enable  prepare  protect                                duty
   clock                          count    count    count        rate   accuracy phase  cycle
---------------------------------------------------------------------------------------------
 xtal                                 2        3        0    25000000          0     0  50000
    i2c_1                             0        0        0    25000000          0     0  50000
    i2c_2                             0        0        0    25000000          0     0  50000
    avs                               0        0        0    25000000          0     0  50000
    TBG-B-S                           2        2        0  1000000000          0     0  50000
       cpu                            0        0        0   200000000          0     0  50000
       usb32_ss_sys                   1        1        0   125000000          0     0  50000
       usb32_usb2_sys                 0        0        0   100000000          0     0  50000
       gbe_125                        0        0        0   125000000          0     0  50000
          gbe0_125                    0        0        0   125000000          0     0  50000
          gbe1_125                    0        0        0   125000000          0     0  50000
       gbe_core                       1        1        0   250000000          0     0  50000
          gbe_bm                      0        0        0   250000000          0     0  50000
          gbe0_core                   1        1        0   250000000          0     0  50000
          gbe1_core                   0        0        0   250000000          0     0  50000
       eip97                          0        0        0   500000000          0     0  50000
       trace                          0        0        0  1000000000          0     0  50000
       ddr_fclk                       0        0        0   125000000          0     0  50000
       pwm                            0        0        0    50000000          0     0  50000
       tscem_tmx                      0        0        0  1000000000          0     0  50000
       sec_dap                        0        0        0   100000000          0     0  50000
       sec_at                         0        0        0   200000000          0     0  50000
    TBG-A-S                           0        0        0  1600000000          0     0  50000
       sdio                           0        0        0   400000000          0     0  50000
       ddr_phy                        0        0        0   400000000          0     0  50000
       mmc                            0        0        0   400000000          0     0  50000
    TBG-B-P                           0        0        0   500000000          0     0  50000
       gbe_50                         0        0        0    50000000          0     0  50000
          gbe0_50                     0        0        0    50000000          0     0  50000
          gbe1_50                     0        0        0    50000000          0     0  50000
    TBG-A-P                           0        1        0   800000000          0     0  50000
       counter                        0        0        0   160000000          0     0  50000
       sqf                            0        1        0   200000000          0     0  50000
       tscem                          0        0        0   200000000          0     0  50000
       sata_host                      0        0        0   200000000          0     0  50000
root@localhost ~ # 

> Also, during this week-end, Christian suggested that the issue might
> come from the AVS support.
> 
> Could you disable it and check you still have the issue?
> 
> For this, you just have to remove the avs node in
> arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.
Sure. You'll have to wait for a week though. Currently on a trip. I'll run that
 once i return


Cheers
/Ilias
