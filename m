Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EC7C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A3E20870
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 18:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPq6Ucvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfFPSl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 14:41:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41201 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfFPSl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 14:41:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so4390710pff.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNvZcOSuQ6Jo5g5X5I/VGQiYgRCh/h5EB0cesihBsnI=;
        b=TPq6UcvtY+KPybGnKrsDikqW2MaIX+aohw9pbuiKDdiQf5hTqkQfsieip1zN4C2uil
         GtxVS7XrVdVGrSOTxZDf2IqdmTTg5QybgbEYeteT/1ZvGe2bWwnkaPpwgpcVy79JG3Ts
         +fkzSZhLZdIi9pz5PZUerxHMQ1fzkpNcSuZME3AxNc4iWuCLJu1wlDQ/dSqsi7Os7tTz
         5oKcOYUubD+BlvvE5J+PkAB3RbdioJAn5hs5MaYj2fGUVGWv0NrcuxZ7a0fvoUQUP1Pi
         uYfaH+8bvapuZEUnj0YTsJqSfCHyTbVY7i871hw4JHB/jmNl1v7dcUf/8njRNs3UNxH8
         T2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNvZcOSuQ6Jo5g5X5I/VGQiYgRCh/h5EB0cesihBsnI=;
        b=mL4t7cN2Oat4rXtxHBRRr9qrfWpGXz3SEpDtxzmMOTEJjlaJloG1crpvDkvGkxngi+
         bBZ+FmmP/6W4QcfNWhDCPtsrcFg7nyfZLh0j8B8oQL3BAvz9WocgyWywtzkII1VdQ2zM
         OLV8k06FvsXE9ePLsn43Px+ZS7QlrhPEZwBiouVMviQ8hwd2VSlUDFQ7+o5OjuhDUeIQ
         80H5dIcOIxEH3Ry6ka38jPdKm8CsTd4WWEnHpjyiqCPk2iB5zcA3kYX7jg0tf4Rs79YM
         U/B211F7gZqpvMasu1epW5T1K2TyUMFyKxlsE4rGdLezj+NNZWEC3bpAEqhgkIMQn/xY
         wYAA==
X-Gm-Message-State: APjAAAUiwHPawu9d2/SOCr5pJF+PTIzUR7cqlFA27tjup1WqqQdsY7Ji
        cozTS8vd9RinAg1THPZ0DTackg==
X-Google-Smtp-Source: APXvYqy8MuYCLwgfLGoyJOgT82CHJUmXEuT5fIIqofVBorJEHKOsOlQnSDu/DtY+3CVsdMhADzy8GA==
X-Received: by 2002:a65:5945:: with SMTP id g5mr13189053pgu.169.1560710485691;
        Sun, 16 Jun 2019 11:41:25 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y185sm9392105pfy.110.2019.06.16.11.41.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 11:41:25 -0700 (PDT)
Date:   Sun, 16 Jun 2019 11:42:12 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, sean@poorly.run,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        jonathan@marek.ca, robh@kernel.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v3 0/6] ARM: qcom: working Nexus 5 display support
Message-ID: <20190616184212.GD31088@tuxbook-pro>
References: <20190531094619.31704-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531094619.31704-1-masneyb@onstation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31 May 02:46 PDT 2019, Brian Masney wrote:

> This patch series adds working display support to the LG Nexus 5
> (hammerhead) phone.
> 
> Changes since v2:
> - Dropped two drm/msm bug fix patches that have been merged separately.
> - New patch: 'add support for per-CRTC max_vblank_count on mdp5'.
>   Special thanks to Jeffrey Hugo for helping to track down this issue.
> - Add panel_pin to msm8974-hammerhead device tree. Dropped Linus
>   Walleij's reviewed-by on this patch due to this change.
> 
> Changes since v1:
> - Shortened problem description above. I'll reply to this email and send
>   a full dmesg with the boot log with debugging turned on.
> - Dropped patch 'fix null pointer dereference in
>   msm_atomic_prepare_fb()'
> - New patch: Remove resv fields from msm_gem_object struct that was
>   incorrectly being referenced by the prepare_fb callbacks.
> - Add drm_plane_enable_fb_damage_clips() to plane init for mdp4, mdp5,
>   and dpu1.
> - Add Linus Walleij's reviewed-by to patches 3-6
> 
> My status page at https://masneyb.github.io/nexus-5-upstream/
> describes what is working so far with the upstream kernel on the Nexus
> 5.
> 

Assuming that patches 1 and 2 won't affect the dts and applied patches 3
through 6 for v5.3.

Regards,
Bjorn

> Brian Masney (6):
>   drm/msm: add dirty framebuffer helper
>   drm/msm: add support for per-CRTC max_vblank_count on mdp5
>   ARM: qcom_defconfig: add display-related options
>   ARM: dts: qcom: msm8974-hammerhead: add support for backlight
>   ARM: dts: msm8974: add display support
>   ARM: dts: qcom: msm8974-hammerhead: add support for display
> 
>  .../qcom-msm8974-lge-nexus5-hammerhead.dts    |  92 ++++++++++++
>  arch/arm/boot/dts/qcom-msm8974.dtsi           | 132 ++++++++++++++++++
>  arch/arm/configs/qcom_defconfig               |   5 +
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |   3 +
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c    |   3 +
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c     |  16 ++-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      |   2 +-
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c    |   3 +
>  drivers/gpu/drm/msm/msm_fb.c                  |   2 +
>  9 files changed, 256 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1
> 
