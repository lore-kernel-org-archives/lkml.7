Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC6DCA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A85214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PvVi5E3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfJULbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:31:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54072 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfJULbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:31:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so12898157wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HROsPL2ByDXym6i/NHIHjJkM5kNiw9jG1m8a8LCeIIQ=;
        b=PvVi5E3b/QEtjs/7GPTJkHEgTng108xrwCrEq3OeVnQI/O2sSx9Y5Hr8Q8GGsQ0k2c
         OwivZCXGkcoAyDW3o+/DoYU75IjkTvv2Qpi4X94sUOe+LMSI0rFp0pwmRduwBWfM6qDj
         KK+spBf+D/bMw2wS+NIGSJTt+0iIVP+gqX5uEuC7cI1X+n1WypYrGryTFXxeI6FTVmEb
         qlwTGE5oFYvkYi4YEZXNFQ3kq8Aehp1No+gJ9JrI2dYSj+R+rWT7o2z/M8UQSU7wRn2F
         TsO2LqfKosoQW6t9QnXaMW9J3LCu4QPbJisQNIA/eQ79jMD+g8nih6SrmAFJsQV5H20r
         aY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HROsPL2ByDXym6i/NHIHjJkM5kNiw9jG1m8a8LCeIIQ=;
        b=pH6pPq7fZi909M2nVkrMpkXO5DaRbFYFeD+vfz1ykg47UgIgnJ5gU+ecgOhF0dt33t
         54NVZkfjf5/hQr4okNEzjd5Jeo9YRPORZi4f4Yy9UJak6opzRdRYGwP2UJBVyUfA5QkW
         ea6PsqvnDTJPDTFu7Uw3atMXN/MrtGkGjOsyB+HyWLXjxKc297Ulmq5tVQQw4SQV2bEV
         VGz2bAXPSFJcrRhzCmgfgvMhZHvk3SsPUrslOsAZxf921C43VcOSeYbB7Bn/a6SD0K8s
         9B9SU1FpPQgb3udAcBktqxyiT/HPVrGbIGaWYzCmZ2F3bYjng+RNu66W3X9J/PFMKRhE
         fvXw==
X-Gm-Message-State: APjAAAVG5fN9ijResvw5MsXeMcKfeDYj+8YI1yslc3K7Hde0mV+d7DG6
        HHVb8gePjzZAMwQ3idUm+twG4Q==
X-Google-Smtp-Source: APXvYqz1au/AUOhj6ismuX2RR7PZXMJCNaAO/iedIYnZZsH6iJy5FEzKuwxsm7YEMvrMJQEsfA7hCQ==
X-Received: by 2002:a05:600c:1107:: with SMTP id b7mr20230104wma.151.1571657494379;
        Mon, 21 Oct 2019 04:31:34 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e3sm13450131wme.39.2019.10.21.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 04:31:33 -0700 (PDT)
References: <1571382865-41978-1-git-send-email-jian.hu@amlogic.com> <1571382865-41978-3-git-send-email-jian.hu@amlogic.com>
User-agent: mu4e 1.3.3; emacs 26.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "Rob Herring" <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clk: meson: add support for A1 PLL clock ops
In-reply-to: <1571382865-41978-3-git-send-email-jian.hu@amlogic.com>
Date:   Mon, 21 Oct 2019 13:31:32 +0200
Message-ID: <1jtv82bai3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 18 Oct 2019 at 09:14, Jian Hu <jian.hu@amlogic.com> wrote:

> The A1 PLL design is different with previous SoCs. The PLL
> internal analog modules Power-on sequence is different
> with previous, and thus requires a strict register sequence to
> enable the PLL. Unlike the previous series, the maximum frequency
> is 6G in G12A, for A1 the maximum is 1536M.
>
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  drivers/clk/meson/clk-pll.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
>  drivers/clk/meson/clk-pll.h |  1 +
>  2 files changed, 61 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index ddb1e56..b440e62 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -349,6 +349,56 @@ static void meson_clk_pll_disable(struct clk_hw *hw)
>  	meson_parm_write(clk->map, &pll->en, 0);
>  }
>  
> +/*
> + * The A1 design is different with previous SoCs.The PLL
> + * internal analog modules Power-on sequence is different with
> + * previous, different PLL has the different sequence, and
> + * thus requires a strict register sequence to enable the PLL.
> + * When set a new target frequency, the sequence should keep
> + * the same with the initial sequence. Unlike the previous series,
> + * the maximum frequency is 6G in G12A, for A1 the maximum
> + * is 1536M.

The comment about the max frequency belongs in your a1 driver, not in
the PLL driver

> + */
> +static void meson_params_update_with_init_seq(struct clk_regmap *clk,
> +				       struct meson_clk_pll_data *pll,
> +				       unsigned int m, unsigned int n,
> +				       unsigned int frac)
> +{
> +	struct parm *pm = &pll->m;
> +	struct parm *pn = &pll->n;
> +	struct parm *pfrac = &pll->frac;
> +	const struct reg_sequence *init_regs = pll->init_regs;
> +	unsigned int i, val;
> +
> +	for (i = 0; i < pll->init_count; i++) {
> +		if (pn->reg_off == init_regs[i].reg) {
> +			/* Clear M N bits and Update M N value */
> +			val = init_regs[i].def;
> +			val &= CLRPMASK(pn->width, pn->shift);
> +			val &= CLRPMASK(pm->width, pm->shift);
> +			val |= n << pn->shift;
> +			val |= m << pm->shift;
> +			regmap_write(clk->map, pn->reg_off, val);
> +		} else if (MESON_PARM_APPLICABLE(&pll->frac) &&
> +			   (pfrac->reg_off == init_regs[i].reg)) {
> +			/* Clear Frac bits and Update Frac value */
> +			val = init_regs[i].def;
> +			val &= CLRPMASK(pfrac->width, pfrac->shift);
> +			val |= frac << pfrac->shift;
> +			regmap_write(clk->map, pfrac->reg_off, val);
> +		} else {
> +			/*
> +			 * According to the PLL hardware constraint,
> +			 * the left registers should be setted again.
> +			 */
> +			val = init_regs[i].def;
> +			regmap_write(clk->map, init_regs[i].reg, val);
> +		}
> +		if (init_regs[i].delay_us)
> +			udelay(init_regs[i].delay_us);
> +	}

So:

1) All the code above this there make the PLL lock, IOW enable the
PLL. It does not belong in the set_rate() callback but in enable() or
prepare() maybe.

2) All the above is works but it is a bit over complicated for what it
does. From the a1_hifi_init_regs I see, all you really need to do is
  * toggle BIT(6) in CTRL2
  * toggle BIT(28) in CTRL0 (enable PARM)
  * toggle BIT(26) in CTRL0

You could use PARM 'rst' for one them and introduce another parm for the
other one. You would not need to repoke the whole sequence this way.

> +}
> +
>  static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  				  unsigned long parent_rate)
>  {
> @@ -366,16 +416,20 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>  	if (ret)
>  		return ret;
>  
> +	if (MESON_PARM_APPLICABLE(&pll->frac))
> +		frac = __pll_params_with_frac(rate, parent_rate, m, n, pll);
> +
>  	enabled = meson_parm_read(clk->map, &pll->en);
>  	if (enabled)
>  		meson_clk_pll_disable(hw);
>  
> -	meson_parm_write(clk->map, &pll->n, n);
> -	meson_parm_write(clk->map, &pll->m, m);
> -
> -	if (MESON_PARM_APPLICABLE(&pll->frac)) {
> -		frac = __pll_params_with_frac(rate, parent_rate, m, n, pll);
> -		meson_parm_write(clk->map, &pll->frac, frac);
> +	if (pll->strict_sequence)
> +		meson_params_update_with_init_seq(clk, pll, m, n, frac);
> +	else {
> +		meson_parm_write(clk->map, &pll->n, n);
> +		meson_parm_write(clk->map, &pll->m, m);
> +		if (MESON_PARM_APPLICABLE(&pll->frac))
> +			meson_parm_write(clk->map, &pll->frac, frac);
>  	}
>  
>  	/* If the pll is stopped, bail out now */
> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
> index 367efd0..d5789cef 100644
> --- a/drivers/clk/meson/clk-pll.h
> +++ b/drivers/clk/meson/clk-pll.h
> @@ -41,6 +41,7 @@ struct meson_clk_pll_data {
>  	const struct pll_params_table *table;
>  	const struct pll_mult_range *range;
>  	u8 flags;
> +	bool strict_sequence;

Don't introduce parameter for this We have ops to tune the behavior of
the clock driver. Properly refactor the code if some of it is common.

>  };
>  
>  extern const struct clk_ops meson_clk_pll_ro_ops;

