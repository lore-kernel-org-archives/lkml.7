Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33AC43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9452073B
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gF5tsuVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfKPGbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 01:31:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45958 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfKPGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 01:31:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so9979067otk.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 22:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpODNTcWa+A401urYWGM84SXXQR7l3TKPlFdQmVBzs0=;
        b=gF5tsuVznJqnYWo56MgDxdPAGHHFgIvh1vwSch7ES7KJAJagvN85gQi55vmuMMjr8g
         fAl9TmJtGOhmH9KI53u2YV33HKDJ8GTzQJbR3olwc6IyhHVNXyxed7HTw3rcbH4O5lXg
         DFBWyLdLVZMA+dXLRbjIYwehUYEqK7HGAZdwGwaXyMuFMJEDQbOtHMaVrIC4JoOFEdrD
         FtnKLpPZy5bsGy7UUfNuL1Tdyd/MRvKuAOQJSQIf8kI9Mmr9deFM9R29KE4nATXS8TTA
         T9Afm2+ns3B0dWXdhrrPyZZ0VPSd/wl9QL8b4RH2Lv7wLMh5fKb1HP5Vpcak//Q3Ps9F
         jZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpODNTcWa+A401urYWGM84SXXQR7l3TKPlFdQmVBzs0=;
        b=M+kJhoAI0wLz0uct2IT1S/P7X+Aw8WRUn3n3OBoY17HSy15SwzrcdmeHwQhaQn7kJy
         AJjlZ9UkAz2hcRM8ahfEzqE9gZxxvXSA35V2CgdcRI55YCBESpyttO4QjELedTHHV3Ah
         POhnw/3bSogF7maRIhb9iJZw3nyd/7EBALObmhvD7R2Mt48U6/5Qq+O1QDnFRQHi5PCw
         TepEe8jDg6kP6RY7ewLNd8yiAWKHZQ/Zy0C31Qx8iZOjs+o5z24S2buDwCTCCHqfIlSs
         N0xZrk2B3KkMK/RWkzESt4Bn6qfo7FFpo6w8TMkGttqY0FjlrwFPynNxmKpajhY//Cbg
         WbtQ==
X-Gm-Message-State: APjAAAVvlhwMZUt7yQbP5g/uofWRu32HIH9SYoujoBNXOjK7auG9ax+G
        BSHrnLsBRIRucU+yN+FqHiTS8il+66J+K2MyRedMGj4mqrc=
X-Google-Smtp-Source: APXvYqy+ZtE/c62xax1ax1pMapTf40gQj6BeNbMWYRA6Pe8p/qNZ7oGWKtS/5hg4q9wMQECRwkR+6tYjUMuHgQwxl6I=
X-Received: by 2002:a9d:400d:: with SMTP id m13mr13658836ote.360.1573885893136;
 Fri, 15 Nov 2019 22:31:33 -0800 (PST)
MIME-Version: 1.0
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com> <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 Nov 2019 22:31:22 -0800
Message-ID: <CALvZod5xuetOb8Vunhgjp69-HcrnHgGHZKKyjVBo3tmoc3WqaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm/lruvec: add irqsave flags into lruvec struct
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 7:15 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> We need a irqflags vaiable to save state when do irqsave action, declare
> it here would make code more clear/clean.
>
> Rong Chen <rong.a.chen@intel.com> reported the 'irqflags' variable need
> move to the tail of lruvec struct otherwise it causes 18% regressions of
> vm-scalability testing on his machine. So add the flags and lru_lock to
> both near struct tail, even I have no clue of this perf losing.

Regressions compared to what? Also no need to have a separate patch.

>
> Originally-from: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> CC: Rong Chen <rong.a.chen@intel.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mmzone.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a13b8a602ee5..9b8b8daf4e03 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -269,6 +269,8 @@ struct lruvec {
>         unsigned long                   flags;
>         /* per lruvec lru_lock for memcg */
>         spinlock_t                      lru_lock;
> +       /* flags for irqsave */
> +       unsigned long                   irqflags;
>  #ifdef CONFIG_MEMCG
>         struct pglist_data *pgdat;
>  #endif
> --
> 1.8.3.1
>
