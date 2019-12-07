Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732E2C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACF421835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 11:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfLGLpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 06:45:20 -0500
Received: from gloria.sntech.de ([185.11.138.130]:51044 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLGLpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 06:45:19 -0500
Received: from p57b7764d.dip0.t-ipconnect.de ([87.183.118.77] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1idYWQ-0007Ld-0z; Sat, 07 Dec 2019 12:45:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
Date:   Sat, 07 Dec 2019 12:45:13 +0100
Message-ID: <2344728.Lq3kATiBNL@phil>
In-Reply-To: <CANAwSgT_k5VgtQcP_vOX4Goa-9_B6GmXP+i-hAwpZuTRVTPt_Q@mail.gmail.com>
References: <20191206184536.2507-1-linux.amoon@gmail.com> <1765889.rfqrfT1PbY@phil> <CANAwSgT_k5VgtQcP_vOX4Goa-9_B6GmXP+i-hAwpZuTRVTPt_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 7. Dezember 2019, 06:07:49 CET schrieb Anand Moon:
> Hi Heiko,
> 
> On Sat, 7 Dec 2019 at 04:02, Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > Hi Anand,
> >
> > Am Freitag, 6. Dezember 2019, 19:45:28 CET schrieb Anand Moon:
> > > Most of the RK3399 SBC boards do not perform clean
> > > shutdown and clean reboot.
> > >
> > > These patches try to help resolve the issue with proper
> > > shutdown by turning off the PMIC.
> > >
> > > For reference
> > > RK805 PMCI data sheet:
> > > [0] http://rockchip.fr/RK805%20datasheet%20V1.3.pdf
> > > RK808 PMIC data sheet:
> > > [1] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf
> > > RK817 PMIC data sheet:
> > > [2] http://rockchip.fr/RK817%20datasheet%20V1.01.pdf
> > > RK818 PMIC data sheet:
> > > [3] http://rockchip.fr/RK818%20datasheet%20V1.0.pdf
> > >
> > > Reboot issue:
> > > My guess is that we need to some proper sequence of
> > > setting to PMCI to perform clean.
> > >
> > > If you have any input please share them.
> >
> > The rk8xx pmics may not on all devices be responsible for powering down
> > the device. That is what the system-power-controller dt-property is for.
> >
> > So that property is there for a reason - to indicate that the pmic is
> > responsible for power-off-handling.
> >
> > Heiko
> >
> 
> Ok, my intent was to have common framework for
> shutdown, restart, suspend, resume routines.

That is a great goal actually :-)

I guess just keep in mind that it should only handle power-off
if instructed by the devicetree property.


