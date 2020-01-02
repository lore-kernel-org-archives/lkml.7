Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A43C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 00:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083C820672
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577926622;
	bh=9zrKPj2giDchEJVfB+upmaTgQezZHZccORzC6mjue4I=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=ws3jkllWLA5XVKi2RfWu2XifpL1PMncStbx6dMc5s28PjPJIx0NumhdNw3hDUK3cd
	 1LTSDdzkU1yZofN2p+uNt4VFYLwew4TBAoprkQp3tW1RAdP25JWIfrZ0xVJxe4NWdp
	 8ALNWAV5lfAQPL2EbfokclFRf+j4jBBH7vX6o9Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgABA5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 19:57:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgABA5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 19:57:00 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAAE20672;
        Thu,  2 Jan 2020 00:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577926620;
        bh=9zrKPj2giDchEJVfB+upmaTgQezZHZccORzC6mjue4I=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=XuL3VO2IgR3048dD9C4JAwyQJ/vNdC0RFydPbsFjobBO1FNw+EXj1TFEGqx7X3DNg
         87/mYLT+I+Zc9Em/cWbZ3awAlyMxGKZmenrYtYMT/xwlJRmeYtCaY+L95nEdYrLwnD
         zojv7n5lO3Pru0t+pi5jHpok50lKDY/jtppLi6+M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1577790048-18263-2-git-send-email-tdas@codeaurora.org>
References: <1577790048-18263-1-git-send-email-tdas@codeaurora.org> <1577790048-18263-2-git-send-email-tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v1 1/2] clk: qcom: rpmh: skip undefined clocks when registering
User-Agent: alot/0.8.1
Date:   Wed, 01 Jan 2020 16:56:59 -0800
Message-Id: <20200102005700.1EAAE20672@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-12-31 03:00:47)
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 7ed313a..05cbe6f 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -462,7 +464,8 @@ static int clk_rpmh_probe(struct platform_device *pde=
v)
>=20
>                 ret =3D devm_clk_hw_register(&pdev->dev, hw_clks[i]);
>                 if (ret) {
> -                       dev_err(&pdev->dev, "failed to register %s\n", na=
me);
> +                       dev_err(&pdev->dev, "failed to register %s\n",
> +                                                       hw_clks[i]->init-=
>name);

After register clk_hw::init is NULL. This will probably oops. It would
be better to save off the name before registering.

