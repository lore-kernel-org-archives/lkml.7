Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A929FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789682176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfK1LOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:14:23 -0500
Received: from mga04.intel.com ([192.55.52.120]:64243 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfK1LOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:14:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 03:14:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="221298377"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 28 Nov 2019 03:14:19 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 28 Nov 2019 13:14:18 +0200
Date:   Thu, 28 Nov 2019 13:14:18 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Laurentiu Palcu <laurentiu.palcu@nxp.com>
Cc:     Uma Shankar <uma.shankar@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH] drm: fix HDR static metadata type field
 numbering
Message-ID: <20191128111418.GP1208@intel.com>
References: <1574865719-24490-1-git-send-email-laurentiu.palcu@nxp.com>
 <20191127151703.GJ1208@intel.com>
 <20191128083940.GC10251@fsr-ub1664-121>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191128083940.GC10251@fsr-ub1664-121>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 08:39:41AM +0000, Laurentiu Palcu wrote:
> On Wed, Nov 27, 2019 at 05:17:03PM +0200, Ville Syrjälä wrote:
> > Caution: EXT Email
> > 
> > On Wed, Nov 27, 2019 at 02:42:35PM +0000, Laurentiu Palcu wrote:
> > > According to CTA-861 specification, HDR static metadata data block allows a
> > > sink to indicate which HDR metadata types it supports by setting the SM_0 to
> > > SM_7 bits. Currently, only Static Metadata Type 1 is supported and this is
> > > indicated by setting the SM_0 bit to 1.
> > >
> > > However, the connector->hdr_sink_metadata.hdmi_type1.metadata_type is always
> > > 0, because hdr_metadata_type() in drm_edid.c checks the wrong bit.
> > >
> > > This patch corrects the HDMI_STATIC_METADATA_TYPE1 bit position.
> > 
> > Was confused for a while why this has even been workning, but I guess
> > that's due to userspace populating the metadata infoframe blob correctly
> > even if we misreported the metadata types in the parsed EDID metadata
> > blob.
> > 
> > Hmm. Actually on further inspection this all seems to be dead code. The
> > only thing we seem to use from the parsed EDID metadata stuff is
> > eotf bitmask. We check that in drm_hdmi_infoframe_set_hdr_metadata()
> > but we don't check the metadata type.
> > 
> > Maybe we should just nuke this EDID parsing stuff entirely? Seems
> > pretty much pointless.
> 
> I've been thinking about that but we may need the rest of the fields as
> well, even though they're not currently used. I'm referring to sink's
> min/max luminance data. Shouldn't we also check min/max cll, besides
> eotf, to make sure the source does not pass higher/lower luminance
> values, than the sink supports, for optimal content rendering?
> 
> However, CTA-861 is not very clear on how a sink should behave if
> the CLL values exceed the allowed range... :/ Also, if the CLL range or
> the FALL values passed in the DRM infoframe exceed the sink's advertised
> min/max values, I guess the sink cannot go lower/higher than it can
> anyway. In which case, we don't really need the rest of the HDR static
> metadata block and nuking that part should be ok.

I'm thinking we should just conclude that such userspace is a 
buggy mess and deserves whatever it gets.

-- 
Ville Syrjälä
Intel
