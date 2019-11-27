Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DF8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC94320684
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DSeeNl4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK0Ldm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:33:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35426 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK0Ldm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:33:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id n5so7071836wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 03:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b/oO5LgHIVezHDa0lWHiVZRMYVl3WjVpcB8Rma2bE0Q=;
        b=DSeeNl4igiUFnQKTSKwXvgHohVfm3OC/tKrYXjjxIPHl/mKpkRiGsJPZvB0LRQMR9/
         snerCB4pXivXSs9anz2HALpOv2YGaoW118K6PyfcfnYTaemYeB591cJoLMnYhBRclEY6
         EP2UpXz33jTdNZJF/IeZy2+EPIyJ2ogsioj3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=b/oO5LgHIVezHDa0lWHiVZRMYVl3WjVpcB8Rma2bE0Q=;
        b=CeoVAmwESbyBqAKRwV4QQ/SLrEq40uMNy3y+utVSpOnqyotIffrl+Sh4y9Aee+ZsYw
         yZcsqt4/r1/TkAYKMRuaRRv/9XXiKPSZwVAtpEb8HnQT1W4dL8nfVOfTAfVWtiiLOHXR
         KPkS9R1TddS+UDoYWhYH0syanu7IPR4gdnl46UipETyLiPvTapXVZTt4MpqnhKzeUjvK
         /m4lfVhiW89lYClW5ZOAbCXkxfvGACWzDC1tyveiLOtvett7XEKDIeQ7vgZ3L78PXVj8
         QqfpP+C21Qe25Ugjrh/LmuWuzjq/eqj9kpdfAtKtnL/JiNrsD/c+FAuOMQx/U0EjKuHB
         QA9g==
X-Gm-Message-State: APjAAAVPJA2ABPRy9iZ6q8CW+kAweNkQb65FXBVjd0IxgFqPJt46Lr1R
        fcIkYru4Gb4//oGJ5TcMqO/5Fg==
X-Google-Smtp-Source: APXvYqxdj4Cb0sM2R96ZUr1ajQFtYGm88VO/1g5Vy4S4C3IPuqYDDBKqaecA00hOMA81KjJPgvGlUg==
X-Received: by 2002:a1c:3d8a:: with SMTP id k132mr3750438wma.144.1574854418904;
        Wed, 27 Nov 2019 03:33:38 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id m15sm18702608wrq.97.2019.11.27.03.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 03:33:38 -0800 (PST)
Date:   Wed, 27 Nov 2019 12:33:36 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Yannick Fertre <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: check post disable
Message-ID: <20191127113336.GB406127@phenom.ffwll.local>
Mail-Followup-To: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1574850165-13135-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574850165-13135-1-git-send-email-yannick.fertre@st.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 11:22:45AM +0100, Yannick Fertre wrote:
> From: Yannick Fertré <yannick.fertre@st.com>
> 
> Some bridges did not registered the post_disable function.
> To avoid a crash, check it before calling.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index cc806ba..1e37233 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -886,7 +886,8 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
>  	 * This needs to be fixed in the drm_bridge framework and the API
>  	 * needs to be updated to manage our own call chains...
>  	 */
> -	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
> +	if (dsi->panel_bridge->funcs->post_disable)
> +		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
>  
>  	if (dsi->slave) {
>  		dw_mipi_dsi_disable(dsi->slave);
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
