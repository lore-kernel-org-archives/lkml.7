Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BEC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73601208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfE0U3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:29:37 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:54410 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0U3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:29:37 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 5422180349;
        Mon, 27 May 2019 22:29:34 +0200 (CEST)
Date:   Mon, 27 May 2019 22:29:32 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, od@zcrc.me,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Extend drm_bus_flags? [Was: [PATCH v3 2/3] drm: Add bus flag for
 Sharp-specific signals]
Message-ID: <20190527202932.GA28319@ravnborg.org>
References: <20190425231854.24479-1-paul@crapouillou.net>
 <20190425231854.24479-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425231854.24479-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8
        a=e5mUnYsNAAAA:8 a=o6lnpZa0LUvyYah9iqMA:9 a=CjuIK1q_8ugA:10
        a=9LHmKk7ezEChjTCyhBa9:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Please see mail below - is it OK to extend drm_bus_flags to
represent "SHARP signals"?

Paul (and I) could not find any better way to let the panel tell the
display driver that it requires the special SHARP signals.

This has been pending almost a month now and it would only be fair
to either accept the solution or to give Paul guidiance how to move
forward.

There is a display driver that awaits the resilutions of this issue.

	Sam

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
>  
>  /**
> -- 
> 2.21.0.593.g511ec345e18
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
