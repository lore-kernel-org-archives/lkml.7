Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30755C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084E220811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCNPF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:05:28 -0400
Received: from muru.com ([72.249.23.125]:41830 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfCNPF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:05:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8500680FB;
        Thu, 14 Mar 2019 15:05:40 +0000 (UTC)
Date:   Thu, 14 Mar 2019 08:05:24 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Christina Quast <cquast@hanoverdisplays.com>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mpfj@newflow.co.uk, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: am335x: Replaced register offsets with
 defines
Message-ID: <20190314150524.GB19425@atomide.com>
References: <20190313142724.27446-1-cquast@hanoverdisplays.com>
 <20190313142724.27446-3-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313142724.27446-3-cquast@hanoverdisplays.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christina Quast <cquast@hanoverdisplays.com> [190313 14:28]:
> The defines are taken from dt-bindings/pinctrl/am335x.h
> 
> Updated AM33XX_IOPAD to take three instead of two parameters:
> AM33XX_IOPAD(register_offset, pin_direction_pullups, mux_mode)

Thanks that works great for making things work eventually
with #pinctrl-cells = <2> :)

> +			AM33XX_IOPAD(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)      /* uart1_rxd */
> +			AM33XX_IOPAD(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)      /* uart1_txd *

Since it sounds like you're modifying these with a script,
just leave out any nop comments while at it where the comment
is just the pad name already there in the new register
define. Some comments might need to be preserved, but my
guess is that they're mostly just the pad name.

And I suggest you split this change to a seprate patch
for each board so in case of trouble we can revert the
changes for a single board if needed.

Regards,

Tony
