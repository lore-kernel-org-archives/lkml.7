Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C1AC46495
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104432184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 01:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BcqlkG8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGEBYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 21:24:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41357 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfGEBYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 21:24:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fxvx15YQz9sND;
        Fri,  5 Jul 2019 11:24:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562289869;
        bh=4bgrb582kH0+3Ea497TRX+KVASI61SRUslWR4D3Raj8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BcqlkG8xdGCqP5+rr4sXG9T5yqPGtCWCgN/I1kxl+HbmrAIvUHwf2syuESch0pwST
         aC0rF5jTWffwwRTGXr/oQk2hWZCRyPYpFrWgPvXs6se+x+p/7vqcCCPu3kQK5yqE8i
         bknn46BuLWVKly9vo/XJWQHxTs26Q2ui+CdHWOVojHOOdLGOg3S+7P0LYKqhYI3z7Z
         wmVy98ijWfZnVoJ4i/zkqCIJriiwL0+NK6m583YiO8VvmNmZDk9vpVum7VjFvyB5W8
         Hq0VqV6bIqMg8MSB9FJ1edC6xGws/wwGjxFQbMi3KUWwbX7Guu0kgEK8TqUIY2YJfA
         qYppyTP2byLtA==
Date:   Fri, 5 Jul 2019 11:24:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the clk tree
Message-ID: <20190705112422.3e150954@canb.auug.org.au>
In-Reply-To: <20190702120350.7029b623@canb.auug.org.au>
References: <20190702100103.12c132da@canb.auug.org.au>
        <20190702111455.4ef3494f@canb.auug.org.au>
        <20190702120350.7029b623@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6QOZ4An.xqIdJ/6Iwugb8Y_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6QOZ4An.xqIdJ/6Iwugb8Y_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 2 Jul 2019 12:03:50 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> This at least passes my (few) build tests (this will be in linux-next
> today):
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 2 Jul 2019 11:53:07 +1000
> Subject: [PATCH] clk: consoldiate the __clk_get_hw() declarations
>=20
> Without this we were getting errors like:
>=20
> In file included from drivers/clk/clkdev.c:22:0:
> drivers/clk/clk.h:36:23: error: static declaration of '__clk_get_hw' foll=
ows non-static declaration
> include/linux/clk-provider.h:808:16: note: previous declaration of '__clk=
_get_hw' was here
>=20
> Fixes: 59fcdce425b7 ("clk: Remove ifdef for COMMON_CLK in clk-provider.h")
> fixes: 73e0e496afda ("clkdev: Always allocate a struct clk and call __clk=
_get() w/ CCF")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/clk/clk.h             | 4 ----
>  drivers/clk/imx/clk-imx6q.c   | 1 +
>  drivers/clk/imx/clk-imx6sll.c | 1 +
>  drivers/clk/imx/clk-imx6sx.c  | 1 +
>  drivers/clk/imx/clk-imx6ul.c  | 1 +
>  drivers/clk/imx/clk-imx7d.c   | 1 +
>  drivers/clk/imx/clk.c         | 1 +
>  include/linux/clk-provider.h  | 7 +++++++
>  8 files changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
> index d8400d623b34..2d801900cad5 100644
> --- a/drivers/clk/clk.h
> +++ b/drivers/clk/clk.h
> @@ -33,10 +33,6 @@ clk_hw_create_clk(struct device *dev, struct clk_hw *h=
w, const char *dev_id,
>  {
>  	return (struct clk *)hw;
>  }
> -static struct clk_hw *__clk_get_hw(struct clk *clk)
> -{
> -	return (struct clk_hw *)clk;
> -}
>  static inline void __clk_put(struct clk *clk) { }
> =20
>  #endif
> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> index 4e61f5189a1f..466561fb8925 100644
> --- a/drivers/clk/imx/clk-imx6q.c
> +++ b/drivers/clk/imx/clk-imx6q.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
> index 342dcc58ac16..5f3e92c09a5e 100644
> --- a/drivers/clk/imx/clk-imx6sll.c
> +++ b/drivers/clk/imx/clk-imx6sll.c
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/clock/imx6sll-clock.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
> index fb58479eaa68..2ada63e6ba16 100644
> --- a/drivers/clk/imx/clk-imx6sx.c
> +++ b/drivers/clk/imx/clk-imx6sx.c
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/clock/imx6sx-clock.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
> index 95ca895c8776..d860a244363a 100644
> --- a/drivers/clk/imx/clk-imx6ul.c
> +++ b/drivers/clk/imx/clk-imx6ul.c
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/clock/imx6ul-clock.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
> index c6d86700a080..c1efb061d237 100644
> --- a/drivers/clk/imx/clk-imx7d.c
> +++ b/drivers/clk/imx/clk-imx7d.c
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/clock/imx7d-clock.h>
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 76457b2bd7f0..f628071f6605 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 0fbf3ccad849..2ae7604783dd 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -805,7 +805,14 @@ void devm_clk_hw_unregister(struct device *dev, stru=
ct clk_hw *hw);
>  /* helper functions */
>  const char *__clk_get_name(const struct clk *clk);
>  const char *clk_hw_get_name(const struct clk_hw *hw);
> +#ifdef CONFIG_COMMON_CLK
>  struct clk_hw *__clk_get_hw(struct clk *clk);
> +#else
> +static inline struct clk_hw *__clk_get_hw(struct clk *clk)
> +{
> +	return (struct clk_hw *)clk;
> +}
> +#endif
>  unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
>  struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
>  struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,

I am still applying this ...

--=20
Cheers,
Stephen Rothwell

--Sig_/6QOZ4An.xqIdJ/6Iwugb8Y_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0epsYACgkQAVBC80lX
0GzQewf+J1IeJSTrm+hdq/9rHnclnvcVHqoJUDNuwk7nmfS+8brFlaZ00/ya6CpI
6OjWSgp/KI6Be+3ChoZ2j4XOFGhVAmiq7LYOTXnmg3zhiuYiWmO9sn6cGOQehFc4
HCtAR+FssD/x/wvQty77lEEgX5W0i+QGGctLmeKN5w2no9U9bKo8lNZs/wk4gjT9
3ui6i4T9WoR5S1JAe0PQvl+luDAmWTWvGI3pJzAZh9QHLjS7bb8MZj3DJxitWLlW
hIGcv2zQL+d2KBRPpGfGgxUT23xlAA4LiXAynKblnteUYh/kKAviTc/84y4a3Y3z
y26tpV7iWZ7tBit8nwXv5GW1rVz/ug==
=RxIK
-----END PGP SIGNATURE-----

--Sig_/6QOZ4An.xqIdJ/6Iwugb8Y_--
