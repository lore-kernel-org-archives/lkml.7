Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9BBC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7494A206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCnAcMdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfLPLMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:12:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53657 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfLPLMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:12:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so4875761wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 03:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xZD3I8JJZiaennb6LqqpxxDp1hFQeIAfrE2ggo+moyA=;
        b=eCnAcMdU/8Xsd7tXngpzHvylikavyroEfIf5ssmpsu7HrQvZvm7j5p3gP3iogyxpUU
         CWSoN0EFQOCm8ydUGAXjvaLBNL2mwSBhoBNAEHvxvhFwiOboRx+6nmziUIQRwnzG/9cf
         pzIu0hCnxzVmJFpkE8KJbEJ5l/SynyYOATVdLa030uSPX3Xz9GDEwqXA7rEmmpO89tV9
         700KZ0pX0ITJdwQ4fXCqoAZRcPMK1RRDwEpmyKJbNHUMNrnuNRz1tX+7VX+ig8J1tVOs
         TnPwEWP6ch1u5yk5HZurHDFUsWr1Dkagx/9ov49IOjtDAmRsiqkM6OrhgWKgV8tOiUYd
         Alkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xZD3I8JJZiaennb6LqqpxxDp1hFQeIAfrE2ggo+moyA=;
        b=GQKoZcHv1zVY7/PVS+fURUdgl9WfG0YY/joI6GAebSOcdpS6vu+ZbeID7K43cKJwME
         oaWvhNUEIqipdlIfAff5lEihxxv4+xBrLnjptpPYKmsqzQLzp0JRAAMPCpEgu7akYDXU
         m6Ho7uA68g1yOPFZ7hm8YlNkGMv/KFbJQ7Xtxa/MHAxB8nT/6WOubwYLmOWZAiLGkWnL
         J5ODUzRRQJjoUU2/pgClCj77ttUu8WN+5Hd33j2YCX38RbPf3EJOFPxUFr59T+TLAxD1
         oz2T9wCsMukEcYSLnMtR9/G+DUFWGVAFspR6z9L4Y2iJTJ23xn1Zy64cNSc6Wh7fpw/S
         KquQ==
X-Gm-Message-State: APjAAAU9UjQuxpFScMNw+ROBFJMK3fWptg4/npUM7i68UruD6QX5Sdu6
        QooN4iZpGqyzxML+FibkxmdvdJNIgvg=
X-Google-Smtp-Source: APXvYqxE3TURcwU8c4mOA/IY6sniQvPajLj4vaeEei4fadshdSN5tW8h51K+7bVQg8iJ6T/rBlHhGw==
X-Received: by 2002:a05:600c:10cd:: with SMTP id l13mr31169017wmd.102.1576494739800;
        Mon, 16 Dec 2019 03:12:19 -0800 (PST)
Received: from dell ([2.27.35.132])
        by smtp.gmail.com with ESMTPSA id s16sm21268284wrn.78.2019.12.16.03.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 03:12:19 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:12:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de, smoch@web.de,
        linux.amoon@gmail.com, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/4] mfd: RK8xx tidyup
Message-ID: <20191216111219.GB2369@dell>
References: <cover.1575932654.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1575932654.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019, Robin Murphy wrote:

> Hi all,
> 
> In trying to debug suspend issues on my RK3328 box, I was looking at
> how the RK8xx driver handles the RK805 sleep pin, and frankly the whole
> driver seemed untidy enough to warrant some cleanup and minor fixes
> before going any further. I've based the series on top of Soeren's
> "mfd: rk808: Always use poweroff when requested" patch[1].
> 
> Note that I've only had time to build-test these patches so far, but I
> wanted to share them early for the sake of discussion in response to
> the other thread[2].
> 
> Robin.
> 
> [1] https://patchwork.kernel.org/patch/11279249/
> [2] https://patchwork.kernel.org/cover/11276945/
> 
> Robin Murphy (4):
>   mfd: rk808: Set global instance unconditionally
>   mfd: rk808: Always register syscore ops
>   mfd: rk808: Reduce shutdown duplication
>   mfd: rk808: Convert RK805 to syscore/PM ops
> 
>  drivers/mfd/rk808.c       | 122 ++++++++++++++++----------------------
>  include/linux/mfd/rk808.h |   2 -
>  2 files changed, 50 insertions(+), 74 deletions(-)

Not sure what's happening with these (competing?) patch-sets.  I'm not
planning on getting involved until you guys have arrived at and agreed
upon a single solution.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
