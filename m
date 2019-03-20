Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40791C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5C72175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UgXys/Yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfCTJFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:05:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43502 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfCTJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:05:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so1779570wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQzgXpUy5ei3usYQ6WK/1U/tk6t8iy2sCzuXJ+U0vig=;
        b=UgXys/YktUaqh5iKlbOWxTmWg3gyfw+YYhCKEKYy8Ffc4Q3bT/vcAxcVmC/a8ChehE
         0DQpMrUjPnycI4dDMPctNdv/vMTumv/scmA8HR/k9E5g0SrOaYccZkPZWIDmjkyDJ2gV
         vgqkzvq081KY1dW3t966Qiicbk0SvGg16P+HN7ErdzxNP5ge33FJ7JGmcGZ8pTK79KQt
         Vjwo5adG0kfHRxOVOKZC84eJZepjlOXBnE2y35XXb+INM8hvKwJExy8vN86nc4SSaNLu
         LJT0wpo/FybSKPymcVUtQ+wqNm4+CzpAk5PmQGfYUpQrGlbeAEIC8D/QVlXhDB9lLRy8
         FDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQzgXpUy5ei3usYQ6WK/1U/tk6t8iy2sCzuXJ+U0vig=;
        b=A2zkVdH6oZ2dKYnOxum10c2ZI9Bf3P99Qu8Y78wRUH1GKg3ysueVWv1JkdO5rrgnmT
         bjzNn2SSXCkP/DFW6BaWVgTPinBEoFSlaEMWVhF3zvTP4ZC69cCbW+EGCAssNyhL6lur
         EfNkusW5g0a8rN3p2V03MghI1c+wv9U1DRaAmGfo94bY0aaM3/j7EJ1Gv1YTf+67Y5uo
         f9FfPScF4ztRm66bBsA1LKG2ZW6OJekPJ4JUJBtFNtVY/DtvkJ+h0iHO23W/MuUTZqBr
         3+eRLbsxVg8a0lTiOwsTpNG8pKh13hXPLlWlPHvDP2P7kYbM0cbr23MBZ2IlTlQPjQnb
         tsYQ==
X-Gm-Message-State: APjAAAVcQPLzcLBM8dds1jy322OVsmqpY0w6USvg+N/WnCKrwC3eJhS2
        aQtG0SmhuhXPBm2WOIthl6ROHIyborVA5NGJdNFktw==
X-Google-Smtp-Source: APXvYqzMkhGCQbYgprw3asmwlfB8aGzhKo6avgH+uXYdPwKKW+WTPm8sLLWF85att2OXv9+4n0TSeN6hJ+LrJZ1+0og=
X-Received: by 2002:a5d:6202:: with SMTP id y2mr20199699wru.29.1553072708376;
 Wed, 20 Mar 2019 02:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190320081110.1718-1-narmstrong@baylibre.com>
In-Reply-To: <20190320081110.1718-1-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Wed, 20 Mar 2019 10:04:57 +0100
Message-ID: <CAMO6naz5bqq7_S_y4yFR-ALinB3ApoE3z3m_fymP2RbaqRotAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: fix TMDS clock filtering for DMT monitors
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,
On Wed, Mar 20, 2019 at 9:11 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> DMT monitors does not necessarely report a maximum TMDS clock
> in a VSDB EDID extension.
>
> In this case, all modes are wrongly rejected, including
> the DRM fallback EDID.
>
> This patch only rejects modes whith clock > max_tmds_clock if
> the max_tmds_clock is specified. This will only reject
> 4:2:0 HDMI2.0 modes, who reports a clock > max_tmds_clock.
>
> Reported-by: Maxime Jourdan <mjourdan@baylibre.com>
> Fixes: d7d8fb7046b6 ("drm/meson: add HDMI div40 TMDS mode")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> index e28814f4ea6c..563953ec6ad0 100644
> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
> @@ -569,7 +569,8 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
>         DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
>
>         /* If sink max TMDS clock, we reject the mode */
> -       if (mode->clock > connector->display_info.max_tmds_clock)
> +       if (connector->display_info.max_tmds_clock &&
> +           mode->clock > connector->display_info.max_tmds_clock)
>                 return MODE_BAD;
>
>         /* Check against non-VIC supported modes */
> --
> 2.21.0
>

Thanks, this patch restores HDMI output with my old 1080p TV which
does not specify a max tmds clock in its EDID. (all modes were
considered BAD before).

Tested-by: Maxime Jourdan <mjourdan@baylibre.com>
Reviewed-by: Maxime Jourdan <mjourdan@baylibre.com>
