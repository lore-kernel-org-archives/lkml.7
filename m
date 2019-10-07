Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EF4C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1780B20659
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="W3fLoSUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfJGQsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:48:04 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34270 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfJGQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:48:04 -0400
Received: by mail-yw1-f65.google.com with SMTP id d192so5371948ywa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bQ7t0YfEyUi6/XxzSzzzJPgkBy/Y1npqi1QHUBdAdjs=;
        b=W3fLoSUrj8yJnZCMtZp+3Z2XubKePSGiIXKCTJtf8NgGqe6YfhNrC9bveRjZw6wpmF
         v9jzQ5j1VQP3GRAx44r0Jhgc8TJPiEB7XTnjchviKgXZI8nD3yG7I/WgoHu3YEtryVvz
         fG4rdsgZxIXFthOSjMaybVSlmOow3T3ljx0qxNCFJpkpmiiGPJBCNNOiY057IySo7EGV
         2yf1Zh1r/t+Q8vdPk8hNVF6FtTOalBTihx2aE1PTwc4qPBruNr0J8+YNM4KwX9C1BzCc
         g8jWzB0LOr31wuXEGyYlQ9E7EGPr+FHjDYwtdXdDlFUFtbYFK+7Ic2bLdoPaPMQMlzMz
         oOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bQ7t0YfEyUi6/XxzSzzzJPgkBy/Y1npqi1QHUBdAdjs=;
        b=KnFgyBNZjezk3lpu/ok9k3yn5qv9HfWeFv6umWZBIvlLse8GcfGN4CrHTktJ8elnbX
         IACwopcCeeY/YSuFGRWzVu3b5lyLxVCDufAcXW7gEYMKg/sW00lKyBX//iKOi1zeyDQc
         tyTlQ4UqgvY4FoXSZcrR/cYm5gchKHQ3k0q+a8aV4hLNAE2iep2mAlVEFXjW4xc9ToMA
         lPkAMJWB4ActhPRIHt8NNbf8bJ8OmaXzqwTen5h5cR0V6siPHhYoE0NVC1cYDNXT8KpA
         ZERjplEyiYULEo9cYJDzk8aC3B5MW9kQBStJU6QK5nVzbO16xWGkeqdlb1otAKPNsC2e
         HsZg==
X-Gm-Message-State: APjAAAVqwadYIKYIVv1GP5lzOzH1y4G+oKIkAjJnwT1zbZp8nhhgvBP1
        Qeb/oBQr06HeCTiEc6voGUKYHA==
X-Google-Smtp-Source: APXvYqzqFE/kG9F8NYrqeqGMnEJIHroH1DGoJ5wHOm/YlpjWwk8tZNWrYg1M2OA9pEzzh3ILFWBkWg==
X-Received: by 2002:a81:7b05:: with SMTP id w5mr20591060ywc.15.1570466883457;
        Mon, 07 Oct 2019 09:48:03 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id y129sm4181437ywy.41.2019.10.07.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:48:02 -0700 (PDT)
Date:   Mon, 7 Oct 2019 12:48:02 -0400
From:   Sean Paul <sean@poorly.run>
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 4/4] drm/mtk: add panel orientation property
Message-ID: <20191007164802.GD126146@art_vandelay>
References: <20190925225833.7310-1-dbasehore@chromium.org>
 <20190925225833.7310-5-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925225833.7310-5-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:58:33PM -0700, Derek Basehore wrote:
> This inits the panel orientation property for the mediatek dsi driver
> if the panel orientation (connector.display_info.panel_orientation) is
> not DRM_MODE_PANEL_ORIENTATION_UNKNOWN.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 224afb666881..2936932344eb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -792,10 +792,18 @@ static int mtk_dsi_create_connector(struct drm_device *drm, struct mtk_dsi *dsi)
>  			DRM_ERROR("Failed to attach panel to drm\n");
>  			goto err_connector_cleanup;
>  		}
> +
> +		ret = drm_connector_init_panel_orientation_property(&dsi->conn);
> +		if (ret) {
> +			DRM_ERROR("Failed to init panel orientation\n");
> +			goto err_panel_detach;
> +		}
>  	}
>  
>  	return 0;
>  
> +err_panel_detach:
> +	drm_panel_detach(dsi->panel);
>  err_connector_cleanup:
>  	drm_connector_cleanup(&dsi->conn);
>  	return ret;
> -- 
> 2.23.0.351.gc4317032e6-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
