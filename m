Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9F220863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfCYIup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:50:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49487 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfCYIuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:50:44 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8LJW-0001dy-02; Mon, 25 Mar 2019 09:50:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h8LJV-0005sp-LY; Mon, 25 Mar 2019 09:50:37 +0100
Date:   Mon, 25 Mar 2019 09:50:37 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     thierry.reding@gmail.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Message-ID: <20190325085037.f4weycbhaa7yyurt@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
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

On Mon, Mar 25, 2019 at 09:41:53AM +0100, Uwe Kleine-König wrote:
> If you want to implement further cleanups, my questions and propositions
> are:
> 
>  - Is there a publicly available manual for this hardware? If yes, you
>    can add a link to it in the header of the driver.
> 
>  - Why do you handle reparenting of the PWM's clk in .request? Wouldn't
>    this be more suitable in .apply?
> 
>  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
>    register) freeze the output, or is the currently running period
>    completed first? (The latter is the right behaviour.)
> 
>  - Please point out in the header that for changing period/duty
>    cycle/polarity the hardware must be stopped. (I suggest to apply the
>    style used in https://www.spinics.net/lists/linux-pwm/msg09262.html
>    for some consistency.)

Another thing I just noted: The .get_state callback only sets .enabled
but nothing of the remaining information is provided.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
