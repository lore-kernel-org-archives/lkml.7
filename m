Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111DEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A43218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568899966;
	bh=5M/n8bdfSy3cE24moaKUuajERdBL//fSt55Q8PVPJbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zwq8F76DhAM1NT+VtcbkgRnFWU4mVLv5TrsdYEleKMrK1RR+OdcD6Zj/Xm3NERo4Z
	 Ut7tx6rws6yjp9iNrxd5H42bagCyx/EJGBn8t4yoPgvKxDajbG9S1W/xunAg09375m
	 Lvt1LBSfWLzaDWEB6iS/uik50/Kj5mr58Kn0Nymw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbfISNcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:32:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34604 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390044AbfISNcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:32:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id 83so2747018oii.1;
        Thu, 19 Sep 2019 06:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6Vbzint3TNkF0RwuJRnvSz0zFNi0mSUxmrLncCYz9Sc=;
        b=OV6EVrlTMNweLWfFFk/d7AqbBHbtp8fHoNhSSqrGUc4RxoTzD6a4217jslhB+HBSQK
         KX1SA2V6weBpFD4AacseJILPD98S8ktAw9ys2k19bBnJQ1lkVPVflEUuMecDmLzDejlF
         3FhrB5LMUFeB/N9c+Kw6LpooC1IZw+GJzMVUbkAd2BWSHsCfnhyg4idtS5zDDQQMxM/T
         CFlK/v+jSEglRDyKpIr+kTWrHc7sE2eWo+REC2YDf0qAxBVABJcR5VKIsHhAFdG3tWq8
         N0VjCItt4wt3xlSmLo1L0bBiL5jo95eIcPhrghfe0UgjEiDI/97E+FJ73JyBMzeDnP0Z
         HmJw==
X-Gm-Message-State: APjAAAVl9RJiGon7LJnLnb5fwz06ilv/mU5Stk+kvnHwYzGVJHCCifv5
        zZUJcOZUz1kGINokcitpnw==
X-Google-Smtp-Source: APXvYqzK08G1BtpQyRdlr3bjTtuu66Pn1FaJm7NcodUZdbVk+gT9gx+YwSgdEuoRELSfmX52YLpvVA==
X-Received: by 2002:aca:dcc4:: with SMTP id t187mr2208633oig.136.1568899963907;
        Thu, 19 Sep 2019 06:32:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm482618oiz.3.2019.09.19.06.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 06:32:42 -0700 (PDT)
Date:   Thu, 19 Sep 2019 08:32:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] of: restore old handling of cells_name=NULL in
  of_*_phandle_with_args()
Message-ID: <20190919133242.GA27990@bogus>
References: <20190918063837.8196-1-u.kleine-koenig@pengutronix.de>
 <b00ca30f-2c06-7722-96b2-123d15751cb6@axentia.se>
 <20190918084748.hnjkiq7wc5b35wjh@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918084748.hnjkiq7wc5b35wjh@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 10:47:48 +0200, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=          wrote:
> Before commit e42ee61017f5 ("of: Let of_for_each_phandle fallback to
> non-negative cell_count") the iterator functions calling
> of_for_each_phandle assumed a cell count of 0 if cells_name was NULL.
> This corner case was missed when implementing the fallback logic in
> e42ee61017f5 and resulted in an endless loop.
> 
> Restore the old behaviour of of_count_phandle_with_args() and
> of_parse_phandle_with_args() and add a check to
> of_phandle_iterator_init() to prevent a similar failure as a safety
> precaution. of_parse_phandle_with_args_map() doesn't need a similar fix
> as cells_name isn't NULL there.
> 
> Affected drivers are:
>  - drivers/base/power/domain.c
>  - drivers/base/power/domain.c
>  - drivers/clk/ti/clk-dra7-atl.c
>  - drivers/hwmon/ibmpowernv.c
>  - drivers/i2c/muxes/i2c-demux-pinctrl.c
>  - drivers/iommu/mtk_iommu.c
>  - drivers/net/ethernet/freescale/fman/mac.c
>  - drivers/opp/of.c
>  - drivers/perf/arm_dsu_pmu.c
>  - drivers/regulator/of_regulator.c
>  - drivers/remoteproc/imx_rproc.c
>  - drivers/soc/rockchip/pm_domains.c
>  - sound/soc/fsl/imx-audmix.c
>  - sound/soc/fsl/imx-audmix.c
>  - sound/soc/meson/axg-card.c
>  - sound/soc/samsung/tm2_wm5110.c
>  - sound/soc/samsung/tm2_wm5110.c
> 
> Thanks to Geert Uytterhoeven for reporting the issue, Peter Rosin for
> helping pinpoint the actual problem and the testers for confirming this
> fix.
> 
> Fixes: e42ee61017f5 ("of: Let of_for_each_phandle fallback to non-negative cell_count")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> 
> On Wed, Sep 18, 2019 at 08:01:05AM +0000, Peter Rosin wrote:
> > On 2019-09-18 08:38, Uwe Kleine-König wrote:
> > >  EXPORT_SYMBOL(of_parse_phandle_with_args);
> > >  
> > > @@ -1765,6 +1779,18 @@ int of_count_phandle_with_args(const struct device_node *np, const char *list_na
> > >  	struct of_phandle_iterator it;
> > >  	int rc, cur_index = 0;
> > >  
> > > +	/* If cells_name is NULL we assume a cell count of 0 */
> > > +	if (cells_name == NULL) {
> > 
> > A couple of nits.
> > 
> > I don't know if there are other considerations, but in the previous two
> > hunks you use !cells_name instead of comparing explicitly with NULL.
> > Personally, I find the shorter form more readable, and in the name of
> > consistency bla bla...
> 
> Ack, changed to !cells_name here, too.
> 
> > 
> > Also, the comment explaining this NULL-check didn't really make sense
> > to me until I realized that knowing the cell count to be zero makes
> > counting trivial. Something along those lines should perhaps be in the
> > comment?
> 
> You're right, I extended the comment a bit.
>  
> > But as I said, these are nits. Feel free to ignore.
> 
> I considered resending already anyhow as I fatfingerd my email address.
> this is fixed now, too. Additionally I fixed a typo in one of the
> comments.
> 
> Thanks for your feedback.
> 
> Best regards
> Uwe
> 
>  drivers/of/base.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 

Applied, thanks.

Rob
