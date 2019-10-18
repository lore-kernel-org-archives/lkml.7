Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF3CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD5620700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VfrWEc+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442507AbfJRK7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:59:05 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44860 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442497AbfJRK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:59:05 -0400
Received: by mail-vs1-f67.google.com with SMTP id w195so3717463vsw.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tni646pGbvRi6tG884NgqaXPsDZfvRsu3le+zg6U7NY=;
        b=VfrWEc+UPGhpJH5fu/FNXtKAqp0bXqeDPFACowzEefNZ5zLtQzHkw+xZos8Ay7Bheo
         3yR1EtxX5qGKRdGcvw/rBZxrrbWc/uABpPzYGgPes0QHryGGXhlQ6B71AXvDDl9h30AT
         B9IG/QNY+xQJO+ADY8LsAiZa/Xn04u3HZSlwKq3j0McxeoD9RyST3TRSxjAblSOhow6m
         54nACDW5Ag/W/7qvH26U7wz5pdzpH8oYrKUup98DqvksL8PdIITSWOt8b4uaWHTWMJgF
         gghDxGv5iPBJTNxv7k9vq89C6JKGckPAW6V9f7YmcUK6XJzhv3NrucPcQbeQg+a7NKUa
         5AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tni646pGbvRi6tG884NgqaXPsDZfvRsu3le+zg6U7NY=;
        b=SRKk+TSYauViUa8fk8nM0xnc0Z2heH/nWFMbhWhhBfQG57kglohYJSyY7Wy/hNZsPb
         Hdbylpk58GCTfDHpb7GhggbwEokGcy57zF1VpUr9Ta1sPh26MtdTjmORkrJtK0gOZjRz
         aERN5sOXDxug7bcqHaINYlxW72f0M6p5ctiAyu5ck9R6/RiZOxgCfuD7OPYCvUN8oZNi
         MEMCWg8b2wwudblCpnsE/wssevxDvavTZtzh4ajy5RRPAzMtnsi7XnSKoe0Sa8P5ewbL
         Xwd3dn0m8OzRWdRqEBk2Sq/OiwbyoPWBAJ2h8LBKE1RwzjnOmwbQxp+Wk4Qq0CHBQ1QD
         xsyg==
X-Gm-Message-State: APjAAAXGloVt9CU5Rj6jld4t+lUwc87m0lLOVWnX3QgYm49jWDSSI8Ru
        exR07EdDs8+uFAwuGU5nArGjj8ObtjT7y06+fyMnpg==
X-Google-Smtp-Source: APXvYqwT9HIEtXhd36+Y0n3RLEWWZSoIkbijxLPnhyiL+bV3YQ//L1TyRMcHOhW3o0/UChzraPW1Awf2Y7Mq/QFe09k=
X-Received: by 2002:a67:ad0e:: with SMTP id t14mr4277823vsl.35.1571396342758;
 Fri, 18 Oct 2019 03:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191010105230.16736-1-faiz_abbas@ti.com>
In-Reply-To: <20191010105230.16736-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:26 +0200
Message-ID: <CAPDyKFo=00NzUUs45bokScp2XUBRaEEvtr4PHWVSXk3x7zV3iQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 at 12:51, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> According to the App note[1] detailing the tuning algorithm, for
> temperatures < -20C, the initial tuning value should be min(largest
> value in LPW - 24, ceil(13/16 ratio of LPW)). The largest value in
> LPW is (max_window + 4 * (max_len - 1)) and not (max_window + 4 * max_len)
> itself. Fix this implementation.
>
> [1] http://www.ti.com/lit/an/spraca9b/spraca9b.pdf
>
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 41c2677c587f..083e7e053c95 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -372,7 +372,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>          * on temperature
>          */
>         if (temperature < -20000)
> -               phase_delay = min(max_window + 4 * max_len - 24,
> +               phase_delay = min(max_window + 4 * (max_len - 1) - 24,
>                                   max_window +
>                                   DIV_ROUND_UP(13 * max_len, 16) * 4);
>         else if (temperature < 20000)
> --
> 2.19.2
>
