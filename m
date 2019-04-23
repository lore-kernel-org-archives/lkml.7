Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D7C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F41218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 21:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556056202;
	bh=J+YHi1IzD02f61Iuwqcb2kR1LgPXS8gmgs5XrI4Xuj8=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=Dbxc1ZoTAumTA/hU3nwDxWaFSr2f029nX0nIxGEewp+3LDDmWG72MyRR5OqCjtr38
	 A012rfx1Klx7WnHlv11m59qjmQyorF0BxucvmDfef76VKzBm3RpXV/W9GLqI6DgmVy
	 jxYIUgwk9ly+vTIOZvc1OJzb8VVe0JJ/7x2gSlk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfDWVuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 17:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfDWVuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 17:50:01 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CCF3218D2;
        Tue, 23 Apr 2019 21:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556056200;
        bh=J+YHi1IzD02f61Iuwqcb2kR1LgPXS8gmgs5XrI4Xuj8=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=X446voAG9HJWFqVCCpXoO3/SL6oUccLndgB8JOJUS7I/Q60Dv3ZTKu+l5P3Fx8/X2
         LFlROxrBQdby105FMx//8RxF2n2yvBVjP8SdsKr21v2FCGX54LtYInJfGVMKDpHfuP
         XVWaWXZ7gvToiszkfcVxUjjdACRvWYl5SYW8EVHM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <155493360763.20095.6174028293897341109@swboyd.mtv.corp.google.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com> <CAOMZO5DWpu9irOWR3rux-vV1sihfsDkTs5SJ7XXy8MgRBCd-Gw@mail.gmail.com> <155493360763.20095.6174028293897341109@swboyd.mtv.corp.google.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to clk_hw based API
To:     Abel Vesa <abel.vesa@nxp.com>, Fabio Estevam <festevam@gmail.com>
Message-ID: <155605619927.15276.90300312265075245@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 23 Apr 2019 14:49:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-10 15:00:07)
> Quoting Fabio Estevam (2019-03-22 09:24:54)
> > Hi Abel,
> >=20
> > On Fri, Mar 22, 2019 at 12:37 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> > >
> > > This work is part of the effort of switching the entire imx clock dri=
vers
> > > towards clk_hw based API. In order to do that, we have to keep the old
> >=20
> > Maybe I missed some earlier discussions on this topic, but let me ask
> > a fundamental question first: what is the motivation for this API
> > change?
> >=20
> > I could not find the reasoning inside the series.
>=20
> The reasoning should be added to the series, but I would like to see clk
> providers only deal with clk_hw structures and not with clk structures.
> This clearly divides the line between clk consumers and clk providers so
> that we know if clk providers are using the clk API themselves. That's
> why I introduced clk_hw_register() in the first place.
>=20

FYI, I'm dropping this from my review queue under the assumption it will
be sent again. Also, it would be nice to not have the wrappers at all in
the next series so that everything is clk_hw based instead of clk based.
Otherwise, it looks good to me and I'd like to see this work completed.
Thanks!

