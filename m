Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E74C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE1E2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392542AbfIWGG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:06:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:65031 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387519AbfIWGG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:06:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Sep 2019 23:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; 
   d="scan'208";a="188965441"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.6])
  by fmsmga007.fm.intel.com with ESMTP; 22 Sep 2019 23:06:54 -0700
Date:   Mon, 23 Sep 2019 14:06:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     kbuild-all@01.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sinan Kaya <okaya@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] platform/x86: huawei-wmi: Add battery charging
 thresholds
Message-ID: <20190923060643.GE15734@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190920160250.12510-5-ayman.bagabas@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ayman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20190918]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Ayman-Bagabas/platform-x86-Huawei-WMI-laptop-extras-driver/20190921-072831
base:   next-20190918
:::::: branch date: 31 hours ago
:::::: commit date: 31 hours ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

smatch warnings:
drivers/platform/x86/huawei-wmi.c:327 huawei_wmi_battery_get() error: buffer overflow 'ret' 256 <= 256

# https://github.com/0day-ci/linux/commit/2b04f79aef9a86ecb9483dd27a82498fa56bc0c9
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 2b04f79aef9a86ecb9483dd27a82498fa56bc0c9
vim +/ret +327 drivers/platform/x86/huawei-wmi.c

2b04f79aef9a86 Ayman Bagabas 2019-09-20  311  
2b04f79aef9a86 Ayman Bagabas 2019-09-20  312  static int huawei_wmi_battery_get(int *start, int *end)
2b04f79aef9a86 Ayman Bagabas 2019-09-20  313  {
2b04f79aef9a86 Ayman Bagabas 2019-09-20  314  	u8 ret[0x100];
2b04f79aef9a86 Ayman Bagabas 2019-09-20  315  	int err, i;
2b04f79aef9a86 Ayman Bagabas 2019-09-20  316  
2b04f79aef9a86 Ayman Bagabas 2019-09-20  317  	err = huawei_wmi_cmd(BATTERY_THRESH_GET, ret, 0x100);
2b04f79aef9a86 Ayman Bagabas 2019-09-20  318  	if (err)
2b04f79aef9a86 Ayman Bagabas 2019-09-20  319  		return err;
2b04f79aef9a86 Ayman Bagabas 2019-09-20  320  
2b04f79aef9a86 Ayman Bagabas 2019-09-20  321  	/* Find the last two non-zero values. Return status is ignored. */
2b04f79aef9a86 Ayman Bagabas 2019-09-20  322  	i = 0x100;
2b04f79aef9a86 Ayman Bagabas 2019-09-20  323  	do {
2b04f79aef9a86 Ayman Bagabas 2019-09-20  324  		if (start)
2b04f79aef9a86 Ayman Bagabas 2019-09-20  325  			*start = ret[i-1];
2b04f79aef9a86 Ayman Bagabas 2019-09-20  326  		if (end)
2b04f79aef9a86 Ayman Bagabas 2019-09-20 @327  			*end = ret[i];
2b04f79aef9a86 Ayman Bagabas 2019-09-20  328  	} while (i > 2 && !ret[i--]);
2b04f79aef9a86 Ayman Bagabas 2019-09-20  329  
2b04f79aef9a86 Ayman Bagabas 2019-09-20  330  	return 0;
2b04f79aef9a86 Ayman Bagabas 2019-09-20  331  }
2b04f79aef9a86 Ayman Bagabas 2019-09-20  332  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
