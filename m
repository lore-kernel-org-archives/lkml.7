Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D07C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E282C2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e+3XTD13";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N5WVvSlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbfDAIOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:14:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAIOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:14:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 585A4614B6; Mon,  1 Apr 2019 08:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106453;
        bh=vHMoLPkgshZnVLl43toZ5Kkh9nygPURntwVOi+03hB4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=e+3XTD13BbPJfK4fDbU95SYsm1Wcpdlsh7J6tBm2tNE142iocGAIntPHQqhP/yyOP
         VAOPVRjn9W2INFsYvczrHVwi4pGlQsYpGy4qF22NiXWFS9KmhK9EKY+0t0qQLFssLM
         ClhpxX0vsGnID+SsdUqI9/pRSYmPhg0iRv2mwyvg=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9315614B6;
        Mon,  1 Apr 2019 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106451;
        bh=vHMoLPkgshZnVLl43toZ5Kkh9nygPURntwVOi+03hB4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=N5WVvSlOlworWohCz7pGWLG9iYRox6ACI91t5QBhrcZvVcrmCzZBZ/bLEMGEJxeyo
         9yK5wzdV77Q4iEWSi6mFY9b392/vCAKx4f79YHW+0GUxWk0p38cYuocrmTe/yNgSSK
         SGE5v+Mk8uYVi0D+4z42hZeVEyoHZ+kYn8Ug3z7o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9315614B6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/3] nvmem: mxs-ocotp: use
 devm_platform_ioremap_resource() to simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
 <1554094479-14596-2-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <200d80d9-84ee-1317-85e8-961c076a2a07@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:44:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554094479-14596-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:29 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/nvmem/mxs-ocotp.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
> index 53122f5..fbb7db6 100644
> --- a/drivers/nvmem/mxs-ocotp.c
> +++ b/drivers/nvmem/mxs-ocotp.c
> @@ -145,7 +145,6 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	const struct mxs_data *data;
>   	struct mxs_ocotp *otp;
> -	struct resource *res;
>   	const struct of_device_id *match;
>   	int ret;
>   
> @@ -157,8 +156,7 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
>   	if (!otp)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	otp->base = devm_ioremap_resource(dev, res);
> +	otp->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(otp->base))
>   		return PTR_ERR(otp->base);
>   
