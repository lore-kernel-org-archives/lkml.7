Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751AC2D0D3
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0AC2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576786060;
	bh=pSXRgiNj+8+4TVlNY9cNujz3BsgiGPqNaak59V6mcRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HmUr/OvXVjwpgXj9sOcP4vzk2MOAUTOrttlAKPOIsRxhZSXscHMThVxfiyu4lALSZ
	 XcoUUM0836m2bPObJXewYPj/STbIhkQx/XdaMyt5zAs9tJvhLmAETN+qGsI0UA0mfu
	 mN+iQbjVRT2DYo+ju7ZZNGVf/HW7NNQZyVl3W6YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfLSUHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:07:35 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42581 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfLSUHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:07:31 -0500
Received: by mail-yw1-f68.google.com with SMTP id x138so2647906ywd.9;
        Thu, 19 Dec 2019 12:07:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYs9YV+R6ZChQu7K5kraIQcgs+ufLWziDdpBF76nsa8=;
        b=LQOxIb2Fjrtoo7RWCQfjlAsPRuEiCIC+VYucUtWXV9VwrCKRV99OnVMpaCu9LZreQY
         /e+zEPEWKveUlgBGkrGo/eGeoWV/V0KBtdkqPfmdkqbjUix2ofVF/kmq+cMKr8uRssNu
         8b88h1kwaIBhNYykR2IeuD3bjzotCOgU4oBBBCVk3zwOnMu5WQ4z7Tap2lC6b/gxOxi+
         GGuxP4QUx04xVFLOnTUMC08di2N0kDFPt77GJL/Fnf/BaQT1APtTEAdSg5AMZe+HDiEe
         UMKu/ClvP+c/IbXdBx7SVQl/sh1QwxXtaf2Rft0BLRYT5jkTylWm8ilA0Qai9l1T1a1n
         e8gA==
X-Gm-Message-State: APjAAAWENh6CVkpbGzMShPBV2M14NqOmrj2Pgvp58uEvWgqcxXdoAubM
        y5M4POdHinskiQJDDRC7lA==
X-Google-Smtp-Source: APXvYqwJjv7J5Gr8OJGkc6rGWBTU0vrDBs3+PxtxHOMedvJ+yysUWFZ4i5JnjUAZYg5iPrMMOMquow==
X-Received: by 2002:a81:3208:: with SMTP id y8mr2497299ywy.231.1576786049885;
        Thu, 19 Dec 2019 12:07:29 -0800 (PST)
Received: from localhost ([172.58.139.89])
        by smtp.gmail.com with ESMTPSA id d199sm2988688ywh.83.2019.12.19.12.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:07:29 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:07:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org, Dinh Nguyen <dinguyen@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: denali: add reset controlling
Message-ID: <20191219200154.GA27949@bogus>
References: <20191210091453.26346-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210091453.26346-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 18:14:53 +0900, Masahiro Yamada wrote:
> According to the Denali User's Guide, this IP has two reset signals.
> 
>   rst_n:     reset most of FFs in the controller core
>   reg_rst_n: reset all FFs in the register interface, and in the
>              initialization sequence
> 
> This commit supports controlling those reset signals, although they
> might be often tied up together in actual SoC integration.
> 
> One thing that should be kept in mind is the automated initialization
> sequence (a.k.a. 'bootstrap' process) is kicked off when reg_rst_n is
> deasserted.
> 
> When the reset is deasserted, the controller issues a RESET command
> to the chip select 0, and attempts to read out the chip ID, and further
> more, ONFI parameters if it is an ONFI-compliant device. Then, the
> controller sets up the relevant registers based on the detected
> device parameters.
> 
> This process is just redundant for Linux because nand_scan_ident()
> probes devices and sets up parameters accordingly. Rather, this hardware
> feature is annoying because it ends up with misdetection due to bugs.
> 
> So, commit 0615e7ad5d52 ("mtd: nand: denali: remove Toshiba and Hynix
> specific fixup code") changed the driver to not rely on it.
> 
> However, there is no way to prevent it from running. The IP provides
> the 'bootstrap_inhibit_init' port to suppress this sequence, but it is
> usually out of software control, and dependent on SoC implementation.
> As for the Socionext UniPhier platform, LD4 always enables it. For the
> later SoCs, the bootstrap sequence runs depending on the boot mode.
> 
> I added usleep_range() to make the driver wait until the sequence
> finishes. Otherwise, the driver would fail to detect the chip due
> to the race between the driver and hardware-controlled sequence.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/mtd/denali-nand.txt   |  7 ++++
>  drivers/mtd/nand/raw/denali_dt.c              | 40 ++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
