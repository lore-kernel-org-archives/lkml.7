Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2538C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B7233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566482433;
	bh=DWwwr3qPkjE4y1klETI0/GZhGb33KyLJV8JKbxYx8mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dB26z6Rsc7MDmJK3AvE6739yq38dNEJEG7pCMFdlNSttftPX/QUAyOlMANfDY7PkU
	 x1FhE78nglFE2MpKMXd52ieRKBZJL/UJJdDXsvS8OeZwyWqbYXVpSsZnchOEjcWCeJ
	 laoTBiod8nL7nLD8lXbXayJpfpjReFo69Qw5Xz7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbfHVOAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfHVOAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:00:32 -0400
Received: from localhost (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B0522CE3;
        Thu, 22 Aug 2019 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566482431;
        bh=DWwwr3qPkjE4y1klETI0/GZhGb33KyLJV8JKbxYx8mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YvQJ7oGkcjX82C23lfVZfJm+UzNfRuqFQPgn7k1BocoUF1hWtH6zzXyf1nsxPScJV
         VjLpanuLLNZj6ff3bpKSk+gvNOFOXjvgF+99cxCKinKhMAGe09mrLcWV5V60yoE+b7
         wapypQsCjygzhmEuThSy+Famze8EnfqcYwxdJ5m4=
Date:   Thu, 22 Aug 2019 19:29:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
Message-ID: <20190822135917.GP12733@vkoul-mobl.Dlink>
References: <20190819073947.17258-1-vkoul@kernel.org>
 <20190819073947.17258-3-vkoul@kernel.org>
 <20190820050829.GJ26807@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820050829.GJ26807@tuxbook-pro>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-19, 22:08, Bjorn Andersson wrote:
> On Mon 19 Aug 00:39 PDT 2019, Vinod Koul wrote:
> 
> > Convert the rpmh clock driver to use the new parent data scheme by
> > specifying the parent data for board clock.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/clk/qcom/clk-rpmh.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > index c3fd632af119..16d689e5bb3c 100644
> > --- a/drivers/clk/qcom/clk-rpmh.c
> > +++ b/drivers/clk/qcom/clk-rpmh.c
> > @@ -95,7 +95,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
> >  		.hw.init = &(struct clk_init_data){			\
> >  			.ops = &clk_rpmh_ops,				\
> >  			.name = #_name,					\
> > -			.parent_names = (const char *[]){ "xo_board" },	\
> > +			.parent_data =  &(const struct clk_parent_data){ \
> > +					.fw_name = "xo",		\
> > +					.name = "xo",		\
> 
> Shouldn't .name be "xo_board" to retain backwards compatibility?

Yes I have updated that

Thanks
-- 
~Vinod
