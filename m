Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F3C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB020B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 08:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405865AbfHIIHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 04:07:54 -0400
Received: from verein.lst.de ([213.95.11.211]:53274 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405690AbfHIIHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 04:07:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6221768AFE; Fri,  9 Aug 2019 10:07:50 +0200 (CEST)
Date:   Fri, 9 Aug 2019 10:07:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH for-5.3] drm/omap: ensure we have a valid dma_mask
Message-ID: <20190809080750.GA21874@lst.de>
References: <20190808101042.18809-1-hch@lst.de> <7fff8fd3-16ae-1f42-fcd6-9aa360fe36b5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fff8fd3-16ae-1f42-fcd6-9aa360fe36b5@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 09:40:32AM +0300, Tomi Valkeinen wrote:
> We do call dma_set_coherent_mask() in omapdrm's probe() (in omap_drv.c), 
> but apparently that's not enough anymore. Changing that call to 
> dma_coerce_mask_and_coherent() removes the WARN. I can create a patch for 
> that, or Christoph can respin this one.

Oh, yes - that actually is the right thing to do here.  If you already
have it please just send it out.

>
> I am not too familiar with the dma mask handling, so maybe someone can 
> educate:
>
> dma_coerce_mask_and_coherent() overwrites dev->dma_mask. Isn't that a bad 
> thing? What if the platform has set dev->dma_mask, and the driver 
> overwrites it with its value? Or who is supposed to set dev->dma_mask?

->dma_mask is a complete mess.  It is a pointer when it really should
just be a u64, and that means every driver layer has to allocate space
for it.  We don't really do that for platform_devices, as that breaks
horribly assumptions in the usb code.  That is why
dma_coerce_mask_and_coherent exists as a nasty workaround that sets
the dma_mask to the coherent_dma_mask for devices that don't have
space for ->dma_mask allocated, which works as long as the device
doesn't have differnet addressing requirements for both.

I'm actually working to fix that mess up at the moment, but it is going
to take a few cycles until everything falls into place.
