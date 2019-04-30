Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9810C04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F2D21734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556648914;
	bh=VOpMYJ8YhRchYdHgIx28TYVxElAUvAnFpns/Y7xKLVw=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=amWAYV/hz7RR0o6g94FX+0QGDFzLcQYNZxaKnjf0gOovLiEzj3pF85JsTUZpmmOAP
	 hV/Ksx+Y9ykCfvyjsF03g9c6f2vM1BWbcwTUC4LQh9esQwe4DSlOprxLHJ5fBW6sBH
	 LDOfV+ka+oFPL5y2pqAHMIYTJ2vfn79AP5I5o4G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfD3S2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbfD3S2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:28:33 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F69020835;
        Tue, 30 Apr 2019 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556648912;
        bh=VOpMYJ8YhRchYdHgIx28TYVxElAUvAnFpns/Y7xKLVw=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=sdO0p9JiF4MxxzNhCblMxxMMaU9fwVgAAXXDhxWvCmIpYdAtV0MHbnGajyxJcT9H7
         9vFbrVwWsq8N0q4ABTiniBbOGo4XUY+WXwF8RSmTQKGOYpBo3O83KhUHeI7Mkjzms9
         //vzqhOVUPYiq2iDPvmpNZgQEgX/bpVFqGv57pAA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alpine.DEB.2.21.9999.1904292252120.7063@viisi.sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <155632691100.168659.14460051101205812433@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904262031510.10713@viisi.sifive.com> <alpine.DEB.2.21.9999.1904291141340.7063@viisi.sifive.com> <155657878993.168659.6676692672888882237@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904292252120.7063@viisi.sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/3] clk: analogbits: add Wide-Range PLL library
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>
Message-ID: <155664891171.168659.10903540623861208390@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 30 Apr 2019 11:28:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-29 22:57:15)
> On Mon, 29 Apr 2019, Stephen Boyd wrote:
>=20
> > Quoting Paul Walmsley (2019-04-29 12:42:07)
> > > On Fri, 26 Apr 2019, Paul Walmsley wrote:
> > > > On Fri, 26 Apr 2019, Stephen Boyd wrote:
> > > >=20
> > > > > Quoting Paul Walmsley (2019-04-11 01:27:32)
> > > > > > Add common library code for the Analog Bits Wide-Range PLL (WRP=
LL) IP
> > > > > > block, as implemented in TSMC CLN28HPC.
> > > > >=20
> > > > > I haven't deeply reviewed at all, but I already get two problems =
when
> > > > > compile testing these patches. I can fix them up if nothing else =
needs
> > > > > fixing.
> > > > >=20
> > > > > drivers/clk/analogbits/wrpll-cln28hpc.c:165 __wrpll_calc_divq() w=
arn: should 'target_rate << divq' be a 64 bit type?
> > > > > drivers/clk/sifive/fu540-prci.c:214:16: error: return expression =
in void function
> > > >=20
> > > > Hmm, that's odd.  I will definitely take a look and repost.
> > >=20
> > > I'm not able to reproduce these problems.  The configs tried here wer=
e:
> > >=20
> > > - 64-bit RISC-V defconfig w/ PRCI driver enabled (gcc 8.2.0 built wit=
h=20
> > >   crosstool-NG 1.24.0)
> > >=20
> > > - 32-bit ARM defconfig w/ PRCI driver enabled (gcc 8.3.0 built with=20
> > >   crosstool-NG 1.24.0)
> > >=20
> > > - 32-bit i386 defconfig w/ PRCI driver enabled (gcc=20
> > >   5.4.0-6ubuntu1~16.04.11)
> > >=20
> > > Could you post the toolchain and kernel config you're using?
> > >=20
> >=20
> > I'm running sparse and smatch too.
>=20
> OK.  I was able to reproduce the __wrpll_calc_divq() warning.  It's been =

> resolved in the upcoming revision. =20
>=20
> But I don't see the second error with either sparse or smatch.  (This is =

> with sparse at commit 2b96cd804dc7 and smatch at commit f0092daff69d.)
>=20

Weird! The return in void function is pretty obvious though so please
fix it regardless.

