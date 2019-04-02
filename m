Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A890C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A9320840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLPfjtRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDBG0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:26:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34345 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfDBG0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:26:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so6028638pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WP8Ny4UZUhZTpeEy7aNPAFetaj06ClqEV6SediKdXdk=;
        b=SLPfjtRvQ1ShDqw9Km8Egk++VeXGZJ5KYOiQDfAKcNbl4y4o4fxH0DdTqLS8BLcHna
         2LnBAZTp7feV43JrdJdkFUTM0FF+SPN/qG/vQoEm59d7au4Rsj998ECQJlRqz0NMa9O4
         LgfHkGHcGMXNO0cWmR1nt9QvrImaa8devqRa9GNlP9CWh/5G3B3/IGE+RgLEwG1zrRI6
         3kyAebNWWgGaL+aFjMrLL/bQ31RwtjqwiqP6RHivtMql7ggUoKpFoB/egjitpn7mkpfK
         /EYbLgmpDOaZQvYpY3N9vAhwT1fo5v9TJtZyGSO3qGUXT67P0av88L/CvS94w2Ze6HOe
         58Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WP8Ny4UZUhZTpeEy7aNPAFetaj06ClqEV6SediKdXdk=;
        b=nZp2m+/xn5P3A4yh8y9TekOvp0nk3pQ2d5OwbQQAYvanmmYw/R8EOj8ZaAVqS07q9y
         X6+ggdvBsJ43luFI+FrjUR5KVd+wta2UcqeYm4rIc4ZAg+Vrmc9/jrMsmYoMs2+Phv9z
         NHpkaRbq3BFUB/Z79oWmwS0xvjokdzoLwkcA/TnHUs9MHaQ5BQCi5b9OmvjM84JZbtlh
         TZV2QIbBw2hg0XsYMSZ7lMk48BdWN4SaInDCA6rrUqCyGmgfhkOPY0Z0j9ffOZO6JAUv
         A2oRv98dMMRXQ6j8guJanHpbDbXLXd9s1bjuZwVJj9ddGYXoF83eGaZLfBzDwfpL8Q73
         586Q==
X-Gm-Message-State: APjAAAXxcLV8Ssh3xVXb2iwgb4686IEtJscLEKPQ8Dfdhll90eVkMRBz
        z2OrbbmStwogQtvCXayqK7lBF+K4XE6CTQ==
X-Google-Smtp-Source: APXvYqwZRFTg82E4osqz8bKv39xsW7jKYwcOMOKKwNUiSpQcFhHq20JWByMcp+r1JhC2ETzOB5qUUg==
X-Received: by 2002:aa7:814e:: with SMTP id d14mr43414090pfn.101.1554186367781;
        Mon, 01 Apr 2019 23:26:07 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id x16sm14251517pge.27.2019.04.01.23.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 23:26:06 -0700 (PDT)
Date:   Tue, 2 Apr 2019 07:26:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Morris Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
Subject: Re: [PATCH 4/4] Add support for SUNIX Multi-I/O board
Message-ID: <20190402062601.GX4187@dell>
References: <20190319120835.3840-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319120835.3840-1-saumah@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019, Morris Ku wrote:

> Driver for SUNIX Multi-I/O card.Based on parport_pc.c, ppdev.c
> and lp.c by Linus Torvalds, Theodore Ts'o.

Parallel port drivers should live in 'drivers/parport' and
'drivers/char'.  LP drivers should live in 'drivers/char'.

Please them there.

> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  mfd/sunix/snx_ieee1284.c     | 144 +++++++
>  mfd/sunix/snx_ieee1284_ops.c | 258 +++++++++++++
>  mfd/sunix/snx_lp.c           | 717 +++++++++++++++++++++++++++++++++++
>  mfd/sunix/snx_lp.h           | 119 ++++++
>  mfd/sunix/snx_parallel.c     | 397 +++++++++++++++++++
>  mfd/sunix/snx_ppdev.c        | 454 ++++++++++++++++++++++
>  mfd/sunix/snx_ppdev.h        |  15 +
>  mfd/sunix/snx_share.c        | 629 ++++++++++++++++++++++++++++++
>  8 files changed, 2733 insertions(+)
>  create mode 100644 mfd/sunix/snx_ieee1284.c
>  create mode 100644 mfd/sunix/snx_ieee1284_ops.c
>  create mode 100644 mfd/sunix/snx_lp.c
>  create mode 100644 mfd/sunix/snx_lp.h
>  create mode 100644 mfd/sunix/snx_parallel.c
>  create mode 100644 mfd/sunix/snx_ppdev.c
>  create mode 100644 mfd/sunix/snx_ppdev.h
>  create mode 100644 mfd/sunix/snx_share.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
