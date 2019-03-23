Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F13C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FCC20850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn7QZ8S6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCWG7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:59:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34426 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfCWG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:59:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id x14so829861eds.1;
        Fri, 22 Mar 2019 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPGocWTVd/nSz9pCODUG9wpnXOGLye4QDFZK77+yf9g=;
        b=jn7QZ8S6kf8fGyNUCNIil+yFwiyTHK+iOG+glQ7VYcbFnYgUljpT/kO6fEvvS/HNFB
         yH0L0gNuLDYok8O3qEbXGiBtLLg160UiyxY9ZcqvhysiCGae/y735V5qYqM+G8zkEjqe
         1UHsi8CHQ9BI93SMmXqaJNxAaZF+H+z8iZgr3ZJJ8dvjZlhYURlaJYfk3hGJqtMzLFXE
         FbLrnt7dzRblBwQcfUzbmlrdf5a6wo/vOVGSNKutdyjpsZrt8jYH0YD4F1Bgzpt+Ju19
         GIRg4chuoYL17Dalcco/v7iqnPmLujraGkeLIvezDn1N6MqEAJl6uvSJTCV2laWJV0M/
         6qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPGocWTVd/nSz9pCODUG9wpnXOGLye4QDFZK77+yf9g=;
        b=LkiQWL9H217A2pMc1MZHxlVwXY10HCaEE2qlQGsCTNOdeIDGKp2MfdPsFEGNdEBSGL
         KZM42M2NLy8WpgwK+tqhLkCWZZs1uNtnT/2WPtOwtL7NYu5uHiyBYvS2HJN2FJN3GpQH
         kxkokhEK9YHULxNjhO9bhHL5xtUwq0VXVoVOwcJY7K6Sgnbc/TNr79pZ9kfiK3zOJauL
         ws08gxIxD0zEAEpobadd1FQT2nJr2lY9HQrmN1Q7FpVAP5ZxBZIcAG11dBpyPp9+Awt+
         t2mCiw1bD3hUOeFyly7nET3Ud1TX1wOKywHLri2VaD1PVBpdAmnQw/i+GRpRaERmpN7O
         N7Mw==
X-Gm-Message-State: APjAAAX5EgNF3J9oTEqrdZn3GHbZNlTeVMDnXIIcdGDNthFt+fY7gF9k
        3pq324MkdtB6fO8txeSLxzY+X/lcj3J3oBhC4wF4cg==
X-Google-Smtp-Source: APXvYqziWWz4RC37KSnnH3pcbg7kZZyBbwUDpgP+VE4ALMEVV5Pqd+atueoqXBmfon4tBJEVV8Eplztil+Zs0xp6Cs0=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr8936733edc.67.1553324361517;
 Fri, 22 Mar 2019 23:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com> <1553269010-15591-6-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-6-git-send-email-abel.vesa@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sat, 23 Mar 2019 08:59:09 +0200
Message-ID: <CAEnQRZAEO-mnfeGtDX19Trjxc94FvPvvyfcVia=W5Zan+msVKQ@mail.gmail.com>
Subject: Re: [RFC 05/19] clk: imx: clk-busy: Switch to clk_hw based API
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 5:39 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> Switch all the clk_busy clock registering functions
> to clk_hw based API.
>

Hi Abel,

The commit message should explain why such a change is needed.

thanks,
Daniel.
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/clk/imx/clk-busy.c | 30 ++++++++++++++++++++----------
>  drivers/clk/imx/clk.h      | 11 +++++++++--
>  2 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
> index e695622..51f75500 100644
> --- a/drivers/clk/imx/clk-busy.c
> +++ b/drivers/clk/imx/clk-busy.c
> @@ -78,13 +78,14 @@ static const struct clk_ops clk_busy_divider_ops = {
>         .set_rate = clk_busy_divider_set_rate,
>  };
>
> -struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
> +struct clk_hw *imx_clk_hw_busy_divider(const char *name, const char *parent_name,
>                                  void __iomem *reg, u8 shift, u8 width,
>                                  void __iomem *busy_reg, u8 busy_shift)
>  {
>         struct clk_busy_divider *busy;
> -       struct clk *clk;
> +       struct clk_hw *hw;
>         struct clk_init_data init;
> +       int ret;
>
>         busy = kzalloc(sizeof(*busy), GFP_KERNEL);
>         if (!busy)
> @@ -107,11 +108,15 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
>
>         busy->div.hw.init = &init;
>
> -       clk = clk_register(NULL, &busy->div.hw);
> -       if (IS_ERR(clk))
> +       hw = &busy->div.hw;
> +
> +       ret = clk_hw_register(NULL, hw);
> +       if (ret) {
>                 kfree(busy);
> +               return ERR_PTR(ret);
> +       }
>
> -       return clk;
> +       return hw;
>  }
>
>  struct clk_busy_mux {
> @@ -152,13 +157,14 @@ static const struct clk_ops clk_busy_mux_ops = {
>         .set_parent = clk_busy_mux_set_parent,
>  };
>
> -struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
> +struct clk_hw *imx_clk_hw_busy_mux(const char *name, void __iomem *reg, u8 shift,
>                              u8 width, void __iomem *busy_reg, u8 busy_shift,
>                              const char * const *parent_names, int num_parents)
>  {
>         struct clk_busy_mux *busy;
> -       struct clk *clk;
> +       struct clk_hw *hw;
>         struct clk_init_data init;
> +       int ret;
>
>         busy = kzalloc(sizeof(*busy), GFP_KERNEL);
>         if (!busy)
> @@ -181,9 +187,13 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
>
>         busy->mux.hw.init = &init;
>
> -       clk = clk_register(NULL, &busy->mux.hw);
> -       if (IS_ERR(clk))
> +       hw = &busy->mux.hw;
> +
> +       ret = clk_hw_register(NULL, hw);
> +       if (ret) {
>                 kfree(busy);
> +               return ERR_PTR(ret);
> +       }
>
> -       return clk;
> +       return hw;
>  }
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index e78519c..69b2a13 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -10,6 +10,7 @@ extern spinlock_t imx_ccm_lock;
>  void imx_check_clocks(struct clk *clks[], unsigned int count);
>  void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
>  void imx_register_uart_clocks(struct clk ** const clks[]);
> +void imx_register_uart_clocks_hws(struct clk_hw ** const hws[]);
>
>  extern void imx_cscmr1_fixup(u32 *val);
>
> @@ -48,6 +49,12 @@ struct imx_pll14xx_clk {
>         int flags;
>  };
>
> +#define imx_clk_busy_divider(name, parent_name, reg, shift, width, busy_reg, busy_shift) \
> +       imx_clk_hw_busy_divider(name, parent_name, reg, shift, width, busy_reg, busy_shift)->clk
> +
> +#define imx_clk_busy_mux(name, reg, shift, width, busy_reg, busy_shift, parent_names, num_parents) \
> +       imx_clk_hw_busy_mux(name, reg, shift, width, busy_reg, busy_shift, parent_names, num_parents)->clk
> +
>  struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
>                  void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
>
> @@ -109,11 +116,11 @@ struct clk *imx_clk_pfd(const char *name, const char *parent_name,
>  struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
>                              void __iomem *reg, u8 idx);
>
> -struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
> +struct clk_hw *imx_clk_hw_busy_divider(const char *name, const char *parent_name,
>                                  void __iomem *reg, u8 shift, u8 width,
>                                  void __iomem *busy_reg, u8 busy_shift);
>
> -struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
> +struct clk_hw *imx_clk_hw_busy_mux(const char *name, void __iomem *reg, u8 shift,
>                              u8 width, void __iomem *busy_reg, u8 busy_shift,
>                              const char * const *parent_names, int num_parents);
>
> --
> 2.7.4
>
