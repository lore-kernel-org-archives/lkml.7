Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE84C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE99B20835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfCRID6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:03:58 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:57726 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfCRID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:03:57 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990398AbfCRIDyrirCY (ORCPT
        <rfc822;linux-arm-msm@vger.kernel.org> + 2 others);
        Mon, 18 Mar 2019 09:03:54 +0100
Date:   Mon, 18 Mar 2019 08:03:54 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        u.kleine-koenig@pengutronix.de, kernel@pengutronix.de,
        slemieux.tyco@gmail.com, andy.gross@linaro.org,
        david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_*
 functions
In-Reply-To: <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
Message-ID: <alpine.LFD.2.21.1903162132540.31531@eddie.linux-mips.org>
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-11-git-send-email-info@metux.net> <20190314225204.GB1795@kroah.com> <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net> <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net> <20190316032630.GB2499@kroah.com> <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019, Enrico Weigelt, metux IT consult wrote:

> > No, it's just that those systems do not allow those devices to be
> > removed because they are probably not on a removable bus.
> 
> Ok, devices (hw) might not be removable - that also the case for uarts
> builtin some SoCs, or the good old PC w/ 8250. But does that also mean
> that the driver should not be removable ?
> 
> IMHO, even if that's the case, it's still inconsistent. The driver then
> shouldn't support a remove at all (or even builtin only), not just
> incomplete remove.

 This device (as well as `dz') is typically used for the serial console as 
well, so being built-in is the usual configuration.  Nevertheless modular 
operation is supposed to be supported, however it may not have been 
verified for ages.

 A further complication is in the virtual console configuration one of the 
serial lines is dedicated for the keyboard, so again you want the driver 
built-in (although hooking up the virtual console keyboard this way has 
been broken with the conversion to the serial core in the 2.6 timeframe 
and I have never figured it out how it is supposed to be done correctly 
with the new serial infrastructure and SERIO_SERPORT; I believe some 
platforms do it with the use of horrible hacks rather than SERIO_SERPORT).

  Maciej
