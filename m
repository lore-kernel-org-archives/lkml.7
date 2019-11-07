Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F27C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9370221882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573154600;
	bh=ftSd/7ehpdn2j3hx+l5leGMaV+fCv0vWroHDpGfHRto=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=QuWLFdU8Myp42kGyxvzdGdUdVMXNAKEEz/YhgelQ1Z0+BjYvXf6OO4ULwIFXiGkM8
	 St4P9ikmwabBwfVWw2yQs0gZOeE1NtjO1DgAF+UTBpEfV4vmvwulb0FKsNABPlyiXY
	 LFIjnXyvNc7N2jNTODZQI7YQ/Azzi+7Lm13co5g8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfKGTXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfKGTXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:23:19 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E31B2084C;
        Thu,  7 Nov 2019 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573154598;
        bh=ftSd/7ehpdn2j3hx+l5leGMaV+fCv0vWroHDpGfHRto=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=0hfQhQvlAHgZvgSiYj3SqZoxBDYPhBwxS6V8lIJkE4gCKLNVwr8xFW/VnOTg57eas
         U5E6mrzmitJwEZL+uDSfwiAvFlvQcY6Fb59c8wJ2ZggGWcAqQMi/X77ePluNmW6djh
         BeIajKROeKq22+QdH6HG0wwx9TC+ayGA5ru8WZoU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573120694-6015-1-git-send-email-rajan.vaja@xilinx.com>
References: <1573120694-6015-1-git-send-email-rajan.vaja@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, jolly.shah@xilinx.com,
        michal.simek@xilinx.com, mturquette@baylibre.com,
        nava.manne@xilinx.com, shubhrajyoti.datta@xilinx.com,
        tejas.patel@xilinx.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: Re: [PATCH] clk: zynqmp: Warn user if clock user are more than allowed
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 11:23:17 -0800
Message-Id: <20191107192318.3E31B2084C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-11-07 01:58:14)
> Warn user if clock is used by more than allowed devices.
> This check is done by firmware and returns respective
> error code. Upon receiving error code for excessive user,
> warn user for the same.
>=20
> This change is done to restrict VPLL use count. It is
> assumed that VPLL is used by one user only.
>=20
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

This sign off chain is incorrect.

> ---
>  drivers/clk/zynqmp/pll.c             | 9 ++++++---
>  drivers/firmware/xilinx/zynqmp.c     | 2 ++
>  include/linux/firmware/xlnx-zynqmp.h | 1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> index a541397..2f4ccaa 100644
> --- a/drivers/clk/zynqmp/pll.c
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -188,9 +188,12 @@ static int zynqmp_pll_set_rate(struct clk_hw *hw, un=
signed long rate,
>                 frac =3D (parent_rate * f) / FRAC_DIV;
> =20
>                 ret =3D eemi_ops->clock_setdivider(clk_id, m);
> -               if (ret)
> -                       pr_warn_once("%s() set divider failed for %s, ret=
 =3D %d\n",
> -                                    __func__, clk_name, ret);
> +               if (ret) {
> +                       if (ret =3D=3D -EUSERS)
> +                               WARN(1, "More than allowed devices are us=
ing the %s, which is forbidden\n", clk_name);
> +                       pr_err("%s() set divider failed for %s, ret =3D %=
d\n",
> +                              __func__, clk_name, ret);
> +               }

Shouldn't we catch this much earlier when clk_get() is called or
something like that?

> =20
>                 eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, f, NU=
LL);
> =20
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/z=
ynqmp.c
> index 75bdfaa..74d9f13 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -48,6 +48,8 @@ static int zynqmp_pm_ret_code(u32 ret_status)
>                 return -EACCES;
>         case XST_PM_ABORT_SUSPEND:
>                 return -ECANCELED;
> +       case XST_PM_MULT_USER:
> +               return -EUSERS;

This is for filesystem quotas? It's a weird error return value.

>         case XST_PM_INTERNAL:
>         case XST_PM_CONFLICT:
>         case XST_PM_INVALID_NODE:
