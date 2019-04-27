Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF04C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDE62087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556326917;
	bh=w7xtzG77bIQLj4EH5p8XHdnkslc2MaHBi4pBdgv/a/8=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=z/iP5h4ASpmHSlZr03OfJOIv2SpZ5YNxHl6aBkaB/gDZC8QIzF+QR6ZUFuhlkOK5f
	 oIctN4mCXIZdZGt4mQrXjuL5GEu78JO6MdcAQWlL6cbw/xxRD7zxCTmDFQgCvjoG2u
	 RaqBq7yH02wan2IAPc6Jmy9oumzQ/yc1YMe7QzCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfD0BBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:01:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfD0BBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:01:52 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEA020873;
        Sat, 27 Apr 2019 01:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556326912;
        bh=w7xtzG77bIQLj4EH5p8XHdnkslc2MaHBi4pBdgv/a/8=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=yesemrRi5X8RA3qSogY0wR6IFNjsCuGDf94v+yi87TNw8NANAtH5SyyTyyza35Wci
         KMu3bYH7HVPRzyCL0CiyD5manlKpF5+mnOZoQkSC5dAkls3RyulJUOnANgv0mbkPsF
         7PYeN9bu0hlAknmYFA7R2QisNwcHeOH0e7f4VqPQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190411082733.3736-2-paul.walmsley@sifive.com>
References: <20190411082733.3736-2-paul.walmsley@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/3] clk: analogbits: add Wide-Range PLL library
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Megan Wachs <megan@sifive.com>
Message-ID: <155632691100.168659.14460051101205812433@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 26 Apr 2019 18:01:51 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-11 01:27:32)
> Add common library code for the Analog Bits Wide-Range PLL (WRPLL) IP
> block, as implemented in TSMC CLN28HPC.
>=20
> There is no bus interface or register target associated with this PLL.
> This library is intended to be used by drivers for IP blocks that
> expose registers connected to the PLL configuration and status
> signals.
>=20
> Based on code originally written by Wesley Terpstra
> <wesley@sifive.com>:
> https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d22=
1b2ee56bb60
>=20
> This version incorporates several changes requested by Stephen
> Boyd <sboyd@kernel.org>.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

I haven't deeply reviewed at all, but I already get two problems when
compile testing these patches. I can fix them up if nothing else needs
fixing.

drivers/clk/analogbits/wrpll-cln28hpc.c:165 __wrpll_calc_divq() warn: shoul=
d 'target_rate << divq' be a 64 bit type?
drivers/clk/sifive/fu540-prci.c:214:16: error: return expression in void fu=
nction

