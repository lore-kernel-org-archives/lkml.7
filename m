Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE4C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CCE20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDHHlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:41:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:39198 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHHlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:41:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 00:41:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="159658647"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 08 Apr 2019 00:41:07 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Apr 2019 10:41:06 +0300
Date:   Mon, 8 Apr 2019 10:41:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Chris Chiu <chiu@endlessm.com>
Cc:     andriy.shevchenko@intel.com, heikki.krogerus@linux.intel.com,
        drake@endlessm.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: [PATCH] pinctrl:intel: Retain HOSTSW_OWN for requested gpio pin
Message-ID: <20190408074106.GC3622@lahna.fi.intel.com>
References: <20190408042103.3804-1-chiu@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408042103.3804-1-chiu@endlessm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:21:03PM +0800, Chris Chiu wrote:
> +static void
> +intel_gpio_update_pad_mode(void __iomem *hostown, u32 mask, u32 value)
> +{
> +	u32 curr = readl(hostown);
> +	u32 updated = (curr & ~mask) | (value & mask);

I think here we should first complain if the expected ownership is not
correct. Warning or info level probably enough.

> +
> +	return writel(updated, hostown);

Also if the pin is not requested and not changed we should not touch the
register.

Otherwise this looks good to me.
