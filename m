Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44615C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D5C216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557334809;
	bh=uHAW0/o+g55YDVcmOd6JTnlBsp1XalPYNPR1umKx9o0=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=FvK5RtmXrIFMf40W0LH+xD4AmXeINyRmDKPDx0oKc2TPBW2wZ0qShwk18NlJKLqIH
	 BVzbFq89sFb5lW+N0VDGxH7UU/B46DKNZg+fpQH11fMib0yjg2dbcOzVYNw3+LAzxB
	 17Sn9X20bAoVmjRKkB5SrArM79Vgpo5zht2gu588=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfEHRAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfEHRAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:00:08 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF3421530;
        Wed,  8 May 2019 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557334807;
        bh=uHAW0/o+g55YDVcmOd6JTnlBsp1XalPYNPR1umKx9o0=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=rT40VyCj79Hd+00Cx7RENkzjM0uBHarbGEU9vXMneMP/7Hn2E06wPch0sWI1CG3eS
         b2+E5k6XRzyntrobMs0+qD0hi+EUeh3fxuQO1QNLqJjFz8PkJKlZE/IifAdKGr5Vq+
         ePrUiNWpC5h8UY6xmJaOEFHB2yQLh2XzgpVdiP4I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190508112842.11654-4-alexandru.ardelean@analog.com>
References: <20190508112842.11654-1-alexandru.ardelean@analog.com> <20190508112842.11654-4-alexandru.ardelean@analog.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 02/16] treewide: rename match_string() -> __match_string()
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Heiko Stuebner <heiko@sntech.de>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155733480678.14659.15999974975874060801@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 08 May 2019 10:00:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Trimming the lists but keeping lkml)

Quoting Alexandru Ardelean (2019-05-08 04:28:28)
> This change does a rename of match_string() -> __match_string().
>=20
> There are a few parts to the intention here (with this change):
> 1. Align with sysfs_match_string()/__sysfs_match_string()
> 2. This helps to group users of `match_string()` into simple users:
>    a. those that use ARRAY_SIZE(_a) to specify the number of elements
>    b. those that use -1 to pass a NULL terminated array of strings
>    c. special users, which (after eliminating 1 & 2) are not that many
> 3. The final intent is to fix match_string()/__match_string() which is
>    slightly broken, in the sense that passing -1 or a positive value does
>    not make any difference: the iteration will stop at the first NULL
>    element.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
[...]
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 96053a96fe2f..0b6c3d300411 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2305,8 +2305,8 @@ bool clk_has_parent(struct clk *clk, struct clk *pa=
rent)
>         if (core->parent =3D=3D parent_core)
>                 return true;
> =20
> -       return match_string(core->parent_names, core->num_parents,
> -                           parent_core->name) >=3D 0;
> +       return __match_string(core->parent_names, core->num_parents,
> +                             parent_core->name) >=3D 0;

This is essentially ARRAY_SIZE(core->parent_names) so it should be fine
to put this back to match_string() later in the series.

>  }
>  EXPORT_SYMBOL_GPL(clk_has_parent);
> =20
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index c3ad92965823..373f13e9cd83 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -276,8 +276,8 @@ static struct clk *rockchip_clk_register_frac_branch(
>                 struct clk *mux_clk;
>                 int ret;
> =20
> -               frac->mux_frac_idx =3D match_string(child->parent_names,
> -                                                 child->num_parents, nam=
e);
> +               frac->mux_frac_idx =3D __match_string(child->parent_names,
> +                                                   child->num_parents, n=
ame);

I suspect this is the same as above, but Heiko can ack/confirm.

>                 frac->mux_ops =3D &clk_mux_ops;
>                 frac->clk_nb.notifier_call =3D rockchip_clk_frac_notifier=
_cb;
> =20
