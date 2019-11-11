Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E1C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5F206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riLeWNGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKKLZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:25:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53963 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfKKLZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:25:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so5263535wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GFaNxAk3pNBsr3uV3c/LGC3tFlJOZyI5xblWjUs9y6k=;
        b=riLeWNGfZzo1BYGSydS4/nhR0vK/m5XDSqF9EfbUdjKwvpFTzMhSSh/VQHYQz2A212
         7jrVEbSA5CezR4htEeFobCbfnmVLR7v6rnpwniiFucvLifKTWvw14nB3h9YEheI3Jy8x
         WptonAJPZPSitn6V7QT0ZF8AMD9+7iKgWwuhvVQEIIGCsZP0M0YEGOPeC5WCiBJTp/Bz
         fQkgZJFVGgS1WBazBH/3x5uz9segsCv4daAF52GyZBQtvGPT8E1DXSrSlb/v4KN/CeCu
         BBR/qT3aijuIlPwzhwEAoYMm8JnEg+h4NEhywjA4D50DfRWzu20mWx2vaW7Z7VXjYJ4V
         kHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GFaNxAk3pNBsr3uV3c/LGC3tFlJOZyI5xblWjUs9y6k=;
        b=oMrK9z2i7WrCKQiUMvlIfCMsTGC+YmkkTTW+2/ThHcArzC7mZtKzHeJ4fPb7WSENgD
         XVaqu2iNd0aeJlq8YWyY4gs6FEjro9/r05hUgJWIgFCui0wzMkbUT9GnqvOpZcmFEYeM
         uF76f240i5eBHb3S2JUQ+jndts7LjFvAtYFQVpK9OKRN2ocKD3zek3RYT9YoRBuXsAwA
         t28DSuXVKYpVSKlAHDCVP9wUwpGpvXHbq2st8umt9CqIGM1OlGzV21os0KYbi76eSoGg
         ap7l9y4KCxvBoTZ2yx6qxXfGQLMXT23eG21GfsQJQIiUEMhvPtQbKjOtoVDJnMFxsB5f
         EVkg==
X-Gm-Message-State: APjAAAV2X2Q2YvZtCcczfqr5mQ4hhDBFsNYCuW4wUI9FsXXlM3H8Z+Tc
        dITkFfRWyzg8E/o1kQid0tykCw==
X-Google-Smtp-Source: APXvYqwBAf05hw4EeW6S2GBkbyzjsoHpYouMWSe0JPavN1oEFLU87VnD2egJaf84sKLBzOF5ddhSwA==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr20842545wmj.125.1573471537216;
        Mon, 11 Nov 2019 03:25:37 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id b66sm19179787wmh.39.2019.11.11.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 03:25:36 -0800 (PST)
Date:   Mon, 11 Nov 2019 11:25:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: bd70528: Staticize bit value definitions
Message-ID: <20191111112529.GI3218@dell>
References: <20191108081551.GA19788@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191108081551.GA19788@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Nov 2019, Matti Vaittinen wrote:

> Make bit definitions static to reduce the scope.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/rohm-bd70528.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
