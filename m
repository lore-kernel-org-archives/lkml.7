Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21985C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E6620863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfCYIsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:48:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52237 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbfCYIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:48:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8LHL-000192-E7; Mon, 25 Mar 2019 09:48:23 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8LHK-0005lS-Pm; Mon, 25 Mar 2019 09:48:22 +0100
Date:   Mon, 25 Mar 2019 09:48:22 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     thierry.reding@gmail.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: meson: use the spin-lock only to protect
 register modifications
Message-ID: <20190325084822.ozixel6bzi6xiw67@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190324220217.15813-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190324220217.15813-2-martin.blumenstingl@googlemail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Mar 24, 2019 at 11:02:17PM +0100, Martin Blumenstingl wrote:
> Holding the spin-lock for all of the code in meson_pwm_apply() can
> result in a "BUG: scheduling while atomic". This can happen because
> clk_get_rate() (which is called from meson_pwm_calc()) may sleep.
> Only hold the spin-lock when modifying registers to solve this.
> 
> The reason why we need a spin-lock in the driver is because the
> REG_MISC_AB register is shared between the two channels provided by one
> PWM controller. The only functions where REG_MISC_AB is modified are
> meson_pwm_enable() and meson_pwm_disable() so the register reads/writes
> in there need to be protected by the spin-lock.
> 
> The original code also used the spin-lock to protect the values in
> struct meson_pwm_channel. This could be necessary if two consumers can
> use the same PWM channel. However, PWM core doesn't allow this so we
> don't need to protect the values in struct meson_pwm_channel with a
> lock.
> 
> Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Looks right.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Bonus points for adding a comment to struct meson_pwm::lock. Something
like:

	/*
	 * Protects register access to the MISC_AB register that is
	 * shared between the two PWMs.
	 */

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
