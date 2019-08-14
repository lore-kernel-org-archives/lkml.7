Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51090C0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC8B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Snb5qobQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfHNIFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:05:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36653 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNIFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:05:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so16452946wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PLbj/cRfB0orCu783WjMRb1h5axtcBLCE8j3IraGBs0=;
        b=Snb5qobQ+qtvJ5RsHxg7EB9FGMlBhUx+89I25tL3WcmUK+/mSKb510zE41kepM/xAN
         adCx8Dla/B+iijq/hfALrsOglvPselgEIAUQeuqrYTCuVOWI3CpN2NRDtv80p4+5Ic6p
         ljIOmFIYK6wom8K+1Bk6lXlYABd4RKMBuV4y9i9aGQQ5RYec5pxe1i2DfbrpDsikB6Y/
         gBTDijySCazqcgeBqx2SOQXe2hxC9F4qKzjBFwTIKVHdcCbGYlhrj4IyDenxYWrv791Z
         vcbI+4VUvgpdYA1cCLmmDk1fTh001mpU1DGEStBTC+QTvOmDIHgAett9bryvfGd4PI+B
         9UrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PLbj/cRfB0orCu783WjMRb1h5axtcBLCE8j3IraGBs0=;
        b=XnZwUcFGPIlW+o1Fqv5rg0r202kZQr6ilcNnG+/1w2zXch3DcNdllTaM+AK2uQAKW3
         Oph7ML7a7Hj6N6DW1vGb/UOo6WnK1aNl7BGvoHYCNNx3dHC0Pj/H01GqxK92il17pAar
         TYLJ5N4A5NyX2O0UWW3kxtA+jGWJ5Zwdze3/+bpicLdv7jLX3n6NYcvmRUeY5ByGM8Ec
         Cn7+hw3fPtZ9nfcqwV0iS85Q8y/9qa4U2uq0Ji8A2aVmgD41LB3Ee75Io2/mA6u4oH7e
         SHNeWBUHItdXPcfygwNVDxHtKLw9u7oBGSyphideMp3vN1UGZZx/dzxdRJ1KBZ/udi/7
         HXTg==
X-Gm-Message-State: APjAAAU/GYa8z9im5e3jrWopb3dsn8Nbdp1enf4Rt0NtwEbLPdimsRm2
        drU0roXsXvfZSM3NvSYWbuDqT7Mz01A=
X-Google-Smtp-Source: APXvYqycZT7wE5HUkJxX8/Tlt6oyT9tbJW5SMpUCe0+rrJwKCHoAFFvUh7Nl9d/twrHfF1xAWJ+YlQ==
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr37157747wrs.260.1565769936682;
        Wed, 14 Aug 2019 01:05:36 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id y7sm2631387wmm.19.2019.08.14.01.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 01:05:35 -0700 (PDT)
Date:   Wed, 14 Aug 2019 09:05:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH] mfd: asic3: Include the right header
Message-ID: <20190814080534.GD26727@dell>
References: <20190814072403.6294-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190814072403.6294-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019, Linus Walleij wrote:

> This is a GPIO driver, use the appropriate header
> <linux/gpio/driver.h> rather than the legacy <linux/gpio.h>
> header.
> 
> Cc: Paul Parsons <lost.distance@yahoo.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/asic3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
