Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C541C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AAC21479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfIJR6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:58:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:49469 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfIJR5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:57:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 10:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; 
   d="scan'208";a="191885982"
Received: from labuser-z97x-ud5h.jf.intel.com (HELO intel.com) ([10.54.75.49])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2019 10:56:40 -0700
Date:   Tue, 10 Sep 2019 10:58:07 -0700
From:   Manasi Navare <manasi.d.navare@intel.com>
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Gaurav K Singh <gaurav.k.singh@intel.com>
Subject: Re: [PATCH] drm: include: fix W=1 warnings in struct drm_dsc_config
Message-ID: <20190910175806.GA31258@intel.com>
References: <20190909135205.10277-1-benjamin.gaignard@st.com>
 <f17b306d-2810-985c-42ec-59c6a6dd7093@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17b306d-2810-985c-42ec-59c6a6dd7093@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 12:58:24PM +0000, Harry Wentland wrote:
> +Manasi, Gaurav
> 
> On 2019-09-09 9:52 a.m., Benjamin Gaignard wrote:
> > Change scale_increment_interval and nfl_bpg_offset fields to
> > u32 to avoid W=1 warnings because we are testing them against
> > 65535.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > ---
> >   include/drm/drm_dsc.h | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/drm/drm_dsc.h b/include/drm/drm_dsc.h
> > index 887954cbfc60..e495024e901c 100644
> > --- a/include/drm/drm_dsc.h
> > +++ b/include/drm/drm_dsc.h
> > @@ -207,11 +207,13 @@ struct drm_dsc_config {
> >   	 * Number of group times between incrementing the scale factor value
> >   	 * used at the beginning of a slice.
> >   	 */
> > -	u16 scale_increment_interval;
> > +	u32 scale_increment_interval;
> 
> The DSC spec defines both as u16. I think the check in drm_dsc.c is 
> useless and should be dropped.
>

I agree with Harry here, all these variables should match the number of bits
in the spec, increasing them to u32 allows more values which violates the
DSC spec.

It should stay u16

Manasi
 
> Harry
> 
> > +
> >   	/**
> >   	 * @nfl_bpg_offset: Non first line BPG offset to be used
> >   	 */
> > -	u16 nfl_bpg_offset;
> > +
> > +	u32 nfl_bpg_offset;
> >   	/**
> >   	 * @slice_bpg_offset: BPG offset used to enforce slice bit
> >   	 */
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
