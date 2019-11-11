Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36349C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D63820674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRCUl0nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKKJZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:25:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40417 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfKKJZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:25:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id i10so13758646wrs.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4p0qtiatlV0SP4T6lSPVHVPXlgHULFnSfHizAyGU0hg=;
        b=XRCUl0ntONH7UguamnyewxwL8FNRl5jKFpvkjL2XRuqeAejncL98iTV2xLCkpWbQSr
         xBN25JtyymE8a0XBGrYbJI5pHr8jvfi0oM24AqCtNC6LxJle9FvadHt/1gNdE3v0GMOu
         PtJMlSAGdQc/4xD3d1HmBJ3IY1rsgmEOP8jxOtf8VMGGc+riDbT9UFXW500Axiv1SEfi
         0bRZFvpuzSv3jHUUzJhoB9NVmj50aPYp5xy7XWDvbOINxxrUj2MjSW6qg8nReOpGUj5Y
         dhuqErqUx3hv3Y17uJUEdWu8XNeW9ln1h57kAE62ZheE7LKr2WhsS1Y89TThUjnCQ5uZ
         cDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4p0qtiatlV0SP4T6lSPVHVPXlgHULFnSfHizAyGU0hg=;
        b=IShoKrCQfTeutUCOouAYXrXHevz4ChT/i0vhKPocoGHsebqQrK1OL+QHcu6fZnqnlK
         j9LSXFKpBl+CQ3v1xqqYIKVcZdrYEqYkAcTGpBsaQ055Djdh9D77waZk0RaW8+EODjbi
         +z0HiEalPWG920Smn8Kf03FQqVv/BSF6Jdt7loUSDeSt4vpn1OUwoy1/WIgA7IJZ2f3u
         EblvZNq5o7JtXIe44B2Z7bsX36G6vbCLd0yicuOoSO6wnXFObt8QaSQHNGlwuAsYGe5y
         1N/wgutase6isGZJKXRdD6hUIm6RztupJUZDpTEQUf2RWTuwLf/oqm34CQC2bJzRYFMt
         P4Fw==
X-Gm-Message-State: APjAAAXGHHJ/Img+6hCW1Pebsl11LmX0XcTxv9Oli5csNlL+2GcabZD8
        L2qdj4i1CX9DWQhiV1tXfr6cRQ==
X-Google-Smtp-Source: APXvYqz33HioT48RXV/AkDamtjCdumAIK3ppi3Q+UqUVT538LwYEY3/vW7NqUhgVByAGLe4va+taaA==
X-Received: by 2002:adf:fa4a:: with SMTP id y10mr15491628wrr.177.1573464337262;
        Mon, 11 Nov 2019 01:25:37 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id c144sm17688792wmd.1.2019.11.11.01.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:25:36 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:25:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH V10 6/8] backlight: qcom-wled: Add support for WLED4
 peripheral.
Message-ID: <20191111092529.GT18902@dell>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-7-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572589624-6095-7-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> WLED4 peripheral is present on some PMICs like pmi8998 and
> pm660l. It has a different register map and configurations
> are also different. Add support for it.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 255 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 253 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
