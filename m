Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3191C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C961121D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 14:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkyOATx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436526AbfIYOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 10:15:24 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:46288 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407319AbfIYOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:15:23 -0400
Received: by mail-lj1-f170.google.com with SMTP id e17so5817741ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XtbzG/PDHB0nH5tZZmEfWG24IcMxbyIbMNZVj9/BKQ=;
        b=dkyOATx9lmLDnncl4zJtlo91Zp1bUtwDHjOBbv+9Jc7LYTOR8Hkjbqp50+n1wBonB5
         ClhTg+OdoJIJx9VdXt/7VqNmmlYCx6QtqyfdTNik7dNQWKUG6FSLcpMO4yKBK590HxjA
         reoI/EKWfyj90vAwRPeHcQXpLWf8PbwrCiY2Ba5l0TFx755VvOTVm77s1nT3pPxaBntj
         jVieeyMvQajnZc1yOum7bJWAoChkF4UKjkXKF+Ag9A1gze2n6fD5JMFAU9w5DZLXPkHB
         7suYRia+8rXVe9n5ovdTt8ikQh2Qlz9UW0ak8CJyLlCeMqFIg+KseoisDnkO4Yy2qRPx
         yPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XtbzG/PDHB0nH5tZZmEfWG24IcMxbyIbMNZVj9/BKQ=;
        b=MzCUTZbVpQUfo7VlpSGf1sYqUGDHpaeX0syh3rUZIAgqKzKKghoD9fkIeNX+Fi4X2W
         Vcg8loX8FhmXuWSBC+ysb/f6F+yu6zQmm3D7keVO/gvZm99jTkm2jt0ZO65YpG2U/0lj
         iCQZm+U/ZtjCpkd7BuxJFDxSuhqXq73PhlOtJeHipAGfdIXcVKYKXqGlmWywk68ohx9f
         xlEDtoN2sVrra0Sy2bjK0lrSsWn1kUXBCQusKcn5iB0fZGNqD9I7REDxH7Lj1Ayr1IVe
         MlVzTFfxSdTrpethHx/NhxLVbBTPvHX/EscfhB9BVUcuVE3dFvzwSrjIGswg/WEN9Emu
         z8Mg==
X-Gm-Message-State: APjAAAVHlzHYSkZ9OD8FKs3ZxRbWkzGrmJ5tpXwfGuTR+XErjI5s26Xg
        fyj1OxEVwcMGiEcKd8wbcWRoQmE5QACdvcUS3FhV2w==
X-Google-Smtp-Source: APXvYqxqBaZ48HccCc5sICcI0U65KHSoI3B+0Ywyekxx11YaVBb03nxxrNJEQk9thhAS/288MMxOqKisdSKl5/WQMvg=
X-Received: by 2002:a2e:9ccb:: with SMTP id g11mr6533141ljj.62.1569420921560;
 Wed, 25 Sep 2019 07:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <1569351740-6285-1-git-send-email-hongweiz@ami.com>
In-Reply-To: <1569351740-6285-1-git-send-email-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 25 Sep 2019 16:15:10 +0200
Message-ID: <CACRpkdbhRo62inQS96OfFO4iWkLn2+P+w1+6g+Y=HFvVyVnXAA@mail.gmail.com>
Subject: Re: [v1, 0/1] gpio: dts: aspeed: Add SGPIO driver
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 9:02 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> The related SGPIO driver has been accepted and merged into v5.4:
> _http://patchwork.ozlabs.org/patch/1150357/

Oh what a mess, it didn't add the necessary code into Kconfig
and Makefile, also names it sgpio-gpio.c when everything
else is named gpio-sgpio.c.

I guess I have to fix it up. My fault for missing.

Linus Walleij
