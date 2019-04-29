Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB642C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD2D2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556578792;
	bh=meRJth1M+kiJPxxgh3MIc+0JTa73UcNp4kMSvaernzI=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=rfKJAfexrkHgtfQNk0iGhKtpdHFMUiEqcTu8IlTKtXgBz1EJAzu2aqUxTxMm93yC4
	 2Bvd8C9BOMjpvyevTuf19tneJa+Kgcz9LNnMt5ryE2nVW8oUdI9trlpefIPmIdZmw/
	 Sdj9zw07kPa5cnTemKARyTnu0q+242xRUAehsfLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfD2W7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfD2W7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:59:51 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14FD2075E;
        Mon, 29 Apr 2019 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556578790;
        bh=meRJth1M+kiJPxxgh3MIc+0JTa73UcNp4kMSvaernzI=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=mQrWCbilGLcMz3ad21W/e5Nvwt9M4j93gDLvZx7ESiUWTOtj+WHaGoOcXY17uAbLB
         Fh94YvstIJydqRddm7wr2f/8N1uhi1A2dMr7BlahyqxjmoVpWG+AJKR3UPN48cRSLx
         5+ny+loJyCvtwx4YI1cbV1EpS0NJHAtDh5jqHqyc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <alpine.DEB.2.21.9999.1904291141340.7063@viisi.sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com> <155632691100.168659.14460051101205812433@swboyd.mtv.corp.google.com> <alpine.DEB.2.21.9999.1904262031510.10713@viisi.sifive.com> <alpine.DEB.2.21.9999.1904291141340.7063@viisi.sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/3] clk: analogbits: add Wide-Range PLL library
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>
Message-ID: <155657878993.168659.6676692672888882237@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 15:59:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-29 12:42:07)
> Hi Stephen,
>=20
> On Fri, 26 Apr 2019, Paul Walmsley wrote:
>=20
> > On Fri, 26 Apr 2019, Stephen Boyd wrote:
> >=20
> > > Quoting Paul Walmsley (2019-04-11 01:27:32)
> > > > Add common library code for the Analog Bits Wide-Range PLL (WRPLL) =
IP
> > > > block, as implemented in TSMC CLN28HPC.
> > >=20
> > > I haven't deeply reviewed at all, but I already get two problems when
> > > compile testing these patches. I can fix them up if nothing else needs
> > > fixing.
> > >=20
> > > drivers/clk/analogbits/wrpll-cln28hpc.c:165 __wrpll_calc_divq() warn:=
 should 'target_rate << divq' be a 64 bit type?
> > > drivers/clk/sifive/fu540-prci.c:214:16: error: return expression in v=
oid function
> >=20
> > Hmm, that's odd.  I will definitely take a look and repost.
>=20
> I'm not able to reproduce these problems.  The configs tried here were:
>=20
> - 64-bit RISC-V defconfig w/ PRCI driver enabled (gcc 8.2.0 built with=20
>   crosstool-NG 1.24.0)
>=20
> - 32-bit ARM defconfig w/ PRCI driver enabled (gcc 8.3.0 built with=20
>   crosstool-NG 1.24.0)
>=20
> - 32-bit i386 defconfig w/ PRCI driver enabled (gcc=20
>   5.4.0-6ubuntu1~16.04.11)
>=20
> Could you post the toolchain and kernel config you're using?
>=20

I'm running sparse and smatch too.

