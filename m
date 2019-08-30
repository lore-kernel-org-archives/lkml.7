Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751DBC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D6E21874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qp8yU+LP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfH3ICF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:02:05 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40662 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfH3ICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:02:05 -0400
Received: by mail-vs1-f68.google.com with SMTP id i128so4210474vsc.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSReTBR+21k+gQlfPIxdDjT6LtoW1ARQm0j/COjHJ9U=;
        b=qp8yU+LPUcX/mAFN/tdWTbxE8ZDUp2Z8cCy/SKuHHj80GZtnQ3tQP7JQDmbyIBAWoy
         ZePqJezkftPXgjaRJ7H2pFtF5ZnZOQZy4N5kyyN4o2HhEhsa410M5iWSyc0l/Ynzaktm
         YOSy3tWjasqTapLStwH3UrO5al31vEt96KXMWgXhv2YXTynO/2BcGjuL+2uj+TX6vHDJ
         UVwmxzPe4wEYqJUHp6HIsvv7G9ymY37avF2pBFZHYsAo8M6r54t/hRz3V8vqsvpuFx4x
         JuYF9njW9ZhqiqYVZqFshkjVEd+qOApUqzk1gOe47O82ybxuy80NG/F0a3bmeO2YRwQJ
         8eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSReTBR+21k+gQlfPIxdDjT6LtoW1ARQm0j/COjHJ9U=;
        b=ZENfahYofYJgJbK/fz4iNcBPicODw4HwoN2DANkmyncNiqn/Sgks7VkoKv0eyXwbKS
         duwn8Kekk4eMsON4XFR401tjkfMxFWzn2hvhmuzVVadw2Z63QBNTCZmgTG/nn+LBrUMx
         ZGOwx3MeSgTZTNG635SJwejF0Ra6lTNzIwVj4iGrTGWzIzAKlxQcm1ndJjqc7iLaWg8B
         dUMvYl5P1SskXkroshB7OZtkjRfHCxZy9pFhtDu3jLIXPa2L8Y5vE6VQj2MR1gdliztD
         543tkqIdEMqCcK0KoTnczVqBRasRXYHuWgPg5tyF0r4+qbIah6e81OHlAZ+BlERhYKad
         XNxQ==
X-Gm-Message-State: APjAAAWWwWH5pldDsLu3gvKP7U3c3XaSzeJO+53wrPreIR26801vjvKz
        jgV4n3QQ0Rle897+5L05+QUS1Bj1gcmN3Pjg9JPklA==
X-Google-Smtp-Source: APXvYqyOx0hFYInMfmpsUnvpCKFGXIHa/+Ahs3V3CNXSh7WcogIeV6A1MSfhHPGxYA3SEvRTgK+RozQPc8r1yR8QgSo=
X-Received: by 2002:a67:983:: with SMTP id 125mr2338906vsj.191.1567152124259;
 Fri, 30 Aug 2019 01:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190830074644.10936-1-andrew@aj.id.au> <20190830074644.10936-2-andrew@aj.id.au>
In-Reply-To: <20190830074644.10936-2-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Aug 2019 10:01:27 +0200
Message-ID: <CAPDyKFrKXfB1F2dh63KrkCiKGbmbBWaAM16vJqtQncnF4YctQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-aspeed: Uphold clocks-on post-condition
 of set_clock()
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        openbmc@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 at 09:46, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The early-exit didn't seem to matter on the AST2500, but on the AST2600
> the SD clock genuinely may not be running on entry to
> aspeed_sdhci_set_clock(). Remove the early exit to ensure we always run
> sdhci_enable_clk().
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index d5acb5afc50f..a9175ca85696 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -55,9 +55,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>         int div;
>         u16 clk;
>
> -       if (clock == host->clock)
> -               return;
> -
>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>
>         if (clock == 0)
> --
> 2.20.1
>

Further down in aspeed_sdhci_set_clock() you should probably also
remove the assignment of host->clock = clock, as that is already
managed by sdhci_set_ios().

Kind regards
Uffe
