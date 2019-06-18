Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3693CC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0472520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 04:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fNNVvfjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfFREEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 00:04:44 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46674 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfFREEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:04:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so11527598ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 21:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJLmkVwnPans9/iuFpcwnbTM7EUsIIBXDTl8TGQaxjk=;
        b=fNNVvfjLstujPCDm6U22v9kUb8V+ystPZzxjPsEpjTbMtRt6UZtFM3QfkWDyzAQMIW
         E6KfxvJkYCAiMigfxeNfkJbvlgJdvzEEfyDNXcSQ4hGpsd9Yv0PN3VCeG9Syybma3zAA
         YweVCf2jDX7KE7OToEgZ3Hm86et1Zzc1wT1rS2GKgDnXDs7wUV3rbSDjUKshW4DDBFiv
         WiW8rczljYaGap+qcx/bFr34QWpznmS62Lv9HHybuJDuuqKHqJD4Khp833m98/pUJhJR
         z/Wi3GOSjsiZFAWusKz/vCsNsKbGzD11ktzwf/VoHCT35CeFpX/vlTnPTD2hFmBTUNJt
         WypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJLmkVwnPans9/iuFpcwnbTM7EUsIIBXDTl8TGQaxjk=;
        b=THXa9XHX90eXbHc5xLoITEFHSPn6OQXKVtMULeJyZyO7dum48xk1rcbEqf/JDv/Xf1
         eCtyBK37tyLlJweRFVm5+ganKUf6TDjb3DKG0NIBy1iKdTw7Zr/6t+N2fWccmknM3LA5
         XfxR75AYxr4Op34N1H7jn1yWgN0z4Rm03cI3AJIA/DpJpdpfWzkGLgpbMNxk7hbhFsf+
         MC0Gxp3Na/cO0yNqc375SV9EasNCfzW2bWyJWVBPmLLGhBeTzf/jWuAA/sELMEL8VHd4
         XH46eteXy5RyiOKCFhNLCQ2+CqaQcV2d0RDmXz5tgf2FfdYzP8LNXWQs8jOjvxwlvPIa
         oAFA==
X-Gm-Message-State: APjAAAUWoj7+XLU0gf8vW9lANCB3N1kYYTJC2le1l0vFXAMV7M77XP9N
        H0o8LNF4E8evYxbYd6+I5QK8w9J+7ekFArnDycG7Yw==
X-Google-Smtp-Source: APXvYqzHxAVSyFWFoE5KWadzgd5NrlnSBkdcYDfnoz898BtjOkb8yWEu0/Ss3PN8knMcABE84pxCcZt3rdAD2rwB66w=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr13909677ljl.8.1560830679001;
 Mon, 17 Jun 2019 21:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <1560745167-9866-1-git-send-email-yash.shah@sifive.com>
 <1560745167-9866-3-git-send-email-yash.shah@sifive.com> <20190617155834.GK25211@lunn.ch>
In-Reply-To: <20190617155834.GK25211@lunn.ch>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 18 Jun 2019 09:34:02 +0530
Message-ID: <CAJ2_jOEm1+HFewpvq6fdoHaTtghpnxkkz9LWTz3-xWJAtYp8-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] macb: Add support for SiFive FU540-C000
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     David Miller <davem@davemloft.net>, devicetree@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 9:28 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Jun 17, 2019 at 09:49:27AM +0530, Yash Shah wrote:
...
> >  static const struct macb_config at91sam9260_config = {
> >       .caps = MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII,
> >       .clk_init = macb_clk_init,
> > @@ -3992,6 +4112,9 @@ static int at91ether_init(struct platform_device *pdev)
> >       { .compatible = "cdns,emac", .data = &emac_config },
> >       { .compatible = "cdns,zynqmp-gem", .data = &zynqmp_config},
> >       { .compatible = "cdns,zynq-gem", .data = &zynq_config },
> > +#ifdef CONFIG_MACB_SIFIVE_FU540
> > +     { .compatible = "sifive,fu540-macb", .data = &fu540_c000_config },
> > +#endif
>
> This #ifdef should not be needed.
>
> >       { /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, macb_dt_ids);
> > @@ -4199,6 +4322,9 @@ static int macb_probe(struct platform_device *pdev)
> >
> >  err_disable_clocks:
> >       clk_disable_unprepare(tx_clk);
> > +#ifdef CONFIG_MACB_SIFIVE_FU540
> > +     clk_unregister(tx_clk);
> > +#endif
>
> So long as tx_clk is NULL, you can call clk_unregister(). So please
> remove the #ifdef.
>
>
> >       clk_disable_unprepare(hclk);
> >       clk_disable_unprepare(pclk);
> >       clk_disable_unprepare(rx_clk);
> > @@ -4233,6 +4359,9 @@ static int macb_remove(struct platform_device *pdev)
> >               pm_runtime_dont_use_autosuspend(&pdev->dev);
> >               if (!pm_runtime_suspended(&pdev->dev)) {
> >                       clk_disable_unprepare(bp->tx_clk);
> > +#ifdef CONFIG_MACB_SIFIVE_FU540
> > +                     clk_unregister(bp->tx_clk);
> > +#endif
>
> Same here.
>
> In general try to avoid #ifdef in C code.

Will remove all the #ifdef in v3.
Thanks for your comments.

- Yash
