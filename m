Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27912146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GMdIfA/L";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hk0/DHHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfCTT1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:27:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38332 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTT1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:27:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E5446119E; Wed, 20 Mar 2019 19:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553110031;
        bh=KxsE+Vgi098gw7lUagctKNE7jjetmQhiXBz4P4yXpss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GMdIfA/LX07diV4w/UODDabnaFHSKD2u8i7ea/zVerCCTaVswxWlWl2FnXElIJqO8
         p+K8DgX6Bj8KcIVvgIYyDWC23W/yqkHxkKOo8ytInAnv3MCPnvY6axoHno1jgniDCk
         ZoCRzAShlhiqg/cZ6+NmXcecxm/GGCp3Xk9rucbg=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C8E5261112;
        Wed, 20 Mar 2019 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553110030;
        bh=KxsE+Vgi098gw7lUagctKNE7jjetmQhiXBz4P4yXpss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hk0/DHHCwnQ32QvkyWXYCzqG3sO1WjTx+Av1hb/jCHSLzaxxL5lxZEC7yHC4N9rMv
         hXDTjdBNgh1ZhZ/bDt1za18eX+6POGsFeKj5YxxoDgyBice3lPogehhWBc83yyJxGU
         YY0nEHh6gMGEduLQHci9wLWLMy9S9rLdT5qN+6OU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C8E5261112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] watchdog: sb_wdog: Make sbwdog_set and sbwdog_pet
 static
To:     Yue Haibing <yuehaibing@huawei.com>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20190320134250.13348-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <45a85dca-93e8-80eb-3392-028a3dca4b3d@codeaurora.org>
Date:   Thu, 21 Mar 2019 00:57:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320134250.13348-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 7:12 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/watchdog/sb_wdog.c:70:6: warning: symbol 'sbwdog_set' was not declared. Should it be static?
> drivers/watchdog/sb_wdog.c:84:6: warning: symbol 'sbwdog_pet' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/watchdog/sb_wdog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
> index 3abae50..8264fced 100644
> --- a/drivers/watchdog/sb_wdog.c
> +++ b/drivers/watchdog/sb_wdog.c
> @@ -67,7 +67,7 @@ static DEFINE_SPINLOCK(sbwd_lock);
>    *
>    * wdog is the iomem address of the cfg register
>    */
> -void sbwdog_set(char __iomem *wdog, unsigned long t)
> +static void sbwdog_set(char __iomem *wdog, unsigned long t)
>   {
>   	spin_lock(&sbwd_lock);
>   	__raw_writeb(0, wdog);
> @@ -81,7 +81,7 @@ void sbwdog_set(char __iomem *wdog, unsigned long t)
>    *
>    * wdog is the iomem address of the cfg register
>    */
> -void sbwdog_pet(char __iomem *wdog)
> +static void sbwdog_pet(char __iomem *wdog)
>   {
>   	spin_lock(&sbwd_lock);
>   	__raw_writeb(__raw_readb(wdog) | 1, wdog);


Acked-by: Mukesh Ojha <mojha@codeaurora.org>


Thanks.

Mukesh

