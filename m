Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55292CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4B820873
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572275236;
	bh=BxVgZAO9kEGOyZ/yQx8KCBKdXlmj3GYDK/1L7KJc+oo=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=cTihSXyBA78DUAa+Oe1WrTzhzJ01gyVDANT1W5/IUoKfbxMVJiwKjMcPc5FXTwTpl
	 xdqZdp6ovWrH8/W7MdNfmGTzGfz8p0Qq94DosAUCmy8AGUP061VkiCRIekIDtR2FlD
	 RB/87+QjRpPlZ6xRKoIfVpZx9Y507Knt3HlJq5yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbfJ1PHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfJ1PHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:07:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B76620873;
        Mon, 28 Oct 2019 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572275233;
        bh=BxVgZAO9kEGOyZ/yQx8KCBKdXlmj3GYDK/1L7KJc+oo=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=rNrXSAfNy4S2Yef4+ylitkwJDt4rdyQOFkiMRZiHv3ot72TsTITl6Shanpey+MgnH
         DvLHux9P7aWdAuHLCE+cLuK7XxVOrz6kP3oyugKUHh+02yXquB/RGT6FOxXciGbROj
         bZkRsVCTKK/845IJlrO87rsf2duVdQz3P0O3uf1M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191001182546.70090-1-john.stultz@linaro.org>
References: <20191001182546.70090-1-john.stultz@linaro.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Allison Randal <allison@lohutok.net>,
        linux-clk@vger.kernel.org, John Stultz <john.stultz@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: hi6220: use CLK_OF_DECLARE_DRIVER
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 28 Oct 2019 08:07:12 -0700
Message-Id: <20191028150713.5B76620873@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting John Stultz (2019-10-01 11:25:46)
> From: Peter Griffin <peter.griffin@linaro.org>
>=20
> As now we also need to probe in the reset driver as well.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/clk/hisilicon/clk-hi6220.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/c=
lk-hi6220.c
> index b2c5b6bbb1c1..63a94e1b6785 100644
> --- a/drivers/clk/hisilicon/clk-hi6220.c
> +++ b/drivers/clk/hisilicon/clk-hi6220.c
> @@ -86,7 +86,7 @@ static void __init hi6220_clk_ao_init(struct device_nod=
e *np)
>         hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
>                                 ARRAY_SIZE(hi6220_separated_gate_clks_ao)=
, clk_data_ao);
>  }
> -CLK_OF_DECLARE(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_i=
nit);
> +CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_c=
lk_ao_init);
> =20

I'll add a comment about the reset driver to the code. Otherwise,
applied to clk-next.
