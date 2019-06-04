Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F148DC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9691120843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCvPEi3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfFDQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 12:14:28 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41837 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbfFDQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 12:14:27 -0400
Received: by mail-yb1-f195.google.com with SMTP id d2so8161052ybh.8;
        Tue, 04 Jun 2019 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D5MMPFwZPDwoVwg0CH5FVocMqyoaqr3N1YLjVthTqt4=;
        b=NCvPEi3qdm1deNg6XsWqtja84SJO+KiT+rTr3MlLL3XFiYwiQvc/HI/hZDcfQ3Z/Ez
         pxzrKO5PfbWQMrNhJp53c++0irTblLw1lUnIuEKx1lCty7aUKdb+Zthwv3NGIsEHYKFQ
         esNBrW/yze0vVonksP6Tt+RNh+dS8qmXPMckX03vDzPVUITBN2L+KyES+Wf6UJvpBSMZ
         DtjKtPgAKadZDNr++L7eW0sS9LrCZn74Wm81D8b3t1laW82mTPZEEU+W+xO/1S23w4cE
         tvfTJp9IFpYSrxiqVb0StJR9A0uEjUaKQE+NQ30SOA9AKZmJjwD4YaV/ydHG4xlS45Yg
         eBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D5MMPFwZPDwoVwg0CH5FVocMqyoaqr3N1YLjVthTqt4=;
        b=Wd94CnivV+3E4+DVIC+0s8zKWJAcyb8KiofiJDx6+BvDOHa7kiejguuwDY3oZd+vUV
         hN7JELKlxwKiAjiKX0DSDbxEutV55Yju45eKvhoHVJ1H0y13Jx5X0M17VXED/o2BhA9n
         5VKikpOQKbFA/7KJtaSOW0k36C1QlBz/EIfcDJfbXdcZuLHoJ5v6mSrVYOD+vYc3CBwk
         qewhz6nJmhhWk8+Assa1H6qmuCHsHN7a91c6NiornF493+OcNIZPEhWv99g7XFAysY3w
         F0R4tXB8e0ahwkureRW/qbOSOuPZTAIrElib5hQQHUP9Cd5PahxE/hGMGhMM5kmYa3ek
         L0SQ==
X-Gm-Message-State: APjAAAUAhDH+l1mp3B1AZKaUuJuq/0b7cpF0tub/L+CYcvPuRLLpalCg
        pDXtYTqhk3uy5MbtDhQzW01BPoPP52s/SxnsLsk=
X-Google-Smtp-Source: APXvYqy65LooPH+1bjcdVqPkjkn1bHuRgJ3PaSVfYkPX8MorTnFlcnNjWXyHFpfD6bfMSX8neQCHQL/2nWA9e1z26tU=
X-Received: by 2002:a25:6148:: with SMTP id v69mr13871252ybb.401.1559664866416;
 Tue, 04 Jun 2019 09:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190604154036.23211-1-megous@megous.com>
In-Reply-To: <20190604154036.23211-1-megous@megous.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 4 Jun 2019 18:14:15 +0200
Message-ID: <CAJiuCcda0ZDDrbdOF7TpTeoUOgt7GeS6wcgy45DRCo_U2XX6bQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2] clk: sunxi-ng: sun50i-h6-r: Fix
 incorrect W1 clock gate register
To:     megous@megous.com
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

On Tue, 4 Jun 2019 at 17:40, megous via linux-sunxi
<linux-sunxi@googlegroups.com> wrote:
>
> From: Ondrej Jirman <megous@megous.com>
>
> The current code defines W1 clock gate to be at 0x1cc, overlaying it
> with the IR gate.
>
> Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR receiver
> causing interrupt floods on H6 (because interrupt flags can't be cleared,
> due to IR module's bus being disabled).
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Fixes: b7c7b05065aa77ae ("clk: sunxi-ng: add support for H6 PRCM CCU")
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-h6-r.c
> index 27554eaf6929..8d05d4f1f8a1 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -104,7 +104,7 @@ static SUNXI_CCU_GATE(r_apb2_i2c_clk,       "r-apb2-i=
2c",   "r-apb2",
>  static SUNXI_CCU_GATE(r_apb1_ir_clk,   "r-apb1-ir",    "r-apb1",
>                       0x1cc, BIT(0), 0);
>  static SUNXI_CCU_GATE(r_apb1_w1_clk,   "r-apb1-w1",    "r-apb1",
> -                     0x1cc, BIT(0), 0);
> +                     0x1ec, BIT(0), 0);
Just for information where did you find this information?
Using the vendor kernel or user manual?

Thanks,
Cl=C3=A9ment

>
>  /* Information of IR(RX) mod clock is gathered from BSP source code */
>  static const char * const r_mod0_default_parents[] =3D { "osc32k", "osc2=
4M" };
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20190604154036.23211-1-megous%40megous.com.
> For more options, visit https://groups.google.com/d/optout.
