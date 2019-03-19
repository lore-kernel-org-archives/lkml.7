Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699D120700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfCSQiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:38:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37911 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfCSQh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:37:59 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h6HkR-00068R-LN; Tue, 19 Mar 2019 17:37:55 +0100
Message-ID: <1553013474.6482.5.camel@pengutronix.de>
Subject: Re: [PATCH 1/5] reset: add acquired/released state for exclusive
 reset controls
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 17:37:54 +0100
In-Reply-To: <20190221152858.GA8652@ulmo>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
         <20190221152858.GA8652@ulmo>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Thu, 2019-02-21 at 16:28 +0100, Thierry Reding wrote:
> On Thu, Feb 21, 2019 at 04:25:53PM +0100, Thierry Reding wrote:
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > There are cases where a driver needs explicit control over a reset line
> > that is exclusively conneted to its device, but this control has to be
> > temporarily handed over to the power domain controller to handle reset
> > requirements during power transitions.
> > Allow multiple exclusive reset controls to be requested in 'released'
> > state for the same physical reset line, only one of which can be
> > acquired at the same time.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/reset/core.c  | 139 ++++++++++++++++++++++++++++++++++++++----
> >  include/linux/reset.h |  93 ++++++++++++++++++++++------
> >  2 files changed, 200 insertions(+), 32 deletions(-)
> 
> Hi Philipp,
> 
> the bulk of this is unchanged relative to what you had posted
> originally. I squashed in the few things that we had already discussed
> earlier (EINVAL -> EPERM) and a couple of minor fixes for issues that I
> found while working with this.
> 
> Attached is my fixup patch which contains all the changes I made on top
> of your version and that I squashed into this.

I have no further comments on this, I find all these changes either
necessary or useful.

regards
Philipp
