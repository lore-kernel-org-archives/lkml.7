Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E58C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38BF20862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbfJDT1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:27:23 -0400
Received: from foss.arm.com ([217.140.110.172]:53228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfJDT1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:27:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D72F15AB;
        Fri,  4 Oct 2019 12:27:22 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEACE3F534;
        Fri,  4 Oct 2019 12:27:21 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 90F28682570; Fri,  4 Oct 2019 20:27:20 +0100 (BST)
Date:   Fri, 4 Oct 2019 20:27:20 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     James Wang <james.qian.wang@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/komeda: remove redundant assignment to pointer
 disable_done
Message-ID: <20191004192720.7eiqdvsm2yv62svg@e110455-lin.cambridge.arm.com>
References: <20191004162156.325-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004162156.325-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 05:21:56PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer disable_done is being initialized with a value that
> is never read and is being re-assigned a little later on. The
> assignment is redundant and hence can be removed.

Not really true, isn't it? The re-assignment is done under the condition that
crtc->state->active is true. disable_done will be used regardless after the if
block, so we can't skip this initialisation.

Not sure why Coverity flags this, but I would NAK this patch.

Best regards,
Liviu

> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 75263d8cd0bd..9beeda04818b 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -296,7 +296,7 @@ komeda_crtc_atomic_disable(struct drm_crtc *crtc,
>  	struct komeda_crtc_state *old_st = to_kcrtc_st(old);
>  	struct komeda_pipeline *master = kcrtc->master;
>  	struct komeda_pipeline *slave  = kcrtc->slave;
> -	struct completion *disable_done = &crtc->state->commit->flip_done;
> +	struct completion *disable_done;
>  	bool needs_phase2 = false;
>  
>  	DRM_DEBUG_ATOMIC("CRTC%d_DISABLE: active_pipes: 0x%x, affected: 0x%x\n",
> -- 
> 2.20.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
