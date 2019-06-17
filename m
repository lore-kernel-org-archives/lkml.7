Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767C7C31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB13218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 06:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560752982;
	bh=UcxbS7rUCgcBM/DB0jqfsiIGehfsD3/yjUCvwOkO9hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nPVGTXFD1m9Vx6yWY1KHTXhn0Q17q4rg1MgWDrz9EhK4IOmt7QkUrTtTx1JrOi1j4
	 NeOj3uG4IdJiVqyBha7ApiYTuQ3njSyQpbLxObUttDscTtLkA18ivknmBDlAc9lkCb
	 o7F7DRaxgY8gETcL+u+RtCB8G4YyElhvfOL9/N4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFQG3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 02:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfFQG3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:29:40 -0400
Received: from localhost (unknown [122.178.208.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25351218C9;
        Mon, 17 Jun 2019 06:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560752980;
        bh=UcxbS7rUCgcBM/DB0jqfsiIGehfsD3/yjUCvwOkO9hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0GW+tvR3UXIHVn9kTa0d5frYtD6j+epz/de/4QneHVmb5DBuSFjAFqdL3XYA/J3uQ
         e/bvSEtKodHJBIsJ9rfClmB3o6sqj5rGgTb4BZ3RqgqPZcwHW91VAaio+6ZVD2vbw8
         O+uJnoyHifdLQUaWJdBj6JZocjTJu8rctL4+IwS0=
Date:   Mon, 17 Jun 2019 11:56:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        "Isaac J . Manjarres" <isaacm@codeaurora.org>
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add SM8150 pinctrl driver
Message-ID: <20190617062631.GH2962@vkoul-mobl>
References: <20190614053032.24208-1-vkoul@kernel.org>
 <20190614053032.24208-2-vkoul@kernel.org>
 <20190617041736.GD750@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617041736.GD750@tuxbook-pro>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-19, 21:17, Bjorn Andersson wrote:
> On Thu 13 Jun 22:30 PDT 2019, Vinod Koul wrote:
> 
> > From: Prasad Sodagudi <psodagud@codeaurora.org>
> > 
> > Add initial pinctrl driver to support pin configuration with
> > pinctrl framework for SM8150
> > 
> > Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> > Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> 
> I presume you did stuff to make it fit with my upstream tiling, mention
> that here.

Thanks for pointing I did miss the changes I did

> 
> [..]
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
> [..]
> > +static const struct pinctrl_pin_desc sm8150_pins[] = {
> [..]
> > +	PINCTRL_PIN(178, "UFS_RESET"),
> 
> Please follow
> https://lore.kernel.org/linux-arm-msm/20190606010249.3538-2-bjorn.andersson@linaro.org/
> for ufs_reset.

Sure will update 
> 
> > +};
> [..]
> > +enum sm8150_functions {
> > +	msm_mux_phase_flag8,
> 
> Please sort these alphabetically and please squash all the phase_flag*
> into msm_mux_phase_flag.

Will do, is there a reason why we want to squash them?
> 
> > +	msm_mux_phase_flag7,
> > +	msm_mux_emac_pps,
> > +	msm_mux_qup12,
> > +	msm_mux_qup16,
> > +	msm_mux_tsif1_clk,
> 
> Please squash all tsif1 into msm_mux_tsif1.

Will do

> 
> > +	msm_mux_qup8,
> > +	msm_mux_qspi_cs,
> > +	msm_mux_tgu_ch3,
> > +	msm_mux_tsif1_en,
> > +	msm_mux_qspi0,
> > +	msm_mux_mdp_vsync0,
> > +	msm_mux_mdp_vsync1,
> > +	msm_mux_mdp_vsync2,
> > +	msm_mux_mdp_vsync3,
> > +	msm_mux_tgu_ch0,
> > +	msm_mux_tsif1_data,
> > +	msm_mux_qspi1,
> > +	msm_mux_sdc4_cmd,
> 
> Squash sdc4_cmd, sdc4_clk and sdc4{0,1,2,3} into msm_mux_sdc4.

Sure will do on all and again what is the motivation. I am trying to
understand the reasoning so that next time I know what to do :-)

> > +static const struct msm_function sm8150_functions[] = {
> > +	FUNCTION(phase_flag8),
> 
> Please sort this array as well.

okay

> > +static const struct msm_pingroup sm8150_groups[] = {
> [..]
> > +	[58] = PINGROUP(58, SOUTH, qup17, qup19, qdss_cti, qdss_cti, _, _, _, _, _),
> 
> qdss_cti can't be both function 3 and 4 of a single pin.

Let me check, maybe error in downstream code

> > +static struct platform_driver sm8150_pinctrl_driver = {
> > +	.driver = {
> > +		.name = "sm8150-pinctrl",
> > +		.owner = THIS_MODULE,
> 
> No .owner in platform_driver

Yeah missed to remove

-- 
~Vinod
