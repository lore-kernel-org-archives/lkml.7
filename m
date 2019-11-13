Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581CBC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AC4206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573683332;
	bh=CoxUo/aSepDBO7izp9qrDJUrGpD/En80chyDGPOhMV0=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=CN6wyACyre3TmnFfM5Y9wjUGy3+8XxRaeDmbP5i5LWPz6S4Evjhxnr5ivP7aCfl8w
	 T/SRh2JziCx91BVGz5fOoSls1bN3/Pyl8gSHasPKXHPp02ziznrT1jokmABE378AzE
	 4uCzBktq/LMrphLvMjLNYBR429IVkgNrZrxOa06s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKMWPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:15:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfKMWPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:15:30 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CAD9206E3;
        Wed, 13 Nov 2019 22:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573683330;
        bh=CoxUo/aSepDBO7izp9qrDJUrGpD/En80chyDGPOhMV0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=ntlvFKWnLpHku9jHgRoJH4W5VoSQD0haBcfRADrXRuOXVDhDhoYY5H7aZFLkmFMNp
         gf+lIRnxVJbdsyZkEdW+9mJcbWOrKAPubzNP+ll1w+Ac0HmwWDMd7w/klUgoD1IU+4
         wJDt0ef0I6Yzu6Y/XPgImpAeBs6I/4E0A7osNS8A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191025111338.27324-2-chunyan.zhang@unisoc.com>
References: <20191025111338.27324-1-chunyan.zhang@unisoc.com> <20191025111338.27324-2-chunyan.zhang@unisoc.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Xiaolong Zhang <xiaolong.zhang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/5] clk: sprd: add gate for pll clocks
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 14:15:28 -0800
Message-Id: <20191113221530.5CAD9206E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2019-10-25 04:13:34)
> diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
> index f59d1936b412..d8b480f852f3 100644
> --- a/drivers/clk/sprd/gate.c
> +++ b/drivers/clk/sprd/gate.c
> @@ -109,3 +120,11 @@ const struct clk_ops sprd_sc_gate_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(sprd_sc_gate_ops);
> =20
> +#define sprd_pll_sc_gate_unprepare sprd_sc_gate_disable

Why is there a redefine? Just use the function where it is.

> +
> +const struct clk_ops sprd_pll_sc_gate_ops =3D {
> +       .unprepare      =3D sprd_pll_sc_gate_unprepare,
> +       .prepare        =3D sprd_pll_sc_gate_prepare,
> +       .is_enabled     =3D sprd_gate_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(sprd_pll_sc_gate_ops);
> diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
> index dc352ea55e1f..598ce607ca0a 100644
> --- a/drivers/clk/sprd/gate.h
> +++ b/drivers/clk/sprd/gate.h
> @@ -14,16 +14,19 @@ struct sprd_gate {
>         u32                     enable_mask;
>         u16                     flags;
>         u16                     sc_offset;
> +       u32                     udelay;

Does the delay need to be 32 bits wide? Maybe a u8 or u16 will work?
Otherwise, make it an unsigned long please because the bit width doesn't
matter.

