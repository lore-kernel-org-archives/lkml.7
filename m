Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B6EC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E1820863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 10:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeChDvIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfIKKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 06:51:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55248 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfIKKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:51:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so2873021wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uryc0/pqdqKJAZc5VoGKLbUrzv2t7H2FdK8rw8hlLgg=;
        b=YeChDvIWXEB0TstAMgYAD4rorZ17PMeVJH48y0XNFopRTKZkFqUzX25bM6/kDkwlSB
         viruUn+aG6aBu7i775BC0uPh+Nsgx/H/fOmG9216rwKNJhReVC/5NFTPYosGl7ssOqXf
         Ip70bQ66StWipRujTpPgoTIYal+mCceDScD4Xpm6y026t3KvdNv8aQG0AX1QCn4xSqqg
         J2DFJGyp8hAvpPJxNa+g/OKeKf5D0HyIxw3JdyOMhYjvFneVT7aV2X+MA1yMM361/1py
         /X/tC/wr7UCCvVd8QF24ZWpp+8FpWc8i3kUAx2gpGTztEI/E2jSfyarbbeJ/q9Js94L+
         T3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uryc0/pqdqKJAZc5VoGKLbUrzv2t7H2FdK8rw8hlLgg=;
        b=q350kOpSuzZSQTmgvoOxFiHRy172gnJdXugas1FGYaleqe+TdVASd+cWTwBRe+9bYN
         tAvB4k1VmrMOxmFck1JxdSclg8O/8IuG1RB7R766J5vX35ZxQMjCo8/Yv6/XVrjg0r6Q
         0Xg/U9+MzmVGeB7wVSRUIIK6vBVJal+OgX5Q50Aaz8lEewDIPmfoQjEZ4j3xEcf7Cpj/
         vEqgm+0VdkI7ARzDd7NZ5M6aFKEfF3YhYL7+EpbUrKj/KW64HEww6H0mH8EAAHT0DIu/
         +02VOHqfk6ljjgmCc7wF0Q8j2XzDHGT+nK0COL4JZtcemreK91XD5+emSY/xBYHEwlpU
         fd1w==
X-Gm-Message-State: APjAAAWsLdBrrusdw4o9xphMFXS9s+NLJ/2jl47czmqEfVxel1rN2IB3
        4+ShyiYBRDy7ME2qW8sgCQuSqszR6QZ3Mw==
X-Google-Smtp-Source: APXvYqxQ+TkhPae6YnwpETNmnZCKnGfRVMJswmmeya3cK+zZE7nfR1qS/48jxDEUAMDXwJhtaDBYyw==
X-Received: by 2002:a1c:110:: with SMTP id 16mr3544521wmb.88.1568199110456;
        Wed, 11 Sep 2019 03:51:50 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b144sm2485131wmb.3.2019.09.11.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 03:51:49 -0700 (PDT)
Date:   Wed, 11 Sep 2019 11:51:48 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hns@goldelico.com
Subject: Re: [PATCH] backlight: lm3630a: fix module aliases
Message-ID: <20190911105148.4prmcr2f2r36sgrf@holly.lan>
References: <20190910152359.7448-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910152359.7448-1-andreas@kemnade.info>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:23:59PM +0200, Andreas Kemnade wrote:
> Devicetree aliases are missing, so that module autoloading
> does not work properly.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/lm3630a_bl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> index 3b45a1733198..9d67c07db2f2 100644
> --- a/drivers/video/backlight/lm3630a_bl.c
> +++ b/drivers/video/backlight/lm3630a_bl.c
> @@ -617,12 +617,14 @@ static const struct i2c_device_id lm3630a_id[] = {
>  	{}
>  };
>  
> +MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> +
>  static const struct of_device_id lm3630a_match_table[] = {
>  	{ .compatible = "ti,lm3630a", },
>  	{ },
>  };
>  
> -MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> +MODULE_DEVICE_TABLE(of, lm3630a_match_table);
>  
>  static struct i2c_driver lm3630a_i2c_driver = {
>  	.driver = {
> -- 
> 2.11.0
> 
