Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5507BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C53521773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NkTukKYy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ONeM8Rn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfC1KWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:22:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1KWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:22:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 61D7E61215; Thu, 28 Mar 2019 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553768569;
        bh=ob7RqlO5/sU2c3rqISRrnIe5pO5ErUNNMzQrLigmU9g=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NkTukKYyktt7rdnaTX0lR3pb1tsiar0ewY0aJTJVPwedPIETUa8o++Q2paGrQapdy
         8m/Uuxo+mEEEN7jis72t3ondytVfVNajtp82P+GhZZGMSYF+4PbLoEicYkdDZuAO4P
         zcmMCCBPK/JQXd7E4ojPQJ/kzpXUdiohQlpnsnOQ=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7E217615E7;
        Thu, 28 Mar 2019 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553768565;
        bh=ob7RqlO5/sU2c3rqISRrnIe5pO5ErUNNMzQrLigmU9g=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ONeM8Rn8yRcpBJ7mZA3f6Jv0mIE2bH6PkzNFi8AI+CajF+x3RRUNA3c0shObdeCKq
         XLavIEBW0/1Zwjyo0yCKmvX8SNrcAGRZvBSJEA0IOeaQRxeFTMOVy7c6wUMIw5N+Zq
         m+rZB5/Up7lPgz9jVbh3lJXuE50iwkD49l+9iyZY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E217615E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drivers/fmc: remove unneeded NULL check
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, rubini@gnudd.com,
        linux-kernel@vger.kernel.org
References: <1553764997-26484-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9a0194ef-2c45-3a29-2297-ee632779adb0@codeaurora.org>
Date:   Thu, 28 Mar 2019 15:52:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553764997-26484-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 2:53 PM, Ding Xiang wrote:
> The variable will check in debugfs_remove_recursive, so
> the NULL check here is not needed
>
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/fmc/fmc-debug.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/fmc/fmc-debug.c b/drivers/fmc/fmc-debug.c
> index 3293072..ab868a3 100644
> --- a/drivers/fmc/fmc-debug.c
> +++ b/drivers/fmc/fmc-debug.c
> @@ -168,6 +168,5 @@ int fmc_debug_init(struct fmc_device *fmc)
>   
>   void fmc_debug_exit(struct fmc_device *fmc)
>   {
> -	if (fmc->dbg_dir)
> -		debugfs_remove_recursive(fmc->dbg_dir);
> +	debugfs_remove_recursive(fmc->dbg_dir);
>   }
