Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAB6CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3A220856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwWCuv7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439591AbfJXMG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:06:58 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39574 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439581AbfJXMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:06:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id o25so1817423uap.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Lbvvl6tmDfsef6Adcm223n4P0saLVKySDcFwg4whEU=;
        b=CwWCuv7zqHDpb3UQa/HhY2uB032NkGh9fyxr+zHL/5NeEcJty7gKPJOyZH91LIGw1u
         4Ig/ixYsJpvxvQq2bS+sOrYW4T5ZUEoVU38sq7UELpHT/0VqKITEOX+WK8tIcGE6w1FS
         JVx3sc2PgANsKhtJv2TY+buoWqv8uUNxqR6rACKXPic9BmQ39dF+y6gjqS/8IHAUx08F
         pfPRkH7SI6qa+O+wStiIyP+NyhhhbKhJi+LVE81jeNfpDqljknxTCK8TbS9a+5DBpxxQ
         U2NQyvJMvBngiOJggMOHDt+NRm7yBPfaJEZc/RkvfZkBheM4+fY7NeHGt+bdEL4WewuR
         tq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Lbvvl6tmDfsef6Adcm223n4P0saLVKySDcFwg4whEU=;
        b=jHcyCHOI0wpKVRwXxxY6dThk49u97Gtt0EYTOxQyyfapcXwhf+fIkMGi3RMF3jT53r
         cH550XTd9qJkOQfIgFSWnuMFbMzrKGwcUyj95ltjeflGKmHnUVXgRn7YJw/KtAYd1eve
         CwKvLsNnXFRUkYm5w4JiiHAVsnjkTVGDJMzd1loln3zmrNvmb1Hl0S6Md0GCsP8Xjp+X
         9KaOeBgRg8CvsgPtWhhq0XFoRv3d0PpVp892LeijLvKGcWeRzwLdNR6/n7lCPnq85jHe
         m+urXNBhTEnFxkgkdpdSRU9HDkIl68FnkxqcysLWTbnct2G3NhjPsaRRL6ENBQ6GSpB8
         3Zvw==
X-Gm-Message-State: APjAAAWKaxLR4LOJ1GAdVuX0qFh0nF41pv1vopMtsShqnQT/XBsAf1ZB
        +NobpMY2qDhBu0fMSDN63uTWWxQEejnpWKbtEqYTdw==
X-Google-Smtp-Source: APXvYqz/u7GDculbgv4Ltb7TsTfgDqc2G1JnhwfCdOEAQ5op57bB4jqXOhU4kGn1Y5/Z2ijpw5NUrHB9jSIPCGb29oQ=
X-Received: by 2002:ab0:7043:: with SMTP id v3mr8419775ual.84.1571918816518;
 Thu, 24 Oct 2019 05:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191016142601.28255-1-geert+renesas@glider.be>
In-Reply-To: <20191016142601.28255-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Oct 2019 14:06:45 +0200
Message-ID: <CACRpkdathjE3CLWsJYapL-0ri9_mC-uCKrh058zBk_nN5wHkDg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: sh-pfc: Do not use platform_get_irq() to
 count interrupts
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 4:26 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing
> of scary messages like:
>
>     sh-pfc e6060000.pin-controller: IRQ index 0 not found
>
> Fix this by using the platform_irq_count() helper instead.
>
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se=
>
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> v2:
>   - Add Reviewed-by, Tested-by.
>
> Linus: Can you please take this one, as it is a fix for v5.4? Thx!

I'm not sure the little error message counts as
a regression, certainly users can live with it.

Can't you just put it in your queue for the next kernel?

Yours,
Linus Walleij
