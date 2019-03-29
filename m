Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4FC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507202184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553899698;
	bh=NGweQ1I5s8Jq+objqslkHJmBFpAoDR+aQ5oCqiMIn7M=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=ILPF7m6X9IN9UDisakJ9GqVT/4QRvplYr+CaK+cbiUFPtISWamhvRbx/X4Nl9Ljt7
	 bd/WMUf1xTF1Bq+AW0NigMn0THiiqOKaVe8Jqf2LQ/6WxqgJQ5fVFciEY1uy7dyOtA
	 BgHyXpBa8Sx4/vFVXQGxFfkID8nhoXwB8nxKKGoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbfC2WsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbfC2WsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:48:16 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FF0217F5;
        Fri, 29 Mar 2019 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553899695;
        bh=NGweQ1I5s8Jq+objqslkHJmBFpAoDR+aQ5oCqiMIn7M=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=fMlU3a7o0IYXKQmkQSOzYhjULpZDkTDT3JEwUwTWDf9mtnn2WkeYZn/Vu6WS7u56r
         T8FOXiC9u8J+Z0h5jyLT5Tf+jV4yeipjO78AUPNF641p+WVtjLlqA0Sr3HOjJKLj+3
         Ukn/1O5o9bRnnpEMmUHbzIrYCOaV8QMYBGVfxdNI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1553859960-31501-1-git-send-email-nixiaoming@huawei.com>
References: <1553859960-31501-1-git-send-email-nixiaoming@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk:mmp: clk-mix.c fix divide-by-zero
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     chao.xie@marvell.com, mturquette@baylibre.com,
        nixiaoming@huawei.com
Message-ID: <155389969479.20095.682832622477946593@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 29 Mar 2019 15:48:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nixiaoming (2019-03-29 04:46:00)
> The _get_div function has a branch with a return value of 0
> Add a check on the return value of _get_div to avoid divide-by-zero
>=20
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>

Similar questions apply here as they do on the generic divider patch you
sent.

> ---
>  drivers/clk/mmp/clk-mix.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
> index 90814b2..9d152c2 100644
> --- a/drivers/clk/mmp/clk-mix.c
> +++ b/drivers/clk/mmp/clk-mix.c
> @@ -245,6 +245,8 @@ static int mmp_clk_mix_determine_rate(struct clk_hw *=
hw,
>                         div_val_max =3D _get_maxdiv(mix);
>                         for (j =3D 0; j < div_val_max; j++) {
>                                 div =3D _get_div(mix, j);
> +                               if (!div) /* avoid divide-by-zero */

Why can't we return 1 for the divider value here?

> +                                       continue;
>                                 mix_rate =3D parent_rate / div;
>                                 gap =3D abs(mix_rate - req->rate);
>                                 if (!parent_best || gap < gap_best) {
> @@ -341,6 +343,8 @@ static unsigned long mmp_clk_mix_recalc_rate(struct c=
lk_hw *hw,
>         shift =3D mix->reg_info.shift_div;
> =20
>         div =3D _get_div(mix, MMP_CLK_BITS_GET_VAL(mux_div, width, shift)=
);
> +       if (!div) /* avoid divide-by-zero */

Same question.

> +               return -EINVAL;
> =20
>         return parent_rate / div;
>  }
