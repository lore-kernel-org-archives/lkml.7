Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5F8C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFD0208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 12:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="MsI3redr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfENMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 08:19:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35941 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfENMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 08:19:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id a17so17386713qth.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=U0DpT43tjbc+zKgowoXNj4gD+VXgSMT7iXcdOXpGfnk=;
        b=MsI3redrPwQrIOqOIgfojac/SeflfTeSEEHbupT3uBsTZOa0Fwu17Q/4GFem24pier
         vnqRKPL/wbNcwCaoZqeRX79HadZM7b7Df0PWoQokbBaY5NO6Q61enz3FUQYzVOzCjSRh
         Jqs1kXHB/1coy7gansBBV9Mqf9q8rqShoZuWHlZnwTVcOvG8ddZsiyHFyixvF3LtFc0j
         L17JRrdPeEVYX2q2LFoX3pn4SECSkSnD/ppXxsWz0TTYPI9m5Z0GxmIddijElsAdWwc9
         bLNiCJSvuSnGFYKrKEQIwPPtVcZTbVDpQTyqEruDc6wUUjIoXyMQy1lvlA5PbQ77siXE
         ia+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=U0DpT43tjbc+zKgowoXNj4gD+VXgSMT7iXcdOXpGfnk=;
        b=dFU/QkKOFYWKW/GxTZiHnexg4mS1QHFJyL75jSXiF6mUfAKsV3SlLQScC8EoZknFDG
         NsXQVTj8LbjiGTYHz7grtWXI8X/qlokIv1IN4POGhgp8QFwX6p9e+WMDDUVl3tuBzIEN
         /tL/c8ojXz0zVNS72cc+LTgy8NsfZDkcZt/9t5EUPqhHocCP7gvbecp+xPI+bQDUWXRC
         B6dsYs1VfAuyyBMvFyY9e3VUcBVboR0UxDe6e35nB4Kw6iGMS7RQQGOfsBxaToj/Wi+C
         GUrCFfrzs/ZKK1obMfu93V9KUFEI/Soa4Hms4TpBgPWEAuMSx43qucug6tb15GnSghIN
         phkA==
X-Gm-Message-State: APjAAAW3Z4PFA4KREEMRdk6JpHgTfMVU30MqgDzKltjhsgiPUkMfEwLY
        1zjm4/gSR/W8wZu6vxBt+55f3g==
X-Google-Smtp-Source: APXvYqxD2KIzuB0hooUSp+6DNIlDqA8GfSvdV41V1sBC1GAHZF5hrB10YsOIvolxxzU+uDonglNXbg==
X-Received: by 2002:a0c:ad46:: with SMTP id v6mr7839465qvc.82.1557836376895;
        Tue, 14 May 2019 05:19:36 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id f33sm2792457qtf.64.2019.05.14.05.19.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 05:19:36 -0700 (PDT)
Message-ID: <ecdb8da5f00a8f5bd5d5ec125e2aa162e0091728.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media/doc: Allow sizeimage to be set by v4l clients
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 May 2019 08:19:34 -0400
In-Reply-To: <a1807c37-99cf-d1fa-bcb9-67af2935abaf@xs4all.nl>
References: <20190412155915.16849-1-stanimir.varbanov@linaro.org>
         <a1807c37-99cf-d1fa-bcb9-67af2935abaf@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 (3.32.1-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 14 mai 2019 à 10:54 +0200, Hans Verkuil a écrit :
> Hi Stanimir,
> 
> On 4/12/19 5:59 PM, Stanimir Varbanov wrote:
> > This changes v4l2_pix_format and v4l2_plane_pix_format sizeimage
> > field description to allow v4l clients to set bigger image size
> > in case of variable length compressed data.
> 
> I've been reconsidering this change. The sizeimage value in the format
> is the minimum size a buffer should have in order to store the data of
> an image of the width and height as described in the format.

Should this read as the minimum size for the specific (returned by
driver) width/height/bytesperline ?

> 
> But there is nothing that prevents userspace from calling VIDIOC_CREATEBUFS
> instead of VIDIOC_REQBUFS to allocate larger buffers.
> 
> So do we really need this change?
> 
> The more I think about this, the more uncomfortable I become with this change.
> 
> Regards,
> 
> 	Hans
> 
> > Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> > ---
> >  Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst | 13 ++++++++++++-
> >  Documentation/media/uapi/v4l/pixfmt-v4l2.rst        | 11 ++++++++++-
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
> > index 5688c816e334..005428a8121e 100644
> > --- a/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
> > +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
> > @@ -31,7 +31,18 @@ describing all planes of that format.
> >  
> >      * - __u32
> >        - ``sizeimage``
> > -      - Maximum size in bytes required for image data in this plane.
> > +      - Maximum size in bytes required for image data in this plane,
> > +	set by the driver. When the image consists of variable length
> > +	compressed data this is the number of bytes required by the
> > +	codec to support the worst-case compression scenario.
> > +
> > +	For uncompressed images the driver will set the value. For
> > +	variable length compressed data clients are allowed to set
> > +	the sizeimage field, but the driver may ignore it and set the
> > +	value itself, or it may modify the provided value based on
> > +	alignment requirements or minimum/maximum size requirements.
> > +	If the client wants to leave this to the driver, then it should
> > +	set sizeimage to 0.
> >      * - __u32
> >        - ``bytesperline``
> >        - Distance in bytes between the leftmost pixels in two adjacent
> > diff --git a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> > index 71eebfc6d853..0f7771151db9 100644
> > --- a/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> > +++ b/Documentation/media/uapi/v4l/pixfmt-v4l2.rst
> > @@ -89,7 +89,16 @@ Single-planar format structure
> >        - Size in bytes of the buffer to hold a complete image, set by the
> >  	driver. Usually this is ``bytesperline`` times ``height``. When
> >  	the image consists of variable length compressed data this is the
> > -	maximum number of bytes required to hold an image.
> > +	number of bytes required by the codec to support the worst-case
> > +	compression scenario.
> > +
> > +	For uncompressed images the driver will set the value. For
> > +	variable length compressed data clients are allowed to set
> > +	the sizeimage field, but the driver may ignore it and set the
> > +	value itself, or it may modify the provided value based on
> > +	alignment requirements or minimum/maximum size requirements.
> > +	If the client wants to leave this to the driver, then it should
> > +	set sizeimage to 0.
> >      * - __u32
> >        - ``colorspace``
> >        - Image colorspace, from enum :c:type:`v4l2_colorspace`.
> > 

