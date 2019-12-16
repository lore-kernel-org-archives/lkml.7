Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA17CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD43206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gAzRCm/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfLPLLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:11:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35719 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfLPLLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:11:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so6746623wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2dxoabKlBZGvbp4gfeIRY6j7pCmpniW5VhZdZM1jvSg=;
        b=gAzRCm/Mi70HEKFLVKwdw4o6dgW1+mLf9GMIm8nSgC7Qz7NVXFTtfe89fsNxF5IPwO
         sNRdlKFk1DehYMbFr3XQ+pzSGskhva5BA9u9F5N1Y+UyWNBPIWImKo/IOxWFzToLNjXz
         I7HXqTpp1ZR7c9w2GQKByZ+FLo7L14/KXzvlnLv99C3e1u2ojDXJu2LMgf+bEWt/aWGm
         5GYZubOutSIqq8w7Ef4Qv0BVyjXAJKWKOhfacE46OxeHUKmjbYzDTDM8SL/J+GayssjG
         pKQvwVNHZ5buP2ykKauqxNaYT4XEvhGGimm7YEeqZppb2oGCLnev0ZZnNcDUvRjkzstJ
         ImqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2dxoabKlBZGvbp4gfeIRY6j7pCmpniW5VhZdZM1jvSg=;
        b=OSFugCY8xuDL4Lh0tAtqWbXNsxjCItpDFR4rjp7mN72UyaPYVtQdafO8vtbzYoiIFY
         sWZoDcTYIur6LH4fPeWZkE+9Bh38fVf8bG1GT0GIib3XDtQveIrr/n4NCPtsNbqKsYd5
         /ksoJUstgPKri4E3aDuB5PDNqiu26tiT4Jpp/HXNqTEyJ/x0ICVLsFKz9pQwQH15MVse
         eAeV+MDibiZBNF8u7cf/O/ultpmC6qIvkJQnmbzBaq2r+U62fDF+bGO3AG0Uw9glKUE9
         nhMLjY4YnxS0MQy0KSqxLBlRDiBUo2Cyiolq0JY9b4iXdRLrEnLW5XDzq99B1PSn5IOb
         ZyVg==
X-Gm-Message-State: APjAAAX+aG7SZF8OF68O31jQfvoxWBU7mLoG72mBOhLHUZXRCS9LjkFG
        G/InMq5ym/UaXY5017fjxylQ5c8EYv8=
X-Google-Smtp-Source: APXvYqx8pA749AH1DqU2BLWtKrkPOyGDfdptUcuuJl8+7mbfN9t9G/HQd47nlhBpyBSIKall5Rya2w==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr30557610wrh.121.1576494711131;
        Mon, 16 Dec 2019 03:11:51 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id g25sm24456932wmh.3.2019.12.16.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 03:11:50 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:11:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 1/8] mfd: rk808: Refactor shutdown functions
Message-ID: <20191216111150.GA2369@dell>
References: <20191206184536.2507-1-linux.amoon@gmail.com>
 <20191206184536.2507-2-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191206184536.2507-2-linux.amoon@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Dec 2019, Anand Moon wrote:

> From: Daniel Schultz <d.schultz@phytec.de>
> 
> Since all shutdown functions have almost the same code, all logic
> from the shutdown functions can be refactored to a new function
> "rk808_update_bits", which can update a register by a given address
> and bitmask and value.
> 
> link: https://lore.kernel.org/patchwork/patch/937404/
> Cc: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> [rebased on latest kernel]
> Modified the API to set the value.
> This changes were submited with below patch.
> [0] https://lore.kernel.org/patchwork/patch/937404/
> ---
>  drivers/mfd/rk808.c | 87 ++++++++++++++-------------------------------
>  1 file changed, 26 insertions(+), 61 deletions(-)

Not sure what's happening with these (competing?) patch-sets.  I'm not
planning on getting involved until you guys have arrived at and agreed
upon a single solution.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
