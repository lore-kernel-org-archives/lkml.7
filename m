Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED59BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5E321783
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfIWSa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:30:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:54296 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfIWSa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:30:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 11:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; 
   d="scan'208";a="188220258"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 23 Sep 2019 11:30:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2019 21:30:49 +0300
Date:   Mon, 23 Sep 2019 21:30:49 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     "sandy.huang" <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/36] drm/fourcc: Add 2 plane YCbCr 10bit format support
Message-ID: <20190923183049.GR1208@intel.com>
References: <1569242365-182133-1-git-send-email-hjc@rock-chips.com>
 <1569242365-182133-2-git-send-email-hjc@rock-chips.com>
 <20190923125314.GJ1208@intel.com>
 <82664d48-36de-15fd-3b30-a12907e5bfcd@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82664d48-36de-15fd-3b30-a12907e5bfcd@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:05:22AM -0700, sandy.huang wrote:
> 
> 在 2019/9/23 上午5:53, Ville Syrjälä 写道:
> > On Mon, Sep 23, 2019 at 08:38:50PM +0800, Sandy Huang wrote:
> >> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> >> index 3feeaa3..5fe89e9 100644
> >> --- a/include/uapi/drm/drm_fourcc.h
> >> +++ b/include/uapi/drm/drm_fourcc.h
> >> @@ -266,6 +266,21 @@ extern "C" {
> >>   #define DRM_FORMAT_P016		fourcc_code('P', '0', '1', '6') /* 2x2 subsampled Cr:Cb plane 16 bits per channel */
> >>   
> >>   /*
> >> + * 2 plane YCbCr 10bit
> >> + * index 0 = Y plane, [9:0] Y
> >> + * index 1 = Cr:Cb plane, [19:0] Cr:Cb little endian
> >> + * or
> >> + * index 1 = Cb:Cr plane, [19:0] Cb:Cr little endian
> > What does "little endian" even mean for these?
> 
> It's Inherited from the following define, the difference is 8bit and 10bit.
> /*
>   * 2 plane YCbCr
>   * index 0 = Y plane, [7:0] Y
>   * index 1 = Cr:Cb plane, [15:0] Cr:Cb little endian
>   * or
>   * index 1 = Cb:Cr plane, [15:0] Cb:Cr little endian
>   */
> #define DRM_FORMAT_NV12        fourcc_code('N', 'V', '1', '2') /* 2x2 
> subsampled Cr:Cb plane */
> #define DRM_FORMAT_NV21        fourcc_code('N', 'V', '2', '1') /* 2x2 
> subsampled Cb:Cr plane */
> #define DRM_FORMAT_NV16        fourcc_code('N', 'V', '1', '6') /* 2x1 
> subsampled Cr:Cb plane */
> #define DRM_FORMAT_NV61        fourcc_code('N', 'V', '6', '1') /* 2x1 
> subsampled Cb:Cr plane */
> #define DRM_FORMAT_NV24        fourcc_code('N', 'V', '2', '4') /* 
> non-subsampled Cr:Cb plane */
> #define DRM_FORMAT_NV42        fourcc_code('N', 'V', '4',

Something not aligned to bytes can't have its endianness defined the
same way as these. Just doesn't make sense.

>
> 
> 
> >
> >> + */
> >> +
> >> +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
> >> +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
> >> +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
> >> +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
> >> +
> >> +/*
> >>    * 3 plane YCbCr
> >>    * index 0: Y plane, [7:0] Y
> >>    * index 1: Cb plane, [7:0] Cb
> >> -- 
> >> 2.7.4
> >>
> >>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

-- 
Ville Syrjälä
Intel
