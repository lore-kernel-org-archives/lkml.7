Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AFBECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B17421655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r8yQnoKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfJGMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:42:56 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38204 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:42:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x97Cgt7K030000;
        Mon, 7 Oct 2019 07:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570452175;
        bh=2Itw8HwAZSNj5kRKXPjiCE0nUkmlTynlNsoxiQueKDE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=r8yQnoKwg3wCL+iF9cQTbag5JVO7eOK7HC1VQZFzW+IH2c2un1NBGg2VaDquRARq9
         7GyaHYEebGOOeaHc1V6HeRdVokxIVPfkKx1ANRho66zoWN4zQHNZCOKB5iAphi7RS9
         hzt0gCMdRBY0pN+k7G8GDu2Tcs+MNzN2zVwe5kvw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x97Cgt8C106348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Oct 2019 07:42:55 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 7 Oct
 2019 07:42:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 7 Oct 2019 07:42:54 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with SMTP id x97CgsWM089465;
        Mon, 7 Oct 2019 07:42:54 -0500
Date:   Mon, 7 Oct 2019 07:45:29 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 16/21] media: ti-vpe: vpe: use standard struct instead
 of duplicating fields
Message-ID: <20191007124529.nnrzx2btnraimivq@ti.com>
References: <20191004162952.4963-1-bparrot@ti.com>
 <20191004162952.4963-17-bparrot@ti.com>
 <cb01914f-3bca-2558-2b07-86ddbfc9626e@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb01914f-3bca-2558-2b07-86ddbfc9626e@xs4all.nl>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Verkuil <hverkuil@xs4all.nl> wrote on Mon [2019-Oct-07 09:57:26 +0200]:
> On 10/4/19 6:29 PM, Benoit Parrot wrote:
> > For each queue we need to maintain resolutions, pixel format,
> > bytesperline, sizeimage, colorspace, etc.
> > 
> > Instead of manually adding more entries in the vpe_q_data struct, it is
> > better to just add a "struct v4l2_format" member and use that to store
> > all needed information.
> > 
> > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > ---
> >  drivers/media/platform/ti-vpe/vpe.c | 185 ++++++++++++++--------------
> >  1 file changed, 91 insertions(+), 94 deletions(-)
> > 
> > diff --git a/drivers/media/platform/ti-vpe/vpe.c b/drivers/media/platform/ti-vpe/vpe.c
> > index d7f8eb901475..5b1e9908fff2 100644
> > --- a/drivers/media/platform/ti-vpe/vpe.c
> > +++ b/drivers/media/platform/ti-vpe/vpe.c
> > @@ -319,14 +319,9 @@ static struct vpe_fmt vpe_formats[] = {
> >   * there is one source queue and one destination queue for each m2m context.
> >   */
> >  struct vpe_q_data {
> > -	unsigned int		width;				/* frame width */
> > -	unsigned int		height;				/* frame height */
> > -	unsigned int		nplanes;			/* Current number of planes */
> > -	unsigned int		bytesperline[VPE_MAX_PLANES];	/* bytes per line in memory */
> > -	enum v4l2_colorspace	colorspace;
> > -	enum v4l2_field		field;				/* supported field value */
> > +	/* current v4l2 format info */
> > +	struct v4l2_format	format;
> 
> Wouldn't it make more sense to use struct v4l2_pix_format_mplane? That avoid having to
> use the '.fmt.pix_mp' sequence every time you need to access it.

Maybe, I chose "struct v4l2_format" because that is the parameter type used
in all related IOCTL. But I guess I can change it, if it make the code
cleaner :).

Benoit

> 
> Regards,
> 
> 	Hans
> 
