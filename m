Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE0AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D742075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DHubhqpF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XnmFszp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfC0Nmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:42:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41780 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbfC0Nmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:42:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 269AB60C72; Wed, 27 Mar 2019 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694162;
        bh=uqkwQJliackH0EEgsbA3hj/4fTUuBH6MhhnAy3sKmYI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DHubhqpFyAJ/wbDXfkgXuzMSJZFJrPfv6eugE1+ym33m4q7R3AaYDrh25GPwXoKRx
         Jbk+hbsakGZob8ZYi4TIImB+EDXge4O5qIG0g1GE/xZWU/s5QiAEpgwQoj4MM+CPAd
         QHQ0+zz2wdy49WBdFZyxSGNwtFz6nyC90cHmlsyY=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3C8D60CF1;
        Wed, 27 Mar 2019 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694160;
        bh=uqkwQJliackH0EEgsbA3hj/4fTUuBH6MhhnAy3sKmYI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XnmFszp2I/ctNar+RzMLI/6ut3O9EUBTnPeJTsUMV/3lM5XIIIBMr2PtEpQMTUZeD
         IR3vo8oKtl88t+8X9n3GspTI1RXPUe6Mpz4u1Ij79BfpyGZ0DkutiVAJKEFGq0R8ca
         Ldsa4urAEG5mMOcxFwlsSBMAv8G//cC4SyZc1CHU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3C8D60CF1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] net: stmmac: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190312073241.27495-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7dbb5203-19fa-36f5-487a-9fbb08a34c4d@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:12:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190312073241.27495-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/2019 1:02 PM, Kangjie Lu wrote:
> In case of_device_get_match_data fails, the fix return -ENOMEM

s/-ENOMEM/-EINVAL


Otherwise looks good to me.
Make the above correction.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> to avoid the NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index 3256e5cbad27..344ead5949b1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -485,6 +485,8 @@ static int dwc_eth_dwmac_remove(struct platform_device *pdev)
>   	int err;
>   
>   	data = of_device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return -EINVAL;
>   
>   	err = stmmac_dvr_remove(&pdev->dev);
>   	if (err < 0)
