Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5042086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566215963;
	bh=BlF5eyN8+BYQuNaKgdgBAcb8evFPpg8cxRjy3CPmiRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yGWYqrlHlMifGjrcILP9wZZwN3pe2jCA0zZ04gXqpn3O3uI3IPpk8E3qGwMh8ownQ
	 NkRzwtcmdseYNx1Ruy/voOAWwiCczw8N1sp58toBkOQOom3Q3O0ypAb/+73eN4akxy
	 1cqjbIkyN0/PQtC1peOK5cFCJQkNBxhDXVMUHh2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHSL7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfHSL7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:59:21 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEDF12085A;
        Mon, 19 Aug 2019 11:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566215960;
        bh=BlF5eyN8+BYQuNaKgdgBAcb8evFPpg8cxRjy3CPmiRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/S1qpYiSKTHfHFnyA5YvjHA45F9f9gS2wu4MxcxIXVBMokQT2MskhpPwU0eBohhZ
         k2iJWiPJx/Rr9D4SsqUjBQwwGBgE/kU+WIFNI9kOWvU46yG9z+N2PbbwhnGUDzICzK
         TB+W5XK0hC8wxg01tmpoCqFv6au/KqzISkPbUiBM=
Date:   Mon, 19 Aug 2019 13:59:09 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx8mn: fix int pll clk gate
Message-ID: <20190819115907.GB5999@X250>
References: <20190814015312.11711-1-peng.fan@nxp.com>
 <20190816180246.D37BD20665@mail.kernel.org>
 <AM0PR04MB4481D73817CFCB7491DE89CB88A80@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481D73817CFCB7491DE89CB88A80@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 01:05:42AM +0000, Peng Fan wrote:
> Hi Stephen,
> 
> > Subject: Re: [PATCH] clk: imx8mn: fix int pll clk gate
> > 
> > Quoting peng.fan@nxp.com (2019-08-13 18:53:12)
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > To Frac pll, the gate shift is 13, however to Int PLL the gate shift
> > > is 11.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > > ---
> > 
> > This is a fix for a change in -next. Why is stable Cced?
> 
> Sorry, that was added by mistaken. Should I resend v2 to drop it?

Applied with both stable and Fixes tag dropped, as the commit ID is
unstable before it lands on mainline.

Shawn
