Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99B9C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805B920709
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 03:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577156452;
	bh=NrKmP/pKKzrTVnxrhbEWGh9BtAtGRur1ikxSIvLahO0=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=HnP28Qb3IRSszXTdnENB0Mm7zS1Q6kHRQ7Sj06uj2u0FnjiCLfQq/fKhue/t0Em+w
	 HPFNLR0f4rniv1DQtrW39KLzBSo5H2dzmA0O9sFeWxxjQm4V6W2IAyayBpzkClV5XW
	 pIrlCuQzHZl1UuXAyHxAB9UR9LLOAkM13jYqGkLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfLXDAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 22:00:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfLXDAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 22:00:51 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E95206B7;
        Tue, 24 Dec 2019 03:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577156450;
        bh=NrKmP/pKKzrTVnxrhbEWGh9BtAtGRur1ikxSIvLahO0=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=VGU+Ae1VYFR7rN1bJsc/luGIK3SXHLp6ZoPSZD4nT9/GbrMtVMfviFP6VQqDvHZD8
         lLY6FAuvA/yxQ1IgSL3UQJYeW5eyE797t6dcIPoWJYoENHGeT7dQeOhsutTCy6IXdS
         SeqhIhwrTxiXB2GS45+1EllIubuIun6RVbdyiGJ0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191219181914.6015-1-info@metux.net>
References: <20191219181914.6015-1-info@metux.net>
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: clk: make gpio-gated clock support optional
User-Agent: alot/0.8.1
Date:   Mon, 23 Dec 2019 19:00:49 -0800
Message-Id: <20191224030050.59E95206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enrico Weigelt, metux IT consult (2019-12-19 10:19:14)
> The gpio-gate-clock / gpio-mux-clock driver isn't used much,
> just by a few ARM SoCs, so there's no need to always include
> it unconditionally.
>=20
> Thus make it optional, but keep it enabled by default.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/clk/Kconfig  | 7 +++++++
>  drivers/clk/Makefile | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 45653a0e6ecd..880f89c46f6f 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -23,6 +23,13 @@ config COMMON_CLK
>  menu "Common Clock Framework"
>         depends on COMMON_CLK
> =20
> +config COMMON_CLK_GPIO
> +       tristate "GPIO gated clock support"
> +       default y

Maybe make it depend on GPIOLIB and default to that too?

Otherwise sounds OK to me.

