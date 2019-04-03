Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C88C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C921473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VKvmVjET";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DAdJOtkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDCJHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:07:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDCJHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:07:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8668360FED; Wed,  3 Apr 2019 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554282424;
        bh=DSkCp9suFSm4FVR7lP7OaPdF+0wJ9sUbA+7BjvF6/Vg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VKvmVjETsbPcwmyJZ4ok8k3io9VuoCG2Dq9yGrgoLQ55Z+HvASwnC020Skuf/jxGf
         hCxU9SC5JG06QP6jXeR9Qww+/lyaXKLf9OwEQoFKyIaEyBRDFNFwrtOcEtKpvfHqc8
         so49R8F36H20LFlyuuv5WtNlWUUvqkwaXXNpNy0Q=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DFA7560CED;
        Wed,  3 Apr 2019 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554282421;
        bh=DSkCp9suFSm4FVR7lP7OaPdF+0wJ9sUbA+7BjvF6/Vg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DAdJOtkSSd4SGLKPI6NOUeT+OQbMP132UMTpZTGKarLBd5VvBFIgbsucXAkUqiN0g
         YMrxv4p6hGfNXNrdWnzDmZjWvsJYkG915hfi1rzjCwPtm1np7aFapO3cjNeIIdT0vu
         ebXgKIofIwzrY7J1xDCbCrb4bGEesepNbSJQ+9C8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DFA7560CED
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ibmvnic: remove set but not used variable 'netdev'
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        tlfalcon@linux.ibm.com, jallen@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20190403075409.29384-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1fda3007-ace5-a3fc-4a1d-22120fec6717@codeaurora.org>
Date:   Wed, 3 Apr 2019 14:36:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403075409.29384-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/2019 1:24 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/net/ethernet/ibm/ibmvnic.c: In function '__ibmvnic_reset':
> drivers/net/ethernet/ibm/ibmvnic.c:1971:21: warning: variable 'netdev' set but not used [-Wunused-but-set-variable]
>
> It's never used since introduction in
> commit ed651a10875f ("ibmvnic: Updated reset handling")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 25b8e04..20c4e08 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -1968,13 +1968,11 @@ static void __ibmvnic_reset(struct work_struct *work)
>   {
>   	struct ibmvnic_rwi *rwi;
>   	struct ibmvnic_adapter *adapter;
> -	struct net_device *netdev;
>   	bool we_lock_rtnl = false;
>   	u32 reset_state;
>   	int rc = 0;
>   
>   	adapter = container_of(work, struct ibmvnic_adapter, ibmvnic_reset);
> -	netdev = adapter->netdev;
>   
>   	/* netif_set_real_num_xx_queues needs to take rtnl lock here
>   	 * unless wait_for_reset is set, in which case the rtnl lock
