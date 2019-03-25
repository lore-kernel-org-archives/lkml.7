Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBDF20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KN61P8Mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbfCYMmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:42:09 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37183 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbfCYMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:42:06 -0400
Received: by mail-vs1-f65.google.com with SMTP id w13so5272812vsc.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 05:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsp4XH4Ex/irM3Jf1bYZ6ywemghmdH2kd9rw5m20oHQ=;
        b=KN61P8MhIbSn7H7PvhbFY9IBmJ/yNcgeLL09DFjGm5dHHuL1+ayJ6/7qJgrEZnhhx8
         Nv6IQjEABQJ+UUJHCVEr9AWmdnxZ8a1KwZEz1SSG9DFq1J2YF0OjDlWK9jU0n7yy9D0A
         1qNXx+4IGw1WiPlvTICoZyjZn1RDjDBYZe1Ak3UnTYXMcOkH9kATfvXh28FL3569hqfs
         GasxNfaJ7aQV24UTFeRXmk/rnkdWmqhAQiAh6hzNxL95/hMUv1zEKzu6YpQUUslLDPDf
         jm0xcE9fZV/Ggc89gszMRalT9NZVy2TVweqrrbUmI34tGz6z94vbB2J7DXp6+95nZwvV
         jUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsp4XH4Ex/irM3Jf1bYZ6ywemghmdH2kd9rw5m20oHQ=;
        b=s27rWozj1coYJMau9ESZYupHtvPS89o1Uy9BmG2qTB4h7Vw/ovEQj0GOaDXBPrJ6Ou
         6ftNM17NYvsqEFOfoawjwKrpPXOiyb2UjOWmKZk0fHg6ZGqfOIl3x3ty437n51SAhakH
         xzsCLvb/+5ZcAlTXbNWhstFjSqa8CySHSfXcBJBZXm7Oz3Ssmvxp1Fr73XPj6NmOzDOR
         1Na7Zykg7MowyEkBuDnW0suHUWrOmv770CT4P1pUG5E7Ooxr6s2lPTZD/jaVUw2rh5nC
         CGR8kr68khwA7B9zadCKaDh3Cvms+ZicRC86U3O9NjVd3sNey0A6OSN9bBqBRqA05EdZ
         53kw==
X-Gm-Message-State: APjAAAVMW02284YW8s359fFLuiAGVWDQ9qwQkzYIXjV139sQz3Nyor/c
        R6YxyD1hixZdRpwtFZbFIMaAxup2yJbZo+TE/7NmrQ==
X-Google-Smtp-Source: APXvYqxBOwX8lTf75TMlNlk//6Eq9auO818/YnRNuZXacFsl47Xge6T+AnqZtsFk5IsY5o8EZNUdMnxWjiazzbe1UGI=
X-Received: by 2002:a67:ee04:: with SMTP id f4mr5653863vsp.34.1553517725403;
 Mon, 25 Mar 2019 05:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190311.121710.968693621648443243.davem@davemloft.net> <20190323032420.21162-1-kjlu@umn.edu>
In-Reply-To: <20190323032420.21162-1-kjlu@umn.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Mar 2019 13:41:29 +0100
Message-ID: <CAPDyKFr6QhDz2f12MuugQ5wnBBnn+y=5QsEQFy5Ve3h2XB6FVw@mail.gmail.com>
Subject: Re: [PATCH v2] net: liquidio: fix NULL pointer dereferences
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Mar 2019 at 04:24, Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case octeon_alloc_soft_command fails, the fix reports the
> error and goes to cleanup to avoid NULL pointer dereferences.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> V2: goto setup_nic_dev_free for cleanup
> ---
>  drivers/mmc/host/mmc_spi.c                         |  2 +-
>  drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 32fea585262b..a3533935e282 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -820,7 +820,7 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>
>         status = spi_sync_locked(spi, &host->m);
>         if (status < 0) {
> -               dev_dbg(&spi->dev, "read error %02x (%d)\n", status, status);
> +               dev_dbg(&spi->dev, "read error %d\n", status);

Looks like a leftover from debugging?

[...]

Kind regards
Uffe
