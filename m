Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D2B217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfCNQMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:12:38 -0400
Received: from muru.com ([72.249.23.125]:41870 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbfCNQMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:12:37 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 558FB80FB;
        Thu, 14 Mar 2019 16:12:49 +0000 (UTC)
Date:   Thu, 14 Mar 2019 09:12:33 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mpfj@newflow.co.uk" <mpfj@newflow.co.uk>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: am335x: Replaced register offsets with
 defines
Message-ID: <20190314161233.GD19425@atomide.com>
References: <20190313142724.27446-1-cquast@hanoverdisplays.com>
 <20190313142724.27446-3-cquast@hanoverdisplays.com>
 <20190314150524.GB19425@atomide.com>
 <4FA4A861EC9F6744BE8446EF2CDFAFE11FF8885D@mail.hanover.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FA4A861EC9F6744BE8446EF2CDFAFE11FF8885D@mail.hanover.local>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christina Quast <cquast@hanoverdisplays.com> [190314 16:03]:
> On 14/03/2019 16:05, Tony Lindgren wrote:
> > * Christina Quast <cquast@hanoverdisplays.com> [190313 14:28]:
> >> The defines are taken from dt-bindings/pinctrl/am335x.h
> >>
> >> Updated AM33XX_IOPAD to take three instead of two parameters:
> >> AM33XX_IOPAD(register_offset, pin_direction_pullups, mux_mode)
> > Thanks that works great for making things work eventually
> > with #pinctrl-cells = <2> :)
> >
> >> +			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)      /* uart1_rxd */
> >> +			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)      /* uart1_txd *
> > Since it sounds like you're modifying these with a script,
> Who would do such a change by hand, anyways? That's too error-prone!

Right :)

> > just leave out any nop comments while at it where the comment
> > is just the pad name already there in the new register
> > define. Some comments might need to be preserved, but my
> > guess is that they're mostly just the pad name.
> >
> > And I suggest you split this change to a seprate patch
> > for each board so in case of trouble we can revert the
> > changes for a single board if needed.
> Is it really useful to have a change per board? Once the AM33XX_IOPAD
> macro is changed and takes 3 arguments instead of 2, the old boards will
> not compile anymore anyways.

That's a good point. How about use some different name for
the new macro? Something like AM33XX_PADCONF maybe?

Note that there is a huge number of out-of-tree board specific
dts files for various devices. So let's also keep the old
macro for now. We could make produce a warning, then we can
drop it later on few merge cycles later.

Regards,

Tony
