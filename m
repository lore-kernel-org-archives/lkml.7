Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88B5218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfCUMgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:36:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:5150 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfCUMgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:36:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 05:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="154408577"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga004.fm.intel.com with SMTP; 21 Mar 2019 05:36:37 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Mar 2019 14:36:37 +0200
Date:   Thu, 21 Mar 2019 14:36:37 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "zhuchangchun@cvte.com" <zhuchangchun@cvte.com>
Cc:     "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        hendychu <hendychu@aliyun.com>
Subject: Re: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190321123637.GJ3622@lahna.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <2019032119195575582546@cvte.com>
 <20190321120324.GI3622@lahna.fi.intel.com>
 <2019032120213955866649@cvte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019032120213955866649@cvte.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:22:40PM +0800, zhuchangchun@cvte.com wrote:
>    On Thu, Mar 21, 2019 at 07:20:56PM +0800, zhuchangchun@cvte.com wrote:
>    >    After you unexport GPIO it can go back to any previous mode it
>    was. If
>    >    you need to use it as GPIO then why unexport it in the first
>    place?
>    >    --> because we need use the GPIO for device reset, we want to
>    recover
>    >    the GPIO value after reset done.If we don't unexport it, then
>    reboot
>    >    the
>    >    intel SOC(not power off), the GPIO's value will stay until the
>    GPIO be
>    >    reinit.
>    >    I tested the GPIO signal with oscilloscope, if  power off the SOC,
>    >    then
>    >    power on, the GPIO value can recover its original value. This will
>    >    infruence
>    >    the peripheral device working condition.
> 
>    If I understand correctly you have some peripheral connected to Intel
>    based board and one GPIO is used to reset the peripheral.
> 
>    You say it works fine if you power cycle the board but it does not when
>    you issue 'reboot' command. Did I understood the problem correctly?
> 
>    --> Yes ,  so I add the -> free callback, it fixes the problem.

OK, so you then write 1 to the sysfs to assert reset, right? And in your
patch you change the mode to input effectively deasserting the reset.

Why not simply do following instead of unexport?

  # echo 0 > /sys/class/gpio/gpioXX/value

or even

  # echo 0 > /sys/class/gpio/gpioXX/value
  # echo in > /sys/class/gpio/gpioXX/direction

Am I missing something?
