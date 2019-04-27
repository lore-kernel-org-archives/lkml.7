Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1D6C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E700205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfD0GcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:32:20 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:56125 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfD0GcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:32:20 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 109D120025;
        Sat, 27 Apr 2019 08:32:15 +0200 (CEST)
Date:   Sat, 27 Apr 2019 08:32:14 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm: Add bus flag for Sharp-specific signals
Message-ID: <20190427063214.GA13123@ravnborg.org>
References: <20190425231854.24479-1-paul@crapouillou.net>
 <20190425231854.24479-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425231854.24479-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=7gkXJVJtAAAA:8 a=o6lnpZa0LUvyYah9iqMA:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

On Fri, Apr 26, 2019 at 01:18:53AM +0200, Paul Cercueil wrote:
> Add the DRM_BUS_FLAG_SHARP_SIGNALS to the drm_bus_flags enum.
> 
> This flags can be used when the display must be driven with the
> Sharp-specific signals SPL, CLS, REV, PS.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v3: New patch
> 
>  include/drm/drm_connector.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 02a131202add..ac7d58fd1e03 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -323,6 +323,8 @@ enum drm_panel_orientation {
>   *					edge of the pixel clock
>   * @DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE:	Sync signals are sampled on the falling
>   *					edge of the pixel clock
> + * @DRM_BUS_FLAG_SHARP_SIGNALS:		Set if the Sharp-specific signals
> + *					(SPL, CLS, PS, REV) must be used
>   */
>  enum drm_bus_flags {
>  	DRM_BUS_FLAG_DE_LOW = BIT(0),
> @@ -341,6 +343,7 @@ enum drm_bus_flags {
>  	DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE = DRM_BUS_FLAG_SYNC_NEGEDGE,
>  	DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE = DRM_BUS_FLAG_SYNC_NEGEDGE,
>  	DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE = DRM_BUS_FLAG_SYNC_POSEDGE,
> +	DRM_BUS_FLAG_SHARP_SIGNALS = BIT(8),
>  };

This solutions looks very good to me.
Now the panel can report to the display driver that is needs the
DRM_BUS_FLAG_SHARP_SIGNALS, so the display driver can adapt to the
connected display.
Obviously not many display drivers will support DRM_BUS_FLAG_SHARP_SIGNALS
but the one that does now no longer need to include panel configuration.

You can add:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

But we need Thierry or someone else with more knowledge in this
area to comment on this before we can apply it.
drm_bus_flag is today only timing related config, and there be a better
way to do this.

Thierry?

	Sam
