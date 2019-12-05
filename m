Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C15AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E182924648
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qtec.com header.i=@qtec.com header.b="bsN/dzuV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfLEHbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:31:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47073 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfLEHbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:31:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id m8so1720532edi.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 23:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bZTVLB6SlZZvHSZ52IQ5R9DgapBKk835vt1/NqLuFM=;
        b=bsN/dzuVIYXI1ejuF6K83PYcEMFOMOeUaB9u1lISiTkBdZZHwNYggeimMOG9be7uOD
         9wCQM0eAY3DUWwfgeDzrcFCzL4GnUrsKlDaczEPOHAV1GjxsDV1MkV6VkOAmorbuhymL
         kwMhThITg49GiY2StsdjLBlt5N5cukkLp/ydQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bZTVLB6SlZZvHSZ52IQ5R9DgapBKk835vt1/NqLuFM=;
        b=IqUMtQj3Q9ghZi3MoK3V2bFhaV5UFSgYdL8ye1vEaPB7bnHyEThbp5wg0ug6RXbFOY
         XcOPY1n6I5AJ0a8/NuKVojKozs+hPmFunI3+M7O5z0BKnGlUkvPc7Bf9iD6aGWBMtF6+
         eUkfUfQqgqYJVFdFKqRgW/NwfsLfghMvjnF4LuV6ixqNj11PUpvR/DsuCeMDwyl7gFm6
         0EMDJl5fwxn28KC3PenX6zWTOy/qQtdkSjaFCavRDW4nq7cVrmwCEWpKOko65Il6Xknm
         fD34Vt9a5+NcEVdyExd7UIdr6ipxr2BGTKXzAA5IWLyIEFYsAv9oqJlVYflaFyl270sU
         iBlw==
X-Gm-Message-State: APjAAAULLUFRoSDMOkwqNIk6ibaM7Gjjb63zm5qnMVVuPsu1CInMPtyf
        ++twm2NTqbSx3ByioTKGbPGsYZSQNBXWDHk4C0A++ozl
X-Google-Smtp-Source: APXvYqzzYaQTO/FR95xhPh9Wrn+4C+E8T1axiWOzdH3Skzt6J/P5+5UvQfwaBbkT2D+o1N25fFQjgCHPEMcNWQkZds0=
X-Received: by 2002:a17:906:82ca:: with SMTP id a10mr7937423ejy.40.1575531071920;
 Wed, 04 Dec 2019 23:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20191203151202.18081-1-daniel@qtec.com> <20191204113046.GF5282@valkosipuli.retiisi.org.uk>
In-Reply-To: <20191204113046.GF5282@valkosipuli.retiisi.org.uk>
From:   Daniel Gomez <daniel@qtec.com>
Date:   Thu, 5 Dec 2019 08:31:00 +0100
Message-ID: <CAH1Ww+R_wdORar58_BmiVN2AAafYqxGo3H5T9COCQeLsDkc3Xg@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2: Fix fourcc names for BAYER12P
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Wed, 4 Dec 2019 at 12:31, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Daniel,
>
> On Tue, Dec 03, 2019 at 04:12:00PM +0100, Daniel Gomez wrote:
> > Fix documentation fourcc names for the 12-bit packed Bayer formats.
> >
> > Signed-off-by: Daniel Gomez <daniel@qtec.com>
> > ---
> >  Documentation/media/uapi/v4l/pixfmt-srggb12p.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst b/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
> > index 960851275f23..7060a4ffad08 100644
> > --- a/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
> > +++ b/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
> > @@ -13,7 +13,7 @@
> >  .. _v4l2-pix-fmt-sgrbg12p:
> >
> >  *******************************************************************************************************************************
> > -V4L2_PIX_FMT_SRGGB12P ('pRAA'), V4L2_PIX_FMT_SGRBG12P ('pgAA'), V4L2_PIX_FMT_SGBRG12P ('pGAA'), V4L2_PIX_FMT_SBGGR12P ('pBAA'),
> > +V4L2_PIX_FMT_SRGGB12P ('pBCC'), V4L2_PIX_FMT_SGRBG12P ('pgCC'), V4L2_PIX_FMT_SGBRG12P ('pGCC'), V4L2_PIX_FMT_SBGGR12P ('pBCC'),
> >  *******************************************************************************************************************************
>
> Thanks for the patch.
>
> There's a bug there, but this doesn't still seem entirely correct. For
> instance, V4L2_PIX_FMT_SRGGB12P is defined as follows in videodev2.h:
>
> #define V4L2_PIX_FMT_SRGGB12P v4l2_fourcc('p', 'R', 'C', 'C')
>
> Could you fix that, and check the rest?
Thanks for the review.
I'll send a new patch with the proper names:
include/uapi/linux/videodev2.h:#define V4L2_PIX_FMT_SBGGR12P
v4l2_fourcc('p', 'B', 'C', 'C')
include/uapi/linux/videodev2.h:#define V4L2_PIX_FMT_SGBRG12P
v4l2_fourcc('p', 'G', 'C', 'C')
include/uapi/linux/videodev2.h:#define V4L2_PIX_FMT_SGRBG12P
v4l2_fourcc('p', 'g', 'C', 'C')
include/uapi/linux/videodev2.h:#define V4L2_PIX_FMT_SRGGB12P
v4l2_fourcc('p', 'R', 'C', 'C')
>
> Please also set the To: header to a valid value; not setting it sometimes
> ends up replies being only sent to the original sender of the patch,
> omitting the list and others cc'd.
>
okay.
> --
> Kind regards,
>
> Sakari Ailus
