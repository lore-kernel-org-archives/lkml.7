Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29687C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E100D2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaU42Vql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfCXUae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:30:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32990 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfCXUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:30:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so6030952ljc.0;
        Sun, 24 Mar 2019 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuxIPFWyE6vKHz01aXS2PGrmp+xsZqZ4aZTXdnRi6Uk=;
        b=HaU42VqlUOlSwuhvlTXdTLIxnvh0CsNtUP5Nw77sA+Pz9ZDLABbFbi24wlJ1KrjFvz
         uexq6mmWcacHpYyMbP65IBBnc0EBgIK4z1JKVdWFor8y4/zAmF6JGxuE/Z4pZW9luffA
         eouVQftzT0U39iPCiBNyBlgGSIisPfxO1BFyZyRtWSX6VRDdIqs/k+7NAcqGpkbpqbKs
         BK6I8KiMx4/VUS8vAKr8I5q3DiX1EYcD2zNtzpJR/zKBK4XxZZersIaI5CyNRTwUELE6
         u3kZy7f3X/EMYffy51uqOmfvSwCblkRqrtrc0BAK9a7H+SYanSXlL9sdHmM9qSpGUsE0
         SpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuxIPFWyE6vKHz01aXS2PGrmp+xsZqZ4aZTXdnRi6Uk=;
        b=hhFJAmdUBDLlIDR80VptZW+HWroH18BEDhfd34PzLm8FgJVx6IiNfqGTdLrbJrKefc
         uIJsW+FAmAdBp8fk1Ltanh8LcEmUqICvnbGh+spOrHrSSXCz1AxpWzRPBZ1RtD34E8zT
         RJWq/TCgZD05E9bkUuiUTdlNALkKUwgdnmRxRmlJR0Aw88toowKDBxg2xvSMzxegH5a0
         JboCqXKnr+37aD9X4pgRJha0JDlR3sZN09wmfyWtYa/wLQ3wCMbTncQuUV3WXcM9l8jS
         voG1U1XtraxJIn+XEj0jWd9A7nFGZMLfchLolROtDFT62MDJRAEZpdnbrV0AZqCW3eYF
         27/g==
X-Gm-Message-State: APjAAAXS9yOHWxKhGG+Gd8I9YxRuKQs7dSsx+0jtwhL3WOhLtBq3yvPj
        xFyy6Kh/tFq8tud5/hovMLs=
X-Google-Smtp-Source: APXvYqyTsSGl12g7kVwQ79IOlx4bJuNI03+SseUOE8CDJ8voRbffyOzLpqQbLklLey2sfN1e3uYgDg==
X-Received: by 2002:a2e:934a:: with SMTP id m10mr10985041ljh.164.1553459431459;
        Sun, 24 Mar 2019 13:30:31 -0700 (PDT)
Received: from z50.localnet (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id h14sm3029220ljg.10.2019.03.24.13.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 13:30:30 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Sun, 24 Mar 2019 21:30:28 +0100
Message-ID: <3239616.xjhv0hSXo4@z50>
In-Reply-To: <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com> <2631901.52Nzq63B5o@z50> <20190324185932.GA24594@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, March 24, 2019 7:59:32 PM CET Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Mar 24, 2019 at 05:48:22PM +0100, Janusz Krzysztofik wrote:
> > Hi Aaro,
> > 
> > Thanks for your review.
> > 
> > On Wednesday, March 20, 2019 2:16:30 AM CET Aaro Koskinen wrote:
> > > On Tue, Mar 19, 2019 at 11:37:18PM +0100, Janusz Krzysztofik wrote:
> > > > After recent modifications, only a hardcoded partition info makes
> > > > the driver device specific.  Other than that, the driver uses GPIO
> > > > exclusively and can be used on any hardware.
> > > > 
> > > > Drop the partition info and use MTD partition parser with default
> > > > list of partition types instead.
> > > > 
> > > > Amstrad Delta users should append the followig partition info to their
> > >                                         ^^^^^^^^
> > > Should be "following".
> > > 
> > > > kernel command line, possibly by embedding it in CONFIG_CMDLINE:
> > > > mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-
boot_params),\
> > > > 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
> > > > convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that board
> > > > Kconfig automatically if this NAND driver is also selected.
> > > > 
> > > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > > Cc: Tony Lindgren <tony@atomide.com>
> > > 
> > > Could we move the fixed partition setup to the board file
> > > instead? Otherwise this kind of change is not really nice for the users,
> > > as it will likely break existing setups. The default partition layout
> > > should remain the same.
> > 
> > I'm wondering if it would be acceptable to pass partition info from a .dts 
> > file.  I think that would be a better, more modern approach than adding a 
new 
> > header under include/linux/platform_data.
> 
> Hmm, I thought there was some generic way to define partitions without
> adding any new headers. But if that is not possible, then I guess your
> CMDLINE proposal is the preferred one..

I could for example reuse (or abuse) struct gpio_nand_platdata defined in 
include/linux/mtd/nand-gpio.h for use with drivers/mtd/nand/raw/gpio.c, but 
I'm not sure if hi-jacking a header that belongs to another driver would be an 
elegant solution.

Thanks,
Janusz


> 
> A.
> 




