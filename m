Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72735C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4001821873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCUIoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:44:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:42319 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfCUIoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:44:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 01:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,252,1549958400"; 
   d="scan'208";a="330608052"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 21 Mar 2019 01:44:21 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Mar 2019 10:44:20 +0200
Date:   Thu, 21 Mar 2019 10:44:20 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     zhuchangchun <zhuchangchun@cvte.com>
Cc:     andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hendychu@aliyun.com
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
Message-ID: <20190321084420.GG3622@lahna.fi.intel.com>
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:35:24AM +0800, zhuchangchun wrote:
> When we use the gpio to control some peripheral devices,and try to
> export the gpio first,then unexport the gpio, we test the signal with
> oscilloscope,and find the signal can't meet the requirements,because
> after we unexported the gpio,the gpio's register(tx and rx)value can't
> be recovered,and this will infruence the device work flow.

After you unexport GPIO it can go back to any previous mode it was. If
you need to use it as GPIO then why unexport it in the first place?

> We check the gpio's unexport code work flow, then find the gpio's free
> hook function has not been implemented, After we add pinmux_ops' free
> function to set exported gpio to recover its original value,the problem
> is fixed.

I don't think this is what ->free callback should do (assuming we decide
to implement it since we don't implement ->release either). It is
supposed to reverse effects of ->request which is what it currently does ;-)
