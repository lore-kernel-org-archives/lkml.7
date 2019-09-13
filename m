Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1015CC4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 03:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D11208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 03:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568346144;
	bh=a4+pLs0HMpwthQVTXKUFl9IjvLrN/5bYwSFxfU5uDKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t7I963le2XmDihKQJxctESWwnkOEtcQUgQ8ZlONxYGFBllj316RXYPNcNcwpBlxCe
	 eKVaqOsa0JraME2E/Dxb9CqYLrcj+2EL4/Hm9+NPT0H9S237rGhmgFGGn/cn8+TixZ
	 xBnz0eerQtuDn3/ERdcfpf1mYobq/XpuOgyrc9Ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfIMDmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 23:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbfIMDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 23:42:23 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759EF20684;
        Fri, 13 Sep 2019 03:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568346143;
        bh=a4+pLs0HMpwthQVTXKUFl9IjvLrN/5bYwSFxfU5uDKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iTlc+yhvbhgGcqvpGhGuRb8jZA11MoghlvglMSEwsgxqcp05bmmYUKE/J82jv2Buq
         pkUX/gLzFxBDpIjNUXXObPjP/a7HDnHC26YmztmstpVsv6dzCD2EJ3XkWgwe1+vVFo
         gn5lk9BdxbneE1Q+HqWQtNKWa8WvzoHclgfl9gLk=
Date:   Fri, 13 Sep 2019 11:42:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Dong Aisheng <dongas86@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
Message-ID: <20190913034213.GH17142@dragon>
References: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
 <20190906172044.B99FB20838@mail.kernel.org>
 <CAA+hA=To9B0H1z6Hh1eSZN9_rcextT_Oe-CTMmz9fC9CDNUBTQ@mail.gmail.com>
 <DB3PR0402MB3916906683B58843B459ABE1F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3916906683B58843B459ABE1F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 02:47:59AM +0000, Anson Huang wrote:
> 
> 
> > On Sat, Sep 7, 2019 at 9:47 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Peng Fan (2019-08-27 01:17:50)
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > There is hardware issue that:
> > > > The output clock the LPCG cell will not turn back on as expected,
> > > > even though a read of the IPG registers in the LPCG indicates that
> > > > the clock should be enabled.
> > > >
> > > > The software workaround is to write twice to enable the LPCG clock
> > > > output.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > Does this need a Fixes tag?
> > 
> > Not sure as it's not code logic issue but a hardware bug.
> > And 4.19 LTS still have not this driver support.
> 
> Looks like there is an errata for this issue, and Ranjani just sent a patch for review internally,

Having errata number in both commit log and code comment is generally
helpful.

Shawn
