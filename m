Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF2DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8EE20896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mzVhXzRv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jdT5AEeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbfDAH5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:57:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAH53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:57:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E7A426047C; Mon,  1 Apr 2019 07:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105449;
        bh=aZdnBPgm+ZLOTCF5PaXKNmR27i48RwuG6RbNlQ5UfgU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mzVhXzRvx9OjCf3KOlVPp9GoLYQgr9VKjKc7/orJ9qzJTyRW9Hs1AIaN3+ns2uYba
         eNxiDahY5/3pUUhbJDToIRQNawrhLojFl7LsoX6322Wv+j3lQIOJHfzmjVDF2+7Pwe
         fJb9Z5c9HOqSlrC9mgB+itWjICifgat+vbV6Ms4c=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7ED9C602FC;
        Mon,  1 Apr 2019 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105448;
        bh=aZdnBPgm+ZLOTCF5PaXKNmR27i48RwuG6RbNlQ5UfgU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jdT5AEeC67ZRcgNjJIQvqQ8UhvDr4W8ou6LR2VFQTvhAPnH8/rPGurfJwbKSCzgTi
         KxBPBhcofDtgpbZVW9qtcHelnTL8Z0nKAqbBWOLZOoI/t7Q86jm6xAD1QgYB0HI+HJ
         oOeT+X/ZzqziFeYKeNCr9kQ6XGpFW9JjXUs6SIVM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7ED9C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] rtc: snvs: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <anson.huang@nxp.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1554096271-17921-1-git-send-email-Anson.Huang@nxp.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8a485ab9-435f-4dfc-1e3d-4dc97e95376a@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:27:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554096271-17921-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 10:59 AM, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>   drivers/rtc/rtc-snvs.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
> index ce73eab..e0edd594 100644
> --- a/drivers/rtc/rtc-snvs.c
> +++ b/drivers/rtc/rtc-snvs.c
> @@ -272,7 +272,6 @@ static const struct regmap_config snvs_rtc_config = {
>   static int snvs_rtc_probe(struct platform_device *pdev)
>   {
>   	struct snvs_rtc_data *data;
> -	struct resource *res;
>   	int ret;
>   	void __iomem *mmio;
>   
> @@ -284,9 +283,8 @@ static int snvs_rtc_probe(struct platform_device *pdev)
>   
>   	if (IS_ERR(data->regmap)) {
>   		dev_warn(&pdev->dev, "snvs rtc: you use old dts file, please update it\n");
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   
Remove this blank line.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> -		mmio = devm_ioremap_resource(&pdev->dev, res);
> +		mmio = devm_platform_ioremap_resource(pdev, 0);
>   		if (IS_ERR(mmio))
>   			return PTR_ERR(mmio);
>   
