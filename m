Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415DB218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfCUN5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:57:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:40074 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfCUN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:57:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 06:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="284630377"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 21 Mar 2019 06:56:43 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Mar 2019 15:56:42 +0200
Date:   Thu, 21 Mar 2019 15:56:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "zhuchangchun@cvte.com" <zhuchangchun@cvte.com>
Cc:     "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        hendychu <hendychu@aliyun.com>
Subject: Re: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190321135642.GK3622@lahna.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <2019032119195575582546@cvte.com>
 <20190321120324.GI3622@lahna.fi.intel.com>
 <2019032120213955866649@cvte.com>
 <20190321123637.GJ3622@lahna.fi.intel.com>
 <2019032121342663125658@cvte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019032121342663125658@cvte.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:35:26PM +0800, zhuchangchun@cvte.com wrote:
>    --> I know your meaning, even though I've did following actions
>    instead of unexport,
> 
>    # echo 0 > /sys/class/gpio/gpioXX/value
>      # echo in > /sys/class/gpio/gpioXX/direction
> 
>    the padcfg0 value still can not roll back,because after export the
>    gpio,the following
> 
>    action as padcfg0 settings was done.
> 
>    Exactly  TX and RX register have been set as below in GPIO request:
> 
>    /* Disable TX buffer and enable RX (this will be input) */
> 
>    value &= ~PADCFG0_GPIORXDIS;
> 
>    value |= PADCFG0_GPIOTXDIS;
> 
>    this will infruence next reboot gpio signal.
> 
>    And could you pls see my ->free function implementation?

I checked it and you do this:

+       value |= PADCFG0_GPIORXDIS;
+       value &= ~PADCFG0_GPIOTXDIS;

which pretty much turns the pin GPIO output unconditionally. I don't
really think it is good idea. May work in your case but may cause
problems with others.

If you want to keep it as output and leave the value 1 (high) before you
issue reboot, I don't think you need to do anything via sysfs (as the
pin is already in that state and issuing reboot command should not
change anything because the driver does not have ->shutdown callback.

In other words, your peripheral expects reset GPIO to be asserted (high)
during reboot so unless the boot firmware resets the pin I don't see why
leaving it as is does not work for you.
