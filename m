Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF6EC7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412D3206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiIC1pel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbfG2Vgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:36:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42393 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388689AbfG2Vgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:36:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so60012459lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+uKl3DmiY8dW8TGLrxGk/fNxMPrGaMpCCMkd3OfZgg=;
        b=XiIC1pelgzO+M5iJgoHNGaFTyBt4JyMKlOsZ+f6+nAfV9oBGWKwb7dU3vhdcbctnq4
         VCEcyn7DrLpIeckFKbi/1dLpgiJtSsuxe2S9dKXC/RJ85kB5lYrKh0T7ZZ2A+Lsc96lj
         RZiZhzpeU87NdQRdREAH+PhFluvzgtMhf4R85gbIovSIzVN07VdPFBUZ2DymoY4rkNq4
         t6ipq/cHvX4AzeY+CiEFb87Q6Dkc26eS4keDhi13IS/16+QXJpHdfi7+Nw7ttGvzKd41
         Jghzth8iqGKCq40V9ct1stdODtFsAPaRDLUJcHC+kuGT94mQMJ25XhbNwswKtuNkNFaR
         f6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+uKl3DmiY8dW8TGLrxGk/fNxMPrGaMpCCMkd3OfZgg=;
        b=JAQQeo0I6g4UAN/+M+51rjChv/lj0eNzXIAtrN5Ce/x38z2bRn1JTf7ixytJWn+TEX
         NizxQ7FUYYXT6M7XWItMp69aW1AbwpBcMn653dn6t/7UmoXzGs8nItYpoYOIQLygKtnC
         VEqFgpSZnzvSC0r398s3e7n/06LlvRaHRgUGPJiluzzvOjw49g0AZ9hCtmqVeCBk05n8
         zbMtiXt/Fu9Q6GeFvzEB89pM5DNIPkrkG/IiTCKTrMbWo+8e/Erml7eKcCJirqge+b4r
         Pm18WfGDsXAoXywkdjC0iDgildjSLe5MYdt7zpnqHFGCOiRh0LNbKG1jO/oDl5t/MeXq
         lbbA==
X-Gm-Message-State: APjAAAUoN3lvkRBzOrUYxSnINobl9cI8cSXgcdAkN5UUJAsH4U1ESbz6
        x00u/ojFpg4bRRmDEz2ABjcud9mv0fYj0lBPZuMngw==
X-Google-Smtp-Source: APXvYqzpGev1ZgT7UDoBmrvnEtfYU3dY7RXU+9rHQOkrcjsAH41AmeGJd40sfREgQBCjTHKjCZUWI87ScfuEsB+15wM=
X-Received: by 2002:a2e:9593:: with SMTP id w19mr12040674ljh.69.1564436189593;
 Mon, 29 Jul 2019 14:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190711142457.37028-1-yuehaibing@huawei.com>
In-Reply-To: <20190711142457.37028-1-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 23:36:18 +0200
Message-ID: <CACRpkdbBWPN8px=5gxeXWifDz5gCdbqWvgk6ZPdXS6Pa_hKO0g@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: aspeed: Make aspeed_pinmux_ips static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 4:25 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Fix sparse warning:
>
> drivers/pinctrl/aspeed/pinmux-aspeed.c:8:12: warning:
>  symbol 'aspeed_pinmux_ips' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied with Andrew's ACK.

Yours,
Linus Walleij
