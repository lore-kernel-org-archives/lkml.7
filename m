Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB5C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C366D2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573163418;
	bh=dQBsw2ArHeU9P5i+qeiGoYYR+Emw9AMMubPkQDQF/9M=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=WVjdft0VinKkjWg6Wzw+9PHmBC9m07W0MPfUZy29yjWeEkwC29m/uEo1AdnOhdX6o
	 3S7GfMZH074v6ytq8bpHGb/rC1n1DZ3eyM0OhDqp6t22sfc461nZ8DZmue6SgJ3eE7
	 +uFXmTVclmQ9iX8PoTnJ5hMdinvrX5VcR964Z55A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfKGVuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfKGVuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:50:17 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CAD2084C;
        Thu,  7 Nov 2019 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573163416;
        bh=dQBsw2ArHeU9P5i+qeiGoYYR+Emw9AMMubPkQDQF/9M=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=rlcb/o2bGAyTstqOc1tYklXzadJiwjesyc7BQpbPEFlIvWsFd/hyNcBoAaq+gcTbd
         vzCkdGVt8kOvP3wx6WyAsZD/jKEwlhlyxHfMa757m8mhFDGuRlu57H1sa19kY5kwlA
         rjf0BBR1+r5zcNIObkMsm/FyNzrghQsL5IPWnsW4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1569959828-8357-1-git-send-email-jhugo@codeaurora.org>
References: <1569959656-5202-1-git-send-email-jhugo@codeaurora.org> <1569959828-8357-1-git-send-email-jhugo@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        marc.w.gonzalez@free.fr, mturquette@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v6 3/6] clk: qcom: smd: Add XO clock for MSM8998
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 13:50:15 -0800
Message-Id: <20191107215016.A6CAD2084C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2019-10-01 12:57:08)
> diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm899=
8.c
> index 091acd59c1d6..1651a2f47ab8 100644
> --- a/drivers/clk/qcom/gcc-msm8998.c
> +++ b/drivers/clk/qcom/gcc-msm8998.c
> @@ -2971,14 +2957,23 @@ static const struct qcom_cc_desc gcc_msm8998_desc=
 =3D {
>         .num_resets =3D ARRAY_SIZE(gcc_msm8998_resets),
>         .gdscs =3D gcc_msm8998_gdscs,
>         .num_gdscs =3D ARRAY_SIZE(gcc_msm8998_gdscs),
> -       .clk_hws =3D gcc_msm8998_hws,
> -       .num_clk_hws =3D ARRAY_SIZE(gcc_msm8998_hws),
>  };
> =20
>  static int gcc_msm8998_probe(struct platform_device *pdev)
>  {
>         struct regmap *regmap;
>         int ret;
> +       struct clk *xo;
> +
> +       /*
> +        * We must have a valid XO to continue, otherwise having a missing
> +        * parent on a system critical clock like the uart core clock can
> +        * result in strange bugs.  We know XO will be provided by rpmcc,
> +        * but it might not be specified in DT like it should.
> +        */
> +       xo =3D __clk_lookup("xo");

I very much dislike __clk_lookup(). I think we can not have this patch?

> +       if (!xo)
> +               return -EPROBE_DEFER;
> =20
