Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A862E21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 12:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfCUMD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 08:03:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:57936 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCUMD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 08:03:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 05:03:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="330650420"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 21 Mar 2019 05:03:24 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Mar 2019 14:03:24 +0200
Date:   Thu, 21 Mar 2019 14:03:24 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "zhuchangchun@cvte.com" <zhuchangchun@cvte.com>
Cc:     "andriy.shevchenko" <andriy.shevchenko@linux.intel.com>,
        "linus.walleij" <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        hendychu <hendychu@aliyun.com>
Subject: Re: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190321120324.GI3622@lahna.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com>
 <2019032119195575582546@cvte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019032119195575582546@cvte.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:20:56PM +0800, zhuchangchun@cvte.com wrote:
>    After you unexport GPIO it can go back to any previous mode it was. If
>    you need to use it as GPIO then why unexport it in the first place?
>    --> because we need use the GPIO for device reset, we want to recover
>    the GPIO value after reset done.If we don't unexport it, then reboot
>    the
>    intel SOC(not power off), the GPIO's value will stay until the GPIO be
>    reinit.
>    I tested the GPIO signal with oscilloscope, if  power off the SOC,
>    then
>    power on, the GPIO value can recover its original value. This will
>    infruence
>    the peripheral device working condition.

If I understand correctly you have some peripheral connected to Intel
based board and one GPIO is used to reset the peripheral.

You say it works fine if you power cycle the board but it does not when
you issue 'reboot' command. Did I understood the problem correctly?
