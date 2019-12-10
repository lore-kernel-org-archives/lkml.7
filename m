Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0808C2D0D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687C2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLSXt+0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfLJJvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:51:38 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44470 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfLJJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:51:37 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so12541460vsj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQDpaNJuTuBCwjRi4ZnQZs7rqwTgBbG2PPToht2ip2k=;
        b=vLSXt+0DuDKITzK3SqmZRrGE5FDWu0InRt15eBUNJ0X20O1kjN9pH9n+E14Yfx+C08
         4qa4xgrg/WCYkwz5zm9rCafjbNNxEsFYcfIgIeKyNiP9qiAk9bXWIUVUI11kKR7PF2SU
         K0xhbqD1TW6QuAkV5pa9VHY4XCnoDktTOhRY9baV7BSYyERUlS1fBTR52DpdamphlyyL
         HdvmaILtNwnX2pqbIJPt0a7g5DAxyVyeG2u0isQftIhovS0a6gHORpWe6p+q+P9uaVkz
         qxWvNIj3uXa9d2JVvwOlYHSI6okmZsH+LDNjji2iJSRc0lxQQeI/CHCyVsB7lnrJay4l
         Qnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQDpaNJuTuBCwjRi4ZnQZs7rqwTgBbG2PPToht2ip2k=;
        b=TcjIqzvu42KkskCb/xmYylgoMq+fdLtcg2ZW3y5g/EBto3spWQ1XtR/GjJ0BNsGgPt
         nVgtHJv3RoGY+rne6WRdqFpBAc7iaHC9YKQGAcMPfCvNjPvFhicwuDUjcl4z9TcCrbOa
         UOkNA8w9szx52Zqhh97an3zJypuP+rG7Hy9eOjDyO+0i99VegC7Ky+raKFwdGKneWv7Q
         HvQXrQtW0Qfw/+eRMZyc3n/JOEgyiLEgkOxZa9IzCIe3obrEYgzPASi73+smfhTBNI+F
         4OTOACIF6AiDG0BJso0qR43aY0Nt2G4iSEBYxOJIaZVbCax6oLK/aLzWDb7918QVCnQj
         baCg==
X-Gm-Message-State: APjAAAW1r9LRd/5iAnCmEAJs+v3545lE/u4gSqW/qL5U5CquwOFcB7sI
        7OHD/+6Z9xpm/Db96ovjnRhrMhvzwQmtnSuZHDgHcrIn
X-Google-Smtp-Source: APXvYqxO1M9SsfvsEtMjn6bF+rEq7sRKb12tvZGh5y8skVng9zb4XL/QUI/Alr8nAhH+JJMWFI9x+cmtZA+MWjC/M9Y=
X-Received: by 2002:a67:ff82:: with SMTP id v2mr23145347vsq.35.1575971496164;
 Tue, 10 Dec 2019 01:51:36 -0800 (PST)
MIME-Version: 1.0
References: <20191128110422.25917-1-faiz_abbas@ti.com>
In-Reply-To: <20191128110422.25917-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 10:51:00 +0100
Message-ID: <CAPDyKFp2Lvea+7-sExpcUvuLsi7QTuk1169nYdUn-CFYj+BAVg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci: Fix incorrect switch to HS mode"
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 at 12:03, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> This reverts commit c894e33ddc1910e14d6f2a2016f60ab613fd8b37.
>
> This commit aims to treat SD High speed and SDR25 as the same while
> setting UHS Timings in HOST_CONTROL2 which leads to failures with some
> SD cards in AM65x. Revert this commit.
>
> The issue this commit was trying to fix can be implemented in a platform
> specific callback instead of common sdhci code.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3140fe2e5dba..296d955ede59 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1882,9 +1882,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>         else if (timing == MMC_TIMING_UHS_SDR12)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> -       else if (timing == MMC_TIMING_SD_HS ||
> -                timing == MMC_TIMING_MMC_HS ||
> -                timing == MMC_TIMING_UHS_SDR25)
> +       else if (timing == MMC_TIMING_UHS_SDR25)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>         else if (timing == MMC_TIMING_UHS_SDR50)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> --
> 2.19.2
>
