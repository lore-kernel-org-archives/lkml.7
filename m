Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C4FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7BC218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897883;
	bh=R34pwDUDjO8Se0nDAvzs0GYjVuxUVhNdHGVyuJkeUBA=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=clEs0wj/LiuffsACVPip1mln5o05rOU8oBxt1iUr3WKtlFoEtFxkaRvQmqKxzikwN
	 wDaj+Y/zJknCrJ7jby0uhxmZzNnoPS/khLv8b04vSWoG7HTTlRdcWRCBCu8yrXVIaU
	 3BlKQXpOaqE6zTUa/YaAr6ildab0yrYVIOJfoOXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfC2WSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbfC2WSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:18:01 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723B4218A2;
        Fri, 29 Mar 2019 22:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553897880;
        bh=R34pwDUDjO8Se0nDAvzs0GYjVuxUVhNdHGVyuJkeUBA=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=N+/kEMSi+/ZJwR+oObY31YOkUzAsdfAzH/tbW6vi8lWSs0dz4Up/khi3EaPqfhMse
         Pqbj2xoHGQn417+aqu43iarGLEjCmfG16wxRk1il7OVR9fT3PsdrbGvH2SGe7iy6hW
         MXndbiTzNkf4galwQzCLBAYfkXyfKJ563Vl7gja4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1553350115-2614-1-git-send-email-qiaozhou@asrmicro.com>
References: <1553350115-2614-1-git-send-email-qiaozhou@asrmicro.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: asr: clock driver support for ASR AquilaC Soc
Cc:     Qiao Zhou <qiaozhou@asrmicro.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        qiaozhou <qiaozhou@asrmicro.com>
Message-ID: <155389787963.20095.9145169286940814698@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 29 Mar 2019 15:17:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting qiaozhou (2019-03-23 07:08:35)
> From: Qiao Zhou <qiaozhou@asrmicro.com>
>=20
> add clock driver support for ASR AquilaC SoC.
>=20
> We add clk-gate, clk-mix, and clk-pll drivers:
> 1. clk-gate driver is for regisers which have different enable/disable bi=
ts
> to control gating.
> 2. clk-mix driver is for registers which request to set div and mux
> bits at the same time.
> 3. clk-pll driver is for pll configuration.
>=20
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>

Please make this match your "From" line above.

> +
> +static void __init aquilac_clk_init(struct device_node *np)
> +{
> +       int ret;
> +       struct asr_clk_data *clock_data;
> +
> +       clock_data =3D kzalloc(sizeof(*clock_data), GFP_KERNEL);
> +       if (!clock_data)
> +               return;
> +
> +       ret =3D aquilac_clk_of_iomap(np, clock_data);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret =3D asr_clk_init(np, &clock_data->unit, ASR_NR_CLKS);
> +       if (ret < 0)
> +               goto out;
> +
> +       aquilac_general_clk_init(clock_data);
> +
> +       aquilac_pll_init(clock_data);
> +
> +       aquilac_mix_clk_init(clock_data);
> +
> +       aquilac_periph_clk_init(clock_data);
> +
> +       asr_clks_enable((const char **)keep_on_clocks_tbl, ARRAY_SIZE(kee=
p_on_clocks_tbl));
> +
> +       return;
> +out:
> +       kfree(clock_data);
> +}
> +CLK_OF_DECLARE(aquilac_clk, "asr,8751c-clock", aquilac_clk_init);

Any reason this can't be a platform driver?

> diff --git a/drivers/clk/asr/clk-gate.c b/drivers/clk/asr/clk-gate.c
> new file mode 100644
> index 0000000..4ba5587
> --- /dev/null
> +++ b/drivers/clk/asr/clk-gate.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * asr gate clock operation source file
> + *
> + * Copyright (C) 2019 ASR Microelectronics(Shanghai) Co., Ltd.
> + * Gang Wu <gangwu@asrmicro.com>
> + * Qiao Zhou <qiaozhou@asrmicro.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.

Please only have the SPDX tag and not this above paragraph.

> + */
> +

I'm not going to review anymore as I'll wait for a resend for Dan's
comments.

