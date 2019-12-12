Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC1C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2359C206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/TELp6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfLLPbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:31:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34932 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfLLPbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:31:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id 15so2034437lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECIp9lV6kJ+VM+6W7bBk3Sdy+LzurMj7dRD2Wk/+8N0=;
        b=b/TELp6QCwaXPDO9kaxh1LNS6hl2y/m9h+qIZeOi/JE7x4Ws8x2zw0/PTtRzRfs2yy
         K8UswXohSzdNsWP7mWOSDld6pgtvcOpoY8/jYLYvxxvntzQ4rpmeSlcZV3+H6LlOhS7b
         v6U+gqlikaQqB8bJzmBmsEGMFL4yxu20K9mJNqkvPcQCbOvY1EANEeqtfIIon/R2gaHa
         VlhrDdjqVizCY+mEHoFxzKRcEjd96cmVJ6fuIgKXipL685jRgQjRJaFraVv2haoI/GJE
         qRAmbDDx67PT9FmuNVAi9DK8w7BiOKHsHcXm/HiRsA1mLqb5NNffqvRJk5lDBZIxg9Wv
         Ns2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECIp9lV6kJ+VM+6W7bBk3Sdy+LzurMj7dRD2Wk/+8N0=;
        b=BseQg8/81qXq8dZpaWYBZwUavaX0nWo+A3d/YIZacc9tHom5E+9DVrXDJRxfmIRj+q
         G/mNeapaJ69LQm05hZ02mG84bcjGGAkPWFiDgUM8J3rP8lZVxW0WFIA4eQcawSjEpv1g
         TK24JiD+I51sfPyGS4RMup2VT6sgluwm/EwUOVFB8633BV0oCvhVGBt4r0PrAoYp+Frd
         mqz3k6FPRC1/RI1z0iIidFO6DbrTtfLbCMp9fl4b9E2MBQR/jXqQpmDoAhWi6edv+3YZ
         /CJ9FvLDilwqVPo3CglwOcmX9SzFZIHwPZ3yjX4902dQwqiNenWMEA7HHGhTmEWeBS73
         ggpA==
X-Gm-Message-State: APjAAAV/CmF0nZRvIPobT8D4gxgkaNdJ0TqicCYT5ke54EzWqB7n3bfh
        OZI9+HUZj89d64r3cI5cP0pQJwa5HOJa7B5Ac6IBqA==
X-Google-Smtp-Source: APXvYqw1PlfuejP1ZPxzLQvWLLSvj4Zx4f38wbFgrFKRxNPyTKCVACivic8/ENzEHqljQsQrx4I1syaFHSBrQG19/gM=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr5854026lfi.93.1576164708519;
 Thu, 12 Dec 2019 07:31:48 -0800 (PST)
MIME-Version: 1.0
References: <1575352925-17271-1-git-send-email-peng.fan@nxp.com> <CACRpkdaTLVNXd+-j_gkOfKnTk02XaZiMA_XxUeM0_4zZ_F-=ug@mail.gmail.com>
In-Reply-To: <CACRpkdaTLVNXd+-j_gkOfKnTk02XaZiMA_XxUeM0_4zZ_F-=ug@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 16:31:37 +0100
Message-ID: <CACRpkdYjCnx46kOuWXMZFme3emm1TugqjQPDctakOppAeCZvZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mvebu: use platform_irq_count
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "rjui@broadcom.com" <rjui@broadcom.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 4:29 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Dec 3, 2019 at 7:04 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use platform_irq_count to replace of_irq_count
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V1:
> >  Code inspection, not tested
>
> Patch applied.

Oops dropped again now that I see there are comments on
2/2 that warrants a v2 of this as well.

Yours,
Linus Walleij
