Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A9C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF61D21743
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 03:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566013941;
	bh=4oxw9KmagPq4gSAaCNa0UfIBjp21fF7APgvTtgAbfh8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=pDKBVpZTd96G2YDDNY4I02olQ8PJYLJyBox7RFu3RaherrjjBM0UVRcRNhTUwDAWW
	 JPlC6PKl5LiPwHL/Zeb3ORk2hanwr1/XiINPNIc9quoHaDP3x385COCDQfYwTJH5VK
	 XIhTX8njCa3gcX6caDUlM08sX4ie8UvD82J75hJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfHQDwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 23:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfHQDwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 23:52:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268F32173B;
        Sat, 17 Aug 2019 03:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566013940;
        bh=4oxw9KmagPq4gSAaCNa0UfIBjp21fF7APgvTtgAbfh8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DcdqOF0UOe9NLgUEeGC/MOUbnT5TQ1k6ns/TnlozI+tFXSveq3eVKqnk4wiQ2O6jZ
         W73j0LpAqXjrYw95uxe7Yrps6KzmDkAayy5sFqqZ08rEd6bj1LY4wYaspvhxwM1IVH
         UYaYJaZczeJrg1PfGnYj4SklLdB80/ZCh2Pmbj2w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1565866783-19672-5-git-send-email-Anson.Huang@nxp.com>
References: <1565866783-19672-1-git-send-email-Anson.Huang@nxp.com> <1565866783-19672-5-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 5/6] clk: imx8mn: Add necessary frequency support for ARM PLL table
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson.Huang@nxp.com, abel.vesa@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, rjw@rjwysocki.net,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        viresh.kumar@linaro.org
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 20:52:19 -0700
Message-Id: <20190817035220.268F32173B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson.Huang@nxp.com (2019-08-15 03:59:42)
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index ecd1062..3f1239a 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -82,6 +84,7 @@ static struct imx_pll14xx_clk imx8mn_dram_pll =3D {
>  static struct imx_pll14xx_clk imx8mn_arm_pll =3D {
>                 .type =3D PLL_1416X,
>                 .rate_table =3D imx8mn_pll1416x_tbl,
> +               .rate_count =3D ARRAY_SIZE(imx8mn_pll1416x_tbl),

Why is rate_count added? That's not described in the commit text.

