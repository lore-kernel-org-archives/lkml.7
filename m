Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A9AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38468217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfDXU1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:27:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:48037 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfDXU1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:27:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 13:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,390,1549958400"; 
   d="scan'208";a="143320430"
Received: from przanoni-mobl.amr.corp.intel.com ([10.254.90.120])
  by fmsmga008.fm.intel.com with ESMTP; 24 Apr 2019 13:27:07 -0700
Message-ID: <15be67b19d898ab74c9ae6d9d9080ef339772e00.camel@intel.com>
Subject: Re: [PATCH] i915: disable framebuffer compression on GeminiLake
From:   Paulo Zanoni <paulo.r.zanoni@intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Daniel Drake <drake@endlessm.com>
Date:   Wed, 24 Apr 2019 13:27:07 -0700
In-Reply-To: <155613593248.25205.769591454199358982@skylake-alporthouse-com>
References: <20190423092810.28359-1-jian-hong@endlessm.com>
         <155613593248.25205.769591454199358982@skylake-alporthouse-com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em qua, 2019-04-24 às 20:58 +0100, Chris Wilson escreveu:
> Quoting Jian-Hong Pan (2019-04-23 10:28:10)
> > From: Daniel Drake <drake@endlessm.com>
> > 
> > On many (all?) the Gemini Lake systems we work with, there is frequent
> > momentary graphical corruption at the top of the screen, and it seems
> > that disabling framebuffer compression can avoid this.
> > 
> > The ticket was reported 6 months ago and has already affected a
> > multitude of users, without any real progress being made. So, lets
> > disable framebuffer compression on GeminiLake until a solution is found.
> > 
> > Buglink: https://bugs.freedesktop.org/show_bug.cgi?id=108085
> > Signed-off-by: Daniel Drake <drake@endlessm.com>
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> 
> Fixes: fd7d6c5c8f3e ("drm/i915: enable FBC on gen9+ too") ?
> Cc: Paulo Zanoni <paulo.r.zanoni@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v4.11+
> 
> glk landed 1 month before, so that seems the earliest broken point.
> 

The bug is well reported, the bug author is helpful and it even has a
description of "steps to reproduce" that looks very easy (although I
didn't try it). Everything suggests this is a bug the display team
could actually solve with not-so-many hours of debugging.

In the meantime, unbreak the systems:
Reviewed-by: Paulo Zanoni <paulo.r.zanoni@intel.com>

> > ---
> >  drivers/gpu/drm/i915/intel_fbc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_fbc.c b/drivers/gpu/drm/i915/intel_fbc.c
> > index 656e684e7c9a..fc018f3f53a1 100644
> > --- a/drivers/gpu/drm/i915/intel_fbc.c
> > +++ b/drivers/gpu/drm/i915/intel_fbc.c
> > @@ -1278,6 +1278,10 @@ static int intel_sanitize_fbc_option(struct drm_i915_private *dev_priv)
> >         if (!HAS_FBC(dev_priv))
> >                 return 0;
> >  
> > +       /* https://bugs.freedesktop.org/show_bug.cgi?id=108085 */
> > +       if (IS_GEMINILAKE(dev_priv))
> > +               return 0;
> > +
> >         if (IS_BROADWELL(dev_priv) || INTEL_GEN(dev_priv) >= 9)
> >                 return 1;
> >  
> > -- 
> > 2.21.0
> > 

