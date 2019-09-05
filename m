Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A15EC00306
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FB320828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567709767;
	bh=KMCg4BnWWE/5WYxMle5+q+OVPUFJUnN8yGfxlfY02Sk=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=oPJLXIVLQbfnTiHet5QSGIXB7CPxnWAGPuUObXlRFQb7dkgBFmpcqowhWJYKmSEao
	 E0nQPDkOEwcfmAeEUTvc5xkcQQ7LZAgnO/+i+TKuZkqE2ajE9IwNnGykqU3Toc2NbD
	 OS1E/hDVcgsaJdZuCCltp3324sA+zv9fcYWDIHZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfIES4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfIES4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:56:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9203A206BA;
        Thu,  5 Sep 2019 18:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567709765;
        bh=KMCg4BnWWE/5WYxMle5+q+OVPUFJUnN8yGfxlfY02Sk=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=IlowzJdJmOcAs6mWH/op88mTjNUcbnSETmgyVsDNE23bZIDo3c3f32+znlVqH4Coh
         J0Vt+e99G49iLLZd/KtYgeCxi9PvYc/w1uZoihrpH2el+xvTa8Yf64ixBms+zDIRxj
         Y0kO1Kz/BL6qPLZDx3y8LQhtWaPdcOxMVnMXb8hk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190821122436.k3s7srhraphfnvgp@flea>
References: <20190820032311.6506-1-samuel@sholland.org> <20190820032311.6506-3-samuel@sholland.org> <20190820071142.2bgfsnt75xfeyusp@flea> <3b67534a-eb1b-c1e8-b5e8-e0a74ae85792@sholland.org> <20190821122436.k3s7srhraphfnvgp@flea>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 02/10] clk: sunxi-ng: Mark AR100 clocks as critical
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Samuel Holland <samuel@sholland.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 11:56:03 -0700
Message-Id: <20190905185605.9203A206BA@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2019-08-21 05:24:36)
> On Tue, Aug 20, 2019 at 08:02:55AM -0500, Samuel Holland wrote:
> > On 8/20/19 2:11 AM, Maxime Ripard wrote:
> > > So I'm not really sure that we should do it statically this way, and
> > > that we should do it at all.
> >
> > Do you have a better way to model "firmware uses this clock behind the =
scenes,
> > so Linux please don't touch it"? It's unfortunate that we have Linux and
> > firmware fighting over the R_CCU, but since we didn't have firmware (e.=
g. SCPI
> > clocks) in the beginning, it's where we are today.
> >
> > The AR100 clock doesn't actually have a gate, and it generally has depe=
ndencies
> > like R_INTC in use. So as I mentioned in the commit message, the clock =
will
> > normally be on anyway. The goal was to model the fact that there are us=
ers of
> > this clock that Linux doesn't/can't know about.
>=20
> Like I said, if that's an option, I'd prefer to have protected-clocks
> work for everyone / for sunxi.
>=20

Yes. Use protected-clocks to indicate what shouldn't be touched by the
kernel. It's not super easy to make it "generic" right now, but I
suppose we can work the flag into the core framework more so that we
still register the clks but otherwise make the 'clk_get()' operation
fail on them somehow and the disable unused operation skip them. I just
took the easy way out for qcom for the time being and didn't register
them from the driver.

