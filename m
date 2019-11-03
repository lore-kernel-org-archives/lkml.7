Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31547CA9ED0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ABE20848
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 07:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfKCHv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 02:51:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:51508 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfKCHv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 02:51:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 00:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,262,1569308400"; 
   d="scan'208";a="352542670"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2019 00:51:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iRAfT-000DzM-E7; Sun, 03 Nov 2019 15:51:23 +0800
Date:   Sun, 3 Nov 2019 15:51:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     allen <allen.chen@ite.com.tw>
Cc:     kbuild-all@lists.01.org, Allen Chen <allen.chen@ite.com.tw>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking
 timings logic
Message-ID: <201911031510.4s2wqcIN%lkp@intel.com>
References: <1572595463-30970-1-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572595463-30970-1-git-send-email-allen.chen@ite.com.tw>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi allen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.4-rc5 next-20191031]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/allen/drm-edid-fixup-EDID-1-3-and-1-4-judge-reduced-blanking-timings-logic/20191102-200357
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1204c70d9dcba31164f78ad5d8c88c42335d51f8

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

smatch warnings:
drivers/gpu/drm/drm_edid.c:2042 drm_monitor_supports_rb() warn: always true condition '(closure.support_rb >= 0) => (0-255 >= 0)'

vim +2042 drivers/gpu/drm/drm_edid.c

  2030	
  2031	/* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
  2032	static bool
  2033	drm_monitor_supports_rb(struct edid *edid)
  2034	{
  2035		struct edid_support_rb_closure closure = {
  2036			.edid = edid,
  2037			.support_rb = -1,
  2038		};
  2039	
  2040		if (edid->revision >= 4) {
  2041			drm_for_each_detailed_block((u8 *)edid, is_rb, &closure);
> 2042			if (closure.support_rb >= 0)
  2043				return closure.support_rb;
  2044		}
  2045	
  2046		return true;
  2047	}
  2048	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
