Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E23C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CF42184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCTKiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:38:13 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:50109 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCTKiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:38:12 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 16496C0013;
        Wed, 20 Mar 2019 10:38:08 +0000 (UTC)
Date:   Wed, 20 Mar 2019 11:38:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] rtc: cros-ec: Fail suspend/resume if wake IRQ can't be
 configured
Message-ID: <20190320103805.GN29054@piout.net>
References: <20190315185112.97699-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315185112.97699-1-swboyd@chromium.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2019 11:51:12-0700, Stephen Boyd wrote:
> If we encounter a failure during suspend where this RTC was programmed
> to wakeup the system from suspend, but that wakeup couldn't be
> configured because the system didn't support wakeup interrupts, we'll
> run into the following warning:
> 
> 	Unbalanced IRQ 166 wake disable
> 	WARNING: CPU: 7 PID: 3071 at kernel/irq/manage.c:669 irq_set_irq_wake+0x108/0x278
> 
> This happens because the suspend process isn't aborted when the RTC
> fails to configure the wakeup IRQ. Instead, we continue suspending the
> system and then another suspend callback fails the suspend process and
> "unwinds" the previously suspended drivers by calling their resume
> callbacks. When we get back to resuming this RTC driver, we'll call
> disable_irq_wake() on an IRQ that hasn't been configured for wake.
> 
> Let's just fail suspend/resume here if we can't configure the system to
> wake and the user has chosen to wakeup with this device. This fixes this
> warning and makes the code more robust in case there are systems out
> there that can't wakeup from suspend on this line but the user has
> chosen to do so.
> 
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/rtc/rtc-cros-ec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
