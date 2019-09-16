Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2DC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A102F20665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfIPMnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:43:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:33211 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbfIPMnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:43:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 05:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="193426829"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 16 Sep 2019 05:43:40 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 16 Sep 2019 15:43:40 +0300
Date:   Mon, 16 Sep 2019 15:43:40 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jani Nikula <jani.nikula@intel.com>, kbuild@01.org,
        kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org
Subject: Re: drivers/gpu/drm/i915/display/intel_display.c:3934
 skl_plane_stride() error: testing array offset 'color_plane' after use.
Message-ID: <20190916124340.GF1208@intel.com>
References: <20190914040858.GT20699@kadam>
 <87lfuou27c.fsf@intel.com>
 <20190916075913.GZ20699@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190916075913.GZ20699@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:59:13AM +0300, Dan Carpenter wrote:
> On Mon, Sep 16, 2019 at 10:31:35AM +0300, Jani Nikula wrote:
> > On Sat, 14 Sep 2019, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   a7f89616b7376495424f682b6086e0c391a89a1d
> > > commit: df0566a641f959108c152be748a0a58794280e0e drm/i915: move modesetting core code under display/
> > > date:   3 months ago
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > New smatch warnings:
> > > drivers/gpu/drm/i915/display/intel_display.c:3934 skl_plane_stride() error: testing array offset 'color_plane' after use.

The code looks fine to me. int color_plane is 0 or 1 so we know
the color_plane[] array is has enough elements. But if
fb->num_planes==1 we don't actually want to look at color_plane[1].

> > > drivers/gpu/drm/i915/display/intel_display.c:16328 intel_sanitize_encoder() error: we previously assumed 'crtc' could be null (see line 16318)

If crtc_state!=NULL then crtc!=NULL. Looks safe to me.

> > 
> > Odd, what changed to provoke the warnings now? Or is the smatch test
> > new?
> > 
> 
> It looks like the cross function DB is out of data slightly.  Maybe
> because the file moved?  On my system Smatch knows that color_plane is
> 0-1 and plane_state->color_plane[] is a two element array so it doesn't
> print the warning.
> 
> This is just a sanity check which is never triggered.  Should the sanity
> check be move?  What was originally intended?  It's hard to say.
> 
> regards,
> dan carpenter

-- 
Ville Syrjälä
Intel
