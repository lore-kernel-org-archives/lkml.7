Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B8BC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA6120674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6upeI4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKKJZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:25:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45872 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfKKJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:25:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id z10so8450918wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 01:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bSMoujBCOiShaOME23UahvoRFbCvakiXJQBAxitgQQI=;
        b=s6upeI4FnIvRR5zLwQsUkI3/ZMzqr5DgNeHpWoPb+6H2V3hXM7UvBjdCn4Nux32H5U
         MvManwUvVpVjjkeVUULBcPUHTNxvLKVKzixF5laNWDCZUDW4F95Q3AsdD0IQHsGxBTQn
         B+BbSW/DT2hgASvbgYv4M42NmdlPcmU6qlv3n72TntMXJPXH64H72RWa1NSssjin1nIT
         vakgqvqU8lLKyCnj9zOgp4jk679iFCmIpMjH34kNjJ+igjToxEFjoegas90cWTR0x3Cu
         E8siF75VAjfQdqt2f6WyUGKKlkr/NlVNQaieU/RMCxT16e757uUePZm/zogW6mnRMYzv
         I8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bSMoujBCOiShaOME23UahvoRFbCvakiXJQBAxitgQQI=;
        b=pVj434FHAY+nNxa5IXZV7IVt00vgxvZpu5znvOnz8pWDahRzgdHhz2twyCQwreBTar
         4f8UrEqnYfmeM5yB6kF9H2+ueizHh1VMuwgY831KwYeW4hLuS3NATyl5X6MAna25aXER
         WmQDi5HNQcTgYMDIPCSJ3nzXNAHZADmyaACwD3LnC+x54cLP6RJSAO5RnBYae+d9Hheo
         DSp0KiBhydt1kkRPZ/ybxN8y6qfr7qGYDkFWYzsjevRG/wnGmP27ktL3bWT1wODylWiu
         WPI89TVrdeHgTtZlzLn7Fyp82HQI1+AzrWgXc8xhPpbQZ5Ni6+rqS29BNUQvCWmcIQNE
         9XuA==
X-Gm-Message-State: APjAAAUQPrbIjNc6x8hPKsXlcFF+tFTO43+SLBjc/EC1BRfiQ/owhoWg
        qy3uwg509T5M+K9LbiXkiHdjDA==
X-Google-Smtp-Source: APXvYqyfcu9bp99G9saaiWZdJypi7e3YwTOAFrPM3hIAg05FdWhgae+G6d5UMCrhcrMkQIAoN8iJNg==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr262428wro.215.1573464302760;
        Mon, 11 Nov 2019 01:25:02 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id i71sm32275541wri.68.2019.11.11.01.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 01:25:02 -0800 (PST)
Date:   Mon, 11 Nov 2019 09:24:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V10 2/8] backlight: qcom-wled: restructure the qcom-wled
 bindings.
Message-ID: <20191111092454.GP18902@dell>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
 <1572589624-6095-3-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572589624-6095-3-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Nov 2019, Kiran Gunda wrote:

> Restructure the qcom-wled bindings for the better readability.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 110 ++++++++++++++++-----
>  1 file changed, 85 insertions(+), 25 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
