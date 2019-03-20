Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F522C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEEC2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ndwItXzc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XGEixebS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfCTNMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:12:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfCTNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:12:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 551696077A; Wed, 20 Mar 2019 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553087572;
        bh=8cQFGJzruBoiOgswrjb5Wx0cq9dJamop5K9KAFud7Ss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ndwItXzcFREELCeXi196ZnMyPHha6a0/TfHCtcFs2k44NJNUmUZij8T6f1o/1dgtj
         WNQCg31O/EQxw8oTlJhl1erSdP5TwjxosOymyxtspCXYJR+hOGXEkPOJVqzw2cDHcL
         UgKyHGBXjlC3/9SIVdQjY5HY4CB3kjiqqa5MbFDo=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 966B6602FC;
        Wed, 20 Mar 2019 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553087571;
        bh=8cQFGJzruBoiOgswrjb5Wx0cq9dJamop5K9KAFud7Ss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XGEixebSdfkGiGCEC6R7QMIAWWWqsYy33KQEIvDH+OmHgPnC6FRbwwILmgn/txFWt
         h6Sl5qUnjtQ4Xf6lRvvN3vrUJN463iHf2mXIXWy44V+AdOWmTtixBvgByIBO/oGvWG
         QAKR+DbcRAK3gPBPIknQvD8Ln7AZPSII+j9WYrcY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 966B6602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: rtlwifi: Fix potential NULL pointer dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190313161336.20182-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <4c393bbd-9d93-6f6e-fc82-133304cfdf69@codeaurora.org>
Date:   Wed, 20 Mar 2019 18:42:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190313161336.20182-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/13/2019 9:43 PM, Aditya Pakki wrote:
> phydm.internal is allocated using kzalloc which is used multiple
> times without a check for NULL pointer. This patch avoids such a
> scenario.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/staging/rtlwifi/phydm/rtl_phydm.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/staging/rtlwifi/phydm/rtl_phydm.c b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> index 9930ed954abb..37c7fcb72b65 100644
> --- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> +++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> @@ -181,6 +181,9 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
>   	rtlpriv->phydm.internal =
>   		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
>   
> +	if (!rtlpriv->phydm.internal)
> +		return -ENOMEM;
> +



Although, it is good to add a check but nobody is checking this 
functions returned value.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Can you fix that cleanly ? Otherwise i will do.

Cheers,
Mukesh


>   	_rtl_phydm_init_com_info(rtlpriv, ic, params);
>   
>   	odm_init_all_timers(dm);
