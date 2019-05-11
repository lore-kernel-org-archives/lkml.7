Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C98C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16095216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SvVJafEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfEKAca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 20:32:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43011 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKAc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 20:32:29 -0400
Received: by mail-yw1-f66.google.com with SMTP id t5so232326ywf.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuUfV6oc9nendPRbafedpVvx9wWx/qxMVHBwdbKP9IU=;
        b=SvVJafEc8XWjHqcV6F3Ytpi6e6N6wBQw8267/PzpLV9HM6E4TREBak64uQ7fMIjicH
         74Tm+wdEZ6XDLi9mz6qvAraTjlbqZqJ7+tRh6X1lh9MLZ4tZXVjFSO3cQFpRe8C3mW8B
         jLjLYLBDnpzEudNaAF3QYN9VWv8d319FZrZ6g632/yvlSZSxFXwQFwvHeofgzWubMMJx
         m90uWlYA6Nu3S4vIq1rb5PR9L/g/67SgjR+qbZRrzF/xa+Vag8KNXiTkwN1HKrVrhLVZ
         czuiNKMqs+oV1OBwH8X5mJvOmET8kCpL1Ptsb04BkVUspc03WXuivwSKvFWOuZnOQjzb
         d5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuUfV6oc9nendPRbafedpVvx9wWx/qxMVHBwdbKP9IU=;
        b=J5pxYb8jJ1rtqMuX9BC9Efxq7Bpi7YDL9b50dSWDmnftsLjFpaskPrFdu0ashNnXu9
         e7hTGPAclq53jmsxSFp3YLns5zJZG+AcH7WwKC7Y9lAWszR2Na7avM22SMbq5AGTmArW
         4nHk4+PumMZOvYfWyBBgV5Jx6MyJsle6t7uqd1dpJ1TUXf5FXudbSmxdfgGDKSaUeb5K
         MxODFLpUO2AKYEoiQef4T8VLUXwGxDEWpqoLwUqhbutbUg47J6nRTUtN5Lw/044kTeQm
         BrER4yJbX72LS4ejB9zjWU9n+hFi2IiAe8vTfSGroYdkMSju+iK0cNDpslJpfSMvtebX
         kfgg==
X-Gm-Message-State: APjAAAV5rLt35c/2wiNoZCjFVQGnQzF1SUkCkrKG8exrzv1xSG31rjg3
        m+9F70QSk8ZqHuAvsP8PMs6NtDfgYfs64WmVeGIWuA==
X-Google-Smtp-Source: APXvYqx7pUQf4So8Uie88ffpDitozppQWANhIlXVwvEjEBR/c4zCrrqV+lxoqOpDs5/C8b+d80cTUBFiwFeCACSTHw0=
X-Received: by 2002:a25:830d:: with SMTP id s13mr7932651ybk.63.1557534748097;
 Fri, 10 May 2019 17:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-4-dianders@chromium.org>
In-Reply-To: <20190510223437.84368-4-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 10 May 2019 17:32:17 -0700
Message-ID: <CABXOdTdnUdr7+Dm_iOjGKwd6YKaPbXuAgMOL+CbGHeBmWJ3wbA@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_spi: Set ourselves as timing sensitive
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>
Date: Fri, May 10, 2019 at 3:35 PM
To: Mark Brown, Benson Leung, Enric Balletbo i Serra
Cc: <linux-rockchip@lists.infradead.org>, <drinkcat@chromium.org>,
Guenter Roeck, <briannorris@chromium.org>, <mka@chromium.org>, Douglas
Anderson, <linux-kernel@vger.kernel.org>

> All currently known ECs in the wild are very sensitive to timing.
> Specifically the ECs are known to drop a transfer if more than 8 ms
> passes from the assertion of the chip select until the transfer
> finishes.
>
> Let's use the new feature introduced in the patch ("spi: Allow SPI
> devices to specify that they are timing sensitive") to specify this
> and increase the success rate of our transfers.
>
> NOTE: if future Chrome OS ECs ever fix themselves to be less sensitive
> then we could consider adding a property (or compatible string) to not
> set this property.  For now we need it across the board.
>
> With this change we can revert the commit 37a186225a0c
> ("platform/chrome: cros_ec_spi: Transfer messages at high priority").
> ...and, in fact, transfers are _even more_ reliable than they were
> with that commit since the SPI framework will use a higher priority
> (realtime) and we no longer lose our priority when we get shunted over
> to the message pumping thread (because we now always get shunted and
> the thread is high priority).
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/cros_ec_spi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 8e9451720e73..757a115502ec 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -703,6 +703,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>
>         spi->bits_per_word = 8;
>         spi->mode = SPI_MODE_0;
> +       spi->timing_sensitive = true;
>         err = spi_setup(spi);
>         if (err < 0)
>                 return err;
> --
> 2.21.0.1020.gf2820cf01a-goog
>
