Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D013120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCKK7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:59:36 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:32994 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:59:35 -0400
Received: by mail-ua1-f65.google.com with SMTP id q17so1357385uam.0;
        Mon, 11 Mar 2019 03:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OLKVxphRgfnEDcet5lBNBYXLMLeC25lXUE4Z/6oh6k=;
        b=Vlx/pD08bUjwsFEXF+XVNXqW4iBh1c/ZdhGiutBp22fXHVTJc6ax9+uyS1Aqz2yMLL
         m0c7mVdDSTR0No2n8IW139SS8QC+7vUDjXQM3tltMmIFRre1DfcSdAhNdOLBl5uX2QU3
         mj9L2dkKiyXnneP94E2EPwxVnK0SmEDBQ8aLGvCn0nNXiY3zFmur999p3GyRqiZDWc3h
         xdaekx3/DGCsqxV8z1Fls6tsIH/0yIx6fTe5VO/3fUcxpT7o9V9susLfNmdfSBCvCgJ3
         XY7zx4zxUOdOG3c3MA0CP7alhDfBH8EpTXJ/jLG7YfR3n+fEF0dQaWmJdjisbh9kzPXx
         jryA==
X-Gm-Message-State: APjAAAVnTW+PZzuxmGDEo3dgLcnCxKuuEhHuw1r/bEX4Ev6M0tnUJCsb
        F7PVKakZCxBwA6KG2LjAx1/TWImO747TIZFEC2c=
X-Google-Smtp-Source: APXvYqxe/+IjsJNdttwCevT2NzWiqo01fV+MMSfCGQCewnwq5x9tQLnaBxJzUVlqexkZuUdsziOSLC9nBN8IhQZ/dyA=
X-Received: by 2002:ab0:7191:: with SMTP id l17mr15051652uao.28.1552301974612;
 Mon, 11 Mar 2019 03:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190311074939.517-1-kjlu@umn.edu>
In-Reply-To: <20190311074939.517-1-kjlu@umn.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 11:59:23 +0100
Message-ID: <CAMuHMdVfhq-d0CExnH+Y37k6pUz6OvOtScf6RbgFQ-Mx4dy4DA@mail.gmail.com>
Subject: Re: [PATCH v2] net: renesas: fix a missing check of of_get_phy_mode
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
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

On Mon, Mar 11, 2019 at 8:50 AM Kangjie Lu <kjlu@umn.edu> wrote:
> of_get_phy_mode may fail and return a negative error code;
> the fix checks the return value of of_get_phy_mode and
> returns NULL of it fails.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
> @@ -3187,6 +3187,8 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
>                 return NULL;
>
>         pdata->phy_interface = of_get_phy_mode(np);
> +       if (pdata->phy_interface < 0)
> +               return NULL;

sh_eth_plat_data.phy_interface has type phy_interface_t.
This is an enum containing only positive values, hence it is unsigned.
So the condition can never be true.

of_get_phy_mode() returns int, as it has to indicate errors by returning
negative error codes.  Hence please use an intermediate of type int:

    int ret;

    ...
    ret = of_get_phy_mode(np);
    if (ret < 0)
            return NULL;

    pdata->phy_interface = ret;

>
>         mac_addr = of_get_mac_address(np);
>         if (mac_addr)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
