Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0617AC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2ADD20673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzEE+tTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391377AbfEXLx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:53:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36530 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390961AbfEXLxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:53:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id y10so6936512lfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArzXIkFbICKV9szOeGfzmIhB8Bq88PwXMETYybb74ok=;
        b=jzEE+tTJPbcrtJ4L4eQdnvHMcevMqqx5FcY5sYaJi/hIwBRhZf/eda7UvoUBQsKPrF
         3m4yW6UvhCwqrLuTnJoHBQGDRuV5vuBC3s0BZDXXgyU8F63o9UUhp4aTVAhdsNPaC4f7
         U/Z2i3KAEq9rF7xHmkGh9bWREmGY2xB+DYAEEucYsFhkF18+R2fckx2ZSQgFVQJL8rLd
         2lPdfoYC0Z2KMEYKi9xauWIqUDH5QN/xPrx/qgz8w4juGGoqw22wrxY2EnESQ3qhRkUz
         dvCTi8jOREMhc3LMNJU0DkAGs87Al91/0vpDJ65HmSkGn7dBP1FWLTlYTEIE5hK+7K4T
         jrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArzXIkFbICKV9szOeGfzmIhB8Bq88PwXMETYybb74ok=;
        b=PaO5kcOixJoJTCROgbLKLZCOPCfogcQERGOPVjPUqapqdrl8r1grLA74dIgK5AwTC7
         ha2UyZCj+iXxuhgb55/WcwantWay8Nnd9TyAMtwNz6PloO/O3ID5t+nBWor5caqRLu/w
         lUjW6EZ4bkItro229elMBumk1k67nCpxATsP01WpkSH7vbzQhnAKqdXzKjgpcOuupI6s
         z7gyjeRXAV9DYbTWAqF44GD5SWg8gPLKxbp2niWMYtO1AFl8U3pf0q+kNaYtHg2CYvpn
         k3cMa77D9fpsbPUMdnA549TkDDHMULTEP3PawbP3hFpAf+yBu7ffStozDgDuBxw+gxRo
         pt+g==
X-Gm-Message-State: APjAAAWo/B93N+bNapShIU23W4q2etGnklMEDzOmLZDnlNAgcu1j36aY
        JoIHX9MCLiMyd7WxAzhmVIITqPTNsjBv5Q6QjOwefA==
X-Google-Smtp-Source: APXvYqzE7BYn50MEZEoe+sHHjHC8sPLW6Y7wfn3iSsAAhDLZMksxZFIgx0M3J1CenXT2tXKspxlHD8pFNqWzLwTn398=
X-Received: by 2002:ac2:4919:: with SMTP id n25mr5435050lfi.114.1558698834149;
 Fri, 24 May 2019 04:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org> <20190520083101.10229-5-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190520083101.10229-5-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:53:42 +0200
Message-ID: <CACRpkda3zvFfEzfVkUT3_zvoL-fTNxF+59T0f8dZtBGV9kQVAg@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: pinctrl: Document pinconf bindings for
 BM1880 SoC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        alec.lin@bitmain.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:31 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Document pinconf bindings for Bitmain BM1880 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Uses standard bindings so completely uncontroversial.
Patch applied.

Yours,
Linus Walleij
