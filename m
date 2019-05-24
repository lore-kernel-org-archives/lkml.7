Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7EDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B072168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVJQ8nvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391318AbfEXLwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:52:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41799 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391204AbfEXLwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:52:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id d8so6912299lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iYR7JRp1HHKG9HCoJt7Z3ej82/8WkT9mMtbM2Bxr1w=;
        b=eVJQ8nvD3hAKgGuALBDODWh58e0l1HeXP9wXW7FkvNcgnbbFuZmFeCJovVHM7dlj/m
         2EiHPDPxvbTD2brb1rT+agQlFIUawA/Dzm6nyArjH8xr3WTv2B6gMtblpROM0lb8OJrD
         VGashTDvVUiaWWxCOc5ezn4iX/aWk+8fmj6TVDLYJogUsOmKuhBtWeoUozBpCe0OX+yX
         K4swzxSB5D53DseVA278hofCrfKYTqriUqPa6ygQQHcf/KgMvQq+TRm1eSn/h/n39EzK
         LO6xBo6WWVgl1/V6k1rKddLmIA1nePqoCwSjk6sPrzwEslBhyCmRfdyKxx+qT3d8MNGO
         ZoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iYR7JRp1HHKG9HCoJt7Z3ej82/8WkT9mMtbM2Bxr1w=;
        b=SFfs6w6aunsq/JKfD7ILdsFplOIVyMrl4X0dw68qzTRjAiRNhItY8Uz/vCA/2LbfzT
         rPAPgTpuiofWHINe4lGQUGGEBBuUK/cLbtVX+WDqzKCj2tvF2zWlAvB85oT9KBlocUwy
         /kYG8tpPx4LJAGCX4odmNYtCxxlVuAT6mIzNw7K3pIB1ZMEg1oi/x+e0yDtDY2Tkmv67
         4dAhMVDzki6lJ0EBJIFI6cK6DHhTsVv+bBXfrMUsHttOBrJOcGzA7IU65fzM1aApo4cD
         RH/kR42jB9hTx8fruUaGkJSmpxfVk7kZj7C4vxkVA2S7wD8KyURt8K1uwMiPaIsKN1CH
         L3rg==
X-Gm-Message-State: APjAAAWVThrN80PFVd5iIucUOJIC2tJLQ3CI2D9lzxJud6Cx28QXtRSM
        2OpVC2rA5BN1YI/U1gljMMHm0ky2u3RupLDdRRgsZw==
X-Google-Smtp-Source: APXvYqz1+uN4e3Ih8IK72RpE7uJUloQIFTXznGy8kaAypBy8X/PEODddYscikHDcaeojiUt2pj4//IiIs7Se/lmo8RM=
X-Received: by 2002:a19:750f:: with SMTP id y15mr1121022lfe.74.1558698720606;
 Fri, 24 May 2019 04:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org> <20190520083101.10229-3-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190520083101.10229-3-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 May 2019 13:51:49 +0200
Message-ID: <CACRpkdbWCbhCdrbUueC9Jv1tJQcKiu5OaFfAqyMhKmEK+nH+xA@mail.gmail.com>
Subject: Re: [PATCH 2/5] arm64: dts: bitmain: Modify pin controller memory map
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

> Earlier, the PWM registers were included as part of the pinctrl memory
> map, but this turned to be useless as the muxing is being handled by the
> SoC pin controller itself. Hence, this commit removes the pwm register
> mapping from the pinctrl node to make it more clean.
>
> Fixes: af2ff87de413 ("arm64: dts: bitmain: Add pinctrl support for BM1880 SoC")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this through ARM SoC.

Yours,
Linus Walleij
