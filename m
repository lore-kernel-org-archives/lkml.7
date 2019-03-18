Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E4CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E5E20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBIwBTkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCRQwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:52:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45744 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfCRQwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:52:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id 5so269327lft.12;
        Mon, 18 Mar 2019 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/t3EL/EIf85pivR1fwgKqBguWDPJO7eRqnh8NxipRys=;
        b=ZBIwBTkPzCywafABFYPnIVfFalPfWJbINgE0ZSa3aT9+KtftuIARCIV9MZXvY3H+FI
         kUft1ovoizbAuLjcvYwakjuGFYt9qm+/lo8JF0xFeIrodRhZ8icJWTJM372t5Z5djaMD
         1uupfs2Md3CiSCemnGmOwgd5TxwMQS03VRNkztUrctdLJ58sSjhhHpWqC+2C3Ay3fwiF
         BNOjBtDY94PBiI8SB4pc5WSvd1QNU1t7OWyB49DpJWNqhQDxJCdD5pJpTZYw3YiNkejQ
         uxWgeomFqQ6lolRS9oTjC9N6uAW/3vMsMZYeX+3In8H12x3QRvsOVF3KjywO4uRutgGg
         RHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/t3EL/EIf85pivR1fwgKqBguWDPJO7eRqnh8NxipRys=;
        b=Ep3rIAthZ8PI2jPxMMeZbNa0HhENpn+F51vPWQPwzvPeTp3MixHhdfnVzBrNZedEyl
         pfH16XI6l/tgDAfQ4UsAkQqXHaWktBOiwlDhxb94ykgRXYRBqet6edBkyrwvmjNwE+XT
         2kTxh54wbPv03DgwVqBd0Q+PgHavwDkcYkori0fZ4THMQIm+5oRDx0jkJy9/Mn0WmXX7
         Bif3WxnyPMO6rMKoAEp2PRmJnhRIK4/2DBUcy78cIt5z9SwsV4Is8a/8z/YdCsgrehVe
         SbpVeH/8920hV8YIZuMTy8t1LYThLWkSXbbcyylAaImVzqyRF3p5oxnTu4tzi4hzyL4q
         fl7g==
X-Gm-Message-State: APjAAAXnHmSB8y3hGmmF9RaeDBXhqbBhg/eUpRfM+T62pt93cSYIF4Na
        u2SabRvFDQsYfey6YDelZfU7445jsYsAT8KpR8E=
X-Google-Smtp-Source: APXvYqyYIs5ERfIJHXSIiOuklI+mJjtYlwGjGoeCqb1p7HsnHsEYXrPEK0sv5kb1VtECZ7CKaAZqIsJM3PbuITZqgSQ=
X-Received: by 2002:a19:920a:: with SMTP id u10mr10947978lfd.122.1552927953244;
 Mon, 18 Mar 2019 09:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190311213124.29325-1-angus@akkea.ca> <20190318160448.28964-1-angus@akkea.ca>
In-Reply-To: <20190318160448.28964-1-angus@akkea.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Mar 2019 13:52:21 -0300
Message-ID: <CAOMZO5CEc88UM+cBd6pv2=xc7mVdyuNawWMX02iGvMXS+BZcbA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl: imx8mq: enable the multi sensor TMU
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Baruch Siach <baruch@tkos.co.il>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 1:05 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> Add the imx8mq TMU (Thermal mannagement unit) nodes for CPU,
> GPU, and VPU.
>
> This patch requires that the multi sensor patch is already applied
>
> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/patch/?id=7797ff424818c975b59c35880dbc90fe08350204

Please remove the reference to this commit. It is already present in 5.1-rc1.
