Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAFCC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98162227B9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbfGWJTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:19:51 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:34405 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGWJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:19:50 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5B183200B6;
        Tue, 23 Jul 2019 11:19:46 +0200 (CEST)
Date:   Tue, 23 Jul 2019 11:19:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Derek Basehore <dbasehore@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-mediatek@lists.infradead.org, Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/4] drm/panel: set display info in panel attach
Message-ID: <20190723091945.GD787@ravnborg.org>
References: <20190710021659.177950-1-dbasehore@chromium.org>
 <20190710021659.177950-3-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710021659.177950-3-dbasehore@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8
        a=e5mUnYsNAAAA:8 a=JKKMseLQFeVpvqDGF_IA:9 a=V_j96s7zFc6XEDQv:21
        a=BZ3M7_42R0vJoBCe:21 a=CjuIK1q_8ugA:10 a=xmb-EsYY8bH0VWELuYED:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Derek.

On Tue, Jul 09, 2019 at 07:16:57PM -0700, Derek Basehore wrote:
> Devicetree systems can set panel orientation via a panel binding, but
> there's no way, as is, to propagate this setting to the connector,
> where the property need to be added.
> To address this, this patch sets orientation, as well as other fixed
> values for the panel, in the drm_panel_attach function. These values
> are stored from probe in the drm_panel struct.

This approch seems to conflict with work done by Laurent where the
ownership/creation of the connector will be moved to the display controller.

If I understand it correct then there should not be a 1:1 relation
between a panel and a connector anymore.

We should not try to work in two different directions with this.
Laurent, can you comment on this?

If we move forard with this patch, then all fields in drm_panel needs
kernel-doc - preferably inline.

	Sam

> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/gpu/drm/drm_panel.c | 28 ++++++++++++++++++++++++++++
>  include/drm/drm_panel.h     | 14 ++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 169bab54d52d..ca01095470a9 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -104,11 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
>   */
>  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
>  {
> +	struct drm_display_info *info;
> +
>  	if (panel->connector)
>  		return -EBUSY;
>  
>  	panel->connector = connector;
>  	panel->drm = connector->dev;
> +	info = &connector->display_info;
> +	info->width_mm = panel->width_mm;
> +	info->height_mm = panel->height_mm;
> +	info->bpc = panel->bpc;
> +	info->panel_orientation = panel->orientation;
> +	info->bus_flags = panel->bus_flags;
> +	if (panel->bus_formats)
> +		drm_display_info_set_bus_formats(&connector->display_info,
> +						 panel->bus_formats,
> +						 panel->num_bus_formats);
>  
>  	return 0;
>  }
> @@ -128,6 +140,22 @@ EXPORT_SYMBOL(drm_panel_attach);
>   */
>  int drm_panel_detach(struct drm_panel *panel)
>  {
> +	struct drm_display_info *info;
> +
> +	if (!panel->connector)
> +		goto out;
> +
> +	info = &panel->connector->display_info;
> +	info->width_mm = 0;
> +	info->height_mm = 0;
> +	info->bpc = 0;
> +	info->panel_orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +	info->bus_flags = 0;
> +	kfree(info->bus_formats);
> +	info->bus_formats = NULL;
> +	info->num_bus_formats = 0;
> +
> +out:
>  	panel->connector = NULL;
>  	panel->drm = NULL;
>  
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index fc7da55f41d9..a6a881b987dd 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -39,6 +39,8 @@ enum drm_panel_orientation;
>   * struct drm_panel_funcs - perform operations on a given panel
>   * @disable: disable panel (turn off back light, etc.)
>   * @unprepare: turn off panel
> + * @detach: detach panel->connector (clear internal state, etc.)
> + * @attach: attach panel->connector (update internal state, etc.)
>   * @prepare: turn on panel and perform set up
>   * @enable: enable panel (turn on back light, etc.)
>   * @get_modes: add modes to the connector that the panel is attached to and
> @@ -95,6 +97,18 @@ struct drm_panel {
>  
>  	const struct drm_panel_funcs *funcs;
>  
> +	/*
> +	 * panel information to be set in the connector when the panel is
> +	 * attached.
> +	 */
> +	unsigned int width_mm;
> +	unsigned int height_mm;
> +	unsigned int bpc;
> +	int orientation;
> +	const u32 *bus_formats;
> +	unsigned int num_bus_formats;
> +	u32 bus_flags;
> +
>  	struct list_head list;
>  };
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
