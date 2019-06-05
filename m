Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D20C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32347206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFEMyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:54:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:37538 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfFEMyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:54:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 05:54:00 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Jun 2019 05:53:57 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Jun 2019 15:53:56 +0300
Date:   Wed, 5 Jun 2019 15:53:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] pwm: pca9685: fix pwm/gpio inter-operation
Message-ID: <20190605125356.GI2781@lahna.fi.intel.com>
References: <20190604181345.9107-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604181345.9107-1-TheSven73@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 02:13:45PM -0400, Sven Van Asbroeck wrote:
> This driver allows pwms to be requested as gpios via gpiolib.
> Obviously, it should not be allowed to request a gpio when its
> corresponding pwm is already requested (and vice versa).
> So it requires some exclusion code.
> 
> Given that the pwm and gpio cores are not synchronized with
> respect to each other, this exclusion code will also require
> proper synchronization.
> 
> Such a mechanism was in place, but was inadvertently removed
> by Uwe's clean-up patch.
> 
> Upon revisiting the synchronization mechanism, we found that
> theoretically, it could allow two threads to successfully
> request conflicting pwms / gpios.
> 
> Replace with a bitmap which tracks pwm in-use, plus a mutex.
> As long as pwm and gpio's respective request/free functions
> modify the in-use bitmap while holding the mutex, proper
> synchronization will be guaranteed.
> 
> Reported-by: YueHaibing <yuehaibing@huawei.com>
> Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
