Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D06C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6B020881
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfEJQAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:00:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:39568 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJQAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:00:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 09:00:35 -0700
X-ExtLoop1: 1
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 10 May 2019 09:00:32 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 10 May 2019 19:00:31 +0300
Date:   Fri, 10 May 2019 19:00:31 +0300
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
Message-ID: <20190510160031.GM24299@intel.com>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
 <32aa13e53dbc98a90207fd290aa8e79f785fb11e.1557486447.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32aa13e53dbc98a90207fd290aa8e79f785fb11e.1557486447.git-series.maxime.ripard@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 01:08:49PM +0200, Maxime Ripard wrote:
> So far, the drm_format_plane_cpp function was operating on the format's
> fourcc and was doing a lookup to retrieve the drm_format_info structure and
> return the cpp.
> 
> However, this is inefficient since in most cases, we will have the
> drm_format_info pointer already available so we shouldn't have to perform a
> new lookup. Some drm_fourcc functions also already operate on the
> drm_format_info pointer for that reason, so the API is quite inconsistent
> there.
> 
> Let's follow the latter pattern and remove the extra lookup while being a
> bit more consistent. In order to be extra consistent, also rename that
> function to drm_format_info_plane_cpp and to a static function in the
> header to match the current policy.

Is there any point keeping the function at all?
It's just info->cpp[i] no?

-- 
Ville Syrjälä
Intel
