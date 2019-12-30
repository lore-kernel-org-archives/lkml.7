Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD2CC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37824206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfL3Mim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:38:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:50536 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfL3Mim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 07:38:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2019 04:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,375,1571727600"; 
   d="scan'208";a="368597928"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Dec 2019 04:38:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iluJi-0007xD-M5; Mon, 30 Dec 2019 20:38:38 +0800
Date:   Mon, 30 Dec 2019 20:37:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kbuild-all@lists.01.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, frieder.schrempf@kontron.de,
        masonccyang@mxic.com.tw, allison@lohutok.net,
        yuehaibing@huawei.com, tglx@linutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: rawnand: macronix: Use match_string() helper
 to simplify the code
Message-ID: <201912302029.5N9R0LjB%lkp@intel.com>
References: <20191230025217.30812-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230025217.30812-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20191220]
[also build test WARNING on linus/master v5.5-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/YueHaibing/mtd-rawnand-macronix-Use-match_string-helper-to-simplify-the-code/20191230-111849
base:    7ddd09fc4b745fb1d8942f95389583e08412e0cd

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

smatch warnings:
drivers/mtd/nand/raw/nand_macronix.c:85 macronix_nand_fix_broken_get_timings() warn: unsigned 'i' is never less than zero.

vim +/i +85 drivers/mtd/nand/raw/nand_macronix.c

    54	
    55	/*
    56	 * Macronix AC series does not support using SET/GET_FEATURES to change
    57	 * the timings unlike what is declared in the parameter page. Unflag
    58	 * this feature to avoid unnecessary downturns.
    59	 */
    60	static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
    61	{
    62		unsigned int i;
    63		static const char * const broken_get_timings[] = {
    64			"MX30LF1G18AC",
    65			"MX30LF1G28AC",
    66			"MX30LF2G18AC",
    67			"MX30LF2G28AC",
    68			"MX30LF4G18AC",
    69			"MX30LF4G28AC",
    70			"MX60LF8G18AC",
    71			"MX30UF1G18AC",
    72			"MX30UF1G16AC",
    73			"MX30UF2G18AC",
    74			"MX30UF2G16AC",
    75			"MX30UF4G18AC",
    76			"MX30UF4G16AC",
    77			"MX30UF4G28AC",
    78		};
    79	
    80		if (!chip->parameters.supports_set_get_features)
    81			return;
    82	
    83		i = match_string(broken_get_timings, ARRAY_SIZE(broken_get_timings),
    84				 chip->parameters.model);
  > 85		if (i < 0)
    86			return;
    87	
    88		bitmap_clear(chip->parameters.get_feature_list,
    89			     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
    90		bitmap_clear(chip->parameters.set_feature_list,
    91			     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
    92	}
    93	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
