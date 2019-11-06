Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0FC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252120659
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfKFJGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:06:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49111 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKFJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:06:47 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iSHH4-0001ZZ-4g; Wed, 06 Nov 2019 10:06:46 +0100
Message-ID: <412b74046c51be6d1228758624b8577453806758.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Free struct reset_control_array in
 reset_control_array_put()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org
Cc:     tomi.valkeinen@ti.com, colin.king@canonical.com, treding@nvidia.com
Date:   Wed, 06 Nov 2019 10:06:45 +0100
In-Reply-To: <7280f9d5-1048-f130-37fd-9a3068f54df7@ti.com>
References: <9c8c5c337a9351a561a4bf18f2faa1e9a01b50e6.1572884515.git.jsarha@ti.com>
         <3a970f3f3518485f58e86f2523e5085f47ec4b15.camel@pengutronix.de>
         <7280f9d5-1048-f130-37fd-9a3068f54df7@ti.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-04 at 21:03 +0200, Jyri Sarha wrote:
> On 04/11/2019 18:30, Philipp Zabel wrote:
> > Hi Jyri,
> > 
> > On Mon, 2019-11-04 at 18:24 +0200, Jyri Sarha wrote:
> > > Fix memory leak in devm_reset_control_array_get(). Free also the
> > > struct reset_control_array pointer in reset_control_array_put() not
> > > only the reset-controls stored in it.
> > > 
> > > Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > Signed-off-by: Jyri Sarha <jsarha@ti.com>
> > > ---
> > >  drivers/reset/core.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > index 213ff40dda11..85d9676ee969 100644
> > > --- a/drivers/reset/core.c
> > > +++ b/drivers/reset/core.c
> > > @@ -748,6 +748,8 @@ static void reset_control_array_put(struct reset_control_array *resets)
> > >  	for (i = 0; i < resets->num_rstcs; i++)
> > >  		__reset_control_put_internal(resets->rstc[i]);
> > >  	mutex_unlock(&reset_list_mutex);
> > > +
> > > +	kfree(resets);
> > >  }
> > >  
> > >  /**
> > 
> > Thank you, this just got fixed in 532f9cd6ee99 ("reset: Fix memory leak
> > in reset_control_array_put()").
> > 
> 
> Ok, sorry. I just checked the mainline, not the mailing lists etc.

No worries, that's perfectly fine. Just letting you know why this patch
isn't picked up.

regards
Philipp

