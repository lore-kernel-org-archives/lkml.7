Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA4EC76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D27216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUdEOJR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfGVNmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:42:33 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44934 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfGVNmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:42:32 -0400
Received: by mail-vs1-f65.google.com with SMTP id v129so26095488vsb.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qaHBjnJFvYpr3DEes/kuOj/K1B5xxoaa1SMu0FmdZ3M=;
        b=rUdEOJR+JNagLCPUzILfIEZUMlA1SQNhUMpKPyVuDLCcj4JfRx+/sKLpXNhfhUz87R
         yqMfG2d5VsWW0cshTolWC9H951TN2G0ZXUjORbyg9lV/WeaWMjU2M9+G1fu/+KrIGwFI
         WPHGA7InTjURufNG2KmUKaJ2wfIzW0/kQumXjx7nHV27S6+pafh6+YYob0dA5rwRp+8/
         RdOy7xdhu6q4z689UGGbUuaCA5ExWd/+WXW8TpptH56iU/TZdsxlfOCfZZRT6fzD5rdl
         N1a7wZdwNvB0wSCMDc6w8btAnHwIiqzOxYbSOAkOaO0TwhA/r4XeIcctkVnWwxFFrxJX
         NMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qaHBjnJFvYpr3DEes/kuOj/K1B5xxoaa1SMu0FmdZ3M=;
        b=Szc6uTn4ih/uCFAHa6dIEh1hrt1C3S4eCX/bp0hsgbUCY4XAjYsdCVaIAkfpel1VUb
         CVojwzEBswmwWuj1I9s2hfl/0AngJRswouvOOCd+GajuBQnnRM6YtJV7JpkHnnQKP1NM
         /3D8uoes5ZR5+v2739jMy4qu4sewtp5565jMCCSiLPsIqDVmhLkiTvtjcEMf5c5N9jTi
         yG31EG5qZ8XWJqGqDd/InL9cIedpdRx0U4Wa+RzXnWb9hKnJckYfzn9qdjF2sz6ZqsZY
         slVEK0pm44LkSyTD8R9cdDxyrZl3OdjvFCeaU497xA2jyec06P1NhEcvv0fdJTHovQjL
         bouA==
X-Gm-Message-State: APjAAAXC/vBDnQ6GOplpRCdmHj8sfl/CqWLUjPnBxEQ0qF7sicuVhA4c
        o+6jIf/WdNmb3mvRCUpj3EemKej1kr1gtectBqhUQA==
X-Google-Smtp-Source: APXvYqyaTv6dJJcv21QQoGgk4eHCM+fKgbd4PtuMRgYz4E+1WOStaJicLhi/fi7A0uYMGvSu0i06RMfT0JeZWXKX4O0=
X-Received: by 2002:a67:8709:: with SMTP id j9mr42144801vsd.35.1563802951387;
 Mon, 22 Jul 2019 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190709135351.25628-1-larper@axis.com>
In-Reply-To: <20190709135351.25628-1-larper@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:41:55 +0200
Message-ID: <CAPDyKFpT7HtJbWo5Em6f+UU+7t7eNGb+WypCzg5xumzqvE=aHg@mail.gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: Add maintainers
To:     Lars Persson <lars.persson@axis.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jesper Nilsson <jespern@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars Persson <larper@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 at 15:54, Lars Persson <lars.persson@axis.com> wrote:
>
> The usdhi6rol0 driver is exclusively used for the ARTPEC family of
> SoCs. Other SoCs with the same IP of Panasonic origin use the tmio_mmc
> driver. Therefore we assigner maintainer responsibility to us at Axis
> until the two drivers become unified.
>
> Change-Id: I38b6fd0addc1d93ae172332b67e6eb71c0871508

I dropped this.

> Signed-off-by: Lars Persson <larper@axis.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 677ef41cb012..a91d04e5c084 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1432,6 +1432,7 @@ F:        arch/arm/mach-artpec
>  F:     arch/arm/boot/dts/artpec6*
>  F:     drivers/clk/axis
>  F:     drivers/crypto/axis
> +F:     drivers/mmc/host/usdhi6rol0.c
>  F:     drivers/pinctrl/pinctrl-artpec*
>  F:     Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
>
> --
> 2.11.0
>
