Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9777BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 19:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7914A218AE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfIHTow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 15:44:52 -0400
Received: from muru.com ([72.249.23.125]:60324 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfIHTow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 15:44:52 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 824B5809B;
        Sun,  8 Sep 2019 19:45:21 +0000 (UTC)
Date:   Sun, 8 Sep 2019 12:44:48 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Lechner <david@lechnology.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/6] bus/ti-pwmss: move TI PWMSS driver from PWM to
 bus subsystem
Message-ID: <20190908194447.GM52127@atomide.com>
References: <20190901225827.12301-1-david@lechnology.com>
 <20190901225827.12301-2-david@lechnology.com>
 <20190902150245.GE1445@ulmo>
 <20190908121524.49b4874d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908121524.49b4874d@archlinux>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonathan Cameron <jic23@jic23.retrosnub.co.uk> [190908 11:16]:
> On Mon, 2 Sep 2019 17:02:45 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
> > On Sun, Sep 01, 2019 at 05:58:22PM -0500, David Lechner wrote:
> > > The TI PWMSS driver is a simple bus driver for providing power
> > > power management for the PWM peripherals on TI AM33xx SoCs, namely
> > > eCAP, eHRPWM and eQEP. The eQEP is a counter rather than a PWM, so
> > > it does not make sense to have the bus driver in the PWM subsystem
> > > since the PWMSS is not exclusive to PWM devices.
> > > 
> > > Signed-off-by: David Lechner <david@lechnology.com>
> > > ---
> > > 
> > > v3 changes:
> > > - none
> > > v2 changes:
> > > - new patch
> > > 
> > >  drivers/bus/Kconfig                           | 9 +++++++++
> > >  drivers/bus/Makefile                          | 1 +
> > >  drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} | 0
> > >  drivers/pwm/Kconfig                           | 9 ---------
> > >  drivers/pwm/Makefile                          | 1 -
> > >  5 files changed, 10 insertions(+), 10 deletions(-)
> > >  rename drivers/{pwm/pwm-tipwmss.c => bus/ti-pwmss.c} (100%)  
> > 
> > Acked-by: Thierry Reding <thierry.reding@gmail.com>
> 
> Do we need an immutable branch for these precursor patches to the
> driver addition? It's not going to make 5.4 via my tree as cutting it
> too fine so we'll be in the position of holding these in a non obvious
> tree for a whole cycle. 

Sure an immutable branch would be nice in case of unlikely
dts file conflicts. And yeah no need to try to rush to v5.4.

Regards,

Tony
