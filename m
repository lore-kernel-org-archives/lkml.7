Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95718C2D0CB
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDFB206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 12:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfLOMf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 07:35:59 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:50834 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfLOMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 07:35:59 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 17A26804FC;
        Sun, 15 Dec 2019 13:35:52 +0100 (CET)
Date:   Sun, 15 Dec 2019 13:35:51 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org,
        sj.huang@mediatek.com
Subject: Re: [PATCH] drm/panel: seperate panel power control from panel
 prepare/unprepare
Message-ID: <20191215123551.GA32327@ravnborg.org>
References: <20191106064005.8016-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106064005.8016-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=mpaa-ttXAAAA:8
        a=UN12_I82iCspjviWGz0A:9 a=CjuIK1q_8ugA:10 a=6heAxKwa5pAsJatQ0mat:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jitao.

On Wed, Nov 06, 2019 at 02:40:05PM +0800, Jitao Shi wrote:
> Some dsi panels require the dsi lanes keeping low before panel power
> on. So seperate the panel power control and the communication with panel.
> 
> And put the power control in drm_panel_prepare_power and
> drm_panel_unprepare_power. Put the communication with panel in
> drm_panel_prepare and drm_panel_unprepare.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Panels that requires power before communicating often/always have
some timing constraints. Power need to be applied in XYZ micro seconds
before it is safe to communicate with the panel.

To support this a typical pattern is:

panel_xxx_prepare()
{
   // power on the panel using one or a few regulators

   // wait until panel is known to be ready

   // Communicate with the panel

}

first driver I looked at (panel-feiyang-fy07024di26a30d.c) follows this
pattern.

So we have the timing spelled out in the enable() function
and the sequence is obvious.


What will the benefit be from a separate drm_panel_prepare_power()
function pointer?

	Sam


> ---
>  drivers/gpu/drm/drm_panel.c | 38 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     | 17 +++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 6b0bf42039cf..e57f6385d2cc 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -131,6 +131,24 @@ void drm_panel_detach(struct drm_panel *panel)
>  }
>  EXPORT_SYMBOL(drm_panel_detach);
>  
> +/**
> + * drm_panel_prepare_power - power on a panel's power
> + * @panel: DRM panel
> + *
> + * Calling this function will enable power and deassert any reset signals to
> + * the panel.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_panel_prepare_power(struct drm_panel *panel)
> +{
> +	if (panel && panel->funcs && panel->funcs->prepare_power)
> +		return panel->funcs->prepare_power(panel);
> +
> +	return panel ? -ENOSYS : -EINVAL;
> +}
> +EXPORT_SYMBOL(drm_panel_prepare_power);
> +
>  /**
>   * drm_panel_prepare - power on a panel
>   * @panel: DRM panel
> @@ -170,6 +188,26 @@ int drm_panel_unprepare(struct drm_panel *panel)
>  }
>  EXPORT_SYMBOL(drm_panel_unprepare);
>  
> +/**
> + * drm_panel_unprepare_power - power off a panel
> + * @panel: DRM panel
> + *
> + * Calling this function will completely power off a panel (assert the panel's
> + * reset, turn off power supplies, ...). After this function has completed, it
> + * is usually no longer possible to communicate with the panel until another
> + * call to drm_panel_prepare_power and drm_panel_prepare().
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_panel_unprepare_power(struct drm_panel *panel)
> +{
> +	if (panel && panel->funcs && panel->funcs->unprepare_power)
> +		return panel->funcs->unprepare_power(panel);
> +
> +	return panel ? -ENOSYS : -EINVAL;
> +}
> +EXPORT_SYMBOL(drm_panel_unprepare_power);
> +
>  /**
>   * drm_panel_enable - enable a panel
>   * @panel: DRM panel
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 624bd15ecfab..0d8c4855405c 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -61,6 +61,13 @@ struct display_timing;
>   * the panel. This is the job of the .unprepare() function.
>   */
>  struct drm_panel_funcs {
> +	/**
> +	 * @prepare_power:
> +	 *
> +	 * Turn on panel power.
> +	 */
> +	int (*prepare_power)(struct drm_panel *panel);
> +
>  	/**
>  	 * @prepare:
>  	 *
> @@ -89,6 +96,13 @@ struct drm_panel_funcs {
>  	 */
>  	int (*unprepare)(struct drm_panel *panel);
>  
> +	/**
> +	 * @unprepare_power:
> +	 *
> +	 * Turn off panel_power.
> +	 */
> +	int (*unprepare_power)(struct drm_panel *panel);
> +
>  	/**
>  	 * @get_modes:
>  	 *
> @@ -155,6 +169,9 @@ void drm_panel_remove(struct drm_panel *panel);
>  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector);
>  void drm_panel_detach(struct drm_panel *panel);
>  
> +int drm_panel_prepare_power(struct drm_panel *panel);
> +int drm_panel_unprepare_power(struct drm_panel *panel);
> +
>  int drm_panel_prepare(struct drm_panel *panel);
>  int drm_panel_unprepare(struct drm_panel *panel);
>  
> -- 
> 2.21.0
