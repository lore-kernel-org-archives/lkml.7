Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E1F2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SPtpBXpf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TEuBPB6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732158AbfDAIYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:24:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42302 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbfDAIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:24:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1CFB261A4A; Mon,  1 Apr 2019 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554107071;
        bh=H32UIKPSQakTiun3Yb8bB1Pwk/cnLrrySxLefa1N1+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SPtpBXpf4mRJdUUR3hbqCGpp25dEtCON1MEPckXEEctQEXaR5Zrkb35bw9iqIlbYf
         fCc/yy2y2LauR0My+0L1tfGXz9voPD2lFGAuqhnRWKqPjT1pAngzHZl28/gqx0KHXL
         2EjkDC1Ga/mhAOFA9GYF/U5ths/4JPivD4GGXsRE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1427E61572;
        Mon,  1 Apr 2019 08:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554107070;
        bh=H32UIKPSQakTiun3Yb8bB1Pwk/cnLrrySxLefa1N1+Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TEuBPB6SlyFkzILXJIUV4cpoKQw5Q2y1QNRZK1f5gxXLNuGknVdEkYu9piK+jdF17
         aRz5eJCRFQzWEngjXguSJzpoled4BhWeVLOdTLc/6Ixk8TVN33sroItx50Eu/Q3a4/
         O1Ja68YBVde9DiwaZDtkXC/vpqvn2+Kurw7Q/iZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1427E61572
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] dccp: Fix memleak in __feat_register_sp
To:     Yue Haibing <yuehaibing@huawei.com>, davem@davemloft.net,
        gerrit@erg.abdn.ac.uk
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        dccp@vger.kernel.org
References: <20190401013554.17488-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <4ad301d4-7af2-87e4-9b52-9c4eee09b79c@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:54:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401013554.17488-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 7:05 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> If dccp_feat_push_change fails, we forget free the mem
> which is alloced by kmemdup in dccp_feat_clone_sp_val.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e8ef967a54f4 ("dccp: Registration routines for changing feature values")
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---


I don't think it is the first version. Do keep in mind to put detail here .

-Mukesh

>   net/dccp/feat.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/dccp/feat.c b/net/dccp/feat.c
> index f227f00..db87d9f 100644
> --- a/net/dccp/feat.c
> +++ b/net/dccp/feat.c
> @@ -738,7 +738,12 @@ static int __feat_register_sp(struct list_head *fn, u8 feat, u8 is_local,
>   	if (dccp_feat_clone_sp_val(&fval, sp_val, sp_len))
>   		return -ENOMEM;
>   
> -	return dccp_feat_push_change(fn, feat, is_local, mandatory, &fval);
> +	if (dccp_feat_push_change(fn, feat, is_local, mandatory, &fval)) {
> +		kfree(fval.sp.vec);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
>   }
>   
>   /**
