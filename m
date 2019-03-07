Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C5320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCGKea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:34:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:57138 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726182AbfCGKeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:34:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 798FFB77C;
        Thu,  7 Mar 2019 10:34:24 +0000 (UTC)
Subject: Re: [PATCH] bcache: add cond_resched() in __bch_cache_cmp()
To:     shile.zhang@linux.alibaba.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1551935728-243664-1-git-send-email-shile.zhang@linux.alibaba.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <24916a71-39ff-7324-ad12-9d79cc68d0da@suse.de>
Date:   Thu, 7 Mar 2019 18:34:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1551935728-243664-1-git-send-email-shile.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/7 1:15 下午, shile.zhang@linux.alibaba.com wrote:
> From: Shile Zhang <shile.zhang@linux.alibaba.com>
> 
> Read /sys/fs/bcache/<uuid>/cacheN/priority_stats can take very long
> time with huge cache after long run.
> 
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

Hi Shile,

Do you test your change ? It will be helpful with more performance data
(what problem that you improved).

Thanks.

Coly Li

> ---
>  drivers/md/bcache/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 557a8a3..028fea1 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -897,6 +897,7 @@ static void bch_cache_set_internal_release(struct kobject *k)
>  
>  static int __bch_cache_cmp(const void *l, const void *r)
>  {
> +	cond_resched();
>  	return *((uint16_t *)r) - *((uint16_t *)l);
>  }
>  
> 


-- 

Coly Li
