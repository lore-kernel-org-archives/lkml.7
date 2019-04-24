Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9571FC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582D8218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 02:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfDXCu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 22:50:29 -0400
Received: from m9783.mail.qiye.163.com ([220.181.97.83]:48143 "EHLO
        m9783.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDXCu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 22:50:28 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2019 22:50:27 EDT
Received: from localhost (unknown [117.48.120.186])
        by m9783.mail.qiye.163.com (Hmail) with ESMTPA id 5DE85C1647;
        Wed, 24 Apr 2019 10:43:04 +0800 (CST)
Date:   Wed, 24 Apr 2019 10:43:04 +0800
From:   WANG Chao <chao.wang@ucloud.cn>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 3/3] RAS/CEC: immediate soft-offline page when
 count_threshold == 1
Message-ID: <20190424024304.GA53822@WANG-Chaos-MacBook-Pro.local>
References: <20190418034115.75954-1-chao.wang@ucloud.cn>
 <20190418034115.75954-3-chao.wang@ucloud.cn>
 <20190420115719.GD29704@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420115719.GD29704@zn.tnic>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-HM-Spam-Status: e1kIGBQJHllBS1VLV1koWUFJQjdXWS1ZQUlXWQkOFx4IWUFZMjUtOjcyP0
        FLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P1E6Dio4ETg2PjYKTw8NCA8R
        Ag1PFC1VSlVKTk5NS0xITENPTk5PVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SkxVT0NVSklLVUpDTVlXWQgBWUFJT0lONwY+
X-HM-Tid: 0a6a4d39a44a2085kuqy5de85c1647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/19 at 01:57P, Borislav Petkov wrote:
> On Thu, Apr 18, 2019 at 11:41:15AM +0800, WANG Chao wrote:
> > count_threshol == 1 isn't working as expected. CEC only does soft
> > offline the second time the same pfn is hit by a correctable error.
> 
> So this?
> 
> ---
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index b3c377ddf340..750a427e1a73 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -333,6 +333,7 @@ int cec_add_elem(u64 pfn)
>  
>  	mutex_lock(&ce_mutex);
>  
> +	/* Array full, free the LRU slot. */
>  	if (ca->n == MAX_ELEMS)
>  		WARN_ON(!del_lru_elem_unlocked(ca));
>  
> @@ -346,14 +347,9 @@ int cec_add_elem(u64 pfn)
>  			(void *)&ca->array[to],
>  			(ca->n - to) * sizeof(u64));
>  
> -		ca->array[to] = (pfn << PAGE_SHIFT) |
> -				(DECAY_MASK << COUNT_BITS) | 1;
> +		ca->array[to] = (pfn << PAGE_SHIFT) | 1;
>  
>  		ca->n++;
> -
> -		ret = 0;
> -
> -		goto decay;
>  	}
>  
>  	count = COUNT(ca->array[to]);
> @@ -386,7 +382,6 @@ int cec_add_elem(u64 pfn)
>  		goto unlock;
>  	}
>  
> -decay:
>  	ca->decay_count++;
>  
>  	if (ca->decay_count >= CLEAN_ELEMS)

It looks good to me. Thanks for a better fix.
