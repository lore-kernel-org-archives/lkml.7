Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2CC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05A620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552940492;
	bh=NQLOYggsPXkWqj3UsTopKS4lKB8iUyd7s/a8ypYs0wM=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=HzJAplwvd8AG2l9lEdnrD8HubgSTLT+2tkWK62J+FdtsDPWmHsqe0F9SO31n4qrc1
	 cEbQJafiKwnmfPT/SIIJa4Wcs3bkDuXbcLvSgfq/AroFS32Ii761Taz//hspfcugXE
	 LNPgtzhCDV4nweCrDw1QQaSpuGmdYHs0XQE+1McM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfCRUVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfCRUVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:21:31 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BC7B20828;
        Mon, 18 Mar 2019 20:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552940490;
        bh=NQLOYggsPXkWqj3UsTopKS4lKB8iUyd7s/a8ypYs0wM=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=SufvF/IsUztt/+hqtcuryfnMKdupBNtR+FL5keTM3ma19HgKkeQnf1wN6t7loLZOU
         8PrLmrj7DkX1IS0fD7xnUcxzU2BYv3cPDIdovqQmLuobtYzCAmv1BcWCuzmVw8yYQA
         wkM1Ud6/2OeIj592Z6QDFVl+Ak94QU20ZhtN9DYg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1552937931-23050-7-git-send-email-peter.griffin@linaro.org>
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org> <1552937931-23050-7-git-send-email-peter.griffin@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 6/6] clk: hi6220: use CLK_OF_DECLARE_DRIVER
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
To:     Peter Griffin <peter.griffin@linaro.org>, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, xuwei5@hisilicon.com
Message-ID: <155294048956.20095.14072308972262767231@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 18 Mar 2019 13:21:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Griffin (2019-03-18 12:38:51)
> As now we also need to probe in the reset driver as well.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/clk/hisilicon/clk-hi6220.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Doesn't this need to be squashed with the reset driver bits so we don't
have a bisection hole?

>=20
> diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/c=
lk-hi6220.c
> index a87809d..952ffe2 100644
> --- a/drivers/clk/hisilicon/clk-hi6220.c
> +++ b/drivers/clk/hisilicon/clk-hi6220.c
> @@ -89,7 +89,7 @@ static void __init hi6220_clk_ao_init(struct device_nod=
e *np)
>         hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
>                                 ARRAY_SIZE(hi6220_separated_gate_clks_ao)=
, clk_data_ao);
>  }
> -CLK_OF_DECLARE(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_i=
nit);
> +CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_c=
lk_ao_init);

Can you also add a comment indicating why/what is the other driver that
is probing the same device node?

