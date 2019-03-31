Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3CAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A901E20643
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XwIcq9Ot";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A2JPEDop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfCaJYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:24:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33006 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfCaJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:24:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1A1D56081E; Sun, 31 Mar 2019 09:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554024264;
        bh=4WOT/BoFlYFkhYyHXVc3Dvgw4H1LazYIh9UH+2gfxc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XwIcq9OtINv4/laVNoSdnL24VNTDPgJWQJxYD6o/BgOIleg4vjA8br2OpMPS0C9pH
         Adbh4/T9aOzDaVQmGSaL9wlAb6lucc2Xaz0FoaHb11jwjZd6SMAmVs6pyOzn1z+4W+
         ftxHfSmiGc9o3+86qYQDkP4+S5hM/vxn7lLpCh8M=
Received: from [10.79.166.22] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B220360736;
        Sun, 31 Mar 2019 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554024263;
        bh=4WOT/BoFlYFkhYyHXVc3Dvgw4H1LazYIh9UH+2gfxc8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A2JPEDopCq3iZwjdtXzLpXOCug2wKSPp07VcJSjwt5YUQUM77ZsOi6TrRweq1QvM0
         qzV6hPOPtvckUgvyUImac6baCPwWvhZmdu/AIRLlAJo9Khn7wUYE7ZX/RlxD65uOLt
         kCXXLvsYNOZp+fPF8a852w3bzKu8dfUDBY5g/v8A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B220360736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] spi: oc-tiny: fix negative loop bound error on for loop
To:     Colin King <colin.king@canonical.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190330212300.11675-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <88c53375-5727-c865-05ba-829b6e7d5128@codeaurora.org>
Date:   Sun, 31 Mar 2019 14:54:16 +0530
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


Same issue, here as well like your other patch. you are putting wrapper 
over a original issue by not checking the returned value.
Please fix that in both patches.



Thanks.
Mukesh

>   	u32 val;
>   
>   	if (!np)
