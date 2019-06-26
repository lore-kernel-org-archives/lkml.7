Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ACCC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3E020659
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMhf6MEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFZJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:23:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38087 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:23:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id s15so1305225wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fO4bTM1QZe1GcdD2hx24VnF0rA6q+Y1RLpl4wvfhCRI=;
        b=TMhf6MEQS0sANWTL5naIbY0V6Prlm8+4dSvxxT+KgkdgJUGn/aRLBiapPWVKL3HuBS
         hvR2KepB1r7h01K+F8uj/8i6bO7bMsYjIMdtgPMgLYk2VkmcXy0cw90KZXEqBBMcqBWM
         LlcfFU6QFJca6V0izwH9Z8auhxkJJd9a5O0AGfC4UN3ZbJP23HhcWuFIKMrFjldeh8i6
         GM5Sp6LbZZPY9px9HdobtBNPPP+iXTXNSbLzUjUaeeHAhqrBJsFkCVEG1CYYdAkV8Sz1
         Ca+NCU9igKRxjX+B3aoT99v+DLBWq9iMIGQ85U5jUkCy9MiD8gb5FkPOBNW97/RVx701
         41/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fO4bTM1QZe1GcdD2hx24VnF0rA6q+Y1RLpl4wvfhCRI=;
        b=Y15xsgnk/7Munmw0dQGp3RVjH54fvAAk1TW/PGCFZNFLStEzhom98SsU8yctErWwal
         FBGbOTm6x/5M6XdPpTaOBeoOEJ7S+ACfebbDVHEWN+HEf/x+6AfAq4N7e8wmrtpYlNpR
         EK72Zam2ne+rq23CZKRkZtYtECsIVWsFEZmMOGpp54zEyuYwPoxlBTXcuRcK4Y6MiiLR
         UMPje7Hb90aFFlGqD9B7xDzRUU1qlECrw1dXQcq6r0SgmiOESUZk4r+LgFw1QrrxAM82
         wIff0hmFCAvHPBY8Pl5qmSzZ3Gs6O2sLiGBAVExg19LZIFANjQytsx6XPav9HYiBWbTu
         POWg==
X-Gm-Message-State: APjAAAUp/YeJvw4okwx1i8OXTa3ipzCVNF0AV4a0MXyweevnXUzBI0bY
        7GWcArLb4uRbnsKMNuLWxQaATDyUVVE=
X-Google-Smtp-Source: APXvYqztfJFIGBqDu/PX/G+s7RvX3QVxBKqfJM1vKfy9cb7v5nZt4CQ8O8pKs6U3SQDOZY8GpJJcyA==
X-Received: by 2002:a1c:618a:: with SMTP id v132mr1982097wmb.17.1561541017991;
        Wed, 26 Jun 2019 02:23:37 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id f204sm1924309wme.18.2019.06.26.02.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 02:23:36 -0700 (PDT)
Date:   Wed, 26 Jun 2019 10:23:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mfd: cs5535-mfd: remove ifdef OLPC noise
Message-ID: <20190626092335.GM21119@dell>
References: <20190620111957.1385008-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190620111957.1385008-1-lkundrak@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019, Lubomir Rintel wrote:

> <asm/olpc.h> provides machine_is_olpc() stub for CONFIG_OLPC=n,
> compiler should just optimize the unneeded bits away.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/mfd/cs5535-mfd.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
