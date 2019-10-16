Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC1FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A92218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571228635;
	bh=tpyw6dnWtRktL2mWFhpiJUG5Thn3Q7Jh+AkFL2KBI+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yj00YYV78O9LlqZNR/X54sgQR9lC7wKRZU20lIWqHjZNmGlx+PCYrBwYkLS8oCV3A
	 2Dy+kenpktAertnKJ2TciTH5cGqm/XEs4KHSEBKq9t0PQUTj+R1bM7Q2tyT9GykgT4
	 KVa7uh25Wq8U8XhynVcpHC/vhg9pAGdyS6u8uAcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfJPMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387581AbfJPMXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:23:54 -0400
Received: from localhost (unknown [171.76.123.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C34B6218DE;
        Wed, 16 Oct 2019 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571228632;
        bh=tpyw6dnWtRktL2mWFhpiJUG5Thn3Q7Jh+AkFL2KBI+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qa/l60b2JJTcUZ278R7jNoVGx28q8QiwPDjwOtI1jkSn/4IzfMZFipQJWoSj3cHm9
         324dSyDpVJWSuUWz58xXxLajnhCAGqgQS0rpyf2eNJ27gsgFeuLPyeymiCitTgXFGD
         O51IqEr0niNCj4CXPP4J2l59dA6ubVPC7XIUA5Vg=
Date:   Wed, 16 Oct 2019 17:53:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc: Add missing clocks in SM8150
Message-ID: <20191016122343.GM2654@vkoul-mobl>
References: <20190917091623.3453-1-vkoul@kernel.org>
 <20190917161000.DAFF3206C2@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917161000.DAFF3206C2@mail.kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Looks like I missed replying to this one, apologies!

On 17-09-19, 09:09, Stephen Boyd wrote:
> Quoting Vinod Koul (2019-09-17 02:16:23)
> > The initial upstreaming of SM8150 GCC driver missed few clock so add
> > them up now.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> 
> Should have some sort of fixes tag?

Not really, the drivers to use these clks are not upstream so we dont
miss it yet

> 
> >  drivers/clk/qcom/gcc-sm8150.c | 172 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 172 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> > index 12ca2d14797f..13d4d14a5744 100644
> > --- a/drivers/clk/qcom/gcc-sm8150.c
> > +++ b/drivers/clk/qcom/gcc-sm8150.c
> > @@ -1616,6 +1616,38 @@ static struct clk_branch gcc_gpu_cfg_ahb_clk = {
> >         },
> >  };
> >  
> > +static struct clk_branch gcc_gpu_gpll0_clk_src = {
> > +       .halt_check = BRANCH_HALT_SKIP,
> 
> Why skip?

I will explore and add comments for that

> > +       .clkr = {
> > +               .enable_reg = 0x52004,
> > +               .enable_mask = BIT(15),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_gpu_gpll0_clk_src",
> > +                       .parent_hws = (const struct clk_hw *[]){
> > +                               &gpll0.clkr.hw },
> > +                       .num_parents = 1,
> > +                       .flags = CLK_SET_RATE_PARENT,
> > +                       .ops = &clk_branch2_ops,
> > +               },
> > +       },
> > +};
> > +
> > +static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
> > +       .halt_check = BRANCH_HALT_SKIP,
> 
> Why skip?
> 
> > +       .clkr = {
> > +               .enable_reg = 0x52004,
> > +               .enable_mask = BIT(16),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_gpu_gpll0_div_clk_src",
> > +                       .parent_hws = (const struct clk_hw *[]){
> > +                               &gcc_gpu_gpll0_clk_src.clkr.hw },
> > +                       .num_parents = 1,
> > +                       .flags = CLK_SET_RATE_PARENT,
> > +                       .ops = &clk_branch2_ops,
> > +               },
> > +       },
> > +};
> > +
> >  static struct clk_branch gcc_gpu_iref_clk = {
> >         .halt_reg = 0x8c010,
> >         .halt_check = BRANCH_HALT,
> > @@ -1698,6 +1730,38 @@ static struct clk_branch gcc_npu_cfg_ahb_clk = {
> >         },
> >  };
> >  
> > +static struct clk_branch gcc_npu_gpll0_clk_src = {
> > +       .halt_check = BRANCH_HALT_SKIP,
> > +       .clkr = {
> > +               .enable_reg = 0x52004,
> > +               .enable_mask = BIT(18),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_npu_gpll0_clk_src",
> > +                       .parent_hws = (const struct clk_hw *[]){
> > +                               &gpll0.clkr.hw },
> > +                       .num_parents = 1,
> > +                       .flags = CLK_SET_RATE_PARENT,
> > +                       .ops = &clk_branch2_ops,
> > +               },
> > +       },
> > +};
> > +
> > +static struct clk_branch gcc_npu_gpll0_div_clk_src = {
> > +       .halt_check = BRANCH_HALT_SKIP,
> > +       .clkr = {
> > +               .enable_reg = 0x52004,
> > +               .enable_mask = BIT(19),
> > +               .hw.init = &(struct clk_init_data){
> > +                       .name = "gcc_npu_gpll0_div_clk_src",
> > +                       .parent_hws = (const struct clk_hw *[]){
> > +                               &gcc_npu_gpll0_clk_src.clkr.hw },
> > +                       .num_parents = 1,
> > +                       .flags = CLK_SET_RATE_PARENT,
> > +                       .ops = &clk_branch2_ops,
> > +               },
> > +       },
> > +};
> > +
> >  static struct clk_branch gcc_npu_trig_clk = {
> >         .halt_reg = 0x4d00c,
> >         .halt_check = BRANCH_VOTED,
> > @@ -2812,6 +2876,42 @@ static struct clk_branch gcc_ufs_card_phy_aux_hw_ctl_clk = {
> >         },
> >  };
> >  
> > +static struct clk_branch gcc_ufs_card_rx_symbol_0_clk = {
> > +       .halt_check = BRANCH_HALT_SKIP,
> 
> Can't we fix the UFS driver to not require this anymore? This is the
> fourth or fifth time I've asked for this.

yeah Bjorn did tell me that and I think there was some other thread on
similar lines. So is this fine by you.

-- 
~Vinod
