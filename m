Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F047C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200FD2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="CMcLeAjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfCDQT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:19:28 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38485 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDQT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:19:28 -0500
Received: by mail-qt1-f195.google.com with SMTP id s1so5721161qte.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 08:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G6JjQy4sNWcoV84Bfh9N/HMfRiNH9A/wF3HlpPWPLzY=;
        b=CMcLeAjnW5UhJ/e1u+D4sxFHBBYdoUKtKzVLDWSd67YjzH9d7yNIMv0/kNVZ9Kepw/
         f1LYGeeU5GGpV0yPcb9556YuPjeVi1ftgqu5morUDZEqGHmkcJwZ10MdNQvBilNlTDMX
         +1QzW8Z+VWKO2CBdiEJeBvrhDvBR00RC3Zi2jpf77X9NOKeirrB2/Gurm0AySr141j2G
         0xiznwgy4bePKHZnX0QULoIY8YcUY/9Oms3VM+cBeQxp3Nix51asbw4+0n4IP3N7uREA
         Xvj+vIZrlHdhZ7SdgacWfQryd9y8qtfR+UHhkMM4Oo15tTlAd+ewoR21Gw1vjTMZmzhp
         Z1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G6JjQy4sNWcoV84Bfh9N/HMfRiNH9A/wF3HlpPWPLzY=;
        b=Zx4OrddEEyidIfU2U9jwewIAYIBlOTp/QAeRxDBBeaGkV75RXtqDbRHf7pyIucj5hs
         p29XiMcnpaCsYUK7a8tXft5wcSdnR9oDlq1RQ38XcgguiVDrEWDe+N4FbWePlRszNYL9
         1RltxIM5Zbj6VsWBrU58mejuZb9PWV0RDVYu1bcKwzF19oHFdZE5/Jz+dmHPZOyMlnGE
         uhlYqm5yUBkVQAmkFjg84q9axOsPSHtFhbkoCUzlWrw8ueIikpn1fipyHamuAIk6DKUT
         YArj38fMyJQXznyj6udqX1BqNzjHnAlnQy5tizNoJHh6ImcCalp6XiYVWUJMlX4UxEhd
         TImg==
X-Gm-Message-State: APjAAAV3vkpXnZo3ceSZUPJLJg0C5W6898Mg6L3Ku9BKgxUQxXMSYaWS
        6m0ckXIQzKEE8U/VUi2dRs3piQ==
X-Google-Smtp-Source: APXvYqyCzfXLTtxqcvUXMbq0iV2+HHco2CNCWvDB3SpgvB4WmhB801rII8V40PcRKjkLVJ69yS08jw==
X-Received: by 2002:ac8:2e16:: with SMTP id r22mr15253792qta.384.1551716366781;
        Mon, 04 Mar 2019 08:19:26 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id x32sm4247677qtj.32.2019.03.04.08.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 08:19:26 -0800 (PST)
Date:   Mon, 4 Mar 2019 11:19:25 -0500
From:   Sean Paul <sean@poorly.run>
To:     Colin King <colin.king@canonical.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fix spelling mistake "intead" -> "instead"
Message-ID: <20190304161925.GS114153@art_vandelay>
References: <20190217225554.17742-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217225554.17742-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 10:55:54PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a DRM_NOTE message. Fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to drm-misc-next, thanks.

Sean

> ---
>  drivers/gpu/drm/drm_kms_helper_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
> index 93e2b30fe1a5..9c5ae825c507 100644
> --- a/drivers/gpu/drm/drm_kms_helper_common.c
> +++ b/drivers/gpu/drm/drm_kms_helper_common.c
> @@ -39,7 +39,7 @@ MODULE_LICENSE("GPL and additional rights");
>  /* Backward compatibility for drm_kms_helper.edid_firmware */
>  static int edid_firmware_set(const char *val, const struct kernel_param *kp)
>  {
> -	DRM_NOTE("drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware intead.\n");
> +	DRM_NOTE("drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware instead.\n");
>  
>  	return __drm_set_edid_firmware_path(val);
>  }
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
