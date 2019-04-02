Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C08C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858632070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LD2K+LBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfDBHZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:25:31 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41676 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfDBHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:25:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so4109031plj.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ncDXaAcV8IOSU4MFdaf+aa9KB9meHR/c5/8u40izinI=;
        b=LD2K+LBJ8hXXl5c8FIkDFuqU71KETlGkRnYUhqwnvSemMzjE9geyacY5aWurE8C3BY
         BxNw+ItHh56oZZ8WSJAq4gx9BOj2VT1gcRwnnNiFW8JOTQJrqK2nF3nKTU4lIaozQGNR
         +HC+a1geMarmMYuBsiSozle3064fZ6952I6sJiTm+5VCxOHs2a58Ht+zwMouvJNm9XfQ
         NUjLTpo63z4oMTR8Y4OHkAr4ASPTN40KR5dn9cqm81mhm93NBIDG01R382RnrqGjVzd8
         i9joyodCQZFFg6Y+zH2EruyB+8IJgvEGOgX26bTVgTOiX7+OaTGlGAPMELYJ+4iCbbOQ
         EBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ncDXaAcV8IOSU4MFdaf+aa9KB9meHR/c5/8u40izinI=;
        b=BWmLCBctqA+FOaIFfTK/fgjZ+JULwkBavyfKrnwcWC8+jnRq2y2p4kahVuVB6OH4IR
         buE0J8B+3VWnfBgPjZEvmkNbCZpZ33RYT3DgmiZbHmlnZME3CtBTSVvlIeEQN7a4DQt5
         6S5oZlOW3d998kAZLAZcOkoN4pxcn/ZaUYlfB5KEQs8eWQmM5y+GoQ0Qa4Xeld3d23Sk
         hlisyX/NVIBMwylBVYio8hyznozIzzo7thkIxwSB0HE4wfIQkh8YZKOuN9aEdtGK2i72
         lcbLcxmuxu67CIEWEfDKviigmjgFTaI2HS0+FWC1X8gpMbsaSSwRomoO9QeWzG50R2Mw
         F1EA==
X-Gm-Message-State: APjAAAU+bbCbAWMw5tOrwuXC+4wZMpi6E1Q9jFL2x7ZAuZKD9BNLpcBX
        ZQggNPaHoWib8/IO8BU/NKWtJg==
X-Google-Smtp-Source: APXvYqx5Yvs4qg3OwqYWLKt5noSGOlGAyNYvDhrqH/w328ZyxDbLKRSBgdzCkfCXXHFd5uVdMM28Jw==
X-Received: by 2002:a17:902:2e83:: with SMTP id r3mr51235438plb.153.1554189930011;
        Tue, 02 Apr 2019 00:25:30 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id f192sm22742858pfc.180.2019.04.02.00.25.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 00:25:28 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:25:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v6 01/11] dt-bindings: mfd: add DT bindings for
 max77650
Message-ID: <20190402072520.GF4187@dell>
References: <20190318174228.18194-1-brgl@bgdev.pl>
 <20190318174228.18194-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318174228.18194-2-brgl@bgdev.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Add a DT binding document for max77650 ultra-low power PMIC. This
> describes the core mfd device and the GPIO module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/max77650.txt      | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
