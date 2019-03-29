Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5240C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9512F218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="l0JaSuV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfC2XH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:07:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36888 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfC2XH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:07:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so4586208wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=X4WzdP2nQiMGjUzeIIS1XDNpuU8ZsZnm39niZjc4DUg=;
        b=l0JaSuV0w/PCUENbmYzE5FTbbDOwumvyyTq3Ua7Xx6VHtPxsR5sxSHDPy5So6b4/rf
         MUWKDhO/cL375Lqp7BToC9tvVmfe2aFAsYsBz4hAq3EU5ZPCTZpQt9780R+tWyatGbIK
         J6vX2XZFtcAHXvsv+d8JTtAMhpkZkC3tRiQPIqmsX1qUnIm+Fl22L7yY2vXRmnydFuYT
         ibnRiNdv7D9WOecp8XghGz9L0ZNtBLsF8sPT/3vTSmlW5k0pSaaRB39vuNCjaRrFYiPx
         GLv8xx9fwPoqLti0eL15I6VBYZ9R+nlcFbYNjW+lyU/ljrsRjqSwy9hWaUqHD5EolKOo
         mUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=X4WzdP2nQiMGjUzeIIS1XDNpuU8ZsZnm39niZjc4DUg=;
        b=ZUk3OLM3WAnPXeUeqyTWByHS7aYgJx4AzjuIAkrHl9UueL4vBtj4F7RvONWoGoVGfA
         MbWK1FKQOiwlKAkWIj+lOivODelQ7O541or6DTJ4u2taQQi2mp4IKTbJxM5qZLTkjwqp
         cWv+Cxa8Nwdx+LBWmdjh5ul3P0fjlT8k97Nwtq/0wC9bdyadq7EyYbFp0uJ3ESSDpQpW
         ykpJpqvVSg2GCxFkL1XBWoELwtxpcapPb5ufHjFijFZ8EwE7JJWtCR/MHz2oCdDRQYyZ
         0umpo88VX8xypp+0xqn1ox3RPRwVWzglAWa5VqrC65sRYGHha0BHDJf2/ZOkMtqVjcMJ
         HCww==
X-Gm-Message-State: APjAAAXo7eTkxzuCOLK7mYHcR7VYse3ZUb6vX7dQzWMLyKc/QUPgvaMz
        Moeaf3vNhV0FqIpman498lZbYg==
X-Google-Smtp-Source: APXvYqwQ8yPsEvN9BsHL6fs8bVGHRAZAnJMewzitTxvw/imFpZ/mWe5MdRSiM+QuoxU7QVhffjGOFw==
X-Received: by 2002:a1c:ce:: with SMTP id 197mr4956859wma.105.1553900875884;
        Fri, 29 Mar 2019 16:07:55 -0700 (PDT)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id u19sm4487071wmc.7.2019.03.29.16.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 16:07:55 -0700 (PDT)
Message-ID: <3bef1bb26e9eff0cfc20cd4bb78a5d7cea4c5076.camel@baylibre.com>
Subject: Re: [PATCH 1/3] clk: meson: mpll: properly handle spread spectrum
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 30 Mar 2019 00:07:53 +0100
In-Reply-To: <CAFBinCDnoY41ZcoHqsngR4WTeczkmOu93R=2G_JOXbdUmHSjMw@mail.gmail.com>
References: <20190329153325.23869-1-jbrunet@baylibre.com>
         <20190329153325.23869-2-jbrunet@baylibre.com>
         <CAFBinCDnoY41ZcoHqsngR4WTeczkmOu93R=2G_JOXbdUmHSjMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 20:39 +0100, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Fri, Mar 29, 2019 at 4:34 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > The bit 'SSEN' available on some MPLL DSS outputs is not related to the
> > fractional part of the divider but to the function called
> > 'Spread Spectrum'.
> > 
> > This function might be used to solve EM issues by adding a jitter on
> > clock signal. This widens the signal spectrum and weakens the peaks in it.
> > 
> > While spread spectrum might be useful for some application, it is
> > problematic for others, such as audio.
> > 
> > This patch introduce a new flag to the MPLL driver to enable (or not) the
> > spread spectrum function.
> > 
> > Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/clk/meson/clk-mpll.c | 9 ++++++---
> >  drivers/clk/meson/clk-mpll.h | 1 +
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
> > index 64d31c8ba3d0..2d39a8bc367c 100644
> > --- a/drivers/clk/meson/clk-mpll.c
> > +++ b/drivers/clk/meson/clk-mpll.c
> > @@ -141,9 +141,12 @@ static void mpll_init(struct clk_hw *hw)
> >         /* Enable the fractional part */
> >         meson_parm_write(clk->map, &mpll->sdm_en, 1);
> > 
> > -       /* Set additional fractional part enable if required */
> > -       if (MESON_PARM_APPLICABLE(&mpll->ssen))
> > -               meson_parm_write(clk->map, &mpll->ssen, 1);
> > +       /* Set spread spectrum if possible */
> > +       if (MESON_PARM_APPLICABLE(&mpll->ssen)) {
> > +               unsigned int ss =
> > +                       mpll->flags & CLK_MESON_MPLL_SPREAD_SPECTRUM ? 1 : 0;
> > +               meson_parm_write(clk->map, &mpll->ssen, ss);
> > +       }
> this changes the "ssen" flag on all supported clocks from 1 (before
> this patch) to 0 (after this patch).
> is this on purpose and how does it affect existing clocks?

Yes, none of our application require spread spectrum

The fact is that only 2 MPLL had this bit, mpll0 on gx (without effect) and
mpll0 on axg: actually spread spectrum impacts mpll2, making it unusable, as
explained in the related patch

> 
> based on the original commit 1f737ffa13ef ("clk: meson: mpll: fix
> mpll0 fractional part ignored") it seems that
> CLK_MESON_MPLL_SPREAD_SPECTRUM should be set for mpll0 (at least on
> GXBB and Meson8b)
> 

There a patch specifically targeting gxbb.
I have checked on GXL and this bit had no effect (fractional part still on, no
spread spectrum)

So either we fixed something since then or I messed up when doing the patch
initially.

Feel free to cross check

> 
> Martin


