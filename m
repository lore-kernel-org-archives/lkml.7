Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CCBC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3242208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqEjpL8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfFYJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:04:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41786 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731102AbfFYJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:04:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id 205so6644083ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhBjmgTFiYbfZZESWFQ8f7valPKPixUWhzHoz12+ivw=;
        b=GqEjpL8FHzMdySOuqZoN9HZ/OkZx7WFMmzNdnwrGpQ+jCqyaej++1ThsR1ZV5rjHoB
         ZwcNL59UKwVRJBRlevU81FuITNrJ929IPiuGv3ysff62ONus6boiXH6VfC/JbaiKuEEp
         zGkt42Fm+sEkxLPKPfSvrAJeJC9ft+j1lC8xswbhuCJrpCnqLjdIUMvAyQbGNEVhjEKG
         WOVSloHSmWWSXZlSXL+oZ6HQdczouaj2LcA5iUTWEF0XpHMSiHKOuAxM2U8RLIn0UdXl
         uxQengVbdXro7sXTxTB0+hJ5nrO5LuZuV0RaUXxGvOEMj+vgvWMruSFCcULQ4Zpf8FnF
         i3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhBjmgTFiYbfZZESWFQ8f7valPKPixUWhzHoz12+ivw=;
        b=RREvXDr5gz3oGtFetNfOjiuQd8/wxAPeiOY9YFs/nJzOUVb2t4HaFt9KBk4tE5qDCB
         qmR/qlyKjYdltb3vRU0sjAGAVElQi9JA5eZYJai3L3PFLQwBz5KGM4ce1eqTzdb3RC4o
         UM9b2YcQsuSj0yM4GAN/CCggjSAqS9w96Iqn3/RjAHu2aFPCfWRXlMfYZDzT/t6PY4zk
         aMuUh+V7nM0KdnZMCemgUKmhG5v5jwCT27W8yDaYt0KJtSjeHtpTGgahVN2LJuCH0N6x
         Lw3WP0Dpk8VeV6rsOQbzZKfhmcvkDMyUPuEvJ+haIDRrNUNb1iuY4TaAhnR8YjpZlth6
         fI/w==
X-Gm-Message-State: APjAAAV/ChIQLJk+DymynsCpLvaVQXUNgvlnBcA4Tl/Q48Z4Ao8y5S8X
        ZQDVoJ8daxsNE8mDKKq2TQ88H5LmrpgkxVwS3ZU64A==
X-Google-Smtp-Source: APXvYqye7HuIOF5YxCSm4sBtOJdPFIUuBv2Fl2N7KdeZdnjWH1VOEEmCjLP5M8RahTU5/pd3UgjGIZJRBiP2FVhZEY8=
X-Received: by 2002:a2e:650a:: with SMTP id z10mr43756285ljb.28.1561453469329;
 Tue, 25 Jun 2019 02:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <1560790160-3372-1-git-send-email-info@metux.net>
In-Reply-To: <1560790160-3372-1-git-send-email-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 11:04:18 +0200
Message-ID: <CACRpkdbcR5bcBRSx_21nq682Q+N+XgmYHS4wCVQVqdAiym1D+w@mail.gmail.com>
Subject: Re: [PATCH 1/7] drivers: gpio: rcar: pedantic formatting
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:49 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> A tab sneaked in, where it shouldn't be.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Patch applied.

Yours,
Linus Walleij
