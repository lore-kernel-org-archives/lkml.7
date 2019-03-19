Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C98DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7D620863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553024567;
	bh=Jdh4DX65N7rfGvDocSid8LiXD/bAViD7h+fq7uSALJc=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=wFQJdN93o6ETLNxqIQ7cGybD9pCIu+iQee/USIKee0mLCHSNp7p806/Idn12nSTMM
	 98Y4si8ceyDTa3hcy2XTJV/EiE1pXdEJINAjB1upuBswvcUnUfDt69Kw09WZXqzTIS
	 FY0UwaT2xTFVZP/frRNpUaAqYNBX4eqeuoiiXUCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCSTmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfCSTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:42:45 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A61762085A;
        Tue, 19 Mar 2019 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553024564;
        bh=Jdh4DX65N7rfGvDocSid8LiXD/bAViD7h+fq7uSALJc=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=izp9BdwSFHPposxifLrsKmT5ILC7LDDMtzWwRW/Atl1qnwMvhN4ZgyO306OrJFisQ
         m29Y2UCRi2WtQzjM4M6obieLBNk9dmWu08ZzlzOjf/3+DXitMMel92jzaJQzrPG3rr
         nx7JWWHtBYdXpAnrBqOLw+DLm91xFAcH+BEZJBnU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190319093148.1909-1-leo.yan@linaro.org>
References: <20190319093148.1909-1-leo.yan@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RESEND PATCH] clk: hi3660: Mark clk_gate_ufs_subsys as critical
Cc:     Leo Yan <leo.yan@linaro.org>, stable@vger.kernel.org,
        Zhong Kaihua <zhongkaihua@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <155302456384.20095.11089482394019450818@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 19 Mar 2019 12:42:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leo Yan (2019-03-19 02:31:48)
> diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/c=
lk-hi3660.c
> index f40419959656..32ba80181cc6 100644
> --- a/drivers/clk/hisilicon/clk-hi3660.c
> +++ b/drivers/clk/hisilicon/clk-hi3660.c
> @@ -164,7 +164,7 @@ static const struct hisi_gate_clock hi3660_crgctrl_ga=
te_sep_clks[] =3D {
>         { HI3660_CLK_GATE_ISP_SNCLK2, "clk_gate_isp_snclk2",
>           "clk_isp_snclk_mux", CLK_SET_RATE_PARENT, 0x50, 18, 0, },
>         { HI3660_CLK_GATE_UFS_SUBSYS, "clk_gate_ufs_subsys", "clk_div_sys=
bus",
> -         CLK_SET_RATE_PARENT, 0x50, 21, 0, },
> +         CLK_SET_RATE_PARENT|CLK_IS_CRITICAL, 0x50, 21, 0, },

Nitpick: Please add space around | and also comment in the code why this
is a critical clk.

>         { HI3660_PCLK_GATE_DSI0, "pclk_gate_dsi0", "clk_div_cfgbus",
>           CLK_SET_RATE_PARENT, 0x50, 28, 0, },
>         { HI3660_PCLK_GATE_DSI1, "pclk_gate_dsi1", "clk_div_cfgbus",
