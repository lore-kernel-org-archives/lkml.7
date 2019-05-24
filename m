Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF163C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B090820879
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kgfxpZcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391567AbfEXRuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:50:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40376 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390929AbfEXRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:50:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id u11so9441938otq.7;
        Fri, 24 May 2019 10:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZnc7DcjNL05PZUl35qBgTMmg9YgsiJ/H98z8gpQ+WU=;
        b=kgfxpZccazO/20c27YqZ/hF+AHYaWjTIKj+4hlpYOmSpYGdq5DSO03BZdAfXSk87zd
         Xxrb5F0o1lmubo/ft/4hp97LJqex8aPiv8lqDux6558iohZD4moHYTlkQq+kXdfvcD5Q
         sT2rTkW1eqxEm+dFXn+mfXoU5IVCbKeyvvWzujoJc2lvoTJRauZI9JPTjH4Kw0xNV79v
         Jcrjj0gLjoOscv2meGBmgwpSR35Dp7jATobUo0Kj1w1WI6DorXaO18b9yQTOnmBU0AEr
         SzgkVFIXR6fax727+rlfnuTMuUTl02Ht6jvKum9cxTpt0SJb/vBLXie+hZluXmAlJB89
         CPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZnc7DcjNL05PZUl35qBgTMmg9YgsiJ/H98z8gpQ+WU=;
        b=haA8spQKZln5AH7uhwAHxta0aL81U2p6dSiUpis6YwHJLzhKIWBBtYEDQ9WVXigHxp
         +bR2tmVCgxK2OAxZlSq9mcjMSyKkHYkboGlZGCT3AaGnzZWtBv1SUohxbh/SQwh7qM0r
         dZtetENAsIaxU7Ax5a/IAAhCcv/0fvf7sVoBgk5Bk4aJ+DkWRIOTfZeWQnrli0BiyOf7
         mGJraPRydjOJDdvBY3qXtWmfT3Pb+ATVpR6CGbHp6mOGHqPuamfcUWqUEo5MY5SfVFOK
         yyqUoCtIZ4kLtK+Rmbss/FsPHhAb3h63UIVJ21y3EPZfQJW6DgdSu6takTfRlGbxSYTh
         XFEQ==
X-Gm-Message-State: APjAAAVhX8LAAdXKxrM+ZU79UnFieo1RnG187N5j/JDcNIbLcs7zpnNz
        ZwVr7ORhASIDX/tiFfaqEtJk+zqCZhgFj7M9ohU=
X-Google-Smtp-Source: APXvYqy1KkZNIxwuQhPqiSRp1aCJoK85ECorsxpw0StRGFYqPUIJ2pkj+G09V+/85cJ6Wtcv6GjLQ4Bz2FginEM62Ok=
X-Received: by 2002:a9d:744d:: with SMTP id p13mr41645269otk.96.1558720212750;
 Fri, 24 May 2019 10:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190524130817.18920-1-jbrunet@baylibre.com>
In-Reply-To: <20190524130817.18920-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 24 May 2019 19:50:01 +0200
Message-ID: <CAFBinCCKA-15sFwyXpoxmqw5b4=6j1t-fdrHM7CoAojqN+ZGzQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: add dwmac-3.70a to ethmac compatible list
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, May 24, 2019 at 3:08 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> After discussing with Amlogic, the Synopsys GMAC version used by
> the gx and axg family is the 3.70a. Set this is in DT
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>
>  Hi,
>
>  The same should be true for the meson8 families but I did not test
>  it which is why only the patch only address the 64bits SoC families
on one of my Meson8m2 boards:
User ID: 0x11, Synopsys ID: 0x37
-> that matches GXBB/GXL/GXM

Odroid-C1 on Kernel CI reports:
User ID: 0x10, Synopsys ID: 0x37
-> however, the public S805 datasheet mentions that it's a
"10/100/1000 MAC 3.70a" (page 120)

I don't know about Meson6 or Meson8 (as I don't have boards with these SoCs)

I'll put this on my to do list (adding the "snps,dwmac-3.70a"
compatible on Meson8b and Meson8m2)


Martin
