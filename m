Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1B9C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E8820652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="L7oPiFvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCGP5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:57:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34919 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGP5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:57:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so13914010edp.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/GqXQBmkdSqQ1wOgMWWR75IMCgWdLAO+p+34fsZNkW0=;
        b=L7oPiFvzIfbGYD2pUSC18v9jv5jkA+3ecOiEnebD0FF8RkhRAS8I3oA3BTQrymmW3F
         aeGv5JT50ZUgJQ2C7m2qLBXUx74E73VH3307clL9tiMDUeXqeDDJmOR34mxDS8wK67oY
         wXsRUjiPPgFalXXzXSFFwmDFdlHQenbrej9pF+H6Hig72zuI6ELOPSK8M3j5ZNnkMG9n
         vLTDpN6PWy0PdEAPCJaf+CPBxE553hnWZ4Om8s7ckg7h5KC5Rv2ppxui8R8IMCLItbBw
         4123tPMj6/ZdzQfW2UIATYen3Vh/MT72h+aCWBSldxKGjtfLJNX38KjQz0JeLFr+2l8y
         tMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/GqXQBmkdSqQ1wOgMWWR75IMCgWdLAO+p+34fsZNkW0=;
        b=ZNR7wQSvyAQoBVldk01Py57UtSkfpBeQXf1T1GuB8VOhTBkIAvIEaK7vJ/DLpUFTTw
         S840vheFImFvGDOJKMWpQVbsiQMhmfO82x+9AkHo6MPpKXDxAf4t2LVE2I7DuKW+00xx
         Vx8BYlYyCqJ4WzyuneYiJ/2S5AvqjIHJ2fwwzSc2X7Pn3TuPD277T8U+QQf4E8INhCER
         qPcQO8O+gi+oa2Zfcdv5VWWqpNnSiTUTQul5FXzmd3qCDO3j1T76iQG9l+0omMlraYxr
         MC41v3yXl8c06fs6jp+AVy5e3IpdaBWRbR5tQeT6b32JszgBdXJmYAWtOKvYDnrJDDRa
         qYaQ==
X-Gm-Message-State: APjAAAXMK0btQEiuim5xm4bSmC+3z/eG9kF7b85bOk2Vh//jLJNiMPGU
        /w2CAxKeoY/gPOZzH78O/zLNeA==
X-Google-Smtp-Source: APXvYqyjmE27orYbGEaM615J3UNweo0x7hvQqNs0J8AHFX4ISC/e0/9eSj/liVzQep/nRuZ5RKSdDg==
X-Received: by 2002:a50:e70a:: with SMTP id a10mr28965559edn.70.1551974272677;
        Thu, 07 Mar 2019 07:57:52 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id z49sm1448730edb.15.2019.03.07.07.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:57:51 -0800 (PST)
Subject: Re: [PATCH] pblk: fix max_io calculation
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20190307121853.14503-1-javier@javigon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8b13dcf3-4486-0e14-b718-417c7fc42a7b@lightnvm.io>
Date:   Thu, 7 Mar 2019 16:57:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190307121853.14503-1-javier@javigon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/19 1:18 PM, Javier González wrote:
> When calculating the maximun I/O size allowed into the buffer, consider
> the write size (ws_opt) used by the write thread in order to cover the
> case in which, due to flushes, the mem and subm pointers are disaligned
> by (ws_opt - 1). This case currently translates into a stall when
> an I/O of the largest possible size is submitted.
> 
> Fixes: f9f9d1ae2c66 ("lightnvm: pblk: prevent stall due to wb threshold")
> 
> Signed-off-by: Javier González <javier@javigon.com>
> ---
> 
> Matias: Can you apply this as a fix to 5.1. This is a case I missed when fixing
> the wb threshold, which is also scheduled for 5.1
> 
> Thanks,
> Javier
> 
>   drivers/lightnvm/pblk-rl.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> index b014957dde0b..a5f8bc2defbc 100644
> --- a/drivers/lightnvm/pblk-rl.c
> +++ b/drivers/lightnvm/pblk-rl.c
> @@ -233,10 +233,15 @@ void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
>   	/* To start with, all buffer is available to user I/O writers */
>   	rl->rb_budget = budget;
>   	rl->rb_user_max = budget;
> -	rl->rb_max_io = threshold ? (budget - threshold) : (budget - 1);
>   	rl->rb_gc_max = 0;
>   	rl->rb_state = PBLK_RL_HIGH;
>   
> +	/* Maximize I/O size and ansure that back threshold is respected */
> +	if (threshold)
> +		rl->rb_max_io = budget - pblk->min_write_pgs_data - threshold;
> +	else
> +		rl->rb_max_io = budget - pblk->min_write_pgs_data - 1;
> +
>   	atomic_set(&rl->rb_user_cnt, 0);
>   	atomic_set(&rl->rb_gc_cnt, 0);
>   	atomic_set(&rl->rb_space, -1);
> 

Hi Jens,

If possible, could you please pick this one up for 5.1? It fixes a 
previous patch that was introduced in 5.1 that should fix a stall, but 
didn't quite catch it.

Thank you,
-Matias
