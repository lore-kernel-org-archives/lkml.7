Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C60EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B3420843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3zOusdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbfEOLrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:47:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46054 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbfEOLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:47:31 -0400
Received: by mail-ed1-f67.google.com with SMTP id g57so3635412edc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UybbNuVimaoZe/obsoU7tb4m5ZUy6LvzQm9jzE+0RrA=;
        b=P3zOusdb1eGvSqR4PHA6LNUt17i57cozISGL1Z2ZbAkKaLsynOH1YiRqPEmYHygXes
         Hoa8kM/IxL3+ytbz2M0n7R9YbChiOVSJCp3VZ6Gf8HDYfa//Mp6Znqahdoc4KmJ2Vyem
         Bsr0HxWRZKVkRvadCyEoeC9SrEmqJ3WTJdyxvLr07Gf5+OfWZrc4EJ6fti3irFy78AyJ
         46eUcKL0bU7ZNnHqaZTw9zVlBkYTTlJ41VvvXTuzFQbAIYt30iDeB4wpgkBE2gspCAcA
         YrAmUx1dZsiJeL4mYNHQGjKmcyOsMb8RlwYN2r9g41m5PLXGQaiAcmK0BPS3UcOGgSVd
         oheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UybbNuVimaoZe/obsoU7tb4m5ZUy6LvzQm9jzE+0RrA=;
        b=gnDFOXz/mvNBbl8OfPdvquJSnB8VIu9PJXeMwf0xiWqMe78P83jpnZRWSeGYSMPM+/
         3Gu5arif5e1jNTmA8hRKEB9eWAoh0As0ZKfVh2MDyTd9Cswtp/y6w/3KXBxPf7eve+68
         DsCNmGzp+QTQ0+QHaU5cudv7bHLMZRCNnhSq4B1THbIyRcth11RNqXStjB742PC3i9Td
         F0AJdvb+Xf2uu+YnAaR50/YnB8ES4yvN0qeH3Pf7M8ysmEkWnBmzv/CsGYV2F/BNuUhW
         CgRClBykKydc4jXMG/54kjGOZqebjaqVPzzl5vnWMWGT8ADKKVh3EpKTXAeZa7ehs/G5
         2ypw==
X-Gm-Message-State: APjAAAVzOIFE98vyVWt82M52shoFrFu0fy0udq4K2q5nNjY1lulvw8Kr
        UL0nV2z9SZ9TSgz28C8ZY3EgiDbufmf5uwlf+7s=
X-Google-Smtp-Source: APXvYqz7aau2riG59uJ1ZUCEP38Mjgz0Ag9fasTQcc+poBDGFEgxyAXaYkwAR0bpXuEEJ7AfA9/qKPJ9PDSBAMX5sEs=
X-Received: by 2002:a50:9441:: with SMTP id q1mr42373727eda.101.1557920849482;
 Wed, 15 May 2019 04:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557908823-11349-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 15 May 2019 14:47:18 +0300
Message-ID: <CAEnQRZAL4BuHP8MDDBfOXTcub8LVdZ-CyZxdzt-5dseVjMMDQA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] soc: imx: Add SCU SoC info driver support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

Since you are going to send a new version for this please consider my
comment inline.

<snip>

> +static u32 imx8qxp_soc_revision(void)
> +{
> +       struct imx_sc_msg_misc_get_soc_id msg;
> +       struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +       u32 rev = 0;

No need to initialize this here.

> +       int ret;
> +
> +       hdr->ver = IMX_SC_RPC_VERSION;
> +       hdr->svc = IMX_SC_RPC_SVC_MISC;
> +       hdr->func = IMX_SC_MISC_FUNC_GET_CONTROL;
> +       hdr->size = 3;
> +
> +       msg.data.send.control = IMX_SC_C_ID;
> +       msg.data.send.resource = IMX_SC_R_SYSTEM;
> +
> +       ret = imx_scu_call_rpc(soc_ipc_handle, &msg, true);
> +       if (ret) {
> +               dev_err(&imx_scu_soc_pdev->dev,
> +                       "get soc info failed, ret %d\n", ret);
> +               /* return 0 means getting revision failed */

Just return 0 here. No need for rev.
> +               return rev;
> +       }
> +
