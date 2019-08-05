Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB7C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01E820856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 10:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAnOjSDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfHEKdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 06:33:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34813 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHEKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:33:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so78872718ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u41rCFVRT5TIJ3WzFOFyBFX+clVgfPodEdyZutaTu+E=;
        b=JAnOjSDww3k0wMC7tRMvLH1EJVHUGgbYraz6NUV4+qPVM6BpUbpsYlBAmLsT42AeNX
         dV+a61ouLe8Ue7j6PfJlmxR8BQcaB/OBny1VFbDkMNFRFYOMzDixYPDzGYCO1k0lkBLL
         4F8HEiLeRhlbwEi7L9XIjsyo/8C7+7eocgK2fMrjL+6y/XzFWrWaniMST8AKs152qsU9
         1sKr6OHrw7D1MRnRp2ni7LQ5O4QgczpxV2l2gumIc3QbjcJ+aWpy67paHz30fXP+72c3
         /cHHlsDRR+2VfQ3WxMtouQ/i5uxoWIXXOtF5exGYJTQiWE0Wu+p7yiWXfK5YpUbptdZC
         zSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u41rCFVRT5TIJ3WzFOFyBFX+clVgfPodEdyZutaTu+E=;
        b=dc47saUX2j5zDvsgNYBOENrqRm7AUmhwuL8Q+o3AP7icNyeqCcv/2flVmT8XhMR1DT
         xs9j2FYD3+fZH4pkC4sPbOcIYz9TZxEONIyO1nVQHr9vGhoWpPq4ZDWUMZv0um7mzxQ8
         /6UJAyJU9cibXgKGEccJIUaPE3gMRQZZqHz/4Y1E5LQlpDmhMK2agLSlBTi+Tx7WAvJT
         A2vlalBIvvVaY20STTzyKJJ68NUR56w4D1O8zGnUvmjSo2RkkO0W10nG6VwZtPV7UFF/
         E78bMS9l6aTUQCibyp2m/+cwQWve2vAaQPNfVDtXM8OtEtLt57/70j9IT5tCI25lDJWJ
         9jHA==
X-Gm-Message-State: APjAAAXD0ocSgTVGflDDWWEJYXsRVG8BwZaE9gVgPj7Rt4GJbwqRrd9L
        R8Xa4dnl86XXPxJlGgdeOtt/OWNLTbVS2AkUBleLZA==
X-Google-Smtp-Source: APXvYqwR1dwZfr1HLWJ7cN516WoABshKlyElWdQnlwPXEJQvNocN+VgY7JTuaxnQRyP1XdPQXdRHl6+Y8x0RSi+a6Aw=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr16465187ljs.54.1565001183227;
 Mon, 05 Aug 2019 03:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190726112812.19665-1-anders.roxell@linaro.org>
In-Reply-To: <20190726112812.19665-1-anders.roxell@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 12:32:52 +0200
Message-ID: <CACRpkdaOe4FvvrVMwLk5_KiMdKVVNm5Z7fSyjPDWKcm5MzxvyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: rockchip: Mark expected switch fall-through
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 1:28 PM Anders Roxell <anders.roxell@linaro.org> wr=
ote:

> When fall-through warnings was enabled by default the following warning
> was starting to show up:
>
> ../drivers/pinctrl/pinctrl-rockchip.c: In function =E2=80=98rockchip_gpio=
_set_config=E2=80=99:
> ../drivers/pinctrl/pinctrl-rockchip.c:2783:3: warning: this statement may=
 fall
>  through [-Wimplicit-fallthrough=3D]
>    rockchip_gpio_set_debounce(gc, offset, true);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/pinctrl/pinctrl-rockchip.c:2795:2: note: here
>   default:
>   ^~~~~~~
>
> Rework so that the compiler doesn't warn about fall-through. Add
> 'return -ENOTSUPP;' to match the comment.
>
> Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Patch applied.

Yours,
Linus Walleij
