Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75FEC3A59B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE721773
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566090647;
	bh=i3YpEXnym46J8n6fFZZQkuId1yawTkolYP1kiWYjf0o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=OXjtVAF+E3CmZD16U3vl8AUHobXcTcZBrJMdWkhhyRdYpG+Gr0GUUQ87oOz9Ivvuf
	 3cqphMxM2kYpmHz4ndaIiSYcucmeLQACuKpvFjQeRiOhc50YkZSDqcbsb3bqoHjBaR
	 uR2UVb84evRHeyNPGsjO7xCQDF4sfgcQe3uYMuVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfHRBKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 21:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfHRBKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 21:10:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21742173B;
        Sun, 18 Aug 2019 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566090644;
        bh=i3YpEXnym46J8n6fFZZQkuId1yawTkolYP1kiWYjf0o=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=wVxF4GLFbd6Ma/3RyvYzcb8xuaPz/SeNzKFdG0Yp2Y8ZVYDt+hdpHX23WBp0tg8bL
         ksTCOWtOus8PJaNkl1Ndis+Mw8EJTv4z91jfRWM+ub2SUbfU9a3ZJ+F2ElBXL5PeJH
         x19yVV3XVajgMODyxILEE4sS3wysBBBOEYHveX3o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611192049.14958-1-jeffrey.l.hugo@gmail.com>
References: <20190611191949.14906-1-jeffrey.l.hugo@gmail.com> <20190611192049.14958-1-jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v3 1/2] clk: qcom: Add MSM8998 GPU Clock Controller (GPUCC) driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr,
        jcrouse@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, mturquette@baylibre.com
User-Agent: alot/0.8.1
Date:   Sat, 17 Aug 2019 18:10:43 -0700
Message-Id: <20190818011044.B21742173B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-06-11 12:20:49)
> +
> +static int gpucc_msm8998_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +       struct clk *xo;
> +
> +       /*
> +        * We must have a valid XO to continue until orphan probe defer is
> +        * implemented.  XO is basically the root of everything.  Since we
> +        * cannot control probe order, its possible XO won't be available
> +        * and the clk framework will allow clients to operate on their
> +        * clocks that depend on XO, which has been observed to cause iss=
ues.
> +        */
> +       xo =3D clk_get(&pdev->dev, "xo");

Sorry, it still bothers me. Please remove any clk consumer API calls in
these MSM8998 drivers and don't put XO into DT for these nodes until the
"observed issues" are resolved with the clk framework.

> +       if (IS_ERR(xo))
