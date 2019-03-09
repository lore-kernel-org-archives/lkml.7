Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABACC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DAE20851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 10:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QcUllTfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCIKvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 05:51:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39358 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfCIKvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 05:51:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id g80so120291ljg.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ljXPcrxeWbpI5VtcQdRpGdRGFj0egxZjP9onQZeOcmw=;
        b=QcUllTfO29nUEMy8YCzXGwD9hf5lgA0/OC3vwFZBml1EeWnaMBZxGHuEi1KeDCGNfi
         Bci7LcgJAXmQse5L5ArnonrF1i5BvGLYSEJJyhu82vuRo+23ik68ugibVrmkZgF5S9B6
         9AxvHRtS5sPd8oPpGmqRCkOk2ZkUP4kHd2iTX/rRzXLjhLcg79qERowkTPIqkrYrD0s4
         /sPZ0yZaVsIUR0C/3W7RvUv20iYUOreEio29lFsN3817fGH+q/alSo4vTxH1NfYqb8yn
         LKdF3ONcK9S/exoeVzlvIbUMTh9+ZvjI7UtKbEeHTzNaosRHIwfkj1b9swDVGLwF2WPa
         KjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ljXPcrxeWbpI5VtcQdRpGdRGFj0egxZjP9onQZeOcmw=;
        b=sjPKWbXVL8wJzcmIdVOuT3IiEsuzRTuJhIIGHt4YvHuJ4hNkYHA5CNxBaQHjtTvP7b
         dXEg9uEu9hpEtlJUC6dL0iZQ1NYAX2neT5c5pXU/no0OyI/IhnES3kFv2QLIb9R036mG
         dlRZuvsLd0j0WcT7prUte0D6wkIzGV0NRdg9yhEIywkxObk1CqZ3GtXOmNmpfO3U+Rqw
         KC4QxGMmQ5f0fZutpxdOEMgNWx3VEHK6ZRAtMEhXgiIEnLEvJenF+uqxPNn3szg9axkq
         l8prxNpuMgCer/ai6/wRJfdvWSjrtGhxRm0yBOS1vwTo+JIE3HvAJECT8KDik8hpyWDT
         9kHQ==
X-Gm-Message-State: APjAAAXcD8jBEE1JQZzZTyntoktl+Z5etCk7beF7wFLpBJ66oTd1Yv02
        S6Hw6b8K5KPZSOupw9E35eFr1xuEOB0IDiZJf+A86A==
X-Google-Smtp-Source: APXvYqy+vUGdKXrCCCeO/P0tIuqunYtGORXofzR963LwCrmh+uZlnT91D48vzhIa4kj7NqdGssDvbrsD74b3svdTf3o=
X-Received: by 2002:a2e:b1c7:: with SMTP id e7mr3309900lja.107.1552128669410;
 Sat, 09 Mar 2019 02:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org> <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20190309015635.5401-2-manivannan.sadhasivam@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Mar 2019 11:50:57 +0100
Message-ID: <CACRpkdboriy8xym-Czj5g6=3MpiZB8-W45Z62nNQER9S9XsrZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] amba: Take device out of reset before reading pid and
 cid values
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Xu Wei <xuwei5@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 9, 2019 at 2:59 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> For the AMBA Primecell devices having the reset lines wired, it is
> necessary to take them out of reset before reading the pid and cid values.
> Earlier we were dependent on the bootloader to do this but a more cleaner
> approach would be to do it in the kernel itself. Hence, this commit
> deasserts the reset line just before reading the pid and cid values.
>
> Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This looks correct to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I think you can put it in Russell's patch tracker in some week.

Yours,
Linus Walleij
