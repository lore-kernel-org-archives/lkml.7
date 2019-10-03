Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7CBC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D445D21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b8geVaxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfJCQMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:12:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39443 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388045AbfJCQM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:12:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id e1so2059112pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=XiVsYRW0n3APOo8SN5jHN6423sGK1hzLkdW22R6gUlQ=;
        b=b8geVaxUUmJEPSmYVZ/urv+GIDjPVA+tUw7s237kt7/4+W9qC3LDCPfcGAQhQ7qMnw
         4T4SP4lmYuQYPQV6SzMaM7KOid5w+rycvgqMZD86rgttuyzqDiKJchqoCKkH6tOvuN0f
         TWekoQ3fbZ0zfYkqUHWkpN71y1uBl7+ZV27Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=XiVsYRW0n3APOo8SN5jHN6423sGK1hzLkdW22R6gUlQ=;
        b=mY0TiEj+5F8IpTnMx/UveGmFOr1d79rv+gAbhdoCKkJbigb9f3DdjIGpRTShyzn6kK
         8fv3N6dUaEeZ+KsKNio2C/4S1qrIugY7H8CW9YDavZLRlddMGCtRta4q4JXQ7FG+FxBA
         wQ9M0giwWJgGf2+mG8T3/oK/U53xlNJg4FiOvJf7rmxLWgpgpMmhICUv1PuyebPKlkf5
         6+LDMmp9F+Pp5M5acfbk7Je9xa7bIlvSU1hhfgUBbWbcuVmcmCkDH4GRsyL7fSvHIJhW
         7Vfy/7vKNG8vsRETySWBa6u+aw4cAZ0/OyMKfdiMQKagZPm2U8Au1lQPEah+uxtYxQgL
         AMHA==
X-Gm-Message-State: APjAAAU1Mpe97wVDwa+RXR0iMvKUOjgxqHBDqfLfMoTtV3eut/Ww5Gl5
        fJBi4U57CHJB8kag6M7Y8CLyYQ==
X-Google-Smtp-Source: APXvYqz1b4RepNxT7vkrCPPzJdtlfmm8TflfIc9vumG8d7od9p989etC+nr8zMpohgtuvg7k7k8vtw==
X-Received: by 2002:a62:5847:: with SMTP id m68mr11824475pfb.23.1570119147433;
        Thu, 03 Oct 2019 09:12:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o9sm3228540pfp.67.2019.10.03.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 09:12:26 -0700 (PDT)
Message-ID: <5d961dea.1c69fb81.d0777.9f4b@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191001180547.734-1-geert+renesas@glider.be>
References: <20191001180547.734-1-geert+renesas@glider.be>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] pinctrl: sh-pfc: Do not use platform_get_irq() to count interrupts
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 09:12:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-01 11:05:47)
> As platform_get_irq() now prints an error when the interrupt does not
> exist, counting interrupts by looping until failure causes the printing
> of scary messages like:
>=20
>     sh-pfc e6060000.pin-controller: IRQ index 0 not found
>=20
> Fix this by using the platform_irq_count() helper instead.
>=20
> Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to =
platform_get_irq*()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

