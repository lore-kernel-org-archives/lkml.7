Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B14DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6527F21902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfCVKmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:42:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:2414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727683AbfCVKmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:42:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 03:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="157366482"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 22 Mar 2019 03:42:43 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 22 Mar 2019 12:42:42 +0200
Date:   Fri, 22 Mar 2019 12:42:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "zhuchangchun@cvte.com" <zhuchangchun@cvte.com>
Cc:     "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        hendychu <hendychu@aliyun.com>
Subject: Re: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190322104242.GV3622@lahna.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <2019032119195575582546@cvte.com>
 <20190321120324.GI3622@lahna.fi.intel.com>
 <2019032120213955866649@cvte.com>
 <20190321123637.GJ3622@lahna.fi.intel.com>
 <2019032121342663125658@cvte.com>
 <20190321135642.GK3622@lahna.fi.intel.com>
 <2019032211131426883268@cvte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019032211131426883268@cvte.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 11:14:14AM +0800, zhuchangchun@cvte.com wrote:
>    static int intel_gpio_set_direction(struct pinctrl_dev *pctldev,
>       struct pinctrl_gpio_range *range,
>       unsigned pin, bool input)
>    {
>    struct intel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>    void __iomem *padcfg0;
>    unsigned long flags;
>    u32 value;
>    spin_lock_irqsave(&pctrl->lock, flags);
>    padcfg0 = intel_get_padcfg(pctrl, pin, PADCFG0);
>    value = readl(padcfg0);
>    if (input)
>    value |= PADCFG0_GPIOTXDIS;
>    else
>    value &= ~PADCFG0_GPIOTXDIS;
>    writel(value, padcfg0);
>    spin_unlock_irqrestore(&pctrl->lock, flags);
>    return 0;
>    }
> 
>    From above,you can kown when you export a GPIO ,it will do request,
> 
>    and there will set TX and RX register at the time same time.
> 
>    when you try to set direction in and set value, TX register value can
>    roll back
> 
>    the value,but RX register was not set, so who will set RX value back??

I think you are looking at some older code. There is now function
__intel_gpio_set_direction() that is supposed to set both buffers
depending on the direction. It was introduced with commit 17fab473693e
("pinctrl: intel: Set pin direction properly").
