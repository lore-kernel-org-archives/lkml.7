Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3373C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8221A20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PqpmLbyo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KtO3IYLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbfDAIE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:04:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37618 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAIEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:04:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B518F60DB2; Mon,  1 Apr 2019 08:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105894;
        bh=HhXZWvUIyTHTWQDiX5fubmfxzlWyOUqOMDvxS4empko=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PqpmLbyoT0h8+nJuIQ6ZWXFUTz7HHnWq5Wm/v9pFP04DKmEeLHM6LJH0kGkF17p4c
         IFaZ58UPN5tL2e/svzCcKgr12gXc+Jccb3evFacYDOn8K4t5fFLo+4C+vSvMCPwDGU
         C7euzVgmTvwjtFfmyrcj/Tb3FlYMea8bIkvzg3Gc=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2152E6049C;
        Mon,  1 Apr 2019 08:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105889;
        bh=HhXZWvUIyTHTWQDiX5fubmfxzlWyOUqOMDvxS4empko=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KtO3IYLqTacz94TO77db5aW+O76ZH+bYh0BNair4Wzg6rbzJzxOE8Db92pZ45VKvu
         nHBUrZcVUS6vnsxp52DmNskxY+aT4qyyM93VIUwnEcH5yESnAcIWBbc2Th0CRFgbgN
         v4vxPRJFgnc9wzV8RvnezmKC8P9/pQhS7yDHgInQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2152E6049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] clk: imx: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554095298-15111-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <dcc9270b-6764-1a39-5953-896851bc601b@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:34:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554095298-15111-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:43 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/clk/imx/clk-imx8qxp-lpcg.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index fb6edf1..c711654 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -159,7 +159,6 @@ static int imx8qxp_lpcg_clk_probe(struct platform_device *pdev)
>   	struct clk_hw_onecell_data *clk_data;
>   	const struct imx8qxp_ss_lpcg *ss_lpcg;
>   	const struct imx8qxp_lpcg_data *lpcg;
> -	struct resource *res;
>   	struct clk_hw **clks;
>   	void __iomem *base;
>   	int i;
> @@ -168,10 +167,7 @@ static int imx8qxp_lpcg_clk_probe(struct platform_device *pdev)
>   	if (!ss_lpcg)
>   		return -ENODEV;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -EINVAL;
> -	base = devm_ioremap(dev, res->start, resource_size(res));
> +	base = devm_platform_ioremap_resource(pdev, 0);
>   	if (!base)
>   		return -ENOMEM;
>   
