Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCCBC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C77620659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFPrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:47:23 -0500
Received: from muru.com ([72.249.23.125]:44212 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfLFPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:47:23 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D0E148047;
        Fri,  6 Dec 2019 15:48:00 +0000 (UTC)
Date:   Fri, 6 Dec 2019 07:47:19 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 073/321] bus: ti-sysc: Check for no-reset and
 no-idle flags at the child level
Message-ID: <20191206154719.GD35479@atomide.com>
References: <20191203223427.103571230@linuxfoundation.org>
 <20191203223430.961774111@linuxfoundation.org>
 <20191204130007.GB25176@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204130007.GB25176@duo.ucw.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@denx.de> [191204 13:00]:
> On Tue 2019-12-03 23:32:19, Greg Kroah-Hartman wrote:
> > From: Tony Lindgren <tony@atomide.com>
> > 
> > [ Upstream commit 4014c08ba39476a18af546186da625a6833a1529 ]
> > 
> > With ti-sysc, we need to now have the device tree properties for
> > ti,no-reset-on-init and ti,no-idle-on-init at the module level instead
> > of the child device level.
> > 
> > Let's check for these properties at the child device level to enable
> > quirks, and warn about moving the properties to the module level.
> > 
> > Otherwise am335x-evm based boards tagging gpio1 with ti,no-reset-on-init
> > will have their DDR power disabled if wired up in such a tricky way.
> > 
> > Note that this should not be an issue for earlier kernels as we don't
> > rely on this until the dts files have been updated to probe with ti-sysc
> > interconnect target driver.
> 
> This is queued for 4.19-stable, but the comment seems to say it is not
> needed in the older kernels.
> 
> Tony, do we want this in 4.19?

Correct, it should not be needed as the related devicetree are
not in earlier kernels and I doubt anybody is going to use a newer
devicetree with v4.19.

I guess one usecase could be to enable more of the accelerators
for v4.19, but that work is still ongoing in the mainline
kernel and would require quite a bit backporting with the reset
and clock driver changes.

So yeah this one can be dropped for earlier kernels.

Regards,

Tony

