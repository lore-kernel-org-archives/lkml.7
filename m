Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7FBC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81A320643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCKHnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:43:49 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44681 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfCKHns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:43:48 -0400
Received: by mail-vs1-f65.google.com with SMTP id r201so2102144vsc.11;
        Mon, 11 Mar 2019 00:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SHLIhBTc+6VD4TIc1/cTXBl25ruYc+eCqRhvdq/5uD8=;
        b=QfwgKRRJWFjIw4Gts2GzHoMDio5GzHR7sU1h3SiJ5yMUgFFL5dPL8zGOZPZWWwNAYX
         90YFHLAS2VDhbloNDZTOnZ9Yfyb5Ium7sJrfRyN6D4pzanjpPBMUWp9SNjtYbLw24poF
         W5v/AngcUs75KyEVxgSUxmiLHewlhG0F4xX5WVY4IAUWxSHRXXIP+0GUdDA2eRgCaLbc
         hQgXKZP0CTUNRecTDnuj0sz439783xxu4k1jWBziCuiBEFRFlZkQydRd3OMwCEtA3Jwb
         MrgdcCqYK+cbVnJ+sXjbUYd912lk298QsRVnbVwLNVDAJB3Dtg/xhNu2Y4J5lSJTnOCt
         AsRQ==
X-Gm-Message-State: APjAAAVqSO3hAgHNgHexmG4ydJSFyJYkQKdkPKel6XKswZtmZwo7tpi1
        U0/VPBltZENeFHO+QtJj0Dd0NMZ/8nq0lAagK28=
X-Google-Smtp-Source: APXvYqzLseUMWhuxsOpfeyXgTkFQ93oA3b4wyD248Ahz3f6/377NiCNkj2khzazEer3yBCw67tfzxS8OZo6M4DR4ptc=
X-Received: by 2002:a67:7dd1:: with SMTP id y200mr14406599vsc.96.1552290227176;
 Mon, 11 Mar 2019 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190311070138.24084-1-kjlu@umn.edu>
In-Reply-To: <20190311070138.24084-1-kjlu@umn.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 08:43:35 +0100
Message-ID: <CAMuHMdUcc2MXwX1sP4QEiWskoDofR8HQv-e2f9nWXhaMPeeZYA@mail.gmail.com>
Subject: Re: [PATCH] net: renesas: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev <netdev@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

On Mon, Mar 11, 2019 at 8:01 AM Kangjie Lu <kjlu@umn.edu> wrote:
> In case of_get_phy_mode fails, the fix returns NULL to avoid
> the NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Thanks for your patch!

> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -3187,6 +3187,8 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
>                 return NULL;
>
>         pdata->phy_interface = of_get_phy_mode(np);
> +       if (unlikely(!pdata->phy_interface))
> +               return NULL;

of_get_phy_mode() does not return a pointer, but a phy mode index.
Hence zero is a valid value.

So I'm wondering where is the potential NULL pointer dereference?

Perhaps we do need to check for negative error codes?
Or is this already handled later, by {of_,}phy_connect()?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
