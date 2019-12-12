Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC4C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486092173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 21:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576187476;
	bh=wJ/XZ7pA6ovLz41DrcE1XnfC1dmO8L0R7vqGMT5CLKk=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=udIUzajrRlmLBRoB62vhm20TAocohdImmVU+N/eLUQ6ObM27rMP7lv+qNkajlCm4C
	 rU+TtbSoWsECk5Kgm1WsF8BA+8JCEmkYBaOAHuoB6me1mgSM6hicd9jy5a5I3bM9IG
	 /6ShZuSDRiqYF8c+ShX46gSLZs4uXgxPjWXsvVQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731182AbfLLVvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 16:51:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730784AbfLLVvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 16:51:14 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F84B21556;
        Thu, 12 Dec 2019 21:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576187474;
        bh=wJ/XZ7pA6ovLz41DrcE1XnfC1dmO8L0R7vqGMT5CLKk=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=mesjzGzJm9XI01CAns4XKRHZ/SLhUS2nfBmTrtlog7AV1EvUH6BsFhokcREU94kX+
         NZiMWmXqsAUPSXCFA5WJb2/KKOQrROsYOrFwlY2FhxT+7m0wfHWiR1Z2DU+E6wueZh
         y+08cV8Cbk3f13MuTCtqd+tekYmCf0j6AJK65JNo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <741ff2c5-56b3-5ba0-3d52-39f77d468739@metux.net>
References: <871rtae1m5.wl-kuninori.morimoto.gx@renesas.com> <741ff2c5-56b3-5ba0-3d52-39f77d468739@metux.net>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: CONFIG_COMMON_CLK vs CONFIG_HAVE_CLK
User-Agent: alot/0.8.1
Date:   Thu, 12 Dec 2019 13:51:13 -0800
Message-Id: <20191212215114.1F84B21556@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enrico Weigelt, metux IT consult (2019-12-12 02:57:14)
> On 12.12.19 03:09, Kuninori Morimoto wrote:
>=20
> > I noticed that there are some CONFIG_HAVE_CLK vs CONFIG_COMMON_CLK mism=
atch.
> > Because of it, I got compile error at clk_set_min_rate() on SH.
> > SH will have HAVE_CLK, but doesn't have COMMON_CLK.
> >=20
> >       > ARCH=3Dsh make allyesconfig
> >       > make
> >       ...
> >       drivers/devfreq/tegra30-devfreq.o: In function `tegra_devfreq_tar=
get':
> >       tegra30-devfreq.c:(.text+0x368): undefined reference to `clk_set_=
min_rate'
> >=20
> > clk_set_min_rate() is under HAVE_CLK at clk.h
> >=20
> >       --- clk.h ---
> > =3D>    #ifdef CONFIG_HAVE_CLK
> >       ...
> >       int clk_set_min_rate(struct clk *clk, unsigned long rate);
> >       ...
> >       #else /* !CONFIG_HAVE_CLK */
> >       static inline int clk_set_min_rate(struct clk *clk, unsigned long=
 rate)
> >       ...
> >       -------------
> >=20
> > It is implemented at clk.c.
> > But it will be compiled via COMMON_CLK
> >=20
> >       --- Makefile ---
> >       ...
> > =3D>    obj-$(CONFIG_COMMON_CLK)        +=3D clk.o
>=20
> You've got CONFIG_HAVE_CLK enabled, but CONFIG_COMMON_CLK disabled ?
>=20
> hmm, the whole CONFIG_HAVE_CLK looks a bit weird to me. I wonder what's
> the actual purpose of having this arch-specific.
>=20
> IMHO, we should sort out whether there are some things that some arch
> really *needs*, and what could be optional - then split that into
> separate modules along this line.
>=20
> It seems that clk_set_min_rate() belongs to CONFIG_COMMON_CLK, and
> tegra30-devfreq.c needds to depend on CONFIG_COMMON_CLK.
>=20

Years ago there wasn't a common clk framework. Just CONFIG_HAVE_CLK and
architectures implementing the API defined in the clk.h header file.
Then the common clk framework was created and we got CONFIG_COMMON_CLK.
When new clk API features are added to the common clk framework, we
typically limit their implementation and scope to CONFIG_COMMON_CLK so
that architectures are encouraged to migrate to the common clk
framework. I'm not really tracking the other implementations of the clk
API, but I thought we were down to a handful of implementations that
haven't migrated. I suppose SH is one of the big ones.

