Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D634FC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4422133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKASZiZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfFROAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:00:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34230 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbfFROAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:00:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so9393723lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdUV7CzfBMqln17zR8zkIO3XNGBpw5OXNtAwnyi4zUU=;
        b=YKASZiZLPnCBby55M8HxvQ3P6hVicwek4YaqtAI8cITJMo4iBFAWa3Yij9dIdVNJQH
         DG1Y36EZ8g1RlQ36fuSZZlWJEos08p8a8NGCJ4ePwoJ/iuXCxhpGJk/5ImxWt9stwQa3
         yzSilSFRMmJXjChN9LX5EyZvKJu7NVi+g7+QVmSVxVxmE9hUq/fjv8eT20WOZ2CX6Gy1
         k+gKh2jDh1GJYeEQ804FDN2kPBVAKd0Ajibuja7XLyFwf9lbnePWZmNBToWcISiz5mD+
         aKQGxa3de+sSqrZXCcZkixnJCx3Go6nC+1fUrTBqDcbfKELH20imaBLJDuj2IuYSDZwJ
         9DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdUV7CzfBMqln17zR8zkIO3XNGBpw5OXNtAwnyi4zUU=;
        b=V4ln1AWgT8MgM7sEPZwRKnGTi6AOkMIIv7J6IKqOLMaZYzt8jCP6aHJzrH4hD7zuES
         +8ZYIcOEzfhiCZGY8bYKdgN5W797NfYwHC5Tg4EaDL6ihne6MuTTGlEYvwDSTrISZzwG
         X938xN7p772+v3wAdy2WMciAeKQF+3tL08UtLryGGz+A4Ispour3vVSzt2D7USiMAAMd
         IFRfT5IY4Lj4JH1oX5y+r8NvIE+OC81uz3covGQpl5l73QCu+487VCaW3HR0El9mRM59
         wJXVMElqCzHCb0BjLuCgSitl/EkD2V8MRQPwHadGAIZMaGoljzTJWe7Ttr9brGOJzmZq
         VfMw==
X-Gm-Message-State: APjAAAVjjOxKcn+jd4VBq60CVWsmPvxFQ2JaEugBAv1n8G3gCNffYYr0
        DiImJdkZniLjChY/I0yLIxfK82eZ6PCMck6Sj3/BeQ==
X-Google-Smtp-Source: APXvYqxZtj/5LSylMWRwAm5XoxiotJGXmZeOzoZYzvkHtOk3c+tM2Kf0qCRtTO0+6PRAgESjaawSeSGiHoL4zjd1R1U=
X-Received: by 2002:ac2:5382:: with SMTP id g2mr2936130lfh.92.1560866450515;
 Tue, 18 Jun 2019 07:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190615100932.27101-1-martin.blumenstingl@googlemail.com> <20190615100932.27101-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20190615100932.27101-4-martin.blumenstingl@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jun 2019 16:00:39 +0200
Message-ID: <CACRpkdZ8vY918mzaJyX38gENJtoA_KJq3RLGxVObdQjLKXULSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 3/5] net: stmmac: drop the reset GPIO from
 struct stmmac_mdio_bus_data
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 12:09 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> No platform uses the "reset_gpio" field from stmmac_mdio_bus_data
> anymore. Drop it so we don't get any new consumers either.
>
> Plain GPIO numbers are being deprecated in favor of GPIO descriptors. If
> needed any new non-OF platform can add a GPIO descriptor lookup table.
> devm_gpiod_get_optional() will find the GPIO in that case.
>
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
