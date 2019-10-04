Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A88C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8388215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbfJDQFE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:05:04 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58938 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390027AbfJDQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:05:03 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18726097-1500050 
        for multiple; Fri, 04 Oct 2019 17:04:48 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <157019813720.18712.6286079822254824652@skylake-alporthouse-com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20191004102251.GC823@mwanda>
 <157019813720.18712.6286079822254824652@skylake-alporthouse-com>
Message-ID: <157020508581.18712.9108329337994387428@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i810: Prevent underflow in ioctl
Date:   Fri, 04 Oct 2019 17:04:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wilson (2019-10-04 15:08:57)
> Quoting Dan Carpenter (2019-10-04 11:22:51)
> > The "used" variables here come from the user in the ioctl and it can be
> > negative.  It could result in an out of bounds write.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/gpu/drm/i810/i810_dma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i810/i810_dma.c b/drivers/gpu/drm/i810/i810_dma.c
> > index 2a77823b8e9a..e66c38332df4 100644
> > --- a/drivers/gpu/drm/i810/i810_dma.c
> > +++ b/drivers/gpu/drm/i810/i810_dma.c
> > @@ -728,7 +728,7 @@ static void i810_dma_dispatch_vertex(struct drm_device *dev,
> >         if (nbox > I810_NR_SAREA_CLIPRECTS)
> >                 nbox = I810_NR_SAREA_CLIPRECTS;
> >  
> > -       if (used > 4 * 1024)
> > +       if (used < 0 || used > 4 * 1024)
> >                 used = 0;
> 
> Yes, as passed to the GPU instruction, negative used is invalid.
> 
> Then it is used as an offset into a memblock, where a negative offset
> would be very bad.
> 
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Applied to drm-misc-next with cc'ed stable.
-Chris
