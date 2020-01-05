Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37F2C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CAA20848
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgAEWfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:35:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:46887 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgAEWfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:35:34 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2020 14:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,400,1571727600"; 
   d="scan'208";a="394850178"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Jan 2020 14:35:32 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ioEUd-000C6n-VL; Mon, 06 Jan 2020 06:35:31 +0800
Date:   Mon, 6 Jan 2020 06:35:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/staging/wfx/main.c:47:14-21: ERROR: PTR_ERR applied after
 initialization to constant on line 42
Message-ID: <202001060659.u13dpgMJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   768fc661d12559b0dbd99d941b3bf28fe92fd365
commit: 0096214a59a72b3c3c943e27bd03307324d3ce0f staging: wfx: add support for I/O access
date:   3 months ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/staging/wfx/main.c:47:14-21: ERROR: PTR_ERR applied after initialization to constant on line 42

vim +47 drivers/staging/wfx/main.c

    30	
    31	struct gpio_desc *wfx_get_gpio(struct device *dev, int override, const char *label)
    32	{
    33		struct gpio_desc *ret;
    34		char label_buf[256];
    35	
    36		if (override >= 0) {
    37			snprintf(label_buf, sizeof(label_buf), "wfx_%s", label);
    38			ret = ERR_PTR(devm_gpio_request_one(dev, override, GPIOF_OUT_INIT_LOW, label_buf));
    39			if (!ret)
    40				ret = gpio_to_desc(override);
    41		} else if (override == -1) {
  > 42			ret = NULL;
    43		} else {
    44			ret = devm_gpiod_get(dev, label, GPIOD_OUT_LOW);
    45		}
    46		if (IS_ERR(ret) || !ret) {
  > 47			if (!ret || PTR_ERR(ret) == -ENOENT)
    48				dev_warn(dev, "gpio %s is not defined\n", label);
    49			else
    50				dev_warn(dev, "error while requesting gpio %s\n", label);
    51			ret = NULL;
    52		} else {
    53			dev_dbg(dev, "using gpio %d for %s\n", desc_to_gpio(ret), label);
    54		}
    55		return ret;
    56	}
    57	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
