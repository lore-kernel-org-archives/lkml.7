Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94AEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994B620883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDHMvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:51:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:14706 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHMva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:51:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 05:51:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="138484312"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 08 Apr 2019 05:51:27 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Apr 2019 15:51:26 +0300
Date:   Mon, 8 Apr 2019 15:51:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Binbin Wu <binbin.wu@intel.com>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] pinctrl: pinctrl-intel: move gpio suspend/resume to
 noirq phase
Message-ID: <20190408125126.GR3622@lahna.fi.intel.com>
References: <1554720566-29103-1-git-send-email-binbin.wu@intel.com>
 <20190408124348.GQ9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408124348.GQ9224@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 03:43:48PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 08, 2019 at 06:49:26PM +0800, Binbin Wu wrote:
> > In current driver, SET_LATE_SYSTEM_SLEEP_PM_OPS is used to install the
> > callbacks for suspend/resume.
> > GPIO pin may be used as the interrupt pin by some device. However, using
> > SET_LATE_SYSTEM_SLEEP_PM_OPS() to install the callbacks, the resume
> > callback is called after resume_device_irqs(). Unintended interrupts may
> > arrive due to resuming device irqs first, but the GPIO controller is not
> > properly restored.
> > 
> > Normally, for a SMP system, there are multiple cores, so even when there are
> > unintended interrupts, BSP gets the chance to init the gpio chip soon.
> 
> gpio -> GPIO.
> (If Mika is okay with patch content, I may fix this when applying)

Yup, this looks good to me.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
