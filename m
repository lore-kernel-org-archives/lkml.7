Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D2D20848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g3nxTJSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfCYV0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:26:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34900 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfCYV0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:26:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so7056765pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=F6eHozPPrDy+9MhKhEeFODU05GUZcOzCOEIshvHqp0U=;
        b=g3nxTJSLig5h9ol2DHrHg/hiRutXrDsxPj0FFoQ2rPTnEtKBxSQhA5zZ4lxGviRD45
         QGWi/QmuAS6ItBsb7WeYLP3SjkHrJ9LhV1xh8RUdxpAmtWAqXZ8Tue1vPoNVmATbdgjm
         jQ+Mvms/roeekMt4OQb2G3OCxIUri44wMmOCj8cF+lVkXG8K3TYTOdyNqe3q9XLvkyH7
         +Af4zdKLTJU8NHYxDphrnkCcJNx4W3HRlI2uo9jGj1FXk3FLGr1VQjw03vDkslFffv9D
         Hf34K3REDNym5BTw2sw5AIE7eM0aDuUeFbfZuFFpvkJshPh5XylJXbx6IpYjjiNnBSA/
         jAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=F6eHozPPrDy+9MhKhEeFODU05GUZcOzCOEIshvHqp0U=;
        b=XhYOVgVwwEsNWjeCxWY3fZzrdBpjUHadrcwH1fs7h5O2OWoO38vrLtdNEFuuwjIWAJ
         JIYSqTZ57B4MS+VAKdDYPOa/98R+8ah7TdWwh9kEIYocW70iPekaiJGphhos2yulcmpe
         ctz7ELDXb0q+uMkxbTfbLDQrLT+bARDi5oZwQbZtfpWkKa3G5vrKM87n5Sg59WJAcM21
         MXx+60rlGO7ruUq0E1DVgYuZM9QtWSrMOelM4LHfhYZfQQHA8nyeSvOFMhtsBunp11WV
         OJT8uXrefUz1EhONHe0lhDCkpeFgOa90ZWHpU800MR5npSqilpY48eqJQBhUvS7/hsbb
         fpkA==
X-Gm-Message-State: APjAAAU6Ww8vAHX3R91u81dy+ZPNDmrIQTGZlsYGlDJQgXFhVnNmf6PD
        koyowfLr3njD5VBFBn4hCtztVw==
X-Google-Smtp-Source: APXvYqz/ru3+hE2pBm6MANXiSA8+rV1nwi78KDf5w6HoOuJ3zwb8ayLpOBXy4XAugDeOr5cb7id9pg==
X-Received: by 2002:a63:4750:: with SMTP id w16mr25932558pgk.256.1553549213939;
        Mon, 25 Mar 2019 14:26:53 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a3sm7591304pfn.182.2019.03.25.14.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 14:26:52 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:26:52 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Borislav Petkov <bp@alien8.de>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        palmer@sifive.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, aou@eecs.berkeley.edu,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH 2/2] edac: sifive: Add EDAC driver for SiFive FU540-C000
 chip
In-Reply-To: <20190325065737.GD12016@zn.tnic>
Message-ID: <alpine.DEB.2.21.9999.1903251418440.8028@viisi.sifive.com>
References: <1553082728-9232-1-git-send-email-yash.shah@sifive.com> <1553082728-9232-3-git-send-email-yash.shah@sifive.com> <alpine.DEB.2.21.9999.1903241558210.8028@viisi.sifive.com> <20190325065737.GD12016@zn.tnic>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Borislav Petkov wrote:

> On Sun, Mar 24, 2019 at 05:23:27PM -0700, Paul Walmsley wrote:
> > > +	if (!IS_ENABLED(CONFIG_EDAC_DEBUG))
> > > +		return;
> > 
> > Can all of these debugfs functions be wrapped with an #if ... #endif such 
> > that, if CONFIG_EDAC_DEBUG is not set, they will all be stripped out by 
> > the preprocessor?
> 
> Why would you make the code more ugly with ifdeffery?
> 
> Do you have any serious code size constraints so that you absolutely
> need to remove a couple of KBs?

We'll definitely take the RAM savings that a few #ifdefs will deliver to 
us.  They add up.  We're selling chips for embedded use cases, not just 
big-iron x86 systems.

Other EDAC drivers have far more #ifdef lines than the single set that I'm 
proposing, so I don't understand why you're singling this driver out for 
criticism.  Consider:

./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_SDRAM
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_L2C
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_OCRAM
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_OCRAM
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_L2C
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_ETHERNET
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_NAND
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_DMA
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_USB
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_QSPI
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_SDMMC
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_L2C
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_OCRAM
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_ETHERNET
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_NAND
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_DMA
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_USB
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_QSPI
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_SDMMC
./altera_edac.c:#ifdef CONFIG_EDAC_ALTERA_SDRAM
./synopsys_edac.c:#ifdef CONFIG_EDAC_DEBUG
./synopsys_edac.c:#ifdef CONFIG_EDAC_DEBUG
./synopsys_edac.c:#ifdef CONFIG_EDAC_DEBUG
./synopsys_edac.c:#ifdef CONFIG_EDAC_DEBUG
./synopsys_edac.c:#ifdef CONFIG_EDAC_DEBUG


- Paul
