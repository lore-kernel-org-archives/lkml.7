Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF1CC5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AF7208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjZ7oJl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfILJId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:08:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40857 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbfILJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:08:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so22823368ljw.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7J4PbmeH1oWO8W8ZajC7YRPfKxbxslCKwg9jxg+VhI=;
        b=wjZ7oJl201ebYkz2a4f5nJBzDw39KWVo2OQLkQ1zXvGCiTSdowLq/j7ziMwP1Rfjrs
         uV7gzQlNFSDiiryzutStPQMBshx949FbzlxiVoQdxywBka36pLfree0FoDtqHieqXZ9h
         LSgcUGWnPCzn38RtRhs/XPWLl0gNsZKoEPpWaZcCYDw3x1qSEcrPoXL0OXhYHOZ/VJCD
         o81eT3EXtrpPzrvnW31ZLOH9xKRQTKq2SpnvdemuVseN+LY2LrjlyZCHaSdpM+Nkqi8r
         dSpTP/SLeNoIUByjYSm41gQDDZcdiwBVHX+C01i1dKIRxJsM+9fV3vd+AvYEZc6zq6Lh
         pjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7J4PbmeH1oWO8W8ZajC7YRPfKxbxslCKwg9jxg+VhI=;
        b=bAiNBwvIt/tZ+td9acgsSjfEYEuLoxsfiArFcSlhRnvbRUT+AnfsZB3QCcAY7Jc21g
         Gk5q+VQNbA9D9HFs919D/KxwFAz0PDsl9U3w6hNZmZ4FHaO/Lj5xRJ7HiXk6TTxKPiBD
         H0PlK8TZUemdZDUe6WiEOKL8xvhGycM6CtaiaUrPKY2Xk+jv/iupO3nw5DOH0kMz6cHP
         Tmf7G1yjWfbAcgNrzM/DPkBWpaPL3U2wYPUis01qNqNuzataqnkFQlV3De4nt4huKxT0
         nDy6il6fysvSYseZSqa5fd/pl97ZelnSSqsmma3RROiz+7XnDe7BbvGywdn+7KpP+zLr
         oX9Q==
X-Gm-Message-State: APjAAAWoV7wFrn5ycM1LXYomuxvcarNFAlf6zNJ2GobsWkRfTECQukCd
        gENHFGv3CHq2j0xuiV8g/LNUOgqRVHoGrd7fNHSkqQ==
X-Google-Smtp-Source: APXvYqycdCEjJhtO9F1hYvDSmgwKHe8g+Qx//eIozwl50NSf3M2ESWqUNchgPo7jVeCOMW93J0H7u9GmmXC1JnhgtLc=
X-Received: by 2002:a2e:8056:: with SMTP id p22mr20790479ljg.69.1568279311270;
 Thu, 12 Sep 2019 02:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190910141529.21030-1-geert+renesas@glider.be>
In-Reply-To: <20190910141529.21030-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:08:18 +0100
Message-ID: <CACRpkdZ=NVVEwk=V8z4--t0Yjf0bqKrjKn0e8d7hKn_1-3xW0w@mail.gmail.com>
Subject: Re: [PATCH] gpio: htc-egpio: Remove unused exported htc_egpio_get_wakeup_irq()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 3:15 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> This function was never used upstream, and is a relic of the original
> handhelds.org code the htc-egpio driver was based on.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
