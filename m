Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A8CC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B0C2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfELRa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:30:58 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48057 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfELRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:30:58 -0400
X-Originating-IP: 46.193.9.130
Received: from localhost (cust-west-pareq2-46-193-9-130.wb.wifirst.net [46.193.9.130])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 2BB1B1C0004;
        Sun, 12 May 2019 17:30:54 +0000 (UTC)
Date:   Sun, 12 May 2019 19:30:54 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH v2 4/6] drm/fourcc: Pass the format_info pointer to
 drm_format_plane_cpp
Message-ID: <20190512173054.uj3thuvkgmllsy2n@flea>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1557486447.git-series.maxime.ripard@bootlin.com>
 <32aa13e53dbc98a90207fd290aa8e79f785fb11e.1557486447.git-series.maxime.ripard@bootlin.com>
 <20190510160031.GM24299@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190510160031.GM24299@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On Fri, May 10, 2019 at 07:00:31PM +0300, Ville Syrjälä wrote:
> On Fri, May 10, 2019 at 01:08:49PM +0200, Maxime Ripard wrote:
> > So far, the drm_format_plane_cpp function was operating on the format's
> > fourcc and was doing a lookup to retrieve the drm_format_info structure and
> > return the cpp.
> >
> > However, this is inefficient since in most cases, we will have the
> > drm_format_info pointer already available so we shouldn't have to perform a
> > new lookup. Some drm_fourcc functions also already operate on the
> > drm_format_info pointer for that reason, so the API is quite inconsistent
> > there.
> >
> > Let's follow the latter pattern and remove the extra lookup while being a
> > bit more consistent. In order to be extra consistent, also rename that
> > function to drm_format_info_plane_cpp and to a static function in the
> > header to match the current policy.
>
> Is there any point keeping the function at all?
> It's just info->cpp[i] no?

You're right, we can remove it.

Do you want this to be done in that patch or a subsequent one?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
