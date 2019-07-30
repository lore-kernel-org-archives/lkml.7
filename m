Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7ED20665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvjGOU3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfG3UqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:46:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37562 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfG3UqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:46:25 -0400
Received: by mail-lj1-f194.google.com with SMTP id z28so9159784ljn.4;
        Tue, 30 Jul 2019 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fnv5nFefw/7jm/2yZ6EkTWBwC2rqBjCv97bX7R5gsmY=;
        b=AvjGOU3mXoTh82z+t2IPNAKmRe57uoapezbR5nSLRJ9W0Ck3IR2/8zUBrSBUSry4U1
         7617CGqztHoKjbZgkP8qZxQnC75QnSELpy/gDF9ugrgktdfWr6a9QVMTFoT2TAIX4yQ/
         6pSyIM8StMRjxVouxe8qb9ocN17lIhWeHoFlyAeIN8Jnm6i2hYQrT4lmktKd/i0PGP0d
         JTt2c5XDCb5+3nEzfuIUeVHfYjbpVANzMT8GpBZL5umcOWOHcoGX42ktUc1hm+rNwN75
         yw5ugapCnVk+c4DR2S2xvnoIr8mUrMB/ZtlLVkTeHZCldgfXe1I6+vHeMuFvl0Ifw/g/
         w12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fnv5nFefw/7jm/2yZ6EkTWBwC2rqBjCv97bX7R5gsmY=;
        b=BB1dMYlaFer3SI0RS9cqWFmJgAXoDiX53YqbXM7aSDNE/cej5huK4CHYDlsp29S957
         m4A6wSfzF9rpQzV3VtmYk8zsm+RjpL4ahRNESVzMKnTqwsn3vRUW2NonzXgx+Rwjpjil
         M4P5ZNwumIv72efcFhHotmjc8p5IRsgzpcmFHnu+vDKIZgTHQ+LQIRE+i++bcKzHPQK4
         yfw5Jmm00BqVkrPK45GShZ/oPvF1ITp6iaDHFQgdLSL2eHJTEiP7h8KdSzhxRaJeCUfx
         BpIJx9I0PTvpHNozbofz5PAkVZG/UKRPbu7ENza+5X95uHCPd73rzFkDDVk8SMQ0EL1b
         wRgg==
X-Gm-Message-State: APjAAAUcx5+5SbUOD43N2KLN4m7UOQgJ50C86gWnBYDxMBddJAAQzgtE
        CN1DdNX+XUUXgGbGaYfPMUYEQ6ZEvzGALQetCYs=
X-Google-Smtp-Source: APXvYqwZR0HlzGm1q4rErB7IZwHUYk+BIas+baAMWS2NtitNJ7sN4NcuNxK+n5zq7+I2M7S3roUAK0iOaJi+qlsXg74=
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr62303623lje.240.1564519583019;
 Tue, 30 Jul 2019 13:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190730144649.19022-1-dev@pschenker.ch> <20190730144649.19022-13-dev@pschenker.ch>
In-Reply-To: <20190730144649.19022-13-dev@pschenker.ch>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jul 2019 17:46:28 -0300
Message-ID: <CAOMZO5DRi6yawn3RF-Mouiejz0nc7htdsCjOBC_EXZZKUZ3nvA@mail.gmail.com>
Subject: Re: [PATCH 12/22] ARM: dts: imx6: Add touchscreens used on Toradex
 eval boards
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:57 AM Philippe Schenker <dev@pschenker.ch> wrote:

> +       /* Atmel maxtouch controller */
> +       atmel_mxt_ts: atmel_mxt_ts@4a {

Generic node names, please:

touchscreen@4a

> +               compatible = "atmel,maxtouch";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pcap_1>;
> +               reg = <0x4a>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* SODIMM 28 */
> +               reset-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>; /* SODIMM 30 */
> +               status = "disabled";
> +       };
> +
> +       /*
> +        * the PCAPs use SODIMM 28/30, also used for PWM<B>, PWM<C>, aka pwm1,
> +        * pwm4. So if you enable one of the PCAP controllers disable the pwms.
> +        */
> +       pcap: pcap@10 {

touchscreen@10

> +               /* TouchRevolution Fusion 7 and 10 multi-touch controller */
> +               compatible = "touchrevolution,fusion-f0710a";

I do not find this binding documented.
