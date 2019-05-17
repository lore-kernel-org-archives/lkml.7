Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B9020879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 12:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DmsorBzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfEQMNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 08:13:45 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42107 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbfEQMNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 08:13:42 -0400
Received: by mail-yb1-f194.google.com with SMTP id a21so2541568ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3s5onH4EKHtLRHaMdmA6OtBScYx3vU5FV884xFkNgc=;
        b=DmsorBzXRDvon/8kG4JcRIox8FFPMnHLt2Pa3GMNzeTIrY3kOQXjVd2VBrPODbpCa3
         n050y2TXrw9wMMLA9KR+e/iqa+pf3SLfhWqrKyNx7sVQ7aFg4wnAf8t7TldJrIe152o3
         UNUCQC+vFQINNOPNJu1oYLW9PArZO3q0eoBIvwOWWnWrjBvnq3k2LJnsCjMZfI6trr1V
         UztxEjymcEYDQ32K/E4lRBDnX5v4Q0uH61h3RMK7mjXq4FZ4NTgtTEEsn2fqODJkLm7U
         SyyiGFcg9Tv0i1o4OTp7AbUrzF3DplnUdd5spgSdeF2Jeur5HMIkKz1gvcu1hJF/hmiL
         1U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3s5onH4EKHtLRHaMdmA6OtBScYx3vU5FV884xFkNgc=;
        b=ZMpua1OLlnyfOlh0EPzRXTEaCkXGeZSZYO2zxFPz1vf7dGqg98vphbv7iXAms9H3ji
         PL+fNFz5blcYkuiXHX6kjj8ajRsVEprCo6fR2p5yuEClBnOIj75PCD2N16SODnh9C7EC
         ZHj4jhDGX8y5WlwMSjDgl1oplKFkVMIjVBv+GrHoA9UQl4Cmh+U+0XRdN7ab7SkY5Ppp
         U1vhy/DdP5HNtjnfdf3mpPO6hSDJBtuc1TnoopLWL/Y0qJiTs/+FdXZkBCEODSfxpfck
         WH59mKB8YV4zGekP49hPmMAJS/OcT+Ihg60LbZ1croeLVL9z8xd+p9U89BrLXS13HOVr
         6LUQ==
X-Gm-Message-State: APjAAAXDC52l6fH7k7gvuJOWyxH262cDnBllnYugZST5Ei3cQHvaJ6Hl
        n5MDb3VYjzNmYSZoeOHeW161TspuW4ezYZ7H7QtCBQ==
X-Google-Smtp-Source: APXvYqxFgKrdchFhbncq+L/DflCvydSU3r588+pQQDqHWgrWJBOXXWXnbpaiVmZjZdH9qR6LbIbNq4yAxWHyN4nmiyo=
X-Received: by 2002:a25:b30b:: with SMTP id l11mr26189771ybj.172.1558095220713;
 Fri, 17 May 2019 05:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190517080044.tnwhbeyxcccsymgf@esperanza> <20190517114204.6330-1-jslaby@suse.cz>
In-Reply-To: <20190517114204.6330-1-jslaby@suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 May 2019 05:13:29 -0700
Message-ID: <CALvZod4w3Hfs1WBsNchp3J_Ymvuni=Ap-rBpaS=iXwd2P+5w5g@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: make it work on sparse non-0-node systems
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 4:42 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> We have a single node system with node 0 disabled:
>   Scanning NUMA topology in Northbridge 24
>   Number of physical nodes 2
>   Skipping disabled node 0
>   Node 1 MemBase 0000000000000000 Limit 00000000fbff0000
>   NODE_DATA(1) allocated [mem 0xfbfda000-0xfbfeffff]
>
> This causes crashes in memcg when system boots:
>   BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
>   #PF error: [normal kernel read fault]
> ...
>   RIP: 0010:list_lru_add+0x94/0x170
> ...
>   Call Trace:
>    d_lru_add+0x44/0x50
>    dput.part.34+0xfc/0x110
>    __fput+0x108/0x230
>    task_work_run+0x9f/0xc0
>    exit_to_usermode_loop+0xf5/0x100
>
> It is reproducible as far as 4.12. I did not try older kernels. You have
> to have a new enough systemd, e.g. 241 (the reason is unknown -- was not
> investigated). Cannot be reproduced with systemd 234.
>
> The system crashes because the size of lru array is never updated in
> memcg_update_all_list_lrus and the reads are past the zero-sized array,
> causing dereferences of random memory.
>
> The root cause are list_lru_memcg_aware checks in the list_lru code.
> The test in list_lru_memcg_aware is broken: it assumes node 0 is always
> present, but it is not true on some systems as can be seen above.
>
> So fix this by avoiding checks on node 0. Remember the memcg-awareness
> by a bool flag in struct list_lru.
>
> [v2] use the idea proposed by Vladimir -- the bool flag.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Suggested-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: <cgroups@vger.kernel.org>
> Cc: <linux-mm@kvack.org>
> Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  include/linux/list_lru.h | 1 +
>  mm/list_lru.c            | 8 +++-----
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index aa5efd9351eb..d5ceb2839a2d 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -54,6 +54,7 @@ struct list_lru {
>  #ifdef CONFIG_MEMCG_KMEM
>         struct list_head        list;
>         int                     shrinker_id;
> +       bool                    memcg_aware;
>  #endif
>  };
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0730bf8ff39f..d3b538146efd 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
>
>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>  {
> -       /*
> -        * This needs node 0 to be always present, even
> -        * in the systems supporting sparse numa ids.
> -        */
> -       return !!lru->node[0].memcg_lrus;
> +       return lru->memcg_aware;
>  }
>
>  static inline struct list_lru_one *
> @@ -451,6 +447,8 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
>  {
>         int i;
>
> +       lru->memcg_aware = memcg_aware;
> +
>         if (!memcg_aware)
>                 return 0;
>
> --
> 2.21.0
>
