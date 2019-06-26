Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EACC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38582063F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfFZO41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:56:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42492 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:56:26 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id ABF5F807C0; Wed, 26 Jun 2019 16:56:13 +0200 (CEST)
Date:   Wed, 26 Jun 2019 16:56:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
Message-ID: <20190626145617.GB22348@xo-6d-61-c0.localdomain>
References: <20190624203114.93277-1-mka@chromium.org>
 <20190624203114.93277-5-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624203114.93277-5-mka@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-06-24 13:31:13, Matthias Kaehlcke wrote:
> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.

I don't think this works. Some hardware does takes brightness in perceptual units,
converting it in the LED controller.

									Pavel
