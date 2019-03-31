Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5F6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960E12082C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SV+zO5Hu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ahz5+jP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfCaJXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:23:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfCaJXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:23:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2FA3A6083E; Sun, 31 Mar 2019 09:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554024189;
        bh=IDcIBT7E9MG2hxZkNAYQL8IF1tG+LOmWYIlJb1/i5rc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SV+zO5HuO7cwkNB7CQCFyJRNnGsAEEc4ATiTMPe9bbObLSeyMU00ZifowNFHQlDrX
         CzXpHkMQg1w4qtqmnRBO44bqWXMDTVRtw7uUMEFwzZJU8zZ0DLf/S3NrcdP2aRVL2s
         e2xO9kB/Q3EMO6f2nyr1Yh5BaM60qgSuBQGHSQ/c=
Received: from [10.79.166.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E7E56047C;
        Sun, 31 Mar 2019 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554024188;
        bh=IDcIBT7E9MG2hxZkNAYQL8IF1tG+LOmWYIlJb1/i5rc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ahz5+jP7l5jeWVCXQxBbzKkSisFmGLnZlohW2wrI8JF5Y8p0p2Gz/nf4v5Xf9AusF
         DNyyU9XIjQjm0cuuLjZYEM+j8aRPGG1ZfmPA2fQ7W1UL+xSMuM2AWd8VDWnwM2/34M
         uJDssaggGAcWkrOawd5I2lWnzi9tHoyd2ljXDdVw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E7E56047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] spi: oc-tiny: fix negative loop bound error on for loop
To:     Colin King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190330212300.11675-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2461a0c8-9d60-d8c3-3021-4a97d91f70ee@codeaurora.org>
Date:   Sun, 31 Mar 2019 14:53:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330212300.11675-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2019 2:53 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the for-loop using an unsigned int for the loop counter
> which is problematic when comparing it to the signed int
> gt->gpio_cs_count.  This is an issue because if the signed int is
> negative (for example, the call to of_gpio_count failed) then
> the negative loop bound is implicitly cast to an unsigned int on
> the comparison to loop counter i and will yield a very large value,
> eventually causing an array bounds overflow on hw->gpio_cs.
>
> Fix this by simply making the loop counter i a signed int;
>
> Fixes: ca632f556697 ("spi: reorganize drivers")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/spi/spi-oc-tiny.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
> index 085f580be7ec..81f74b938dc9 100644
> --- a/drivers/spi/spi-oc-tiny.c
> +++ b/drivers/spi/spi-oc-tiny.c
> @@ -206,7 +206,7 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
>   {
>   	struct tiny_spi *hw = platform_get_drvdata(pdev);
>   	struct device_node *np = pdev->dev.of_node;
> -	unsigned int i;
> +	int i;


same here as well you are putting wrapper over a original issue by not 
checking the returned value.
Please fix that in both patches.



Thanks.
Mukesh

>   	u32 val;
>   
>   	if (!np)
