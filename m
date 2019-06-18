Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E975C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738FC2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 22:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbfFRWi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:38:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34309 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfFRWi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 18:38:56 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=lindsey)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1hdMke-0004ks-Dk; Tue, 18 Jun 2019 22:38:52 +0000
Date:   Tue, 18 Jun 2019 17:38:49 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Gen Zhang <blackgod016574@gmail.com>, sean@poorly.run,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm_edid-load: Fix a missing-check bug in
 drivers/gpu/drm/drm_edid_load.c
Message-ID: <20190618223848.GD6248@lindsey>
References: <20190522123920.GB6772@zhanggen-UX430UQ>
 <87o93u7d3s.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o93u7d3s.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-22 17:55:35, Jani Nikula wrote:
> On Wed, 22 May 2019, Gen Zhang <blackgod016574@gmail.com> wrote:
> > In drm_load_edid_firmware(), fwstr is allocated by kstrdup(). And fwstr
> > is dereferenced in the following codes. However, memory allocation 
> > functions such as kstrdup() may fail and returns NULL. Dereferencing 
> > this null pointer may cause the kernel go wrong. Thus we should check 
> > this kstrdup() operation.
> > Further, if kstrdup() returns NULL, we should return ERR_PTR(-ENOMEM) to
> > the caller site.
> 
> strsep() handles the NULL pointer just fine, so there won't be a NULL
> dereference. However this patch seems like the right thing to do anyway.

I came across this thread while triaging CVE-2019-12382. I agree that
the code before was fine but more complex than necessary. There's no
real security impact here since a NULL pointer dereference was not
possible. I've requested that MITRE reject CVE-2019-12382.

This change is a nice improvement, though.

Tyler

> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> >
> > ---
> > diff --git a/drivers/gpu/drm/drm_edid_load.c b/drivers/gpu/drm/drm_edid_load.c
> > index a491509..a0e107a 100644
> > --- a/drivers/gpu/drm/drm_edid_load.c
> > +++ b/drivers/gpu/drm/drm_edid_load.c
> > @@ -290,6 +290,8 @@ struct edid *drm_load_edid_firmware(struct drm_connector *connector)
> >  	 * the last one found one as a fallback.
> >  	 */
> >  	fwstr = kstrdup(edid_firmware, GFP_KERNEL);
> > +	if (!fwstr)
> > +		return ERR_PTR(-ENOMEM);
> >  	edidstr = fwstr;
> >  
> >  	while ((edidname = strsep(&edidstr, ","))) {
> > ---
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
