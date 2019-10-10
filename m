Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F005AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8B220659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJJRgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:36:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:11447 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfJJRgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:36:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 10:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,281,1566889200"; 
   d="scan'208";a="200538447"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 10 Oct 2019 10:36:08 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 10 Oct 2019 20:36:07 +0300
Date:   Thu, 10 Oct 2019 20:36:07 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Sean Paul <sean@poorly.run>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sean Paul <seanpaul@chromium.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        kernel@collabora.com, Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v4 2/3] drm/rockchip: Add optional support for CRTC gamma
 LUT
Message-ID: <20191010173607.GH1208@intel.com>
References: <20191008230038.24037-1-ezequiel@collabora.com>
 <20191008230038.24037-3-ezequiel@collabora.com>
 <20191009180136.GE85762@art_vandelay>
 <CAAEAJfDP0PsGAoRfGyDyWj7DxgP6nwwwA1_gwLQuVy-fRDa-UA@mail.gmail.com>
 <20191010160059.GJ85762@art_vandelay>
 <CAKb7UvhWWYcpmyMZgerdJiG=sZjQUBVkeEwev+PdYzBW6+xsbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKb7UvhWWYcpmyMZgerdJiG=sZjQUBVkeEwev+PdYzBW6+xsbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 12:23:05PM -0400, Ilia Mirkin wrote:
> On Thu, Oct 10, 2019 at 12:01 PM Sean Paul <sean@poorly.run> wrote:
> > > > > +static int vop_crtc_atomic_check(struct drm_crtc *crtc,
> > > > > +                              struct drm_crtc_state *crtc_state)
> > > > > +{
> > > > > +     struct vop *vop = to_vop(crtc);
> > > > > +
> > > > > +     if (vop->lut_regs && crtc_state->color_mgmt_changed &&
> > > > > +         crtc_state->gamma_lut) {
> > > > > +             unsigned int len;
> > > > > +
> > > > > +             len = drm_color_lut_size(crtc_state->gamma_lut);
> > > > > +             if (len != crtc->gamma_size) {
> > > > > +                     DRM_DEBUG_KMS("Invalid LUT size; got %d, expected %d\n",
> > > > > +                                   len, crtc->gamma_size);
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > >
> > > > Overflow is avoided in drm_mode_gamma_set_ioctl(), so I don't think you need
> > > > this function.
> > > >
> > >
> > > But that only applies to the legacy path. Isn't this needed to ensure
> > > a gamma blob
> > > has the right size?
> >
> > Yeah, good point, we check the element size in the atomic path, but not the max
> > size. I haven't looked at enough color lut stuff to have an opinion whether this
> > check would be useful in a helper function or not, something to consider, I
> > suppose.
> 
> Some implementations support multiple sizes (e.g. 256 and 1024) but
> not anything in between. It would be difficult to expose this
> generically, I would imagine.
> The 256 size is kind of special, since
> basically all legacy usage assumes that 256 is the one true quantity
> of LUT entries...

What we do currently in i915 is:
crtc->gamma_size = 256
GAMMA_LUT_SIZE = platform specific (256, 129, 257, 2^10, or 2^18+1 (lol))
DEGAMMA_LUT_SIZE = platform specific (0, 33, 65, or 2^10)

i915 will accept:
- gamma lut of size 256, iff ctm==NULL and degamma==NULL (the so
  called "legacy gamma" mode)
- (de)gamma_lut of size (DE)GAMMA_LUT_SIZE if it passes the
  checks done by drm_color_lut_check()

Ie. just one or two gamma modes per platform is exposed. And that's
about all we can do with the current uapi even though our hardware
supports many more modes.

The resulting precision, interpolation vs. truncation behaviour,
and handling of out of gamut values are all totally unspecified
and userspace just has to make a guess.

We also cheat with the 2^10 sized LUTs a bit due to the hw sharing
the same LUT for gamma and degamma, and so if you enable both at
the same time we throw away every second entry and each stage
only gets a 2^9 entry LUT in the end.

Oh and for the 2^18+1 monstrosity we cheat even more and
throw away ~99.8% of the entries :(


This here was my idea for extending the uapi so that we
could expose the full hw capabilities and let userspace
decide which mode suits it best without having to guess
what it'll get:
https://github.com/vsyrjala/linux/commits/gamma_mode_prop

Maybe in a few years I'll find time to get back to it...

-- 
Ville Syrjälä
Intel
