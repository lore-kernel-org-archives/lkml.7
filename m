Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA069C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24AA2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfDLMjn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:39:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39918 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfDLMjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:39:41 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEvSw-0005aO-ET; Fri, 12 Apr 2019 14:39:34 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph =?ISO-8859-1?Q?M=FCllner?= 
        <christoph.muellner@theobroma-systems.com>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v1 1/6] clk: rockchip: Add supprot to limit input rate for fractional divider
Date:   Fri, 12 Apr 2019 14:39:33 +0200
Message-ID: <2068630.7I2iUbhqZj@diego>
In-Reply-To: <0e47770b-fa20-74f9-8548-c07aebdcaa53@theobroma-systems.com>
References: <1554284549-24916-1-git-send-email-zhangqing@rock-chips.com> <3395739.hcHkC3K37q@diego> <0e47770b-fa20-74f9-8548-c07aebdcaa53@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. April 2019, 14:32:08 CEST schrieb Christoph Müllner:
> 
> On 12.04.19 14:21, Heiko Stübner wrote:
> > Hi Christoph,
> > 
> > Am Freitag, 12. April 2019, 14:12:52 CEST schrieb Christoph Müllner:
> >> On 12.04.19 13:52, Heiko Stübner wrote:
> >>> Am Mittwoch, 3. April 2019, 11:42:24 CEST schrieb Elaine Zhang:
> >>>> From: Finley Xiao <finley.xiao@rock-chips.com>
> >>>>
> >>>> From Rockchips fractional divider usage, some clocks can be generated
> >>>> by fractional divider, but the input clock frequency of fractional
> >>>> divider should be less than a specified value.
> >>>>
> >>>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> >>>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >>>
> >>> can you tell me where these maximum input values come from?
> >>>
> >>> I talked to Christoph from Theobroma (Cc'ed) last week and he mentioned
> >>> that they're using the fractional divider with a higher input frequency
> >>> to create a very specific frequency [some details are gone from my memory
> >>> though] they can't get otherwise.
> >>>
> >>> So I really don't want to break their working setup by introducing barriers
> >>> that are not strictly necessary.
> >>>
> >>> @Christoph: can you describe the bits from your fractional setup that
> >>> I've forgotten please?
> >>
> >> We need to set the I2S0 clock to 24.56 MHz.
> >>
> >> When restricting the input frequency to a maximum of 600 Mhz,
> >> we could use the integer divider to get 400 Mhz (dividing by 2).
> >> However, with the 400 Mhz as input to the frac divider,
> >> we run into the problem, that the maximum possible output frequency
> >> is 20 MHz (there is another restriction which states that the
> >> fraction input : output frequency must be >= 20).
> > 
> > just for clarification, what is the current input frequency you
> > already use sucessfully?
> 
> Our working setup uses the integer divider to reduce to 400 MHz
> and uses the frac divider to get something near 24.56 MHz.
> I have to admit I have never measured what's on the clock line.

Ah ok, so the 600MHz input maximum is ok for your setup and the "< 20"
ratio is the question. I thought I remembered you using a higher than
600MHz input rate. [bad memory on my side]



