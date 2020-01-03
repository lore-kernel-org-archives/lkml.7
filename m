Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB58C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637C921835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="IpzbyTAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgACIQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:16:08 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:46728 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgACIQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:16:08 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47pyQs3YPrz7s;
        Fri,  3 Jan 2020 09:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578039365; bh=24INBJn6/AhdszYZsAgIJQtalmEEUe8z6ScniBZ7g6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IpzbyTANCkZ9yF3r2s21R+38rXuz/WzxXFi3gE68qjHjylRxDulDxKMUVgt1W+vyW
         IXf1htwIZwg7L2B8zXpgn0oU81qtcPmKiNo6mZB4BXKlftyhxN4cj7dCtbB+XkaCZl
         Ewk4JVc/4US1fof5N4JK5Zu6P9WXqBzTLybCcZSf1zb2CtOU6FThLhbnha3h+B4cx8
         L7R9FrY1nJyXlR+GY9ohLUmxc4n/675ALzwcG57UL6geD7gyjMKLZasP1mCJzaacOG
         VWwccLIp/MqwJS4X52LFDXRTjvA/c9VRnuZRCycOOVhsKFPusHaEEjbdy6NCK5FAE0
         L/cfAylESAZ/A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 3 Jan 2020 09:16:04 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/7] dmaengine: tegra-apb: Prevent race conditions on
 channel's freeing
Message-ID: <20200103081604.GD14228@qmqm.qmqm.pl>
References: <20191228204640.25163-1-digetx@gmail.com>
 <20191228204640.25163-4-digetx@gmail.com>
 <20191230204555.GB24135@qmqm.qmqm.pl>
 <20191230205054.GC24135@qmqm.qmqm.pl>
 <4e1e4fef-f75c-f2e2-4d9e-29af69daf8db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e1e4fef-f75c-f2e2-4d9e-29af69daf8db@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 06:09:45PM +0300, Dmitry Osipenko wrote:
> 30.12.2019 23:50, Michał Mirosław пишет:
> > On Mon, Dec 30, 2019 at 09:45:55PM +0100, Michał Mirosław wrote:
> >> On Sat, Dec 28, 2019 at 11:46:36PM +0300, Dmitry Osipenko wrote:
> >>> It's unsafe to check the channel's "busy" state without taking a lock,
> >>> it is also unsafe to assume that tasklet isn't in-fly.
> >>
> >> 'in-flight'. Also, the patch seems to have two independent bug-fixes
> >> in it. Second one doesn't look right, at least not without an explanation.
> >>
> >> First:
> >>
> >>> -	if (tdc->busy)
> >>> -		tegra_dma_terminate_all(dc);
> >>> +	tegra_dma_terminate_all(dc);
> >>
> >> Second:
> >>
> >>> +	tasklet_kill(&tdc->tasklet);
> > 
> > BTW, maybe you can convert the code to threaded interrupt handler and
> > just get rid of the tasklet instead of fixing it?
> 
> This shouldn't bring much benefit because the the code's logic won't be
> changed since we will still have to use the threaded ISR part as the
> bottom-half and then IRQ API doesn't provide a nice way to synchronize
> interrupt's execution, while tasklet_kill() is a nice way to sync it.

What about synchronize_irq()?

BTW, does tegra_dma_terminate_all() prevent further interrupts that might
cause the tasklet to be scheduled again?

Best Regards,
Michał Mirosław
