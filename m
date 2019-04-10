Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE79C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1AC20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554933610;
	bh=EUNMqByKjK+QIttPlTNdEbvE2O2+uFwFINYJBA43bhQ=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=AIcb9aUzdJWpPYU+EKGVZwQBR339Tzv/3qVCqZPZG4jGFmRJDyMhS7Rzz/FqJ8jhE
	 vJi7ux1xslagAyraMst4izUV/QwGXPHoEMDJqz1eZ8hF6I5yKj41YesI2hNqNqLrD7
	 ZDY0j1vxpDQxck02a3hsC5075jq2G/BsjI7Lt8Ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDJWAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJWAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:00:09 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839CD2082A;
        Wed, 10 Apr 2019 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554933608;
        bh=EUNMqByKjK+QIttPlTNdEbvE2O2+uFwFINYJBA43bhQ=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=0OqW8VX7CDNe5jiTwFbNIJ1I2j5gvP5yDmqXpmyBrP4MOVuM0tsL8vxmfpzBpfQjb
         WZbAFhYI1F0UYycaQ4V3yxYBDwdNjJmcU0d9sapgjTBtBeBJxeCljhhvqMjxRunr9h
         DUFZNP4x26O690C/776dpjncFxyBANGmn5i1csh0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAOMZO5DWpu9irOWR3rux-vV1sihfsDkTs5SJ7XXy8MgRBCd-Gw@mail.gmail.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com> <CAOMZO5DWpu9irOWR3rux-vV1sihfsDkTs5SJ7XXy8MgRBCd-Gw@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to clk_hw based API
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>, Fabio Estevam <festevam@gmail.com>
Message-ID: <155493360763.20095.6174028293897341109@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 10 Apr 2019 15:00:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabio Estevam (2019-03-22 09:24:54)
> Hi Abel,
>=20
> On Fri, Mar 22, 2019 at 12:37 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > This work is part of the effort of switching the entire imx clock drive=
rs
> > towards clk_hw based API. In order to do that, we have to keep the old
>=20
> Maybe I missed some earlier discussions on this topic, but let me ask
> a fundamental question first: what is the motivation for this API
> change?
>=20
> I could not find the reasoning inside the series.

The reasoning should be added to the series, but I would like to see clk
providers only deal with clk_hw structures and not with clk structures.
This clearly divides the line between clk consumers and clk providers so
that we know if clk providers are using the clk API themselves. That's
why I introduced clk_hw_register() in the first place.

