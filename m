Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C555921900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCUX3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:29:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47407 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCUX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:29:29 -0400
Received: from 79.184.255.210.ipv4.supernova.orange.pl (79.184.255.210) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 73b0d81de9614e38; Fri, 22 Mar 2019 00:29:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jiada Wang <jiada_wang@mentor.com>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1] PM / Domains: Avoid a potential deadlock
Date:   Fri, 22 Mar 2019 00:27:33 +0100
Message-ID: <14940273.hSlFUEJerr@aspire.rjw.lan>
In-Reply-To: <CAPDyKFodmgkpLkJDiMqh3vm+Ynuo852biZkY7uB5sm9UeAJ63A@mail.gmail.com>
References: <20190312065128.24994-1-jiada_wang@mentor.com> <CAPDyKFodmgkpLkJDiMqh3vm+Ynuo852biZkY7uB5sm9UeAJ63A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 13, 2019 8:35:02 AM CET Ulf Hansson wrote:
> On Tue, 12 Mar 2019 at 07:51, Jiada Wang <jiada_wang@mentor.com> wrote:
> >
> > Lockdep warns that prepare_lock and genpd->mlock can cause a deadlock
> > the deadlock scenario is like following:
> > First thread is probing cs2000
> > cs2000_probe()
> >   clk_register()
> >     __clk_core_init()
> >       clk_prepare_lock()                            ----> acquires prepare_lock
> >         cs2000_recalc_rate()
> >           i2c_smbus_read_byte_data()
> >             rcar_i2c_master_xfer()
> >               dma_request_chan()
> >                 rcar_dmac_of_xlate()
> >                   rcar_dmac_alloc_chan_resources()
> >                     pm_runtime_get_sync()
> >                       __pm_runtime_resume()
> >                         rpm_resume()
> >                           rpm_callback()
> >                             genpd_runtime_resume()   ----> acquires genpd->mlock
> >
> > Second thread is attaching any device to the same PM domain
> > genpd_add_device()
> >   genpd_lock()                                       ----> acquires genpd->mlock
> >     cpg_mssr_attach_dev()
> >       of_clk_get_from_provider()
> >         __of_clk_get_from_provider()
> >           __clk_create_clk()
> >             clk_prepare_lock()                       ----> acquires prepare_lock
> >
> > Since currently no PM provider access genpd's critical section
> > in .attach_dev, and .detach_dev callbacks, so there is no need to protect
> > these two callbacks with genpd->mlock.
> > This patch avoids a potential deadlock by moving out .attach_dev and .detach_dev
> > from genpd->mlock, so that genpd->mlock won't be held when prepare_lock is acquired
> > in .attach_dev and .detach_dev
> 
> Thanks for the detailed description, this seems like a reasonable change to me!
> 
> >
> > Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied, thanks!

