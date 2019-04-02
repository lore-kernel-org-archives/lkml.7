Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E839C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E92F20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXg5fk9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbfDBJVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:21:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46503 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDBJVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:21:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so10849178ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 02:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4bFY46yq9boFcAd7/7tIpz/4cYOFrEHP8TbnORpLII=;
        b=BXg5fk9baAP+2B9KhplTRd8bHfXNp/rTTbZQE+Yont8KVNmzsHwwkoWjyCmPKf2qcB
         hcPcWT0p3uvbV4GY8urD0Vql2BPP7PVHmnnRqMhypeS2u6FKnk5Qdl0xhA1lTCWX2Jct
         ERiaCw5m1PnKBLhviQQCKzynYB4Da0fijL+y2E+HtWsdSb4ofTuzmmTF9brNOeDadZdZ
         t+ZhiramAhXSyMTBzXURuGegSL47CKwlcgt+KHP08VBdNL+nMBjLs+F4AeeVmG1IWJZX
         9g1Jretyj0R23d37bqxXcHk+Me7XzlwsL/9GFLDJY9ZB5hqk8pDqiUQagFv9q5P6oJq8
         VdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4bFY46yq9boFcAd7/7tIpz/4cYOFrEHP8TbnORpLII=;
        b=XkPfoyeHIh1Jf4cJTDxuDfgTQUMpKW8+1Qd9k+uzeM3aVXi0ysasWEcgXbiGDFmfu5
         5WqHsF+8700eULJ3CsgDwfC7aJWKNE6tPXrS9Bg5smQEpo8ZrAe7H6GyqcSDTIjL+0kf
         PgV0QITGOMGXlg58ya7bynKYRmlOLR69vV2Je8WRElpA1GtCbdkO4WPRPq6EuYL2Dtkp
         CDbzzywYJoMBo5hyPT05rC6vlq5/xzlYLTNOSsPNQTBiR0BZcmbAiF3EUjrsQF76P0Kw
         Km+/KkgfOpKGLNknkaePFbTnjGoSWIDuOiJJ5TlONNPmkETb2pRgcl9QXjpUKf7+/9ug
         Kgcw==
X-Gm-Message-State: APjAAAV0ypcBS9LaJXP3cvT5fO9MbQ7XKmR/NXnrIAyX5+6eSkVe7f7i
        LPVNn3/6+oAuO953H2Tq4WxOy5FLqRFFJkBn8TvINA==
X-Google-Smtp-Source: APXvYqzd7ZUxeeFq2f0+XDJRdWWHCIsR62wqCQnIFMbAZH/I3UakyZl6gRLOFMX8U+yXbsZwB26RNdtuCwtJOr04Qrk=
X-Received: by 2002:a2e:808e:: with SMTP id i14mr20141593ljg.103.1554196865261;
 Tue, 02 Apr 2019 02:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-9-git-send-email-info@metux.net>
In-Reply-To: <1552330521-4276-9-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Apr 2019 16:20:53 +0700
Message-ID: <CACRpkdZPU7E-hCJc+ohrpPtN+oS2qpX5XpHBpSC00fcEQgZGFQ@mail.gmail.com>
Subject: Re: [PATCH 09/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 1:55 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 9 ++-------

Please fix the subject of this patch to gpio: eic-sprd: because
gmail goes bananas with things that have the same subject line.

Yours,
Linus Walleij
