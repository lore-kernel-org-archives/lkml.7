Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD63EC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B04921743
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566013574;
	bh=Ceb8jDe4ZN3E1BKGFRkTVG7X9cSBE7uIXb55UYz9P6A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=DDQvlAs7Ai9By9sKeJ9+FvJ6BJ+hTn2OtdgiLGcr3Uc0CVAie5a9i38hpWt3siMJr
	 JqaF629g4QmZigi4M2lzzQcW77l17H2y83m4qArDOw8oF43+nLrgCYf3f9llZl5j9j
	 midcK20qgN7IWTtB3tjeX+n2ueQivxmsteZYLNM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHQDqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 23:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfHQDqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:46:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA7E21721;
        Sat, 17 Aug 2019 03:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566013572;
        bh=Ceb8jDe4ZN3E1BKGFRkTVG7X9cSBE7uIXb55UYz9P6A=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Tqozy/nZkkQ+GMDOJjYHBa/24QsMLHgpIYmpe3LiCwmEXw1zqncAgO+gPp0+TLwzv
         ehFP029agWLq9gcTwZmZ4bn3KhL6A7503G/GvgyuorMvJQexTtdCZw6PznaMPqREI2
         FumXZbiqz7ovopHiMVC6X9GOAOul+sF00e4UZUtw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190817033422.GB14652@Mani-XPS-13-9360>
References: <20190705151440.20844-1-manivannan.sadhasivam@linaro.org> <20190705151440.20844-2-manivannan.sadhasivam@linaro.org> <20190808050128.E3DA52186A@mail.kernel.org> <20190817033422.GB14652@Mani-XPS-13-9360>
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add Bitmain BM1880 SoC clock controller binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 20:46:11 -0700
Message-Id: <20190817034612.6DA7E21721@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-08-16 20:34:22)
> On Wed, Aug 07, 2019 at 10:01:28PM -0700, Stephen Boyd wrote:
> > Quoting Manivannan Sadhasivam (2019-07-05 08:14:36)
> > > +It is expected that it is defined using standard clock bindings as "=
osc".
> > > +
> > > +Example:=20
> > > +
> > > +        clk: clock-controller@800 {
> > > +                compatible =3D "bitmain,bm1880-clk";
> > > +                reg =3D <0xe8 0x0c>,<0x800 0xb0>;
> >=20
> > It looks weird still. What hardware module is this actually part of?
> > Some larger power manager block?
> >=20
>=20
> These are all part of the sysctrl block (clock + pinctrl + reset) and the
> register domains got split between system and pll.
>=20

And that can't be one node that probes the clk, pinctrl, and reset
drivers from C code?

