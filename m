Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C724AC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F788208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="aTccKlPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfEMWZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:25:49 -0400
Received: from onstation.org ([52.200.56.107]:41112 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbfEMWZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:25:49 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 8BB1F44970;
        Mon, 13 May 2019 22:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1557786348;
        bh=WG9zRTna5JnQXnaHyxtn3T7a3OqxN5oqCrPNGTOLtWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTccKlPYNf2/bHvNairklSh5B+qdpDj4RYT3xreYv2BBMSjDZ5pboplX6bkZkuXY2
         a+pCqRXfvDyUyKIHDWZpQdtJ0LkZDmr/vSkVgUDaxrw2P3Fx4nY3uoehCebnatKLoN
         ya9WVpjTN/v01gaBqpOl+0ma+Vv2PY3fauaAMTUU=
Date:   Mon, 13 May 2019 18:25:47 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     robdclark@gmail.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        jonathan@marek.ca, robh@kernel.org
Subject: Re: [PATCH v2 1/6] drm: msm: remove resv fields from msm_gem_object
 struct
Message-ID: <20190513222547.GA6435@basecamp>
References: <20190509020352.14282-1-masneyb@onstation.org>
 <20190509020352.14282-2-masneyb@onstation.org>
 <20190513203239.GA9527@builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513203239.GA9527@builder>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 01:32:39PM -0700, Bjorn Andersson wrote:
> On Wed 08 May 19:03 PDT 2019, Brian Masney wrote:
> 
> > The msm_gem_object structure contains resv and _resv fields that are
> > no longer needed since the reservation object is now stored on
> > drm_gem_object. msm_atomic_prepare_fb() and msm_atomic_prepare_fb()
> > both referenced the wrong reservation object, and would lead to an
> > attempt to dereference a NULL pointer. Correct those two cases to
> > point to the correct reservation object.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Fixes: dd55cf6929e6 ("drm: msm: Switch to use drm_gem_object reservation_object")
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> This resolves a NULL-pointer dereference about to show up in v5.2-rc1,
> so please pick this up for -rc.

Let me send out another version of just this patch. This snippet below
that I removed needs to stay. I got a little too over eager removing
code.

> > @@ -973,9 +973,6 @@ static int msm_gem_new_impl(struct drm_device *dev,
> >  	msm_obj->flags = flags;
> >  	msm_obj->madv = MSM_MADV_WILLNEED;
> >  
> > -	if (resv)
> > -		msm_obj->base.resv = resv;
> > -
> >  	INIT_LIST_HEAD(&msm_obj->submit_entry);
> >  	INIT_LIST_HEAD(&msm_obj->vmas);
> >  

Brian
