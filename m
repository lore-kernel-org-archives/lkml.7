Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4953C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE2528154
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfFCLke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:40:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:57686 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfFCLkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:40:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 04:40:32 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Jun 2019 04:40:29 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 03 Jun 2019 14:40:29 +0300
Date:   Mon, 3 Jun 2019 14:40:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable
 'pwm'
Message-ID: <20190603114029.GC2781@lahna.fi.intel.com>
References: <20190601035709.85379-1-yuehaibing@huawei.com>
 <CAGngYiXZM0QUdKE_zDK763J9iDuiKSbmFeTVA1PJ_4WvjntjQQ@mail.gmail.com>
 <20190601160459.baedo5pp5hsrltzs@pengutronix.de>
 <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGngYiUfGGF+PwaT4SE2ZJkrCidc7-QWeuRsPTDwrLL1onm88w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 10:18:15AM -0400, Sven Van Asbroeck wrote:
> On Sat, Jun 1, 2019 at 12:05 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > I didn't look into the driver to try to understand that, but the
> > definitely needs a comment to explain for the next person to think they
> > can do a cleanup here.
> 
> Certainly.

I agree.

> But if we do restore the old behaviour, there may still be problems.
> I'm unsure if the old synchronization was working correctly.
> See the example at the end of this email.

I think you are right. pca9685_pwm_request() should take the mutex as
long as it is requesting PWM.

> An intuitive way forward would be to use a simple bitfield in
> struct pca9685 to track if a specific pwm is in use by either
> pwm or gpio. Protected by a mutex.

A flag would probably be easier to understand than the magic we have
now. Or then wrap it inside function with an explanation comment:

static inline void pca9685_pwm_set_as_gpio(struct pwm_device *pwm)
{
	/*
	 * We use ->chip_data to convoy the fact that the PWM channel is
	 * being used as GPIO instead of PWM.
	 */
	pwm_set_chip_data(pwm, (void *)1)
}

static inline void pca9685_pwm_set_as_pwm(struct pwm_device *pwm)
{
	pwm_set_chip_data(pwm, NULL);
}
