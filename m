Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF69C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845B920651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iYfj3jkh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iYfj3jkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbfC0PLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:11:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41260 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfC0PLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:11:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CAC6D60790; Wed, 27 Mar 2019 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553699476;
        bh=MODtx7813TSucvilWbV+OFYYSVAqW46NBhqC7gk6suo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iYfj3jkhI/lvjKouCzx9Mp/PUSK5pNLP6bbNxg5XD+7dkrzY1R4/yxj/MLKizNb0y
         /UNuIWZOgeUHN9bLYYlrxX6czujvPEyveB6HyKmUFsDSfYftv6YD0Uvz8ui+TPWVDw
         +z76EIgGvyrAh1taBn3wgBz2pfvmvepZsPZJ1Ek8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A30560790;
        Wed, 27 Mar 2019 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553699476;
        bh=MODtx7813TSucvilWbV+OFYYSVAqW46NBhqC7gk6suo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iYfj3jkhI/lvjKouCzx9Mp/PUSK5pNLP6bbNxg5XD+7dkrzY1R4/yxj/MLKizNb0y
         /UNuIWZOgeUHN9bLYYlrxX6czujvPEyveB6HyKmUFsDSfYftv6YD0Uvz8ui+TPWVDw
         +z76EIgGvyrAh1taBn3wgBz2pfvmvepZsPZJ1Ek8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A30560790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] net: ieee802154: fix missing checks for
 regmap_update_bits
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190324231856.2664-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <60649d69-5a89-cf42-8690-ec30a112da8f@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:41:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324231856.2664-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 4:48 AM, Kangjie Lu wrote:
> regmap_update_bits could fail and deserves a check.
>
> The patch adds the checks and if it fails, returns its error
> code upstream.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/net/ieee802154/mcr20a.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index c589f5ae75bb..8bb53ec8d9cf 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -533,6 +533,8 @@ mcr20a_start(struct ieee802154_hw *hw)
>   	dev_dbg(printdev(lp), "no slotted operation\n");
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>   				 DAR_PHY_CTRL1_SLOTTED, 0x0);
> +	if (ret < 0)
> +		return ret;
>   
>   	/* enable irq */
>   	enable_irq(lp->spi->irq);
> @@ -540,11 +542,15 @@ mcr20a_start(struct ieee802154_hw *hw)
>   	/* Unmask SEQ interrupt */
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
>   				 DAR_PHY_CTRL2_SEQMSK, 0x0);
> +	if (ret < 0)
> +		return ret;
>   
>   	/* Start the RX sequence */
>   	dev_dbg(printdev(lp), "start the RX sequence\n");
>   	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
>   				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
> +	if (ret < 0)
> +		return ret;
>   
>   	return 0;
>   }
