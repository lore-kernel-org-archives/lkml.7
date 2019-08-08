Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B83BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4A72189E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfHHMy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:54:28 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:2929 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732678AbfHHMy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:54:28 -0400
X-IronPort-AV: E=Sophos;i="5.64,361,1559512800"; 
   d="scan'208";a="315934545"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 14:54:24 +0200
Date:   Thu, 8 Aug 2019 14:54:24 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
Subject: drivers/clk/bcm/clk-bcm2835.c:2144:1-13: WARNING: Use
 devm_platform_ioremap_resource for cprman -> regs (fwd)
Message-ID: <alpine.DEB.2.21.1908081453540.2995@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Thu, 8 Aug 2019 20:52:32 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/clk/bcm/clk-bcm2835.c:2144:1-13: WARNING: Use
    devm_platform_ioremap_resource for cprman -> regs

CC: kbuild-all@01.org
CC: linux-kernel@vger.kernel.org
TO: Florian Fainelli <f.fainelli@gmail.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Eric Anholt <eric@anholt.net>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ecb095bff5d4b8711a81968625b3b4a235d3e477
commit: 5d59f12a19e6cb96a1a72fac2b0d73ab8435b167 clk: bcm: Make BCM2835 clock drivers selectable
date:   9 weeks ago
:::::: branch date: 15 hours ago
:::::: commit date: 9 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/clk/bcm/clk-bcm2835.c:2144:1-13: WARNING: Use devm_platform_ioremap_resource for cprman -> regs

git remote add linus https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 5d59f12a19e6cb96a1a72fac2b0d73ab8435b167
vim +2144 drivers/clk/bcm/clk-bcm2835.c

9e400c5cc5c105 Eric Anholt   2016-06-01  2123
41691b8862e2a3 Eric Anholt   2015-10-08  2124  static int bcm2835_clk_probe(struct platform_device *pdev)
41691b8862e2a3 Eric Anholt   2015-10-08  2125  {
41691b8862e2a3 Eric Anholt   2015-10-08  2126  	struct device *dev = &pdev->dev;
b19f009d451060 Stephen Boyd  2016-06-01  2127  	struct clk_hw **hws;
41691b8862e2a3 Eric Anholt   2015-10-08  2128  	struct bcm2835_cprman *cprman;
41691b8862e2a3 Eric Anholt   2015-10-08  2129  	struct resource *res;
56eb3a2ed97269 Martin Sperl  2016-02-29  2130  	const struct bcm2835_clk_desc *desc;
56eb3a2ed97269 Martin Sperl  2016-02-29  2131  	const size_t asize = ARRAY_SIZE(clk_desc_array);
56eb3a2ed97269 Martin Sperl  2016-02-29  2132  	size_t i;
9e400c5cc5c105 Eric Anholt   2016-06-01  2133  	int ret;
41691b8862e2a3 Eric Anholt   2015-10-08  2134
0ed2dd03b94b7b Kees Cook     2018-05-08  2135  	cprman = devm_kzalloc(dev,
0ed2dd03b94b7b Kees Cook     2018-05-08  2136  			      struct_size(cprman, onecell.hws, asize),
56eb3a2ed97269 Martin Sperl  2016-02-29  2137  			      GFP_KERNEL);
41691b8862e2a3 Eric Anholt   2015-10-08  2138  	if (!cprman)
41691b8862e2a3 Eric Anholt   2015-10-08  2139  		return -ENOMEM;
41691b8862e2a3 Eric Anholt   2015-10-08  2140
41691b8862e2a3 Eric Anholt   2015-10-08  2141  	spin_lock_init(&cprman->regs_lock);
41691b8862e2a3 Eric Anholt   2015-10-08  2142  	cprman->dev = dev;
41691b8862e2a3 Eric Anholt   2015-10-08  2143  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
41691b8862e2a3 Eric Anholt   2015-10-08 @2144  	cprman->regs = devm_ioremap_resource(dev, res);
41691b8862e2a3 Eric Anholt   2015-10-08  2145  	if (IS_ERR(cprman->regs))
41691b8862e2a3 Eric Anholt   2015-10-08  2146  		return PTR_ERR(cprman->regs);
41691b8862e2a3 Eric Anholt   2015-10-08  2147
8a39e9fa578229 Eric Anholt   2017-01-18  2148  	memcpy(cprman->real_parent_names, cprman_parent_names,
8a39e9fa578229 Eric Anholt   2017-01-18  2149  	       sizeof(cprman_parent_names));
8a39e9fa578229 Eric Anholt   2017-01-18  2150  	of_clk_parent_fill(dev->of_node, cprman->real_parent_names,
8a39e9fa578229 Eric Anholt   2017-01-18  2151  			   ARRAY_SIZE(cprman_parent_names));
8a39e9fa578229 Eric Anholt   2017-01-18  2152
8a39e9fa578229 Eric Anholt   2017-01-18  2153  	/*
8a39e9fa578229 Eric Anholt   2017-01-18  2154  	 * Make sure the external oscillator has been registered.
8a39e9fa578229 Eric Anholt   2017-01-18  2155  	 *
8a39e9fa578229 Eric Anholt   2017-01-18  2156  	 * The other (DSI) clocks are not present on older device
8a39e9fa578229 Eric Anholt   2017-01-18  2157  	 * trees, which we still need to support for backwards
8a39e9fa578229 Eric Anholt   2017-01-18  2158  	 * compatibility.
8a39e9fa578229 Eric Anholt   2017-01-18  2159  	 */
8a39e9fa578229 Eric Anholt   2017-01-18  2160  	if (!cprman->real_parent_names[0])
41691b8862e2a3 Eric Anholt   2015-10-08  2161  		return -ENODEV;
41691b8862e2a3 Eric Anholt   2015-10-08  2162
41691b8862e2a3 Eric Anholt   2015-10-08  2163  	platform_set_drvdata(pdev, cprman);
41691b8862e2a3 Eric Anholt   2015-10-08  2164
b19f009d451060 Stephen Boyd  2016-06-01  2165  	cprman->onecell.num = asize;
b19f009d451060 Stephen Boyd  2016-06-01  2166  	hws = cprman->onecell.hws;
41691b8862e2a3 Eric Anholt   2015-10-08  2167
56eb3a2ed97269 Martin Sperl  2016-02-29  2168  	for (i = 0; i < asize; i++) {
56eb3a2ed97269 Martin Sperl  2016-02-29  2169  		desc = &clk_desc_array[i];
56eb3a2ed97269 Martin Sperl  2016-02-29  2170  		if (desc->clk_register && desc->data)
b19f009d451060 Stephen Boyd  2016-06-01  2171  			hws[i] = desc->clk_register(cprman, desc->data);
56eb3a2ed97269 Martin Sperl  2016-02-29  2172  	}
cfbab8fbab9c33 Remi Pommarel 2015-12-06  2173
b19f009d451060 Stephen Boyd  2016-06-01  2174  	ret = bcm2835_mark_sdc_parent_critical(hws[BCM2835_CLOCK_SDRAM]->clk);
9e400c5cc5c105 Eric Anholt   2016-06-01  2175  	if (ret)
9e400c5cc5c105 Eric Anholt   2016-06-01  2176  		return ret;
9e400c5cc5c105 Eric Anholt   2016-06-01  2177
b19f009d451060 Stephen Boyd  2016-06-01  2178  	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
41691b8862e2a3 Eric Anholt   2015-10-08  2179  				      &cprman->onecell);
41691b8862e2a3 Eric Anholt   2015-10-08  2180  }
41691b8862e2a3 Eric Anholt   2015-10-08  2181

:::::: The code at line 2144 was first introduced by commit
:::::: 41691b8862e2a32080306f17a723efc4b6ca86ab clk: bcm2835: Add support for programming the audio domain clocks

:::::: TO: Eric Anholt <eric@anholt.net>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
