Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA61C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6F3204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfH0K31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:29:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:54854 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfH0K31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:29:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 03:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="gz'50?scan'50,208,50";a="209699803"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2019 03:29:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i2Yj6-000DaT-MW; Tue, 27 Aug 2019 18:29:24 +0800
Date:   Tue, 27 Aug 2019 18:28:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kbuild-all@01.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] clk: Evict unregistered clks from parent caches
Message-ID: <201908271848.zrwFj4Pk%lkp@intel.com>
References: <20190826234311.138147-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zmkxfqkp5ldnubxr"
Content-Disposition: inline
In-Reply-To: <20190826234311.138147-1-sboyd@kernel.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zmkxfqkp5ldnubxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc6 next-20190827]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/clk-Evict-unregistered-clks-from-parent-caches/20190827-165138
config: mips-allnoconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/clk.c: In function 'clk_core_evict_parent_cache':
>> drivers/clk/clk.c:3785:15: error: 'all_lists' undeclared (first use in this function); did you mean 'lists'?
     for (lists = all_lists; *lists; lists++)
                  ^~~~~~~~~
                  lists
   drivers/clk/clk.c:3785:15: note: each undeclared identifier is reported only once for each function it appears in

vim +3785 drivers/clk/clk.c

  3776	
  3777	/* Remove this clk from all parent caches */
  3778	static void clk_core_evict_parent_cache(struct clk_core *core)
  3779	{
  3780		struct hlist_head **lists;
  3781		struct clk_core *root;
  3782	
  3783		lockdep_assert_held(&prepare_lock);
  3784	
> 3785		for (lists = all_lists; *lists; lists++)
  3786			hlist_for_each_entry(root, *lists, child_node)
  3787				clk_core_evict_parent_cache_subtree(root, core);
  3788	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--zmkxfqkp5ldnubxr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--zmkxfqkp5ldnubxr--
