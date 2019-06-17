Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DE6C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04EE217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LizGSr8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfFQDnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:43:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37207 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfFQDnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:43:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so4879838pfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 20:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=taZZTmqZDJ/thPE/pxrihvxmQccJO4Nc9IvueiEvDBc=;
        b=LizGSr8PfLFiYmns24CLOA6uq9rPTN5J9LMubsnAbQe9RV6tkwJrBNTXdptYXq5mw6
         2vnAvivFmjogvwYbXezf+fKUXJcvI0ecCe2WwoN+nfbyRhMIXvBOmBsgZXZt3TBt/2fj
         2bHdNuQrZjAK3MXJeXs7UjYdTfWqIl3/vAdFohqW2i07pgBld5KNgDuU+Y7o/0NxgqMZ
         7Oh3ewUcSgElC1cHriL60uKCNP919CvPmoBjHYgMoQydxVUWR5Og1bbD6uU7nkS8isH4
         /0119BZ4/nBZy7YDTKG+phwyoX7Ze8Npbz4FRbVFGK964mxOh8Yds774GqIya6KgN5uK
         zQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=taZZTmqZDJ/thPE/pxrihvxmQccJO4Nc9IvueiEvDBc=;
        b=FKjT5N4S/QRr7Eoi32UO3rEBeeX9dUdHJP0+VZPLaDGwmJggUyE3UFsekStnUu9E/m
         0UuVbRB3XXAWVcXvjddhrp+Ht8LBBZweXRWmkPEUTS6TOSmquEILRtOJ3jwXgsA/BCt4
         aBYH/RbUHxcyT/ObpTNxz547C2GDCgDD0JYRGINmmF5oGQ4Fx/0YOrutKEg9kMEQlH4R
         WhdyM+/Sx2He7JSFQLal9ekNd9b5kjvSEiU14z3t/nxbXhh4tWqjC88/uwZv32APf5qV
         DOELntW6f94goGdCTvsVVHBxQGClwUWBfN4JLKtZnYUVpEkam++fZ1kqK/6ZFTMorbz+
         SfmA==
X-Gm-Message-State: APjAAAUZ1H6tMZAgVqjFleyl7BBn6Dr0AF4fHd7tz/DA2H+dmpdr1qHh
        U5mw6TU4Y/4u3Doauod3pzj7kg==
X-Google-Smtp-Source: APXvYqxi14hXWZ21/68Cghl+12pHyJ8hnJvsh96H3bdcGwm+nFCpyQijLNQF3h2LfUM4gAlDChUV4A==
X-Received: by 2002:aa7:9ad2:: with SMTP id x18mr31710822pfp.192.1560742983352;
        Sun, 16 Jun 2019 20:43:03 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f7sm8791031pfd.43.2019.06.16.20.43.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 20:43:02 -0700 (PDT)
Date:   Sun, 16 Jun 2019 20:43:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
        sean@poorly.run, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mark.rutland@arm.com, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/6] drm/msm/gpu: add ocmem init/cleanup functions
Message-ID: <20190617034351.GA750@tuxbook-pro>
References: <20190616132930.6942-1-masneyb@onstation.org>
 <20190616132930.6942-7-masneyb@onstation.org>
 <20190616180633.GS22737@tuxbook-pro>
 <20190617001851.GA19038@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617001851.GA19038@onstation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 16 Jun 17:18 PDT 2019, Brian Masney wrote:

> Hi Bjorn,
> 
> On Sun, Jun 16, 2019 at 11:06:33AM -0700, Bjorn Andersson wrote:
> > > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > index 6f7f4114afcf..e0a9409c8a32 100644
> > > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> > > @@ -29,6 +29,10 @@
> > >  #include "msm_gem.h"
> > >  #include "msm_mmu.h"
> > >  
> > > +#ifdef CONFIG_QCOM_OCMEM
> > > +#  include <soc/qcom/ocmem.h>
> > > +#endif
> > 
> > This file exists (after the previous patch), so no need to make its
> > inclusion conditional.
> > 
> > > +
> > >  static bool zap_available = true;
> > >  
> > >  static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
> > > @@ -897,6 +901,43 @@ static int adreno_get_pwrlevels(struct device *dev,
> > >  	return 0;
> > >  }
> > >  
> > > +int adreno_gpu_ocmem_init(struct device *dev, struct adreno_gpu *adreno_gpu,
> > > +			  struct adreno_ocmem *adreno_ocmem)
> > > +{
> > > +#ifdef CONFIG_QCOM_OCMEM
> > 
> > No need to make this conditional.
> 
> I have these #ifdefs for the a5xx and a6xx GPUs that don't have ocmem
> in the SoC. Without the #ifdefs, those systems would need to have the
> ocmem driver in their kernel.
> 

In order to provide the means for compiling a kernel for a[56]xx without
having to compile ocmem you should move these #ifdef to the ocmem
header file and provide static inline dummies for the case when it's
not.

(and use #if IS_ENABLED(CONFIG_FOO))

Don't forget to add
	depends on QCOM_OCMEM || QCOM_OCMEM=n

to the DRM_MSM config option, to allow the driver pair to be selected in
all possible ways.

> Thanks for the quick review on the patch set!
> 

Regards,
Bjorn
