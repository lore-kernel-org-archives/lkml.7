Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C7FFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A3A21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="evDKXDez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfKHQhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:37:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46601 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:37:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so7725368wrs.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3ysdcSB8erY1ob+nK0csXptVhQaQ+5y764qzBsgWZe4=;
        b=evDKXDezObhhBY+xHhKIVVGVpLGXXbyUHHE9hz1gLskTJPKyM1eBbmEWMHfRV80bgj
         aOSugDk3gNf6PWxUQ9dtC2TYYgtLa3yXMxIQJZ7QNcNrjUqdXf5ws+skIpE7q9EZ7BE5
         T6VKqV0Ykwxke1vPqkfdaTsYMEj9y5Q4oGpak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=3ysdcSB8erY1ob+nK0csXptVhQaQ+5y764qzBsgWZe4=;
        b=kw7sZcEHreqVhKuqVCt6r5vWJJ6vMd039kgSf0QW5vintbB3cHSUQ9sXzWKvhfHyGi
         NACjR/lkpqh0QpXcZRmtmJ6Sev3F3g8EaodmXMr0qjmrvXNIz7o6t5df6mPHcY97+pcD
         FZ2Si2yJHHsCi17HE+IeJv/ZC75JWr6Y9pIJ6s9BCgFWdq6t9y5RhG4nJYfXqHTK8Q/1
         CVVzMbtPUPERWjIBE89Lmm6JxZVBo99lURFCclishuiZ3iAiy2hSk4hm0EvSQkZpyBL0
         tw/N98w6bGQh0SQwr+VkdTSUn2VXLKyqAMPOzN9vGpER625hQOl1BR78dIO8hbSNkaIV
         UnMg==
X-Gm-Message-State: APjAAAUmzz1mO/7bNhcPFUxOtVmjkt034bSm9fPfAnuK2LJvZcjKyNUa
        hIUVpRpv6lGwuXuwlrWZDjw3jw==
X-Google-Smtp-Source: APXvYqzFg0AHeMBXu0MVVrCZuAXv1md1B70QDvpdkw18Sw0uyUEzCP2npiyiZq+sANVM277CKct9SQ==
X-Received: by 2002:adf:f20c:: with SMTP id p12mr8633721wro.379.1573231050743;
        Fri, 08 Nov 2019 08:37:30 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id y15sm5860894wrh.94.2019.11.08.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:37:29 -0800 (PST)
Date:   Fri, 8 Nov 2019 17:37:27 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Message-ID: <20191108163727.GZ23790@phenom.ffwll.local>
Mail-Followup-To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
 <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
 <20191009145008.GB16989@phenom.ffwll.local>
 <17879396.dXe580Ps6o@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17879396.dXe580Ps6o@diego>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 04:08:50PM +0100, Heiko Stübner wrote:
> Hi Daniel, Sandy,
> 
> Am Mittwoch, 9. Oktober 2019, 16:50:08 CET schrieb Daniel Vetter:
> > On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
> > > These new format is supported by some rockchip socs:
> > > 
> > > DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
> > > DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
> > > DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
> > > 
> > > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > > ---
> > >  drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
> > >  include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
> > >  2 files changed, 32 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > > index c630064..ccd78a3 100644
> > > --- a/drivers/gpu/drm/drm_fourcc.c
> > > +++ b/drivers/gpu/drm/drm_fourcc.c
> > > @@ -261,6 +261,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
> > >  		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2,
> > >  		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 },
> > >  		  .hsub = 2, .vsub = 2, .is_yuv = true},
> > > +		{ .format = DRM_FORMAT_NV12_10,		.depth = 0,  .num_planes = 2,
> > > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> > > +		{ .format = DRM_FORMAT_NV21_10,		.depth = 0,  .num_planes = 2,
> > > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> > > +		{ .format = DRM_FORMAT_NV16_10,		.depth = 0,  .num_planes = 2,
> > > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> > > +		{ .format = DRM_FORMAT_NV61_10,		.depth = 0,  .num_planes = 2,
> > > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> > > +		{ .format = DRM_FORMAT_NV24_10,		.depth = 0,  .num_planes = 2,
> > > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > +		  .hsub = 1, .vsub = 1, .is_yuv = true},
> > > +		{ .format = DRM_FORMAT_NV42_10,		.depth = 0,  .num_planes = 2,
> > > +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> > > +		  .hsub = 1, .vsub = 1, .is_yuv = true},
> > >  		{ .format = DRM_FORMAT_P210,		.depth = 0,
> > >  		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
> > >  		  .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 2,
> > 
> > Yup this is what I had in mind with using the block stuff to describe your
> > new 10bit yuv formats. Thanks for respining.
> > 
> > Once we've nailed the exact bit description of the format precisely this
> > can be merged imo.
> 
> I just saw this series still sitting in my inbox, so was wondering about the
> "once we've nailed the exact bit description..." and what is missing for that.

Since my name is on this mail ... what I meant here is that in principle
I'm ok, but someone else needs to check that we've documented all the
details properly. And once that review is done they or you can also merge
it. From my side not going to dig more into this, we have tons of
reviewers/committers.
-Daniel


> 
> Thanks
> Heiko
> 
> 
> > > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > > index 3feeaa3..08e2221 100644
> > > --- a/include/uapi/drm/drm_fourcc.h
> > > +++ b/include/uapi/drm/drm_fourcc.h
> > > @@ -238,6 +238,20 @@ extern "C" {
> > >  #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
> > >  
> > >  /*
> > > + * 2 plane YCbCr
> > > + * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
> > > + * index 1 = Cb:Cr plane, Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
> > > + * or
> > > + * index 1 = Cr:Cb plane, Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
> > > + */
> > > +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
> > > +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
> > > +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
> > > +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
> > > +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
> > > +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
> > > +
> > > +/*
> > >   * 2 plane YCbCr MSB aligned
> > >   * index 0 = Y plane, [15:0] Y:x [10:6] little endian
> > >   * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
> > 
> > 
> 
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
