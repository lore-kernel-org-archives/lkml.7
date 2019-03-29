Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C029218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553899326;
	bh=NyAqODDr/8UfYBpcXxCTkCgR2venfW3HzkWlCOuQxh8=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=RalLtEUZ6JV/YEjBStJVESbsEaHnUp7BA45QZJEbOucanjk+giJpzXwM7F3PIhF9X
	 U8eJRDApkcPTJH0ZQilqLubaADV5MWhME7Bk1tyfn7tnA/3RTzSps8NdUCOU0rq6P9
	 2SSWRny1ZJJoh3FYcMGOFmVRM7DacqI0+R+BIgOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfC2WmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbfC2WmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:42:04 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96AA1217F5;
        Fri, 29 Mar 2019 22:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553899323;
        bh=NyAqODDr/8UfYBpcXxCTkCgR2venfW3HzkWlCOuQxh8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=hGatEvv+AEX0SbUVXTpRr6ED1e2Lc2hk/mEq8PAvRWj1GXC/HxhUPGp+zUaJanHKf
         lpy3UI2EUajljwffnm5h0GzQZOMj/s8GHe4plPKE/VE2p0LaTI9LGNMJTtdD+wZD/b
         aZqg8E06i2ECZSlV0IjvO98kPaY97ioaXzNm2tcA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1553850324-25625-1-git-send-email-nixiaoming@huawei.com>
References: <1553850324-25625-1-git-send-email-nixiaoming@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk:Fix divide by 0 error in divider_ro_round_rate_parent
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     jbrunet@baylibre.com, mturquette@baylibre.com,
        nixiaoming@huawei.com, rnayak@ti.com, sboyd@codeaurora.org,
        soren.brinkmann@xilinx.com
Message-ID: <155389932276.20095.12054188967513679921@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 29 Mar 2019 15:42:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nixiaoming (2019-03-29 02:05:24)
> In the function divider_recalc_rate The judgment of the return value of

Please write divider_recalc_rate() with parenthesis to show it's a
function.

> _get_div indicates that the return value of _get_div may be 0.

__get_div()

> In order to avoid the divide-by-zero error, add check the return value
> of _get_div in the divider_ro_round_rate_parent
>=20
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>

Is this your name? nixiaoming? Or is it written some other way?

> ---
>  drivers/clk/clk-divider.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index e5a1726..0854e3e 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -347,6 +347,8 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, =
struct clk_hw *parent,
>         int div;
> =20
>         div =3D _get_div(table, val, flags, width);
> +       if (!div) /* avoid divide-by-zero */
> +               return -EINVAL;

How does _get_div() return 0? What is the value of 'flags' here when
this goes wrong?

> =20
>         /* Even a read-only clock can propagate a rate change */
>         if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
> --=20
> 1.8.5.6
>=20

Wow that's a 5 year old version of git!

