Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A7CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287BD2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556835101;
	bh=YE/dc/fbqSnsUBzu9pKS5Er4/+4KslyKlrQjkn6EK20=;
	h=In-Reply-To:References:To:Cc:From:Subject:Date:List-ID:From;
	b=H+wjLiO8mnGvMfkOFNsNtRqGAgzSHPbwWDl546Hm3n6aVXemRECKgpmdS0oLYpdnL
	 ZxxuLOAVt3xASKMr6TpvaUa0TFTuVvEocTI6/sdx/N+27Ze6p9phe/TG2u4VPzJzja
	 jMJZbKZZUNctE/nyOKL9KXE7BINccVdYft4cFziI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEBWLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfEBWLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:11:39 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E652080C;
        Thu,  2 May 2019 22:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556835098;
        bh=YE/dc/fbqSnsUBzu9pKS5Er4/+4KslyKlrQjkn6EK20=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=twrMDF/5I3O4hSsKWXOGEE/q2vs6/Svlyb5/LFsXPBqyyHFop4Kot60KTa18xfDyh
         XAst1BemLDx0ICPsyX6gW7u7aRdATGtFIRXWMtgMf6PzOFEBqJMQ5RjOQxvHQQs9Va
         bfQNjwUsDrTw15NUc7BTa87zy8WHakHlLkffoYVQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430205055.25673-3-paul.walmsley@sifive.com>
References: <20190430205055.25673-1-paul.walmsley@sifive.com> <20190430205055.25673-3-paul.walmsley@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 2/2] clk: sifive: add a driver for the SiFive FU540 PRCI IP block
Message-ID: <155683509781.200842.728012475637311820@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 02 May 2019 15:11:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-30 13:51:00)
> Add driver code for the SiFive FU540 PRCI IP block.  This IP block
> handles reset and clock control for the SiFive FU540 device and
> implements SoC-level clock tree controls and dividers.
>=20
> Based on code written by Wesley Terpstra <wesley@sifive.com>:
> https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d22=
1b2ee56bb60
>=20
> Boot and PLL rate change were tested on a SiFive HiFive Unleashed
> board.
>=20
> This version includes several changes requested by Stephen Boyd
> <sboyd@kernel.org>.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Wesley W. Terpstra <wesley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> ---

Applied to clk-next

