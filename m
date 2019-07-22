Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4863DC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4EA2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563830657;
	bh=Q1SxLd/6lmvU8jCiIlAjSa9MkP+kP6OmwP8tsxTbFSk=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=GIy1Q9opih7gQcWmtwWtzlfWiaISUhLyufK4OSl9brtFkkNOts4oIuPzTK+2+/lgT
	 o46tRWt3n8w7JTHDoINGQDfCi2C+JV2q23Vgjvn1meIchDI0zmUz5VZ+mBa7iCoGYe
	 UTn30Sp/mcmTrLJ/0/aEJDbVvcVQ9C5lJWnJMAgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbfGVVYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbfGVVYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:24:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF8D21900;
        Mon, 22 Jul 2019 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563830654;
        bh=Q1SxLd/6lmvU8jCiIlAjSa9MkP+kP6OmwP8tsxTbFSk=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=lvSyT3Iw9UFWvNfwslsgbjCNm3+F54F0oSQEj1HWdxa+xSdk0SpY3A1JWc01XMWgY
         aj4R3f5Y8GOLY5DoJuyTUnFo441wg5BUZbd/39gGkfGTAhIVQynFqLqiplIFctTZK8
         G9Hwca4oz7cKrLc7bB+zgOfOL62mlBPBv6Ksc/Fw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190701165020.19840-1-colin.king@canonical.com>
References: <20190701165020.19840-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] clk: Si5341/Si5340: remove redundant assignment to n_den
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:24:13 -0700
Message-Id: <20190722212414.6EF8D21900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please Cc authors of drivers so they can ack/review.

Adding Mike to take a look.

Quoting Colin King (2019-07-01 09:50:20)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The variable n_den is initialized however that value is never read
> as n_den is re-assigned a little later in the two paths of a
> following if-statement.  Remove the redundant assignment.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/clk-si5341.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-si5341.c b/drivers/clk/clk-si5341.c
> index 72424eb7e5f8..6e780c2a9e6b 100644
> --- a/drivers/clk/clk-si5341.c
> +++ b/drivers/clk/clk-si5341.c
> @@ -547,7 +547,6 @@ static int si5341_synth_clk_set_rate(struct clk_hw *h=
w, unsigned long rate,
>         bool is_integer;
> =20
>         n_num =3D synth->data->freq_vco;
> -       n_den =3D rate;
> =20
>         /* see if there's an integer solution */
>         r =3D do_div(n_num, rate);
