Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5343FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2358F2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZAZQqeR4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M7PrN2WV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfCVLwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:52:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732683AbfCVLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:52:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14B0A61728; Fri, 22 Mar 2019 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553255533;
        bh=rawpSVqa1bskqqmhAVkN/rVrlWCL224jzBAzEXrIkh4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZAZQqeR4WkrzT2YYM4t6GGbJD0gKs5Ulmxn/FQHKNIyTzwn+A/ixhwCCJ1ToTfEVr
         zhb7emQF05lhY1VSZyqMFW31bHYTuoTVEP8JQKurDvyPennq7Fb23aM4Pd9SeAf/Y0
         ivAPeSMUwVf7RaODdSgw3QVgnDxocwR9Zjbk2jtw=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C5B861A7D;
        Fri, 22 Mar 2019 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553255532;
        bh=rawpSVqa1bskqqmhAVkN/rVrlWCL224jzBAzEXrIkh4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M7PrN2WVFO7hgUtEOGViFyrjGrF9d/L7Dz54ygMJvX6Pca+IGE64NHNTfRiy9QTg7
         dD7U7SNs/tLt0Z4YX8GmDOGNtEEeACR1VAIxa2jqx6x9WU8jw9swwi3omAji2upb2r
         GDHOBwWFIHoLbKs1UAxwhCPyNNnlpd5ZskH2s5cQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C5B861A7D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] dccp: Fix memleak in __feat_register_sp
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        gerrit@erg.abdn.ac.uk
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dccp@vger.kernel.org
References: <20190321141058.14580-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <21f94a25-949a-1a6a-2ba2-59c829edeb04@codeaurora.org>
Date:   Fri, 22 Mar 2019 17:22:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190321141058.14580-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/2019 7:40 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> If dccp_feat_push_change fails, we forget free the mem
> which is alloced by kmemdup in dccp_feat_clone_sp_val.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   net/dccp/feat.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/dccp/feat.c b/net/dccp/feat.c
> index f227f00..083e012 100644
> --- a/net/dccp/feat.c
> +++ b/net/dccp/feat.c
> @@ -738,7 +738,12 @@ static int __feat_register_sp(struct list_head *fn, u8 feat, u8 is_local,
>   	if (dccp_feat_clone_sp_val(&fval, sp_val, sp_len))
>   		return -ENOMEM;
>   
> -	return dccp_feat_push_change(fn, feat, is_local, mandatory, &fval);
> +	if (dccp_feat_push_change(fn, feat, is_local, mandatory, &fval)) {
> +		kfree(val->sp.vec);

Please atleast check the compilation first, don't  just rush into 
sending patch.

s/val/fval


Thanks,
Mukesh

> +		return -ENOMEM;
> +	}
> +
> +	return 0;
>   }
>   
>   /**
