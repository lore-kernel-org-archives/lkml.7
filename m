Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F0FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBE62087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="zP4ASyvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfCLOny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:43:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43800 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCLOny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:43:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id z20so2526135ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5NQcBxY47fw3R8/zazl7n563AF9t648pimjaUCnVC6o=;
        b=zP4ASyvOB5laE7R7jCLh3iAHt9D9CiVOvG0hbINCL1gy4msFEE3vcABlCkj7pCnBqC
         bTpDVu1gP0cvQ2rhbA1Drzp4UUWD0yT43NBwhIKaiUnMv4knlEmi1on+7YBaJ/ej8dtW
         0MH3SiK+Le6nQy55dggIHcaGLRGmgt9hV4aKV8Ophxk4uQp7oy8A+PmMvXw5lU7UbDHg
         nEuScAkMW4jenBguQqUeCN0LKPtBKfIkRv/4Byh3+VY7cR6CfR/1b40IWCjP5lVq9biY
         L2FWOSI9n4ovqUZopso84+0mk93rVEJ3fIXqcrOp6k/LM8dXxSdtVjOXGJJRMJCoupdw
         aPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5NQcBxY47fw3R8/zazl7n563AF9t648pimjaUCnVC6o=;
        b=hERq+Jf58nD7VKOc7KFr2A4GivS8OAmrgMsTXiZLJPsrUm6wbtMzJJAAa29Ym6rzL5
         5LlAGUF8LZKcvyfqmwDD4DHvRv4A7XuJ/XO404ldswoFcpZYw4ApaTFlwQQ/Yd9Z6jQP
         LMQanZQc6Eb7VBnHLLVSlV5gTTdLAYcTe0/3/KkYTVRmp84Hyg+XkNl0YkDdkPQLV1ic
         hDycSTcXaSf9kTvgYPJQM4lBOy88zIj1ZjfRq4qf1xLhF94I2PkkWS/2BpRdWU5Idf9I
         2AFPmJTspLF2L4tqM2rkcNCB4MxLa+8RKqKbQcdRFBSXH8/lJ0DC63QAbQ6ec+sc4Fcf
         fa3A==
X-Gm-Message-State: APjAAAVCgiGbKT7TKFIn2Dkg9wbX0uw1rKAO/qE18szCdHE02VF5/5AF
        J58nTd0b1cbieM3qe20A8EJxrQ==
X-Google-Smtp-Source: APXvYqxT9I2NHOiXGBUffv6hOydayjqB/ICcA/4+QsQl1SbjsexnRVWjT8hUSgsL6L6HndhBH1SEmw==
X-Received: by 2002:a2e:b001:: with SMTP id y1mr19922877ljk.130.1552401832012;
        Tue, 12 Mar 2019 07:43:52 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.160])
        by smtp.gmail.com with ESMTPSA id l11sm1383945lja.38.2019.03.12.07.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:43:51 -0700 (PDT)
Subject: Re: [PATCH 4/9] drivers: ata: ahci_xgene: use
 devm_platform_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1552382374-28789-1-git-send-email-info@metux.net>
 <1552382374-28789-4-git-send-email-info@metux.net>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <4cab769a-f4cf-4042-fd0b-1a33f0dbd4f7@cogentembedded.com>
Date:   Tue, 12 Mar 2019 17:43:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1552382374-28789-4-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/12/2019 12:19 PM, Enrico Weigelt, metux IT consult wrote:

> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/ata/ahci_xgene.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 7e157e1..99c622c 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -752,7 +752,6 @@ static int xgene_ahci_probe(struct platform_device *pdev)
[...]
>  	/* Retrieve the optional IP mux resource */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
> -	if (res) {
> -		void __iomem *csr = devm_ioremap_resource(dev, res);
> -		if (IS_ERR(csr))
> -			return PTR_ERR(csr);
> -
> -		ctx->csr_mux = csr;
> +	ctx->csr_mux = csr = devm_platform_ioremap_resource(pdev, 4);
> +	if (IS_ERR(ctx->csr_mux)) {
> +		dev_info(&pdev->dev, "cant get ip mux resource (optional)");

   Can't.

> +		ctx->csr_mux = NULL;

MBR, Sergei
