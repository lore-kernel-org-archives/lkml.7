Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDBCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AA921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhS6Gqk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfDWLGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:06:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35112 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:06:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so13098819ljc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6pcFSCzkNLQdsm4gDRxzGJM3hxRqc7AwxBZKZnAR0u4=;
        b=yhS6Gqk5W1RDkTeqHVTCQ/20J/oanpoB7M2GvcyzBN9VSVB8n1OqZ1nOBZ7y1/1zP/
         VNG9pdigPoFi+j9fmLEjmsYj4Ma44GlqynV7jpRu5KNEkm2Lbjs/jD6PiKUXfmQl7lHY
         DjNBYoZV3MJaTQwhP11+oQMDN4WL1uOvyirtPq7DUyO3356IfhJFcpkv+JM6gxy98Dyi
         pGLByZDqeJGI1tb37D55V40guUtwYjLekDvisb309SHrjeoJ/8/crPtl4kS4N5E4rKCY
         voUv63t9AND8wYO2Roo55pwtSU/X7LqQzMp9SR8E+B9ExJR9FCVZQWLHK9mCCaLfJfHe
         7Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6pcFSCzkNLQdsm4gDRxzGJM3hxRqc7AwxBZKZnAR0u4=;
        b=rIgJG6/QEMI9niRj22hy+9D/BwDE6kyCWcw6t6tk42XJXay3/PZkFju0V/Z3Yrpbrz
         2XOvYi3/AIMytY6bCST/T2HVk1iM98u77vDRiJYamZvaIf+kFkjXEOJ53XYH/gHoObGQ
         eCqZEcgeY3u51uGVmCm4YcSr1quChQqf+GT4wCjXsw2fSX4rI3zzX93nDUEjIs/Tw3Nc
         X8UpnfOhxWzzBbviQJ9+5umCXLrOU4FvCWfvFoHXMxUfT26V3e8V2j9bL50dgnpqtrzR
         cqi4NotujoU/dGewiQMjMVnP7jy++loubGoJ34RsX20uPShi0YpkmcQvIwgH+yQY/iab
         H2EA==
X-Gm-Message-State: APjAAAV9E9YyZSf/5popq/KoklJ4M3eBVyVLyH8y1WSzuz0ZvjXxwKeX
        cUviHKsFFNo7socAJIiAqdM6LhWRcYr3rPi8r9/RUbBC
X-Google-Smtp-Source: APXvYqwA3g6TA5any/sN3iMoUec8wCGv3iTeRjIle1md48T8SthJKbC0WZZzlesQ6Zlf9H+srKnPIxBCM0Jn3afvkR8=
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr3166686ljc.126.1556017579012;
 Tue, 23 Apr 2019 04:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190416083305.24965-1-fparent@baylibre.com>
In-Reply-To: <20190416083305.24965-1-fparent@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Apr 2019 13:06:07 +0200
Message-ID: <CACRpkdbpUKwwwRZBXqJke2Z7K1QgBY4XBN5XN7CtihEVTbrr4Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Add MT8516 Pinctrl driver
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 10:33 AM Fabien Parent <fparent@baylibre.com> wrote:

> This commit adds the pinctrl driver for the MediaTek's MT8516 SoC.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Patch applied with Sean's ACK.

Yours,
Linus Walleij
