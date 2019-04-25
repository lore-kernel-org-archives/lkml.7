Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6A8C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4794B218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofnwmQSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfDYIvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:51:13 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38636 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDYIvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:51:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so4426387lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Eikb/yBQff5JOeEE2uiEqVRn90Tt1lpV+GMJ2ggsT4=;
        b=ofnwmQSEAYWCSoq02lyj4dnfajjWQ7OEXTDEOWrUgAhTIgIc/YM6TeSWCvzv8cH0fA
         UO7qf0rztJvlJdM18Sm4dFmdkT9nga2kw2wMapE02URL+syZUEBXn4CjXk9nY2bhKJj+
         OASMNuncDL7SpXPTBpe+4NSNsDTls2qmDlQE0BmzOkua00NEfxgtyrPvl8bI0RMO21wL
         T/SrskBZ5zPwNe2j5zWV265xnHGrdNRfpH0RvH+roqXe5In7DIGatn/7sPIZu6d7j87C
         /kXcYYq+dc7l6H1eRN1E/RJ6eFYPhqcP7T8vET7K1V1FVhuMic+iBmrbB+v92IhjONHd
         UVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Eikb/yBQff5JOeEE2uiEqVRn90Tt1lpV+GMJ2ggsT4=;
        b=GVwIV+rczEj+YALkt+ZjQuZPhyf+G5TzYggJJQcTiQd289OSh0Tq4c1B4Eml937Hr3
         yo30/KzrPRXd2aaiUBKtTtgPfb1CdLHq9L/9o4CHKuXNlB7NbYoYqextnaDi/jK7xi5/
         Fc3hU/3rb2mU5VbNROeGK3B1fCg3Z8BiUyJ9m8CFtp60FzG7Z6wWW8njfKnHN3XYBZoN
         a/zp+t8fxn/9a/Kpod9qv+EP0KTy0hwZcvlZQf7ua28nJ2flWC1BDyRfCrasRCIzf56E
         hJAfl1BN5OE+W1HHYeS1vIt3kPW//kGu5s0yA6pZzB56s4jP8E1KTYakadn1mcGKnpJF
         4ZJA==
X-Gm-Message-State: APjAAAVlMr9xw8PmFM6yoqCNY6TbBhIaDJuFbZHMyfX2ufAZgnDdPuHz
        eVgpDTPRgtaElR1roUSwU478DRtBm0cqNg9zOCqcMA==
X-Google-Smtp-Source: APXvYqwOawJJPPs6LgNFUUg4DMlz84KzC3A5YKLXQnYPEMkS3mAuyyKKpHpEFKVN/9UOneh515vRvI6OoOtfAmNl4Vg=
X-Received: by 2002:a19:c301:: with SMTP id t1mr19654550lff.167.1556182270688;
 Thu, 25 Apr 2019 01:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190425083224.9762-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190425083224.9762-1-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Apr 2019 10:50:58 +0200
Message-ID: <CACRpkdY8MCfS5McDAGBhFGUxb-eioW9+GAmEgOYKmrSZgkY4JA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Rework Kconfig dependency for BM1880 pinctrl driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:32 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Make the BM1880 SoC pinctrl driver depend on COMPILE_TEST to get compiler
> test coverage and also select this driver by default for ARCH_BITMAIN
> platform.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied.

Yours,
Linus Walleij
