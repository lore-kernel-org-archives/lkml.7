Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C0AC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1781421955
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfGWAeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:34:01 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:44119 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbfGWAeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:34:01 -0400
X-IronPort-AV: E=Sophos;i="5.64,297,1559512800"; 
   d="scan'208";a="392907466"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 02:33:57 +0200
Date:   Mon, 22 Jul 2019 19:33:55 -0500 (CDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Miquel Raynal <miquel.raynal@bootlin.com>
cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:142:1-10: WARNING: Use
 devm_platform_ioremap_resource for ecc -> base
Message-ID: <alpine.DEB.2.21.1907221929450.3471@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The calls to platform_get_resource and devm_ioremap_resource can be
merged.

julia

---------- Forwarded message ----------
Date: Tue, 23 Jul 2019 06:07:33 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:142:1-10: WARNING: Use
    devm_platform_ioremap_resource for ecc -> base

CC: kbuild-all@01.org
CC: linux-kernel@vger.kernel.org
TO: Miquel Raynal <miquel.raynal@bootlin.com>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7b5cf701ea9c395c792e2a7e3b7caf4c68b87721
commit: 72c5af00272339af6bbed6fe7275cd731f57be2d mtd: rawnand: Clarify Kconfig entry MTD_NAND
date:   3 months ago
:::::: branch date: 6 hours ago
:::::: commit date: 3 months ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/mtd/nand/raw/ingenic/ingenic_ecc.c:142:1-10: WARNING: Use devm_platform_ioremap_resource for ecc -> base

git remote add linus https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 72c5af00272339af6bbed6fe7275cd731f57be2d
vim +142 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c

15de8c6efd0effe Paul Cercueil 2019-03-19  126
15de8c6efd0effe Paul Cercueil 2019-03-19  127  int ingenic_ecc_probe(struct platform_device *pdev)
15de8c6efd0effe Paul Cercueil 2019-03-19  128  {
15de8c6efd0effe Paul Cercueil 2019-03-19  129  	struct device *dev = &pdev->dev;
15de8c6efd0effe Paul Cercueil 2019-03-19  130  	struct ingenic_ecc *ecc;
15de8c6efd0effe Paul Cercueil 2019-03-19  131  	struct resource *res;
15de8c6efd0effe Paul Cercueil 2019-03-19  132
15de8c6efd0effe Paul Cercueil 2019-03-19  133  	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
15de8c6efd0effe Paul Cercueil 2019-03-19  134  	if (!ecc)
15de8c6efd0effe Paul Cercueil 2019-03-19  135  		return -ENOMEM;
15de8c6efd0effe Paul Cercueil 2019-03-19  136
15de8c6efd0effe Paul Cercueil 2019-03-19  137  	ecc->ops = device_get_match_data(dev);
15de8c6efd0effe Paul Cercueil 2019-03-19  138  	if (!ecc->ops)
15de8c6efd0effe Paul Cercueil 2019-03-19  139  		return -EINVAL;
15de8c6efd0effe Paul Cercueil 2019-03-19  140
15de8c6efd0effe Paul Cercueil 2019-03-19  141  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
15de8c6efd0effe Paul Cercueil 2019-03-19 @142  	ecc->base = devm_ioremap_resource(dev, res);
15de8c6efd0effe Paul Cercueil 2019-03-19  143  	if (IS_ERR(ecc->base))
15de8c6efd0effe Paul Cercueil 2019-03-19  144  		return PTR_ERR(ecc->base);
15de8c6efd0effe Paul Cercueil 2019-03-19  145
15de8c6efd0effe Paul Cercueil 2019-03-19  146  	ecc->ops->disable(ecc);
15de8c6efd0effe Paul Cercueil 2019-03-19  147
15de8c6efd0effe Paul Cercueil 2019-03-19  148  	ecc->clk = devm_clk_get(dev, NULL);
15de8c6efd0effe Paul Cercueil 2019-03-19  149  	if (IS_ERR(ecc->clk)) {
15de8c6efd0effe Paul Cercueil 2019-03-19  150  		dev_err(dev, "failed to get clock: %ld\n", PTR_ERR(ecc->clk));
15de8c6efd0effe Paul Cercueil 2019-03-19  151  		return PTR_ERR(ecc->clk);
15de8c6efd0effe Paul Cercueil 2019-03-19  152  	}
15de8c6efd0effe Paul Cercueil 2019-03-19  153
15de8c6efd0effe Paul Cercueil 2019-03-19  154  	mutex_init(&ecc->lock);
15de8c6efd0effe Paul Cercueil 2019-03-19  155
15de8c6efd0effe Paul Cercueil 2019-03-19  156  	ecc->dev = dev;
15de8c6efd0effe Paul Cercueil 2019-03-19  157  	platform_set_drvdata(pdev, ecc);
15de8c6efd0effe Paul Cercueil 2019-03-19  158
15de8c6efd0effe Paul Cercueil 2019-03-19  159  	return 0;
15de8c6efd0effe Paul Cercueil 2019-03-19  160  }
15de8c6efd0effe Paul Cercueil 2019-03-19  161  EXPORT_SYMBOL(ingenic_ecc_probe);
15de8c6efd0effe Paul Cercueil 2019-03-19  162
15de8c6efd0effe Paul Cercueil 2019-03-19  163  MODULE_LICENSE("GPL v2");

:::::: The code at line 142 was first introduced by commit
:::::: 15de8c6efd0effef3a5226bd5ab7f101c9f4948f mtd: rawnand: ingenic: Separate top-level and SoC specific code

:::::: TO: Paul Cercueil <paul@crapouillou.net>
:::::: CC: Miquel Raynal <miquel.raynal@bootlin.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
