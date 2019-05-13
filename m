Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CCC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DF420873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557778943;
	bh=rUumpDM3UecrwQ7TBHU63Q7wVdRFdbY9R6pHgI3XXUU=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=kVXi/uJdituFoqsmL1jaDQooi0BcmY7lvX1Hz960lvWuSKP3zV7wqhJ/vntyaLQJb
	 6YvdbuQY5JZk5mWwf5g0ZSIi9rNFJjz81VgwAH/UJT8Ul1/5GEI5FbAzrzRW1bHRf/
	 3juMdNNisHy+XZUwxen7MvkWUOamgHwDTdK7GvvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfEMUWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEMUWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:22:22 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A03F20862;
        Mon, 13 May 2019 20:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557778941;
        bh=rUumpDM3UecrwQ7TBHU63Q7wVdRFdbY9R6pHgI3XXUU=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=eWOcVhl7rhA8P+caYmgE348aRGNcCsgXWD4IWR9sejbueLJYMZW+Ge/7VqKgP81O+
         34n12gx0kewuLnKO84a00k3U3iVXBCezrOPsWdkPt6ljwtxHoi5DuWkwLZNxXaFK9n
         ozBcif5H1L+1jNZzB87yhgwjYRCRLrUMgDn6ZZHY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190513200758.15241-1-paul.walmsley@sifive.com>
References: <20190513200758.15241-1-paul.walmsley@sifive.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: sifive: restrict Kconfig scope for the FU540 PRCI driver
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>, mturquette@baylibre.com,
        pavel@ucw.cz
Message-ID: <155777894054.14659.13824195555713805550@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 13 May 2019 13:22:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-05-13 13:07:58)
> Restrict Kconfig scope for SiFive clock and reset IP block drivers
> such that they won't appear on most configurations that are unlikely
> to support them.  This is based on a suggestion from Pavel Machek
> <pavel@ucw.cz>.  Ideally this should be dependent on
> CONFIG_ARCH_SIFIVE, but since that Kconfig directive does not yet
> exist, add dependencies on RISCV or COMPILE_TEST for now.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>

Reported-by?

> ---
>  drivers/clk/sifive/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
> index 8db4a3eb4782..27a8fe531357 100644
> --- a/drivers/clk/sifive/Kconfig
> +++ b/drivers/clk/sifive/Kconfig
> @@ -2,6 +2,7 @@
> =20
>  menuconfig CLK_SIFIVE
>         bool "SiFive SoC driver support"
> +       depends on RISCV || COMPILE_TEST
>         help
>           SoC drivers for SiFive Linux-capable SoCs.
> =20
> @@ -10,6 +11,7 @@ if CLK_SIFIVE
>  config CLK_SIFIVE_FU540_PRCI
>         bool "PRCI driver for SiFive FU540 SoCs"
>         select CLK_ANALOGBITS_WRPLL_CLN28HPC
> +       depends on RISCV || COMPILE_TEST

This isn't needed? The config already implicitly depends on CLK_SIFIVE
which depends on RISCV || COMPILE_TEST. This line should be removed.

