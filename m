Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8165C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8987B20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 16:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DwiKlg3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfL0Qxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 11:53:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43682 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfL0Qxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 11:53:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so25737753edb.10;
        Fri, 27 Dec 2019 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PutLJWPd2cEOhbmgZKTEhd5XEP7OpzpWifMhut4DmqA=;
        b=DwiKlg3avHIENCyNavhob2AMpVyTS9QSLl42Sq+4wmPxA2eGoEaW0dNQJSDgR9qVI/
         gVpTH5X0CHsaaBqUQSIqqYyJvt9ANz4oUcUiF1HgEuaNFJ4f5fSTRM+ZdOaxipbQ+37l
         e52TCpfVMWTs/4gfu4RQu63sv+6g+UJdbWRp+TidXrL8tOQ5ctn3zFDhXQl7NGKZtaEy
         ejJ3rs1FslamWH8noA5P8dlPPpBQmf7bK+8qfHBl8yjGCGtAJYq7knGY0d37A9JguVRB
         6wK1qjeq7+pJfp7csnP5t+//L8L+/RTNsK49f9NZAKBd2xrob+rD8KIBexvwXOkcSiRD
         3zRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PutLJWPd2cEOhbmgZKTEhd5XEP7OpzpWifMhut4DmqA=;
        b=ndYCI3/fQPYhVgkEdZmaNNCFUD9dL99pDMAcWgS414N+sbh3tAnxekWXfEH9qd2ytd
         yMG3TzJaPZS4xzAYrOsVkao0XxBno7cl8KXdXkY8GrAuf9x+jvsaMxfr39xI0n4Pv9Zc
         FJKWEEv6s8edVEAgNRyFR0FBiQwHRZCdfpKKJO4q3rQzWX2clBIT5ghtauiwtp8JVMLx
         V8MeLNAqmt/VdIoovQFwkO+SkmidUPWcoPntpTvZvQ3hlYsMfvbkU4yyLTvd/n6Jf46q
         LakZLmQXAEqCHUeDwmzGiJFVj7oYPltdlQmk5Bgk8DEnTlZ7Q19fGdTit4Xe3dajNLCu
         xOvg==
X-Gm-Message-State: APjAAAW2fW7NZHqsCBZXwHbwZ+sZI/x9mlvX4cYZmpfBUGiMdoL+n/Lm
        tPzay9vTgdW3gAzy1DYbiSGgFHM/pY4qoGScZJ4=
X-Google-Smtp-Source: APXvYqygkSSfnw8HoIDr9icAV5YXJN/IAat2JIa4d06E0rVnVK5uFaStiuAG+Sxv/pJ2HevsAWvvqJm4znilTktaA3I=
X-Received: by 2002:aa7:c80b:: with SMTP id a11mr57661239edt.240.1577465632157;
 Fri, 27 Dec 2019 08:53:52 -0800 (PST)
MIME-Version: 1.0
References: <20191227094606.143637-1-jian.hu@amlogic.com> <20191227094606.143637-3-jian.hu@amlogic.com>
In-Reply-To: <20191227094606.143637-3-jian.hu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 27 Dec 2019 17:53:41 +0100
Message-ID: <CAFBinCC4Fgn3QQ6H-TWO_Xx+USonzMDZDyvJBfYp-_6=pmKdLQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] clk: meson: add support for A1 PLL clock ops
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian,

On Fri, Dec 27, 2019 at 10:46 AM Jian Hu <jian.hu@amlogic.com> wrote:
[...]
> @@ -294,9 +298,12 @@ static int meson_clk_pll_is_enabled(struct clk_hw *hw)
>  {
>         struct clk_regmap *clk = to_clk_regmap(hw);
>         struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
> +       int ret = 0;
>
> -       if (meson_parm_read(clk->map, &pll->rst) ||
> -           !meson_parm_read(clk->map, &pll->en) ||
> +       if (MESON_PARM_APPLICABLE(&pll->rst))
> +               ret = meson_parm_read(clk->map, &pll->rst);
> +
> +       if (ret || !meson_parm_read(clk->map, &pll->en) ||
>             !meson_parm_read(clk->map, &pll->l))
>                 return 0;
I had to read this part twice to understand what it's doing because I
misunderstood what "ret" is used for (I thought that some "return ret"
is missing)
my proposal to make it easier to read:
...
if (MESON_PARM_APPLICABLE(&pll->rst) &&
    meson_parm_read(clk->map, &pll->rst))
  return 0;

if (!meson_parm_read(clk->map, &pll->en) ||
    !meson_parm_read(clk->map, &pll->l))
                 return 0;
...

please let me know what you think about this

> @@ -321,6 +328,23 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>         /* do nothing if the PLL is already enabled */
>         if (clk_hw_is_enabled(hw))
>                 return 0;
> +       /*
> +        * Compared with the previous SoCs, self-adaption module current
> +        * is newly added for A1, keep the new power-on sequence to enable the
> +        * PLL.
> +        */
> +       if (MESON_PARM_APPLICABLE(&pll->current_en)) {
> +               /* Enable the pll */
> +               meson_parm_write(clk->map, &pll->en, 1);
> +               udelay(10);
> +               /* Enable the pll self-adaption module current */
> +               meson_parm_write(clk->map, &pll->current_en, 1);
> +               udelay(40);
> +               /* Enable lock detect module */
> +               meson_parm_write(clk->map, &pll->l_detect, 1);
> +               meson_parm_write(clk->map, &pll->l_detect, 0);
> +               goto out;
> +       }
in all other functions you are skipping the pll->rst register by
checking for MESON_PARM_APPLICABLE(&pll->rst)
I like that because it's a pattern which is easy to follow

do you think we can make this part consistent with that?
I'm thinking of something like this (not compile-tested and I dropped
all comments, just so you get the idea):
...
if (MESON_PARM_APPLICABLE(&pll->rst)
  meson_parm_write(clk->map, &pll->rst, 1);

meson_parm_write(clk->map, &pll->en, 1);

if (MESON_PARM_APPLICABLE(&pll->rst))
  meson_parm_write(clk->map, &pll->rst, 0);

if (MESON_PARM_APPLICABLE(&pll->current_en))
  meson_parm_write(clk->map, &pll->current_en, 1);

if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
  meson_parm_write(clk->map, &pll->l_detect, 1);
  meson_parm_write(clk->map, &pll->l_detect, 0);
}

if (meson_clk_pll_wait_lock(hw))
...

I see two (and a half) benefits here:
- if there's a PLL with neither the pll->current_en nor the pll->rst
registers then you get support for this implementation for free
- the if (MESON_PARM_APPLICABLE(...)) pattern is already used in the
driver, but only for one register (in your example when
MESON_PARM_APPLICABLE(&pll->current_en) exists you also modify the
pll->l_detect register, which I did not expect)
- only counts half: no use of "goto", which in my opinion makes it
very easy to read (just read from top to bottom, checking each "if")


Martin
