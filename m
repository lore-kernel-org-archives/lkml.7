Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCC4C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29819218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="dNLB2bp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfIRPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:35:18 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33032 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730523AbfIRPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:35:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id j128so112220ywf.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WXRR5zyqVQASQ4N9vA9Ov0ItwFdEJLRSuq1ARX/xesM=;
        b=dNLB2bp3hfKDZc3abQIP7Oj8s66zGdtSp4haltezOEd6bKHKjGfSMozAqh6lGbdzjr
         Ij1QeFFZcQRSypfUAksMR/Lw23q0Q055c2yADGVxFSBn7g3+840ox0TbRwukGFMqe8GU
         jLSX6NFkEzBstjyRVOvShg73Ts1xvP9nGSrwSzgp81g8YRJ5+gdnWqTRS5AEZukRyB2a
         Tr342gQGPH2Gb6+Mz0CxM7drrTwr3haV5dqeSkF0U30vLD2nPCGVlhBbJdxNCBx+6R4d
         h0bEKIsWN0WErgB+hX61fDRGmDPfOfNAzKbBgKsSX6CQE3a4pc/R22V54rnEIApO3bAS
         dCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXRR5zyqVQASQ4N9vA9Ov0ItwFdEJLRSuq1ARX/xesM=;
        b=bAHZhT+uN8Pgqf7T5XDOpa3lm2k6tkxN8HN+tpR18DfUhV8IyuaoFQmUxiOGLRt3Oy
         GqlmMgC3zmE4f4jIZ/kf6GG0o9xWxdKwROWnOQggbCL0+cfSHtg/nqcUVRxnT3yCItZj
         JUdpLpGlZ0Ylr2JaggaDTCtN7mmsRfS7o5FAF3VrQLtCqGgDURuI0IyQk4WfL7kbUTqv
         klU04isJyHDjKuqsunx2oMHq8U3gabAvKowhK4JCUIJdvIDaGyulTcYv6+xEEUXr/IwG
         QJ0t/KATSBENB3MX1+brDoUntnVPOA+5mEQQapepA3yDOTMMt3qWjwJ6lgfLna3MLxiI
         Gq8w==
X-Gm-Message-State: APjAAAWdAnqU6FPYxtOL/1FVtIimkwCEoTDkJJuImSFcRuKPSJWQUiXa
        qGHnGnYysPT8aJJukRQnCrLAZg==
X-Google-Smtp-Source: APXvYqz1D2kt/w72OnVw3WwBQ3uRSgZrxojXH1V2r/86e2KhMJ6L8LT/IJavDbljbLIdEBUfDjqCbQ==
X-Received: by 2002:a81:a347:: with SMTP id a68mr3744553ywh.427.1568820917136;
        Wed, 18 Sep 2019 08:35:17 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id i62sm1299104ywi.102.2019.09.18.08.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 08:35:16 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:35:15 -0400
From:   Sean Paul <sean@poorly.run>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com
Subject: Re: [PATCH v6 2/8] drm/panel: support for BOE tv101wum-nl6 wuxga dsi
 video mode panel
Message-ID: <20190918153515.GS218215@art_vandelay>
References: <20190918122422.17339-1-jitao.shi@mediatek.com>
 <20190918122422.17339-3-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918122422.17339-3-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 08:24:16PM +0800, Jitao Shi wrote:
> Add driver for BOE tv101wum-nl6 panel is a 10.1" 1200x1920 panel.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 709 ++++++++++++++++++
>  3 files changed, 719 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> 
/snip

> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> new file mode 100644
> index 000000000000..e27529b80d78
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c

/snip

> +static int boe_panel_init(struct boe_panel *boe)
> +{
> +	struct mipi_dsi_device *dsi = boe->dsi;
> +	struct drm_panel *panel = &boe->base;
> +	int err, i;
> +
> +	if (boe->desc->init_cmds) {
> +		const struct panel_init_cmd *init_cmds = boe->desc->init_cmds;
> +
> +		for (i = 0; init_cmds[i].len != 0; i++) {
> +			const struct panel_init_cmd *cmd = &init_cmds[i];
> +
> +			switch (cmd->type) {
> +			case DELAY_CMD:
> +				msleep(cmd->data[0]);
> +				err = 0;
> +				break;
> +
> +			case INIT_DCS_CMD:
> +				err = mipi_dsi_dcs_write(dsi, cmd->data[0],
> +							 cmd->len <= 1 ? NULL :
> +							 &cmd->data[1],
> +							 cmd->len - 1);
> +				break;
> +			}
> +
> +			if (err < 0) {

err possibly used uninitialized here.

> +				dev_err(panel->dev,
> +					"failed to write command %u\n", i);
> +				return err;
> +			}
> +		}
> +	}
> +	return 0;
> +}
/snip

> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
