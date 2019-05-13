Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98604C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E48321473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfEMNLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:11:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:35713 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbfEMNLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:11:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 06:11:36 -0700
X-ExtLoop1: 1
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 13 May 2019 06:11:33 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 13 May 2019 16:11:32 +0300
Date:   Mon, 13 May 2019 16:11:32 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v2 4/6] drm/fourcc: Pass the format_info pointer to
 drm_format_plane_cpp
Message-ID: <20190513131132.GN24299@intel.com>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
 <32aa13e53dbc98a90207fd290aa8e79f785fb11e.1557486447.git-series.maxime.ripard@bootlin.com>
 <20190510160031.GM24299@intel.com>
 <20190512173054.uj3thuvkgmllsy2n@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190512173054.uj3thuvkgmllsy2n@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 07:30:54PM +0200, Maxime Ripard wrote:
> Hi Ville,
> 
> On Fri, May 10, 2019 at 07:00:31PM +0300, Ville Syrjälä wrote:
> > On Fri, May 10, 2019 at 01:08:49PM +0200, Maxime Ripard wrote:
> > > So far, the drm_format_plane_cpp function was operating on the format's
> > > fourcc and was doing a lookup to retrieve the drm_format_info structure and
> > > return the cpp.
> > >
> > > However, this is inefficient since in most cases, we will have the
> > > drm_format_info pointer already available so we shouldn't have to perform a
> > > new lookup. Some drm_fourcc functions also already operate on the
> > > drm_format_info pointer for that reason, so the API is quite inconsistent
> > > there.
> > >
> > > Let's follow the latter pattern and remove the extra lookup while being a
> > > bit more consistent. In order to be extra consistent, also rename that
> > > function to drm_format_info_plane_cpp and to a static function in the
> > > header to match the current policy.
> >
> > Is there any point keeping the function at all?
> > It's just info->cpp[i] no?
> 
> You're right, we can remove it.
> 
> Do you want this to be done in that patch or a subsequent one?

I don't mind either way.

-- 
Ville Syrjälä
Intel
