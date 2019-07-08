Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E569BC606C8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A30217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrveiZfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbfGHSSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:18:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45211 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfGHSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 14:18:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so7967841pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/QMgQTKtFRkJ4v8si1Lhzq6OUV7QwuUzq9j2cNj8/jE=;
        b=yrveiZfDqMQPVb5N9MbMDDnxfNkt+t0+tuHlP4drzJ9vt+xF4DpLWTIFI4YTnzsx43
         vql/uZ7KD4+n/ls+9rTUSm2vlM752Xqs636O9zKJ6Hn3gvdSJ41GPnB4D3LzedFc9EAg
         /LKNFyXGm+oAgntunFj8wSOMVuI8WOG7X0g+1zAQNrr8M46zfrz3CXzgicI/ZtifWRBu
         9Rd1K0xsCEJW3aAoZrIKCP7Qsothk1dqLK7TCXQxPnIuXGpNuttws3mpmoaeapRMDSA1
         dcwJQBjDdiWzifTm0FjCPLOHYuRZRedSI2p93sI4c2IYzKT3WQTQxw9uOFfbprTYhmYF
         9BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/QMgQTKtFRkJ4v8si1Lhzq6OUV7QwuUzq9j2cNj8/jE=;
        b=YL7w2AFXbc+xiWLb2+cklgA2UTK+euJg+ZQP7+H85whXfTJQb7Y+AuCnUsBDSUUAVm
         zX4O6g3bMgANgGgf/44YvBWLZ1Kx8Pi38ommu0PNOlFoB+7jvHVjmPqWzNGcIofuE7Hc
         9jFqplk7SVRD4DUJqAHI8XmWCNpbENIdeo+j9JttEJp36e78FxV39V0cjBTFhiMzbZZk
         addSQRXfrAXBj3gzi2OYEVrdZI4JsblHZQuBr76nJwo2RdDTPRj0LIUqpGACkp5RBsaC
         t6dYBAe/5kiUEyn1z2Bepi7UVqF224E1nSm9qX6CqhMZi9Ri0FJmIKY/u6ZWO5B2M0Pa
         RR5A==
X-Gm-Message-State: APjAAAU34fCAWx4kAlPcd4besoLoQJyx7MJ0yQxn2VlzlUSSV4lKhERD
        x+eUL2NUbGKG6Fs5T0BxjT6AzA==
X-Google-Smtp-Source: APXvYqzsXmKUfVEW/k/FB3dDrJJr364KJZ/8KOYkHUL0DikG1R+45OGwaG/PKF8QRVQG5eGuniNanQ==
X-Received: by 2002:a17:90a:4803:: with SMTP id a3mr28046704pjh.58.1562609923292;
        Mon, 08 Jul 2019 11:18:43 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t8sm179007pji.24.2019.07.08.11.18.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 11:18:42 -0700 (PDT)
Date:   Mon, 8 Jul 2019 11:18:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: add missing MODULE_FIRMWARE()
Message-ID: <20190708181840.GD30636@minitux>
References: <20190703140055.26300-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703140055.26300-1-robdclark@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Jul 07:00 PDT 2019, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> For platforms that require the "zap shader" to take the GPU out of
> secure mode at boot, we also need the zap fw to end up in the initrd.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

My upcoming pull request for this merge window includes the support for
the mdt_loader to read unsplit firmware files. So how about running the
firmware through [1] (pil-squasher a630_zap.mbn a630_zap.mdt) and
pointing the driver to use the single .mbn file instead?


If not, you have my:
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

[1] https://github.com/andersson/pil-squasher

Regards,
Bjorn

> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index d9ac8c4cd866..aa64514afd5c 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -174,6 +174,10 @@ MODULE_FIRMWARE("qcom/a530_zap.b01");
>  MODULE_FIRMWARE("qcom/a530_zap.b02");
>  MODULE_FIRMWARE("qcom/a630_sqe.fw");
>  MODULE_FIRMWARE("qcom/a630_gmu.bin");
> +MODULE_FIRMWARE("qcom/a630_zap.mdt");
> +MODULE_FIRMWARE("qcom/a630_zap.b00");
> +MODULE_FIRMWARE("qcom/a630_zap.b01");
> +MODULE_FIRMWARE("qcom/a630_zap.b02");
>  
>  static inline bool _rev_match(uint8_t entry, uint8_t id)
>  {
> -- 
> 2.20.1
> 
