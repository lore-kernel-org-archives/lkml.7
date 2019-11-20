Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820B1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6D220878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hRL2tDCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbfKTQgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:36:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40301 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfKTQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:36:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id y5so283135wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=omWiA+8UvJju/f0RhpZnlfMjZi7KNti/SjVz56D+iCM=;
        b=hRL2tDCx6el6phLJYT7VKJlIX9kzoD6aoLA5K6Quu6d5IPDsTr71zv52h72hxlh+ts
         k5xd6qylRBcFDMnPQKbpMvLHiYgFgMcW1GfxLnNLg2AfBMLsqmVYQBi2W3R9QPzs6Rkz
         MKweV/MqvChxeLfqbXRa8L6PYJhM9s3X4dxIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=omWiA+8UvJju/f0RhpZnlfMjZi7KNti/SjVz56D+iCM=;
        b=YTKHvUP+EgBDu8SAlEI40xCyinguz7gkk2sAjxvfdrDwjdzLnGHmYiTGA+XmJhu/FG
         23am97xvOFgKTmL1qe9hoa//8esm0F1tfJjWMo2PcKV2badZ0tC3iFhmAzaUt8w2jePq
         EmZEjVpG/OHlLECDbPt/FXXHV1UiRmXiA7XB68SI1m/vEnFCHqiCD3K3hAgGDbJkvyGZ
         nrJaG01Wgw+Jn3yEPeuijYH79Taxjo4H/a9K63P8ciaekzy+mmMNN1DrI6Q98qS4dOvE
         dMqJvezsmahly9hJao0ayGbesSizR6uF6kac88sRCM3TTWMW3Og/enTVMXFNDnXS+F1T
         JTbA==
X-Gm-Message-State: APjAAAUX7w1xFyy10DCiyRarNkY45BpuuEB1zuq+zC7yELx+kPd/297E
        8/K5dpv972Ak3LIow58Us2XqCQ==
X-Google-Smtp-Source: APXvYqzIBVBtoDa0M7K4+BNAPUZpAVBHu/NYxZkMSpGxBdxeihs2POYM3n+zTBi3yyJULegORyw67Q==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr4209118wme.57.1574267766731;
        Wed, 20 Nov 2019 08:36:06 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id y189sm7313992wmb.13.2019.11.20.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:36:06 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:36:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/udl: Fix Kconfig indentation
Message-ID: <20191120163604.GM30416@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <20191120133341.6582-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120133341.6582-1-krzk@kernel.org>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:33:41PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Queued for 5.6 in drm-misc, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/drm/udl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/udl/Kconfig b/drivers/gpu/drm/udl/Kconfig
> index b4d179b87f01..b13aa33990f3 100644
> --- a/drivers/gpu/drm/udl/Kconfig
> +++ b/drivers/gpu/drm/udl/Kconfig
> @@ -8,4 +8,4 @@ config DRM_UDL
>  	select DRM_KMS_HELPER
>  	help
>  	  This is a KMS driver for the USB displaylink video adapters.
> -          Say M/Y to add support for these devices via drm/kms interfaces.
> +	  Say M/Y to add support for these devices via drm/kms interfaces.
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
