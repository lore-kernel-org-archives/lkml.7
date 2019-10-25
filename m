Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A680ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824B521D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437759AbfJYIHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:07:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:33385 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437747AbfJYIHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:07:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 01:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="201741758"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 01:06:56 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNucZ-0001sH-FJ; Fri, 25 Oct 2019 11:06:55 +0300
Date:   Fri, 25 Oct 2019 11:06:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrey Zhizhikin <andrey.z@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 2/2] mfd: add regulator cell to Cherry Trail Whiskey Cove
 PMIC
Message-ID: <20191025080655.GF32742@smile.fi.intel.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191024142939.25920-3-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024142939.25920-3-andrey.zhizhikin@leica-geosystems.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:29:39PM +0000, Andrey Zhizhikin wrote:
> Add a regulator mfd cell to Whiskey Cove PMIC driver, which is used to
> supply various voltage rails.
> 
> In addition, make the initialization of this mfd driver early enough in
> order to provide regulator cell to mmc sub-system when it is initialized.

Doesn't deferred probe mechanism work for you?
MMC core returns that error till we have the driver initialized.

> +	}, {
> +		.name = "cht_wcove_regulator",
> +		.id = CHT_WC_REGULATOR_VSDIO + 1,

> +		.num_resources = 0,
> +		.resources = NULL,

No need to put these.

> -static struct i2c_driver cht_wc_driver = {
> +static struct i2c_driver cht_wc_i2c_driver = {

Renaming is not explained in the commit message.

-- 
With Best Regards,
Andy Shevchenko


