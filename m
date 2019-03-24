Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C52C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9623F20989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPT/L0tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfCXUkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:40:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40998 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:40:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id 10so4573743lfr.8;
        Sun, 24 Mar 2019 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zag3mS16/ocWpIVeVVV7YLnfoYtX1qKbn1MjQNJ0iGE=;
        b=gPT/L0tzX/vifYTUsA5MPNJD/Y4KG7q8tZijBuFJQfi0Jv6xIteIvXtfthZCZSMIl5
         y4wtmNQFyF72Jm6UKocE1/54kP+th90xkaqZ8rOCT4soTummmQ6LqAIplPZHHg/e9AHN
         2eyKwF96i1qRT5mu2Rssz12t3GDtJaxe2cEIiHJBL3zEw8TScVUdOrct2uFAZ4sV9rK8
         ZTM057pchI9qokWhXYE1ikb1phfVo771mINfdiav4cAV+egPuXZdazb8CGLnn9Tt3N4e
         5l2mLNTxqo80q4OKOuOSKwI4+pvj6vNY1GTqmd88fb298iGciwiPCv3bqaI4VkpNuEyk
         tAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zag3mS16/ocWpIVeVVV7YLnfoYtX1qKbn1MjQNJ0iGE=;
        b=jeqF/6cj7cqGV4sLwyRFGluknd4YBEB5sTAackctP1lXHwBgXgBm7LSYZdNppDQ5Nz
         wH6xPUNkFmKxNUNddBJhE7FNoSeXcqD3H6ohtWX+asUdShbYHsMGfY4HqJdD8VYw9x67
         71BjwRxg9CMJpYgdkLK1iQm7Y4VEQ0Uy1n0qoZWipL1Na6tP66kOxzTFOIyf9IpGUJgm
         cXtG6UQcQA/KiT2LVn8+td6Rynjy5NQvV8p140rvJZE1cwTxvEgnXpVCoXWbNaebqfIZ
         yvubd/qsWYuoEV8kMBwSPlOReixhuiTgciYz0csQunsf+tBMyNlT7ErBRbnaPcLQc9yi
         AWPA==
X-Gm-Message-State: APjAAAX6a39TYqLr63p6s5QKr3rC9fNj/fbVg6F5Hpngiclaj5f4hRXr
        yDPUeTA0kNB3gLifS3dm7Go=
X-Google-Smtp-Source: APXvYqxTsAbZitRwsCnlTyDIDMZNbwyT8GykkG8UMah4iOV1rdBf54Ehs7lMSr967Bp/Jh6M3wAdzw==
X-Received: by 2002:ac2:5921:: with SMTP id v1mr10775321lfi.135.1553460037040;
        Sun, 24 Mar 2019 13:40:37 -0700 (PDT)
Received: from z50.localnet (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id 77sm1079933ljc.69.2019.03.24.13.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 13:40:36 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-mtd@lists.infradead.org,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Sun, 24 Mar 2019 21:40:34 +0100
Message-ID: <1944041.gYv7fxL5Uc@z50>
In-Reply-To: <454BF5C9-478A-4E2A-BF00-D2A2AFE25C45@goldelico.com>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <20190324185932.GA24594@darkstar.musicnaut.iki.fi> <454BF5C9-478A-4E2A-BF00-D2A2AFE25C45@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, March 24, 2019 8:24:48 PM CET H. Nikolaus Schaller wrote:
> Hi,
> 
> > Am 24.03.2019 um 19:59 schrieb Aaro Koskinen <aaro.koskinen@iki.fi>:
> > 
> > Hi,
> > 
> > On Sun, Mar 24, 2019 at 05:48:22PM +0100, Janusz Krzysztofik wrote:
> >> Hi Aaro,
> >> 
> >> Thanks for your review.
> >> 
> >> On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
> >>> On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
> >>>> After recent modifications, only a hardcoded partition info makes
> >>>> the driver device specific.  Other than that, the driver uses GPIO
> >>>> exclusively and can be used on any hardware.
> >>>> 
> >>>> Drop the partition info and use MTD partition parser with default
> >>>> list of partition types instead.
> >>>> 
> >>>> Amstrad Delta users should append the followig partition info to their
> >>>                                        ^^^^^^^^
> >>> Should be "following".
> >>> 
> >>>> kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> >>>> mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),
\
> >>>> 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
> >>>> convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that board
> >>>> Kconfig automatically if this NAND driver is also selected.
> >>>> 
> >>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> >>>> Cc: Tony Lindgren <tony@atomide.com>
> >>> 
> >>> Could we move the fixed partition setup to the board file
> >>> instead? Otherwise this kind of change is not really nice for the users,
> >>> as it will likely break existing setups. The default partition layout
> >>> should remain the same.
> >> 
> >> I'm wondering if it would be acceptable to pass partition info from a 
.dts 
> >> file.  I think that would be a better, more modern approach than adding a 
new 
> >> header under include/linux/platform_data.
> > 
> > Hmm, I thought there was some generic way to define partitions without
> > adding any new headers. But if that is not possible, then I guess your
> > CMDLINE proposal is the preferred one..
> 
> I am not sure what you exactly need, but partitions can be defined in
> the DTS as children of some NAND drivers. Example:
> arch/arm/boot/dts/omap3-beagle.dts
> So this design pattern could be copied instead of using CMDLINE.

The problem is, OMAP1 has no device tree support.  Other than that, your 
proposed approach already works for me locally with some basic support for 
device tree added to the board file.

Thanks,
Janusz



