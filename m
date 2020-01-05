Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8110AC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF82206F0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 19:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578254173;
	bh=7t14hCA0XP+MmY5EzlL7gorT0FZ/Fb5lWXrgUegaoiw=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=0vpDZybPTFG+/579lnkREXk7xeVmLsEKKewRS+5N/wa7cYbDzLdUp1opB4logiEqy
	 UgwAUgtMf5P6GvERbNLDaISR2vi1HYg4+jo/LwYwOrNZvhPrEd/iV6A7q7tM+QlKb9
	 KUKvJPzKuCNOIVRw8tR/ZtOXg+YKFW7Mihi0FDOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgAET4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 14:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAET4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 14:56:11 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F17320678;
        Sun,  5 Jan 2020 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578254170;
        bh=7t14hCA0XP+MmY5EzlL7gorT0FZ/Fb5lWXrgUegaoiw=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=TvaJCIOY2xoO4b9U18aVip2O69DWnnW/lVnrj/tYcqMV/Q6fLIYHE6aZu1m35h8a7
         sjNEnFg2OGJZ3337lOgONBWYb44lfYcezHBW1mQuuBLhhBFz8ebCFs/wy4ncp1tRw4
         DsYZ5vY3+Uaebud2bgeFcjRCXmCSe0HJF7sEQsOQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4b69f5ba64b68b388ab1e1a0c5896536b063da74.1574922435.git.shubhrajyoti.datta@xilinx.com>
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com> <4b69f5ba64b68b388ab1e1a0c5896536b063da74.1574922435.git.shubhrajyoti.datta@xilinx.com>
Cc:     gregkh@linuxfoundation.org, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        shubhrajyoti.datta@gmail.com, devicetree@vger.kernel.org,
        soren.brinkmann@xilinx.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     devel@driverdev.osuosl.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v3 06/10] clk: clock-wizard: Remove the hardcoding of the clock outputs
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 11:56:09 -0800
Message-Id: <20200105195610.8F17320678@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting shubhrajyoti.datta@gmail.com (2019-11-27 22:36:13)
> diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-c=
lock-wizard.c
> index bc0354a..4c6155b 100644
> --- a/drivers/clk/clk-xlnx-clock-wizard.c
> +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> @@ -493,6 +493,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
>         const char *clk_name;
>         struct clk_wzrd *clk_wzrd;
>         struct resource *mem;
> +       int outputs;
>         struct device_node *np =3D pdev->dev.of_node;
> =20
>         clk_wzrd =3D devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERN=
EL);
> @@ -583,7 +584,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
>         }
> =20
>         /* register div per output */
> -       for (i =3D WZRD_NUM_OUTPUTS - 1; i >=3D 0 ; i--) {
> +       for (i =3D outputs - 1; i >=3D 0 ; i--) {

Where is 'outputs' assigned in this patch?

>                 const char *clkout_name;
> =20
>                 if (of_property_read_string_index(np, "clock-output-names=
", i,
> @@ -614,7 +615,7 @@ static int clk_wzrd_probe(struct platform_device *pde=
v)
>                 if (IS_ERR(clk_wzrd->clkout[i])) {
>                         int j;
> =20
> -                       for (j =3D i + 1; j < WZRD_NUM_OUTPUTS; j++)
> +                       for (j =3D i + 1; j < outputs; j++)
>                                 clk_unregister(clk_wzrd->clkout[j]);
>                         dev_err(&pdev->dev,
>                                 "unable to register divider clock\n");
