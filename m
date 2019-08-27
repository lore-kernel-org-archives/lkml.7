Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D18821872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBPtAp0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfH0FzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:55:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37714 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfH0Fy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:54:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so5988856lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 22:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+vpsDloTUdy5MvFdUSFeHVMIbrM4Okd8BXV+IVwifM=;
        b=tBPtAp0WoXthyCDuxt0/UFLRqezDiJevoRKm/SOQIUlGRldn152fQioRxeB7al5xxT
         sVoOIxaT/VuG5XuiKbuOW9+y1OHW9NHrC/uPtx+grRsTws3Vq7QqhSTz6j+4C26nCUqr
         LDMbBJz9Sa7OUTHFnJspqelzZyXBxk3eFAElrk3MWHmSUzcbICTCuExINBxSK/XylvvR
         ohpvOvP1+OoJDBUHQJQWotFSoTwt7NYPl+x0e1RajCT2jLQU3sCCkvBLETeYiSi3H541
         rDNr7/WbU2NPl9VrKwbfQ/oxycmkvFye7tObGO23O2OCVf9LLaBGOow+JWnc2DkFAg20
         8Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+vpsDloTUdy5MvFdUSFeHVMIbrM4Okd8BXV+IVwifM=;
        b=aKIUjmX+388vTNRpMXtMCv4lXSpf0hgN/Js9R+MrDnhuv/Y1d3y80KajzZWe3GWb7H
         hVw2N9+hkQq9ZioqHirUXjQHnIvrfjryKlvheKiqpWMfO+eqmnEdRmxa1D/oHqQ5u1o4
         qQ/S8TLjfIgT7YL6poTZMwigJpb442Rk9W9tpg4pF75VQYUjCu9qijiSjJlh1vN0idCt
         APJACHhdGheAgpBpGweWZqog26Au1QcLZFm/SmpH99f1w7H55uiCyz5VfeShAFZqbMaW
         jXw5XMbvCP4Zraudeqa8NDHZfeQuyUWwppgpr6wHY7d/SVX3CAxEv5bxe6gfmlRyzMB4
         Gu9Q==
X-Gm-Message-State: APjAAAXH2Dn4yLSqNuYynwRry9Qr03MoW95xDIS0KQDy3doRl7cM8+Ls
        V+hUTkBIRdRC3jdBMZQFuBBR0BudiRC3nkYURlU=
X-Google-Smtp-Source: APXvYqzidw7it9RFvQO3QHpIyQRWnqyn2HDPGgcq72wbtDx3y1RWj/BFazwXFiWSboCAudwrFQw+mF1nebwphQAgI5I=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr12969143lff.93.1566885297683;
 Mon, 26 Aug 2019 22:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-2-codekipper@gmail.com>
 <CAGb2v651jVp+J2eyWh7vw-yHmFTVy4eaMjHV0FvOF17C5_Hswg@mail.gmail.com>
In-Reply-To: <CAGb2v651jVp+J2eyWh7vw-yHmFTVy4eaMjHV0FvOF17C5_Hswg@mail.gmail.com>
From:   Code Kipper <codekipper@gmail.com>
Date:   Tue, 27 Aug 2019 07:54:45 +0200
Message-ID: <CAEKpxBmCg4AkqKM-O3C76gto+mPWyEdDbviAmRJ8PxLOOMTJ7w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v6 1/3] ASoC: sun4i-i2s: incorrect regmap
 for A83T
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 06:13, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Aug 27, 2019 at 2:07 AM <codekipper@gmail.com> wrote:
> >
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > The regmap configuration is set up for the legacy block on the
> > A83T whereas it uses the new block with a larger register map.
>
> Looking at the code Allwinner previously released [1], that doesn't seem to be
> the case. Keep in mind that the register map shown in the user manual is for
> the TDM interface, which we don't actually support right now.

Should it matter what we support right now?, the block according to the user
manual shows the bigger range. I don't have a A83T device and from what I
gather not many users do. But the compatible for the H3 has been removed
and replaced with the settings for the A83T which also has default settings in
registers further up than SUNXI_RXCHMAP.

>
> The file shows the base address as 0x01c22800, and the last defined register
> is SUNXI_RXCHMAP at 0x3c.
>
> The I2S driver [2] also shows that it is the old register map size, but with
> TX_FIFO and INT_STA swapped around. This might mean that it would need a
> separate regmap_config, as the read/write callbacks need to be changed to
> fit the swapped registers.
>
> Finally, the TDM driver [3], which matches the TDM section in the manual, shows
> a larger register map.
>
> A83T is SUN8IW6, while SUN8IW7 refers to the H3.

Since when have we trusted Allwinner code?, the TDM labelled block
clearly supports
I2S. The biggest use case for this block is getting HDMI audio working
on the newer
devices(LibreELEC nightlies has a user base of over 300) and I've tested this on
numerous set ups over the last couple of years.

Failing that reverting (3e9acd7ac693: "ASoC: sun4i-i2s: Remove
duplicated quirks structure")
would help.

BR,
CK
>
> ChenYu
>
> [1] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.h
> [2] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/i2s0/sunxi-i2s0.h
> [3] https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/daudio0/sunxi-daudio0.h
>
> > Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 57bf2a33753e..34575a8aa9f6 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -1100,7 +1100,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
> >  static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
> >         .has_reset              = true,
> >         .reg_offset_txdata      = SUN8I_I2S_FIFO_TX_REG,
> > -       .sun4i_i2s_regmap       = &sun4i_i2s_regmap_config,
> > +       .sun4i_i2s_regmap       = &sun8i_i2s_regmap_config,
> >         .field_clkdiv_mclk_en   = REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
> >         .field_fmt_wss          = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
> >         .field_fmt_sr           = REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> > --
> > 2.23.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190826180734.15801-2-codekipper%40gmail.com.
