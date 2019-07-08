Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E144C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551FE20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfHHkqzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfGHL4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:56:37 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42851 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbfGHL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:56:36 -0400
Received: by mail-vs1-f65.google.com with SMTP id 190so7990350vsf.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQ8OPkmw07aEeQyb9mErO8HsEQ8fLM7WgoGd9dnI8OQ=;
        b=mfHHkqzVTlPh7DD/CXaqQN1IxI2n1m0H59RqJua4BBVg+5iCaga+ERxDXoHUKbEaQq
         M0oLaH1uL7nA2OJzVPaTjltyNJENi6CoxCBojSt0VeD3ReYSbHjEe3Z0l0FOq9ZGp069
         ZtBpw1G0uP/YQVNLk+KL7lasYV6EMFMTqH6H5F7a1kvNuClhV4RanPtq4aaAYcIXMa6z
         1gNYeK8OICR3H5L+I0eVp371+Mq+pIRd1MENdLApQED1DD+Voi7etHnDPvt6l+/Ugf7z
         KwSFmpdCwN7VOQvTigWk34zWmLIi235TAaKqER4eZH/iR/7JHeXUNOwXS0ImfGkfmlxo
         Jjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQ8OPkmw07aEeQyb9mErO8HsEQ8fLM7WgoGd9dnI8OQ=;
        b=uX00Bq5q5y+HxpwKmLnXEb/6ShYS5MxwkjALqtUtazy8ZLBfY2vwsnWODMdy+buduj
         KdaTHDmj5V6NPGfT48pAU56uSiuJGjQDzuEAvUZ7gU28s+WkHpUHH8CkLHL6JaRL4fFe
         wrdxoU7vF0lO6/sXbXW6k1QoI0hJR/kb/bz5XUyDBQF9VkU38E0CFEZmIVbEz9DYI0xk
         sOlKrCk1b5mcD+yij3WBMTxdtUoUSiqONglU72LgbV5BIko+B80SzK4gn+nIB2eX/lJC
         bpbQ8Lw+xtVaMWo4FZtfXtKFKJRNlpbl5X45wM7ypd073dJwMS8I6CYvfh2WpCRb00ii
         PlNg==
X-Gm-Message-State: APjAAAUsAj8CLbuDX5vlrUrxbDnSC1zJV+EghlfLvqVVUlGzvWmI9Jea
        KJjE9iGG857HKrZrGXaLA+y1mDjd55GSdtukMZA/DWvg
X-Google-Smtp-Source: APXvYqwqtOmX5E+dmwbt6Q18NzrXU5GOE2mxAS6wu10KW6bphP9M7qyNV0agevIeb9KZwCnxq8yI0RElrUtd+y91huQ=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr9850526vsp.191.1562586995022;
 Mon, 08 Jul 2019 04:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190701175246.32270-1-colin.king@canonical.com>
In-Reply-To: <20190701175246.32270-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Jul 2019 13:55:59 +0200
Message-ID: <CAPDyKFoXEr+DskqQesxJoe+btA3VXzwZKhVZSXLHiw7tiwhX3g@mail.gmail.com>
Subject: Re: [PATCH] mmc: alcor: remove a redundant greater or equal to zero comparison
To:     Colin King <colin.king@canonical.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019 at 19:52, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> A greater or equal comparison on the unsigned int variable tmp_diff
> is always true as unsigned ints are never negative.  Hence the
> comparison is redundant and can be removed.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/alcor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index e481535cba2b..1aee485d56d4 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -672,7 +672,7 @@ static void alcor_set_clock(struct alcor_sdmmc_host *host, unsigned int clock)
>                 tmp_clock = DIV_ROUND_UP(cfg->clk_src_freq, tmp_div);
>                 tmp_diff = abs(clock - tmp_clock);
>
> -               if (tmp_diff >= 0 && tmp_diff < diff) {
> +               if (tmp_diff < diff) {
>                         diff = tmp_diff;
>                         clk_src = cfg->clk_src_reg;
>                         clk_div = tmp_div;
> --
> 2.20.1
>
