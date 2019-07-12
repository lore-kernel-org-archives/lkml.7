Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDB0C742D6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D64205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562954013;
	bh=ONPzdVHMIvpPolwKBGo1Y6DqMR7K8PMrIb8PTJIfEbs=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=zofyHI5Ysv0TwZk3o+FdzCjQf/LV488iY/8XgNFHbMKV1bsqEEo0sN3cmYtEKdpsm
	 8Yux6BlGGdd8N5yUsH+6xFLUJGYxcE4uYFdIlLKdws42Wu3otxRmU8ygqRmeKNwPMC
	 Wr9JPkpPUVBHVce1b70QtnwyGWAyxiLIo4t0US48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfGLRxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfGLRxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:53:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC5E2054F;
        Fri, 12 Jul 2019 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562954011;
        bh=ONPzdVHMIvpPolwKBGo1Y6DqMR7K8PMrIb8PTJIfEbs=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=OcYdDGI7OlrM5FG9m7dDxn2LvXBPD5GoNw3OLQENTi6ufmgPWi43NEDY3pLt5Wd62
         a6n7xt/slE8vIrDW+vybclyC4wXbcYqpyMUx2CPa8FtbIiDMkTqxOpsmumwK//2w5I
         bWq1W+RrA1kpEa+6/OTl79Oln1OFMpuyZLfD6Kcg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190702120350.7029b623@canb.auug.org.au>
References: <20190702100103.12c132da@canb.auug.org.au> <20190702111455.4ef3494f@canb.auug.org.au> <20190702120350.7029b623@canb.auug.org.au>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the clk tree
User-Agent: alot/0.8.1
Date:   Fri, 12 Jul 2019 10:53:30 -0700
Message-Id: <20190712175331.5EC5E2054F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2019-07-01 19:03:50)
> Hi all,
>=20
> On Tue, 2 Jul 2019 11:14:55 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > On Tue, 2 Jul 2019 10:01:03 +1000 Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote:
> > >=20
> > > We need something like this (untested): =20
> >=20
> > simple testing shows build errors ... we need something better.
>=20
> This at least passes my (few) build tests (this will be in linux-next
> today):
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 2 Jul 2019 11:53:07 +1000
> Subject: [PATCH] clk: consoldiate the __clk_get_hw() declarations
>=20
> Without this we were getting errors like:
>=20
> In file included from drivers/clk/clkdev.c:22:0:
> drivers/clk/clk.h:36:23: error: static declaration of '__clk_get_hw' foll=
ows non-static declaration
> include/linux/clk-provider.h:808:16: note: previous declaration of '__clk=
_get_hw' was here
>=20
> Fixes: 59fcdce425b7 ("clk: Remove ifdef for COMMON_CLK in clk-provider.h")
> fixes: 73e0e496afda ("clkdev: Always allocate a struct clk and call __clk=
_get() w/ CCF")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for fixing this. I didn't run all the configs it seems.

I'll pull this into the clk pile now.

