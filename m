Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D15B218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 05:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfC3Fxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 01:53:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:21277 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfC3Fxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 01:53:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 22:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,287,1549958400"; 
   d="scan'208";a="138672331"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2019 22:53:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hA6w1-00026q-Nb; Sat, 30 Mar 2019 13:53:41 +0800
Date:   Sat, 30 Mar 2019 13:53:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com,
        faiz_abbas@ti.com
Subject: Re: [PATCH v5] mmc: sdhci-omap: Don't finish_mrq() on a command
 error during tuning
Message-ID: <201903301321.kfK13ZG5%lkp@intel.com>
References: <20190329121042.24415-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329121042.24415-1-faiz_abbas@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faiz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ulf.hansson-mmc/next]
[also build test WARNING on v5.1-rc2 next-20190329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Faiz-Abbas/mmc-sdhci-omap-Don-t-finish_mrq-on-a-command-error-during-tuning/20190330-093057
base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   drivers/mmc/host/sdhci-omap.c:386:31: sparse: expression using sizeof(void)
   drivers/mmc/host/sdhci-omap.c:386:31: sparse: expression using sizeof(void)
>> drivers/mmc/host/sdhci-omap.c:847:16: sparse: incorrect type in initializer (different signedness) @@    expected unsigned int ( *irq )( ... ) @@    got int enunsigned int ( *irq )( ... ) @@
   drivers/mmc/host/sdhci-omap.c:847:16:    expected unsigned int ( *irq )( ... )
   drivers/mmc/host/sdhci-omap.c:847:16:    got int enum irqreturn ( *<noident> )( ... )
   include/linux/device.h:688:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/device.h:688:13: sparse: call with no type!

vim +847 drivers/mmc/host/sdhci-omap.c

   836	
   837	static struct sdhci_ops sdhci_omap_ops = {
   838		.set_clock = sdhci_omap_set_clock,
   839		.set_power = sdhci_omap_set_power,
   840		.enable_dma = sdhci_omap_enable_dma,
   841		.get_max_clock = sdhci_pltfm_clk_get_max_clock,
   842		.get_min_clock = sdhci_omap_get_min_clock,
   843		.set_bus_width = sdhci_omap_set_bus_width,
   844		.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
   845		.reset = sdhci_omap_reset,
   846		.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 > 847		.irq = sdhci_omap_irq,
   848	};
   849	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
