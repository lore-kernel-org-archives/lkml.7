Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C15C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB2820820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRZ6d0bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391439AbfFJQGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:06:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33019 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389498AbfFJQGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:06:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id k187so4784937pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+I+xDmvcQKHmO9dh102ZKpExR/xb5wT9g6AOUjcf0i0=;
        b=HRZ6d0btQjpro8mwTrmGvklpATd5mRNEN52DdDuz/6kuyjIjQ4eAQSTs+/HolrLRJF
         R46ckAicM6miqcI8kDAYBiRTp74s7MgVOJtU7IjDaFSEIgs2m0ZDdbkV0XoV+3WlWFpS
         CGCyiM/WFQ6sHMPCaB8LOdNrF/www8lWUCttKSxq7ihl4gGYKI5tUHPPaEzE1xLOFNse
         R2yFIRzdXh9MZzz4r6Vc11GRojUrJPzx/ZW7FSAhE11IhdWMxfH5VMLWrfsD+0ERwwFN
         OgJIy3ihs7dLDenjIv+P5/ik0a0O34QzAhxlTCLpViHDPU7vJlwdAfjQMlr0Eel6IaN6
         SJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+I+xDmvcQKHmO9dh102ZKpExR/xb5wT9g6AOUjcf0i0=;
        b=fqfoU3IFHXdHQsv8lZcV74/2EjwnbBis7jqTOpQt4h320WaX+hEzGiZ8CJTFELFJT+
         MQzk0N1fa4N7cXj3ZDQDPncsoABnJVKKI/orHk0abWYbJHyjTCd38o9gqqM0CHy/uWkU
         6+3LFJBsONYJVnPsmTFt/WKc5vef8hvkzoYY7VOvFFWXLax/+7btNXiwz+TnXRFFtHZv
         RCV/jKuFL+Bab9Kiq56d60i7MZKr4yq0Cs4O1ctJfUQTpr+bOAFGyuOpjbXvVa94zUS4
         OGs9X3AcjJBoPicmIAqRwgIhPb7DV+vjXqMfOB2S7cZOVTc0X1VEgplS37WcQYR2ObH0
         /tWQ==
X-Gm-Message-State: APjAAAWFsxwO1iUlj7ayX3+ZzzT4PJTdVteMevRcmVlhuJDKl9XC53jw
        WA7WYswSTKhaNAr/7KJIhCGq
X-Google-Smtp-Source: APXvYqyPStAbOOnuohurlk0zpLRLMxEkhlvLZbtp16fWZxTRI9S6Jt2woTfc68wM1hNRZFPRhCC6/g==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr15547024pgm.97.1560182761868;
        Mon, 10 Jun 2019 09:06:01 -0700 (PDT)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id y1sm11062506pfe.19.2019.06.10.09.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 09:06:01 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:35:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     sboyd@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/7] clk: actions: Fix factor clk struct member access
Message-ID: <20190610160555.GB31461@mani>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
 <20190608195317.6336-2-manivannan.sadhasivam@linaro.org>
 <29ef33a9-f1f1-fe10-9288-8103714d40fa@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29ef33a9-f1f1-fe10-9288-8103714d40fa@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andreas,

On Mon, Jun 10, 2019 at 03:36:42PM +0200, Andreas Färber wrote:
> Hi Mani,
> 
> Am 08.06.19 um 21:53 schrieb Manivannan Sadhasivam:
> > Since the helper "owl_factor_helper_round_rate" is shared between factor
> > and composite clocks, using the factor clk specific helper function
> > like "hw_to_owl_factor" to access its members will create issues when
> > called from composite clk specific code. Hence, pass the "factor_hw"
> > struct pointer directly instead of fetching it using factor clk specific
> > helpers.
> > 
> > This issue has been observed when a composite clock like "sd0_clk" tried
> > to call "owl_factor_helper_round_rate" resulting in pointer dereferencing
> > error.
> > 
> > Fixes: 4bb78fc9744a ("clk: actions: Add factor clock support")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/actions/owl-factor.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
> > index 317d4a9e112e..f419dfdd334f 100644
> > --- a/drivers/clk/actions/owl-factor.c
> > +++ b/drivers/clk/actions/owl-factor.c
> > @@ -64,11 +64,10 @@ static unsigned int _get_table_val(const struct clk_factor_table *table,
> >  	return val;
> >  }
> >  
> > -static int clk_val_best(struct clk_hw *hw, unsigned long rate,
> > +static int clk_val_best(const struct owl_factor_hw *factor_hw,
> > +			struct clk_hw *hw, unsigned long rate,
> >  			unsigned long *best_parent_rate)
> >  {
> > -	struct owl_factor *factor = hw_to_owl_factor(hw);
> > -	struct owl_factor_hw *factor_hw = &factor->factor_hw;
> >  	const struct clk_factor_table *clkt = factor_hw->table;
> >  	unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
> >  	unsigned long parent_rate_saved = *best_parent_rate;
> > @@ -126,7 +125,7 @@ long owl_factor_helper_round_rate(struct owl_clk_common *common,
> >  	const struct clk_factor_table *clkt = factor_hw->table;
> >  	unsigned int val, mul = 0, div = 1;
> >  
> > -	val = clk_val_best(&common->hw, rate, parent_rate);
> > +	val = clk_val_best(factor_hw, &common->hw, rate, parent_rate);
> >  	_get_table_div_mul(clkt, val, &mul, &div);
> >  
> >  	return *parent_rate * mul / div;
> 
> While at it, I think it would be a good idea to rename it to
> owl_clk_val_best. Pretty confusing that you're touching only owl files
> for a clk_ refactoring, which sounds like common clk code.
> 

Sure, will do.

Thanks,
Mani

> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> HRB 21284 (AG Nürnberg)
