Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04537C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3352081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCHDM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:12:58 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:50052 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCHDM5 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 7 Mar 2019 22:12:57 -0500
Received: from linux-fcij.suse (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 07 Mar 2019 20:12:45 -0700
Subject: Re: [PATCH] md: Fix failed allocation of md_register_thread
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190304224854.12494-1-pakki001@umn.edu>
From:   Guoqing Jiang <gqjiang@suse.com>
Message-ID: <854b0e4a-35e4-4666-5d05-c1f9ffaceae8@suse.com>
Date:   Fri, 8 Mar 2019 11:12:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190304224854.12494-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/19 6:48 AM, Aditya Pakki wrote:
> mddev->sync_thread can be set to NULL on kzalloc failure downstream.
> The patch checks for such a scenario and frees allocated resources.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/md/raid10.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index abb5d382f64d..f52b4d9bcd24 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -3939,6 +3939,8 @@ static int raid10_run(struct mddev *mddev)
>   		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>   		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
>   							"reshape");
> +		if (!mddev->sync_thread)
> +			goto out_free_conf;
>   	}
>   
>   	return 0;

Could you make the change for raid5 as well? It also doesn't check the 
failure
in raid5_run.

Thanks,
Guoqing
