Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E122C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16382080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 22:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556835098;
	bh=2Npcycgwql1NQwXWHBSmcFCyRTuCpGuk4AWq0e9cSUI=;
	h=In-Reply-To:References:To:Cc:From:Subject:Date:List-ID:From;
	b=YWryMvh98eoaoVysYXtcR3q1y5+FCLWRuCbiyjm21JW8RkLN6FInZkN223lKn3V6e
	 QqtOlMD1XD3WkM3jBPg8CRNbR7U1G9n55J7N5y2YO382x81gvALjnrlQLH9QGnqc/R
	 CdMH9EuSGKlBm2siZ/eynC96WAfxOnJvIIV8/ol4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEBWLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 18:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfEBWLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 18:11:36 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9AB12080C;
        Thu,  2 May 2019 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556835095;
        bh=2Npcycgwql1NQwXWHBSmcFCyRTuCpGuk4AWq0e9cSUI=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=SqczSP24PSwwh51HipvMPIHWCAgkSQYRBX9iVLL0l3kbSCXTluWEQF/+H7gcMfnWg
         tlFI3LseEmvmcfVp1jpEQaMU3IR0vH8gGfmWFlAixbSnetJQRbFRd7O77kvP/LMX5L
         u2DAf3zOR5K3fNUtZMy4O0b9J4YmlpgMZ1Ie93Lw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430205055.25673-2-paul.walmsley@sifive.com>
References: <20190430205055.25673-1-paul.walmsley@sifive.com> <20190430205055.25673-2-paul.walmsley@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/2] clk: analogbits: add Wide-Range PLL library
Message-ID: <155683509491.200842.3659543106794259397@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 02 May 2019 15:11:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-04-30 13:50:58)
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

Applied to clk-next

