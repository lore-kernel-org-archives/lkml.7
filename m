Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F766C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488A1218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556059906;
	bh=SLbCAZJQDRjk9vfOn393HVdMCmgStLY/ewawo1pjTEg=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=gCwe1P7a96vcrGtjzCgGYDsEd5iVRa/ziUV7JYkKFNmpwoXjqf8ITWDbXrXvvUeQI
	 HbqjnPTybq/480hVebsqck98Bm3nyJSRP2Pp4iMUgeGMNbapqsftBPOXu4Tm6lsu8s
	 POYOVSjZB1uV45EaUi6WeUAE68i0dYvEaXLBfz3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfDWWvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfDWWvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:51:44 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B73E1218D3;
        Tue, 23 Apr 2019 22:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556059903;
        bh=SLbCAZJQDRjk9vfOn393HVdMCmgStLY/ewawo1pjTEg=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=YbJ/44xwF2XkY70C8ezjis7D1gJTyERQsW1BJULYaY3DojG/gKkDZwEcDpIpPovXB
         7Wn3dzuyjn11xp2pcoCLDPnYnUSVyqMxfNn0SEsnKom8V+4w8YXdE+ruwR9q4fYlmN
         N6Vg8eY3NdKvD+8ZoQnQeKflQGdFAQ0c3nQMD1SQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1553954090-65470-1-git-send-email-nixiaoming@huawei.com>
References: <1553954090-65470-1-git-send-email-nixiaoming@huawei.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] clk:Fix divide-by-zero in divider_ro_round_rate_parent
To:     jbrunet@baylibre.com, mojha@codeaurora.org,
        mturquette@baylibre.com, nixiaoming@huawei.com,
        sboyd@codeaurora.org, soren.brinkmann@xilinx.com
Message-ID: <155605990288.15276.7089726827167650203@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 23 Apr 2019 15:51:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting nixiaoming (2019-03-30 06:54:50)
> In the function divider_recalc_rate() The judgment of the return value of
> _get_div() indicates that the return value of _get_div() can be 0.

When does _get_div() return 0? It can't be CLK_DIVIDER_MAX_AT_ZERO or
CLK_DIVIDER_POWER_OF_TWO. I suppose it could be CLK_DIVIDER_ONE_BASED if
CLK_DIVIDER_ALLOW_ZERO is set? Or just CLK_DIVIDER_ALLOW_ZERO is set? Or
a table that has 0 in it for some odd reason.

> In order to avoid the divide-by-zero error, add check for return value
> of _get_div() in the divider_ro_round_rate_parent()
>=20
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  drivers/clk/clk-divider.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index e5a1726..f4bf7a4 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -347,6 +347,9 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, =
struct clk_hw *parent,
>         int div;
> =20
>         div =3D _get_div(table, val, flags, width);
> +       /* avoid divide-by-zero */
> +       if (!div)
> +               return -EINVAL;

Can you please give more details on what's happening here? Who's the
caller? What are the arguments being passed in? Shouldn't we check for
CLK_DIVIDER_ALLOW_ZERO and then return prate as it comes in instead of
returning an error?

> =20
>         /* Even a read-only clock can propagate a rate change */
>         if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
