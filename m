Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC83C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE4D21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568024478;
	bh=w2wltwsNcp2EjCC6ZyD5k+5u/Dld7Cc5n/dDmNpsSx4=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=ks2TRSq4lWbL9vLIuSStx5YgFfwpZoNm5YPZWzWPOLtLQlOOUfT5SxhYC51sjO4Qv
	 hPd7+zg6wdDCUXiuur6xHAXKwg+gASbVjtjvp67XYtNevKNKk5FkkzHkXZD7hRaw1U
	 x8U9OBgCdvSFBnpUU8myCVtDVNxRk8cX9hbPUZ7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfIIKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbfIIKVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:21:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245112089F;
        Mon,  9 Sep 2019 10:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568024477;
        bh=w2wltwsNcp2EjCC6ZyD5k+5u/Dld7Cc5n/dDmNpsSx4=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=pqMSJnz4bg4KDRBcAr/iLot2g0LHV9vM6cKsUeHva9mAQPp4diH8E6E3rKrfuEfEz
         2Wl5SdkM/s8aSar1tRwg4SG6N7H+dOTZFPNW8jjHyzW0l/w1XKhvYtakKK4sFd++t7
         VhZI+urCxmZCaF1G2VNuevax3/zFYfSnB2+4uRdU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826164510.6425-2-jorge.ramirez-ortiz@linaro.org>
References: <20190826164510.6425-1-jorge.ramirez-ortiz@linaro.org> <20190826164510.6425-2-jorge.ramirez-ortiz@linaro.org>
Cc:     bjorn.andersson@linaro.org, niklas.cassel@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     agross@kernel.org, jorge.ramirez-ortiz@linaro.org,
        mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 2/5] clk: qcom: apcs-msm8916: get parent clock names from DT
User-Agent: alot/0.8.1
Date:   Mon, 09 Sep 2019 03:21:16 -0700
Message-Id: <20190909102117.245112089F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-08-26 09:45:07)
> @@ -76,10 +88,11 @@ static int qcom_apcs_msm8916_clk_probe(struct platfor=
m_device *pdev)
>         a53cc->src_shift =3D 8;
>         a53cc->parent_map =3D gpll0_a53cc_map;
> =20
> -       a53cc->pclk =3D devm_clk_get(parent, NULL);
> +       a53cc->pclk =3D of_clk_get(parent->of_node, pll_index);

Presumably the PLL was always index 0, so why are we changing it to
index 1 sometimes? Seems unnecessary.

