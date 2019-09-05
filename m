Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D25C43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EF720870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567702499;
	bh=nKT/O1n/v5MYBOvcPUjxo6kL8wDcef637/w8VZsls4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WLii09jNLtZUO7cNSHHhpqBFJ+9MF10WI6JxhZSNmFpOzkbVIOV8miTTBg+EGX9gy
	 j1CZCe4ccOEDxHTfCdluj2h6dNGyWYmqCLJd1IySZZ7UIXbljhPCct8hpxxBEtMkZq
	 anASuJEGUgLk60ZuzZwDF5TOG0NGfBjY2ta17ZvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390508AbfIEQy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:54:57 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41888 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbfIEQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:54:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id o11so2779993qkg.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jE6ZC79bO1bFrMB62KwN7ZpncSaTigWMUVJvTrnSnEw=;
        b=QzFf35aYyGJUJ+WAn5dJTu/ucM/ixxhXMHyeGmrNJ6+I47BgYtPAaPLT5v/FxN7Vyl
         +XkNqEZR9TGd7ap9y7Xq7oDKPsxKAYky2rxCTJYEavjqHOGb+vAAWTQAS4VctRqTiKYa
         4HvizQ66m+p2e45W1vx71gs776bMvJOALfVlSi1zU4THOzoflV+qiTPriZjRwGz/Vags
         C0+96iGoc2+ZJddypu1z9jhUJOg8CtJ7tzTbRHcw4xaqJUnpDR8lT4tV9lYWkoE9KqqW
         p8t0lfezafFv5M6lN3Oh8bKgw3dqKuLyo1Mtn70DocStg4/c4Ujux4kl5OxXqlYNWCAF
         PrlQ==
X-Gm-Message-State: APjAAAXDdBXtZNkTojib/5dgjdmOtZIy1WlXeeiKlsHQ8ZemY+w9+gSl
        ftgWS8CXQHzbuIeVxtfjElk=
X-Google-Smtp-Source: APXvYqwfLOIHZyQ8iOjDluAk4+y+6lFXCmFhYZR1/22lWMsqrGXka5bWbv19wHUkbOT8953e4sY3ag==
X-Received: by 2002:a37:7686:: with SMTP id r128mr3835153qkc.444.1567702495838;
        Thu, 05 Sep 2019 09:54:55 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::2:4832])
        by smtp.gmail.com with ESMTPSA id r19sm1560936qte.63.2019.09.05.09.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:54:54 -0700 (PDT)
Date:   Thu, 5 Sep 2019 12:54:52 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: Use struct_size() helper
Message-ID: <20190905165452.GA41838@dennisz-mbp.dhcp.thefacebook.com>
References: <20190829190605.GA17425@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829190605.GA17425@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 02:06:05PM -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct pcpu_alloc_info {
> 	...
>         struct pcpu_group_info  groups[];
> };
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> So, replace the following form:
> 
> sizeof(*ai) + nr_groups * sizeof(ai->groups[0])
> 
> with:
> 
> struct_size(ai, groups, nr_groups)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  mm/percpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 7e2aa0305c27..7e06a1e58720 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2125,7 +2125,7 @@ struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
>  	void *ptr;
>  	int unit;
>  
> -	base_size = ALIGN(sizeof(*ai) + nr_groups * sizeof(ai->groups[0]),
> +	base_size = ALIGN(struct_size(ai, groups, nr_groups),
>  			  __alignof__(ai->groups[0].cpu_map[0]));
>  	ai_size = base_size + nr_units * sizeof(ai->groups[0].cpu_map[0]);
>  
> -- 
> 2.23.0
> 
> 

Hi Gustavo,

Sorry about the delay, I meant to get to this before the holiday. I've
applied it to for-5.4.

Thanks,
Dennis
