Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97B9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEB62133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCSIJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:09:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59775 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSIJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:09:57 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h69ok-00082l-Ul; Tue, 19 Mar 2019 09:09:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1h69ok-0006Ko-A2; Tue, 19 Mar 2019 09:09:50 +0100
Date:   Tue, 19 Mar 2019 09:09:50 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, kernel@pengutronix.de
Subject: Re: [PATCH v10 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Message-ID: <20190319080950.4nsgzvkz5iwbkb24@pengutronix.de>
References: <1552909634-18757-1-git-send-email-yash.shah@sifive.com>
 <1552909634-18757-3-git-send-email-yash.shah@sifive.com>
 <20190318214640.ob2ldr3tpn2vsfkl@pengutronix.de>
 <CAJ2_jOHqGBB=eej6KkdspTNiCU_uJ8deHN3O=BQmyu=GtrTT7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2_jOHqGBB=eej6KkdspTNiCU_uJ8deHN3O=BQmyu=GtrTT7w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:52:12PM +0530, Yash Shah wrote:
> On Tue, Mar 19, 2019 at 3:16 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 18, 2019 at 05:17:14PM +0530, Yash Shah wrote:
> > > +     val = PWM_SIFIVE_PWMCFG_EN_ALWAYS |
> > > +           FIELD_PREP(PWM_SIFIVE_PWMCFG_SCALE, scale);
> > > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> >
> > Starting with this write the new period length might be active with the
> > previous duty cycle. Is this worth a comment? I think the window where
> > this can actually happen should be made as small as possible, so it
> > would be great to first calculate both register values and then write
> > them in two consecutive writels.
> 
> The comment for this scenario has already been mentioned under the
> limitation on top of this driver.
> Anyway, I will try to implement your suggestion of consecutive writes

Yeah, the comment at the top is for general information about the
shortcomings. The comment here would be to say: The problem occurs *here*.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
