Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143CCC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D4A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEOJhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:37:35 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40498 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOJhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:37:34 -0400
Received: from p5b127b5a.dip0.t-ipconnect.de ([91.18.123.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hQqLq-0006Xp-5g; Wed, 15 May 2019 11:37:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Tero Kristo <t-kristo@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] clk: Remove io.h from clk-provider.h
Date:   Wed, 15 May 2019 11:37:28 +0200
Message-ID: <1633148.JVzFjimNce@phil>
In-Reply-To: <20190514170931.56312-1-sboyd@kernel.org>
References: <20190514170931.56312-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. Mai 2019, 19:09:31 CEST schrieb Stephen Boyd:
> Now that we've gotten rid of clk_readl() we can remove io.h from the
> clk-provider header and push out the io.h include to any code that isn't
> already including the io.h header but using things like readl/writel,
> etc.
> 
> Found with this grep:
> 
>   git grep -l clk-provider.h | grep '.c$' | xargs git grep -L 'linux/io.h' | \
>   	xargs git grep -l \
> 	-e '\<__iowrite32_copy\>' --or \
> 	-e '\<__ioread32_copy\>' --or \
> 	-e '\<__iowrite64_copy\>' --or \
> 	-e '\<ioremap_page_range\>' --or \
> 	-e '\<ioremap_huge_init\>' --or \
> 	-e '\<arch_ioremap_pud_supported\>' --or \
> 	-e '\<arch_ioremap_pmd_supported\>' --or \
> 	-e '\<devm_ioport_map\>' --or \
> 	-e '\<devm_ioport_unmap\>' --or \
> 	-e '\<IOMEM_ERR_PTR\>' --or \
> 	-e '\<devm_ioremap\>' --or \
> 	-e '\<devm_ioremap_nocache\>' --or \
> 	-e '\<devm_ioremap_wc\>' --or \
> 	-e '\<devm_iounmap\>' --or \
> 	-e '\<devm_ioremap_release\>' --or \
> 	-e '\<devm_memremap\>' --or \
> 	-e '\<devm_memunmap\>' --or \
> 	-e '\<__devm_memremap_pages\>' --or \
> 	-e '\<pci_remap_cfgspace\>' --or \
> 	-e '\<arch_has_dev_port\>' --or \
> 	-e '\<arch_phys_wc_add\>' --or \
> 	-e '\<arch_phys_wc_del\>' --or \
> 	-e '\<memremap\>' --or \
> 	-e '\<memunmap\>' --or \
> 	-e '\<arch_io_reserve_memtype_wc\>' --or \
> 	-e '\<arch_io_free_memtype_wc\>' --or \
> 	-e '\<__io_aw\>' --or \
> 	-e '\<__io_pbw\>' --or \
> 	-e '\<__io_paw\>' --or \
> 	-e '\<__io_pbr\>' --or \
> 	-e '\<__io_par\>' --or \
> 	-e '\<__raw_readb\>' --or \
> 	-e '\<__raw_readw\>' --or \
> 	-e '\<__raw_readl\>' --or \
> 	-e '\<__raw_readq\>' --or \
> 	-e '\<__raw_writeb\>' --or \
> 	-e '\<__raw_writew\>' --or \
> 	-e '\<__raw_writel\>' --or \
> 	-e '\<__raw_writeq\>' --or \
> 	-e '\<readb\>' --or \
> 	-e '\<readw\>' --or \
> 	-e '\<readl\>' --or \
> 	-e '\<readq\>' --or \
> 	-e '\<writeb\>' --or \
> 	-e '\<writew\>' --or \
> 	-e '\<writel\>' --or \
> 	-e '\<writeq\>' --or \
> 	-e '\<readb_relaxed\>' --or \
> 	-e '\<readw_relaxed\>' --or \
> 	-e '\<readl_relaxed\>' --or \
> 	-e '\<readq_relaxed\>' --or \
> 	-e '\<writeb_relaxed\>' --or \
> 	-e '\<writew_relaxed\>' --or \
> 	-e '\<writel_relaxed\>' --or \
> 	-e '\<writeq_relaxed\>' --or \
> 	-e '\<readsb\>' --or \
> 	-e '\<readsw\>' --or \
> 	-e '\<readsl\>' --or \
> 	-e '\<readsq\>' --or \
> 	-e '\<writesb\>' --or \
> 	-e '\<writesw\>' --or \
> 	-e '\<writesl\>' --or \
> 	-e '\<writesq\>' --or \
> 	-e '\<inb\>' --or \
> 	-e '\<inw\>' --or \
> 	-e '\<inl\>' --or \
> 	-e '\<outb\>' --or \
> 	-e '\<outw\>' --or \
> 	-e '\<outl\>' --or \
> 	-e '\<inb_p\>' --or \
> 	-e '\<inw_p\>' --or \
> 	-e '\<inl_p\>' --or \
> 	-e '\<outb_p\>' --or \
> 	-e '\<outw_p\>' --or \
> 	-e '\<outl_p\>' --or \
> 	-e '\<insb\>' --or \
> 	-e '\<insw\>' --or \
> 	-e '\<insl\>' --or \
> 	-e '\<outsb\>' --or \
> 	-e '\<outsw\>' --or \
> 	-e '\<outsl\>' --or \
> 	-e '\<insb_p\>' --or \
> 	-e '\<insw_p\>' --or \
> 	-e '\<insl_p\>' --or \
> 	-e '\<outsb_p\>' --or \
> 	-e '\<outsw_p\>' --or \
> 	-e '\<outsl_p\>' --or \
> 	-e '\<ioread8\>' --or \
> 	-e '\<ioread16\>' --or \
> 	-e '\<ioread32\>' --or \
> 	-e '\<ioread64\>' --or \
> 	-e '\<iowrite8\>' --or \
> 	-e '\<iowrite16\>' --or \
> 	-e '\<iowrite32\>' --or \
> 	-e '\<iowrite64\>' --or \
> 	-e '\<ioread16be\>' --or \
> 	-e '\<ioread32be\>' --or \
> 	-e '\<ioread64be\>' --or \
> 	-e '\<iowrite16be\>' --or \
> 	-e '\<iowrite32be\>' --or \
> 	-e '\<iowrite64be\>' --or \
> 	-e '\<ioread8_rep\>' --or \
> 	-e '\<ioread16_rep\>' --or \
> 	-e '\<ioread32_rep\>' --or \
> 	-e '\<ioread64_rep\>' --or \
> 	-e '\<iowrite8_rep\>' --or \
> 	-e '\<iowrite16_rep\>' --or \
> 	-e '\<iowrite32_rep\>' --or \
> 	-e '\<iowrite64_rep\>' --or \
> 	-e '\<__io_virt\>' --or \
> 	-e '\<pci_iounmap\>' --or \
> 	-e '\<virt_to_phys\>' --or \
> 	-e '\<phys_to_virt\>' --or \
> 	-e '\<ioremap_uc\>' --or \
> 	-e '\<ioremap\>' --or \
> 	-e '\<__ioremap\>' --or \
> 	-e '\<iounmap\>' --or \
> 	-e '\<ioremap\>' --or \
> 	-e '\<ioremap_nocache\>' --or \
> 	-e '\<ioremap_uc\>' --or \
> 	-e '\<ioremap_wc\>' --or \
> 	-e '\<ioremap_wc\>' --or \
> 	-e '\<ioremap_wt\>' --or \
> 	-e '\<ioport_map\>' --or \
> 	-e '\<ioport_unmap\>' --or \
> 	-e '\<ioport_map\>' --or \
> 	-e '\<ioport_unmap\>' --or \
> 	-e '\<xlate_dev_kmem_ptr\>' --or \
> 	-e '\<xlate_dev_mem_ptr\>' --or \
> 	-e '\<unxlate_dev_mem_ptr\>' --or \
> 	-e '\<virt_to_bus\>' --or \
> 	-e '\<bus_to_virt\>' --or \
> 	-e '\<memset_io\>' --or \
> 	-e '\<memcpy_fromio\>' --or \
> 	-e '\<memcpy_toio\>'
> 
> I also reordered a couple includes when they weren't alphabetical and
> removed clk.h from kona, replacing it with clk-provider.h because
> that driver doesn't use clk consumer APIs.
> 
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com> 
> Cc: John Crispin <john@phrozen.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

For the Rockchip parts (both arch/arm + drivers/clk)
Acked-by: Heiko Stuebner <heiko@sntech.de>


