Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F34C49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA0E218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0hM9Hrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405336AbfIIOO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:14:58 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37111 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405250AbfIIOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:14:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id y5so2104605lji.4;
        Mon, 09 Sep 2019 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwPtv2PkHjRWVfHgdMma8hT5zZLqlYAxoe2nwjsXNiM=;
        b=d0hM9Hrtn18AtU+ItYS9C5KbSbAKVPpAtJi/W3hBTlbUSAWkLU0R2Mv3yQSK7Rgwwz
         tcsA+5RnBZdnOqJ5dtNsDjuvjPPLMWHDEE9UwxY7LK2xb/qgGxnAH85F0O4/Dc6vWzkg
         LnofrMxWnuLmgz3aiBmPeBMOcjjc0b3vwQhbhQ6oWa1DSisWWb1l0LCK9BfxIonpZRSt
         lewluv90tzc1TxR7XBO+o4nRYdZgXLVGxJj2vktBoMfD60K+MO1B9gIYVoggs6MNp+5Z
         WTYH0UmlsdBl/E9mryMLNUomGjZw6qwyfjxgRovhf3AJh36tirGbwfm2H3+Vbh4b6/yY
         OHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwPtv2PkHjRWVfHgdMma8hT5zZLqlYAxoe2nwjsXNiM=;
        b=FTdhHUrAyII4uVdlHMB+4M414uCE9YMEFHHf9e0nugGHdzgsEpelh5N8/3ppFi9YCg
         Y25UtFuPO2rQaGHSkqwG7ragKg/yQ04wRw6/j8dv78fzzlb908w9NLczZAZWtZnZH7fJ
         ysC0enDxGOToP1A87ebgpSQ1ghWj8VKMctLqSAAa0OZs5L12mNitAVJ4aXo1FZv8fYyL
         0H1NR/evtgI5HWDR8LXaywxz2Wv3IG2WnTqn9fBq3CwKksaTVRtaspIrXoP1zHQwvl8B
         IFDYYrUARZsN3ZS7urLWWj26E41tAFxMUuiHAstdWFUp0H8xmXeLTt/GuiyQJIML7lRu
         91Hw==
X-Gm-Message-State: APjAAAVn4h8rlD+6sP33OPASdDfh9MuVf/PGggHzodUJ0vGwIdXzZYNy
        iSEsjQE8EqlLzcxUyOkKo/h1/D2tJz72VpQPmkU=
X-Google-Smtp-Source: APXvYqzW8UtXCJLn1NiAEYBOEdyxkVEvLirKRufFFnCXOBna7CwH0djt8OgcYo082H7aaYsJDDuPbJx6pF2cN9g+nO4=
X-Received: by 2002:a2e:9b43:: with SMTP id o3mr5058959ljj.214.1568038495704;
 Mon, 09 Sep 2019 07:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190909021214.25646-1-hui.song_1@nxp.com>
In-Reply-To: <20190909021214.25646-1-hui.song_1@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 9 Sep 2019 11:14:45 -0300
Message-ID: <CAOMZO5AG2xmnDbjmysTbiHpF1W0yERFFwYAa98+YFH7cGSPE6w@mail.gmail.com>
Subject: Re: [PATCH v3] gpio/mpc8xxx: change irq handler from chained to normal
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Song,

On Mon, Sep 9, 2019 at 11:12 AM Hui Song <hui.song_1@nxp.com> wrote:

>  static void mpc8xxx_irq_unmask(struct irq_data *d)
> @@ -409,8 +409,14 @@ static int mpc8xxx_probe(struct platform_device *pdev)
>         if (devtype->gpio_dir_in_init)
>                 devtype->gpio_dir_in_init(gc);
>
> -       irq_set_chained_handler_and_data(mpc8xxx_gc->irqn,
> -                                        mpc8xxx_gpio_irq_cascade, mpc8xxx_gc);
> +       ret = request_irq(mpc8xxx_gc->irqn, mpc8xxx_gpio_irq_cascade,
> +               IRQF_NO_THREAD | IRQF_SHARED, "gpio-cascade", mpc8xxx_gc);
> +       if (ret) {
> +               pr_err("%s: failed to request_irq(%d), ret = %d\n",

In drivers, it is preferred to use dev_err() instead of pr_err().

Please swicth for dev_err().
