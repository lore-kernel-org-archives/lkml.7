Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354B1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0601A20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oKVHexL8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pMpHnOn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfDDKQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:16:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39738 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDKQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:16:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3635E61B5D; Thu,  4 Apr 2019 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554372981;
        bh=RFTudF1rRaNt3OPm2mm6NoDnBvgqm0+bKsN0rR8r01o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oKVHexL8quzjjaPFs7tpyGgBXtcFCxQ6cayijiJhEy+dxLzcTdDByuQ3gRviSaosg
         tqe8g5M/R7+1K7UHhHnhpV74hrAnWS6Kc81PPJKXaRpp4cGRBFODHvng9AYyOHX4kS
         dsQGoyz0wDr0Rj2kld9FKbyF0AVmETzPoT9Stt30=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A7AC461C97;
        Thu,  4 Apr 2019 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554372979;
        bh=RFTudF1rRaNt3OPm2mm6NoDnBvgqm0+bKsN0rR8r01o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pMpHnOn6KXYkmKjSPmlNGpySR2wGvtZBtq8agWKyc5rWlDRtnidfg2124dEKRxf/8
         jz1QdgLVKo7kEmTfnzKti7/BaEbsUNBZUiTBEz2WAz8s4AAc0uWcIUacwIxMY4zBCr
         8JhpPerEz53YWWKLzh1U61cXrUfE4mR0bFLZiIU4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7AC461C97
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: rtl8192u: remove redundant null check on array
 'data'
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404093257.18757-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ced06fcb-153b-1e3c-4d6b-718dd3a91db7@codeaurora.org>
Date:   Thu, 4 Apr 2019 15:46:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404093257.18757-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 3:02 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The NULL check on ram->u.wpa_ie.data is redudant as data is
s/redudant/redundant
> zero-length array and is not a pointer, so it can't be null.
> Remove the check.
>
> Addresses-Coverity: ("Array compared against 0")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

fix the commit text minor err

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> index 944c8894f9ff..c4a4f118f547 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
> @@ -2659,8 +2659,7 @@ static int ieee80211_wpa_set_wpa_ie(struct ieee80211_device *ieee,
>   {
>   	u8 *buf;
>   
> -	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN ||
> -	    (param->u.wpa_ie.len && param->u.wpa_ie.data == NULL))
> +	if (param->u.wpa_ie.len > MAX_WPA_IE_LEN || param->u.wpa_ie.len)
>   		return -EINVAL;
>   
>   	if (param->u.wpa_ie.len) {
