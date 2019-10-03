Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E581C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9CC222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 05:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfJCFQP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 01:16:15 -0400
Received: from mailoutvs23.siol.net ([185.57.226.214]:42844 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725497AbfJCFQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:16:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 2941F520E78;
        Thu,  3 Oct 2019 07:16:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uo2TMQr76LRD; Thu,  3 Oct 2019 07:16:10 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C1F2D521B43;
        Thu,  3 Oct 2019 07:16:10 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 35AA5521111;
        Thu,  3 Oct 2019 07:16:10 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] media: cedrus: Fix H264 default reference index count
Date:   Thu, 03 Oct 2019 07:16:09 +0200
Message-ID: <12199603.8LrTjBMqpV@jernej-laptop>
In-Reply-To: <20191002220650.GB24151@aptenodytes>
References: <20191002193553.1633467-1-jernej.skrabec@siol.net> <20191002193553.1633467-3-jernej.skrabec@siol.net> <20191002220650.GB24151@aptenodytes>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 03. oktober 2019 ob 00:06:50 CEST je Paul Kocialkowski 
napisal(a):
> Hi,
> 
> On Wed 02 Oct 19, 21:35, Jernej Skrabec wrote:
> > Reference index count in VE_H264_PPS should come from PPS control.
> > However, this is not really important, because reference index count is
> > in our case always overridden by that from slice header.
> 
> Thanks for the fixup!
> 
> Our libva userspace and v4l2-request testing tool currently don't provide
> this, but I have a pending merge request adding it for the hantro so it's
> good to go.

Actually, I think this is just cosmetic and it would work even if it would be 
always 0. We always override this number in SHS2 register with 
VE_H264_SHS2_NUM_REF_IDX_ACTIVE_OVRD flag and recently there was a patch merged 
to clarify that value in slice parameters should be the one that's set on 
default value if override flag is not set in bitstream:
https://git.linuxtv.org/media_tree.git/commit/?
id=187ef7c5c78153acdce8c8714e5918b1018c710b

Well, we could always compare default and value in slice parameters, but I 
really don't see the benefit of doing that extra work.

Best regards,
Jernej

> 
> Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Cheers,
> 
> Paul
> 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/staging/media/sunxi/cedrus/cedrus_h264.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c index
> > bd848146eada..4a0e69855c7f 100644
> > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> > @@ -364,12 +364,8 @@ static void cedrus_set_params(struct cedrus_ctx *ctx,
> > 
> >  	// picture parameters
> >  	reg = 0;
> > 
> > -	/*
> > -	 * FIXME: the kernel headers are allowing the default value to
> > -	 * be passed, but the libva doesn't give us that.
> > -	 */
> > -	reg |= (slice->num_ref_idx_l0_active_minus1 & 0x1f) << 10;
> > -	reg |= (slice->num_ref_idx_l1_active_minus1 & 0x1f) << 5;
> > +	reg |= (pps->num_ref_idx_l0_default_active_minus1 & 0x1f) << 10;
> > +	reg |= (pps->num_ref_idx_l1_default_active_minus1 & 0x1f) << 5;
> > 
> >  	reg |= (pps->weighted_bipred_idc & 0x3) << 2;
> >  	if (pps->flags & V4L2_H264_PPS_FLAG_ENTROPY_CODING_MODE)
> >  	
> >  		reg |= VE_H264_PPS_ENTROPY_CODING_MODE;




