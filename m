Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB580C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C501921A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYO8M14u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfKMLcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:32:20 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36815 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKMLcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:32:20 -0500
Received: by mail-wr1-f44.google.com with SMTP id r10so1961760wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 03:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sS3GaEsmYVTT8e7e9aE8xCn5QY0c0oDK5wXddhigAzo=;
        b=CYO8M14unOarpyCMrij5/QgQvuSQhghb6lNIxYwEhmTJDfQAfPVC9+D7zTsLxANKmS
         XOhtiJRx+PgD9O/gBnG++DQiXFXLxHrROmodJu9nwj/KRsEGGR/sftjKT7S2uSI+5VLl
         yZe9beW3UNVHVWEbNmNwB8mDKLDxLgYDXytky5cZjStLFR3FjqTa61F3vDNXnNvvHzYe
         76Mtd4Rb98ulGoJENiFUg2nXaB9MM4MH+IALrHn9VUFjNIr1cubho30W9ayKiPYXDCGo
         CssQBKMiFAx8N4DrCpDWlqKhpuZNe4KLEWF3QmcEx3zZjaQK6pN0pOBJYFnXcN7QiGiW
         QAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sS3GaEsmYVTT8e7e9aE8xCn5QY0c0oDK5wXddhigAzo=;
        b=DdNR9FJqlrq5igfplLUR6Q/64dOkzJeEgm+9vTTvpQBT18EZvsQV69oRVRD1q9ZknN
         E27etoMWMjkZqvO5vj2cTsu6bbsMqF+xcgKNWEmPQjHBr1t7Ttd03gNfyHYRoYS7KTew
         9oUUKkH+JMqfHfJzIv6ETo5yTP17RZuykPJDDIIv9F/kwx54waNpeEi7X8kaTSlKGUbE
         eQVEXraqK9gfm/amnHp3UNHcqSS/28R8V8CAGDYXwvyyTNniCGYHAnzpOq79S+ZZ9tds
         X4xNaHj2XxUs2fb3ygvMV8SDW3c6xPsvIK+DwP7Q6/zdox6rIFU1471vmnSofRGVg1x/
         5jwg==
X-Gm-Message-State: APjAAAUiypyjag1WhG7CNrqSxUj++URJ8dzg+MdMSKUb9gzSJScpPwZ1
        +EeQP5YNiYJcPCImeUWyPkGDQA==
X-Google-Smtp-Source: APXvYqznHxf9lTwtcWainnqvBciljEaqd825jlA+LPO+60naLZWLA4kld7qN7etRMPJUI7I//NyhTw==
X-Received: by 2002:adf:e94e:: with SMTP id m14mr2414909wrn.233.1573644738184;
        Wed, 13 Nov 2019 03:32:18 -0800 (PST)
Received: from dell ([2.27.35.135])
        by smtp.gmail.com with ESMTPSA id o10sm2519246wrq.92.2019.11.13.03.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 03:32:17 -0800 (PST)
Date:   Wed, 13 Nov 2019 11:32:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] backlight: qcom-wled: fix spelling mistake
 "trigged" -> "triggered"
Message-ID: <20191113113206.GB3285@dell>
References: <20191112093025.98638-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191112093025.98638-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_err error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/video/backlight/qcom-wled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
