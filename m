Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E796C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79242067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578587771;
	bh=5RgWw6lwdyzlKUQmrYNvjaKIr4jFpcu60qB64YShEeQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sml1/kqOBTJRZm/AyF7rwKIcnKjHmFkJMC6dx12Dwt5RjQTkkjufOcCHdqxPBHGXd
	 mFz357sMJ+DFrIMidjC8Kw2LujgEfEwqjwX+W6lXuJVwO07NRtVv02suLEHszHLVLA
	 MmthOdolmVcT01oE6XAVAAW7B6Y14Hlhzu9pphtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbgAIQgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:36:10 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48787 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbgAIQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:36:09 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 009GZtqc017274;
        Fri, 10 Jan 2020 01:35:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 009GZtqc017274
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578587756;
        bh=7XvNI2YxCo7qESWtt2JSnXGjkOVg6FyfonoIBJamMh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hi94LVf3WXr6pLFb6llim/deUvBQso/rLntf9sz7hy/JWpqc62QG4CkQtF9Wnx9I/
         xjdWNKS/OuXj5SPq9jNAT/fsEBuK3QI4mhqMGwuxgZ/BTZz29D3HXhl0eVNCxrZYXo
         AoVlct3DkFgk5c90G/xCwimiOCYpe2jp1rv2ET4qwSP3LgKCimvCgVdBi5NzgGqJgi
         xOell8csHNpBOysat2oDWZGm+mFcQ1Yu++21mOIKEwfR6jH9VLFhTFGrFCYGBkYD4p
         d1TyySZ4YPfOgWNN+GV75HynljcTgZoWXyDrCm8iNOBS7t79+/tkzDjue98kU9pfwG
         /qq+0RO3Q7KBg==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id c7so2742616uaf.5;
        Thu, 09 Jan 2020 08:35:55 -0800 (PST)
X-Gm-Message-State: APjAAAXlYUX3xIEqiRBbSGytiWk8E7iFwjsQZquokm030qcmmpkFHXs0
        5YHAnQdlflor4u0vIpNwAzPAhMjDok/c/jus5ms=
X-Google-Smtp-Source: APXvYqwN102hllPkb04oSSjtpK6/klNrgMFGpuMG+Mswq9WQQI25tCM85hN2Eo4/aIoLVRNo357C5LaEJ+8g6meAja8=
X-Received: by 2002:ab0:6509:: with SMTP id w9mr7567756uam.121.1578587754564;
 Thu, 09 Jan 2020 08:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20200109161724.9546-1-brgl@bgdev.pl>
In-Reply-To: <20200109161724.9546-1-brgl@bgdev.pl>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 10 Jan 2020 01:35:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQcGLq46QOhqHArQvQG8DP2uQDtpn8XoUthNhwu8Aiyg@mail.gmail.com>
Message-ID: <CAK7LNAQQcGLq46QOhqHArQvQG8DP2uQDtpn8XoUthNhwu8Aiyg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: ignore temporary generated files
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 1:17 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> If building gconfig fails, a temporary gtk config file is left in the
> kconfig directory and is not ignored by git. Add an appropriate pattern
> to .gitignore.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  scripts/kconfig/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index b5bf92f66d11..d22e6753397d 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -3,6 +3,7 @@
>  #
>  *.moc
>  *conf-cfg
> +*conf-cfg.tmp

I have no idea in which situation this pattern is left.

Could you tell me the way to reproduce it?


>
>  #
>  # configuration programs
> --
> 2.23.0
>


-- 
Best Regards
Masahiro Yamada
