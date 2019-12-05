Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC7E2464E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575539046;
	bh=RFTpQ/2aeZH14uClkRXY2oJYA9bua16jmP+Edib+ej4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LCBaHP+/Zu1jhq8MPQTWdhL0FFi1hdY/xouB5rRnzPEJ5jkZ98cjvhZHGaVijwh2L
	 ltiGjMYsdgDdSnJE40KqvFBajN4JYJyz0ltTVp9L/i9b7MtI66N0p3DLybGb/t1jDf
	 yTDZuYbjwzNMpPaPf2+dQPCMjpANDs+7PSCk2S4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfLEJoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:44:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51814 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbfLEJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:44:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so2882917wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ka9sSILTxUVdAZQPC7DMhXhoTbQ0HVKj/V2oqIbOzkM=;
        b=OTWQewy8kRchdGr01ZqnWI0I8Ih0mbaE8APRhgIjHUekpGLqXF62kRMloLv69YFdvB
         ggyLCS4KwFQUgsQVCpN+KbMQhipqmV0iDYVQSOF4MNqtX4POxdchxP/0924FI4euBlRe
         49fjadVBJixek4/0f7XvxHkauEOpVLepS/zTWH5dK4t7CDTMFsFxPTebwB/gOALDEAk3
         k/sMEoebmVub5I6x0W8PTyP0JnyUOobEr/DFlnIZj7lXKIUIbr7OQRhsueP74rSQ9DgI
         W/QOTDn/8rTBQnGEj7QnA1BIJCvnXK7NtwEVAwQRd+d2Kwi2Tl27w0PQXSkIBCg571ez
         EGKQ==
X-Gm-Message-State: APjAAAXh3zwIAHu0wuEma3Mag+Kf7IEPJDTODJUatbOWGncPpyI4QCnl
        a6jVIxbSvw3syuvY+YEo47g=
X-Google-Smtp-Source: APXvYqwrUVRVMKUxJPaCjMUQVE33lai5Ld4BdGvSwiW8Dv1YhLMcEAPCLflbsdQVilqLtU64uKqn0Q==
X-Received: by 2002:a1c:e007:: with SMTP id x7mr3938784wmg.3.1575539042064;
        Thu, 05 Dec 2019 01:44:02 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id x18sm11464223wrr.75.2019.12.05.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 01:44:01 -0800 (PST)
Date:   Thu, 5 Dec 2019 10:44:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, shakeelb@google.com,
        guro@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: protect shrinker idr replace with
 CONFIG_MEMCG
Message-ID: <20191205094400.GD28317@dhcp22.suse.cz>
References: <1575486978-45249-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575486978-45249-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-12-19 03:16:18, Yang Shi wrote:
> Since commit 0a432dcbeb32edcd211a5d8f7847d0da7642a8b4 ("mm: shrinker:
> make shrinker not depend on memcg kmem"), shrinkers' idr is protected by
> CONFIG_MEMCG instead of CONFIG_MEMCG_KMEM, so it makes no sense to
> protect shrinker idr replace with CONFIG_MEMCG_KMEM.
> 
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ee4eecc..e7f10c4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -422,7 +422,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
>  {
>  	down_write(&shrinker_rwsem);
>  	list_add_tail(&shrinker->list, &shrinker_list);
> -#ifdef CONFIG_MEMCG_KMEM
> +#ifdef CONFIG_MEMCG
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		idr_replace(&shrinker_idr, shrinker, shrinker->id);
>  #endif
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
