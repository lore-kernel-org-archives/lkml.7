Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F118AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4D20718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="BRKC2o/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfKOQR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:17:29 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:34771 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfKOQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:17:27 -0500
Received: by mail-pf1-f171.google.com with SMTP id n13so6918656pff.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pbqn4UOLsCUmS2w+1MSU94yBFEcgWrVd3oXN3b1LEx8=;
        b=BRKC2o/FBEZKJP3PrSUWqd+44yMTJCJlrFCYjmuyln3cjvp9ytyil6MuMCNP4gSUzm
         dPNz9pehbWI9TUuYKmOK7p2nx0+bVWhzxgSaSOul9QphVp1gkcX1gBSaIS1jxYo4SJnd
         uQaIw7rPbRJOLVYMpOMO5h5jideGs00NibYy8oj2ctly/HKRUKWOPMCsZpfD7P/8mYFr
         96tVb9N69jh03s36MWT6Rokbs47yNDuS66OH2IcINuNaAVIN3W1xDIJQMxpjsYC+ADU7
         T+AOIwmgVTqpu4EESHTVdU+yOvW+uerH6aNPRfBaKBXQDyWiWORRrtS/U0sEznq43lZh
         TUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pbqn4UOLsCUmS2w+1MSU94yBFEcgWrVd3oXN3b1LEx8=;
        b=S4J46sS9IBR0H0aU/9mdQBzahWQ9qodzYCsEqI+n3wNrotMgy/MXnzGmDiemr6tqnE
         ofIwBKodw53LSAVEZKOnL8B0tKofrdcUBCxAvHvPq2FlupYZEPQKsBILrFyWJ1aspCS6
         DlnrVQMgyu3CVquEhp16cv18hnwz8Gw8wEG9DdhZdZzIc4E+rZg6spVFcwm2hj04HzD6
         Ao3JNJ9V3nuqxrZvPZyUHR2FnlAUNh+xI72u7uQSmWCSQ9fcLtgj57eFUmsMDyEr3dCD
         IO+XJkpjGP+zAEWUgKyTKHeXCsX0jcFkIKpbPiNVAfQHjynhithAEGV6BxI9xMOGiFK3
         lUtg==
X-Gm-Message-State: APjAAAWKYIDx3S9NsIoEyyOlNGtq5RUqKiMbFAjVXlE6sgQ5wfffoYuu
        RcV4Lefa4MTBQjzvPgMq7CD8cbVtLlV3tQ==
X-Google-Smtp-Source: APXvYqxmi24iXu0LREAQssFRJC9yqoJHNzorfijmEqsFdQKPjMycC0crWL0/VvNTKiXaajs6SsaZ8w==
X-Received: by 2002:a63:3cd:: with SMTP id 196mr10683792pgd.150.1573834646139;
        Fri, 15 Nov 2019 08:17:26 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::a9db])
        by smtp.gmail.com with ESMTPSA id c3sm10597891pfi.91.2019.11.15.08.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:17:25 -0800 (PST)
Date:   Fri, 15 Nov 2019 11:17:23 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/vmscan: fix some -Wenum-conversion warnings
Message-ID: <20191115161723.GB309754@cmpxchg.org>
References: <1573826697-869-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573826697-869-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:04:57AM -0500, Qian Cai wrote:
> The -next commit "mm: vmscan: enforce inactive:active ratio at the
> reclaim root" [1] introduced some GCC -Wenum-conversion warnings,
> 
> mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
> 'enum lru_list' to different enumeration type 'enum node_stat_item'
> [-Wenum-conversion]
>         inactive = lruvec_page_state(lruvec, inactive_lru);
>                    ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
> mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
> 'enum lru_list' to different enumeration type 'enum node_stat_item'
> [-Wenum-conversion]
>         active = lruvec_page_state(lruvec, active_lru);
>                  ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
> mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
> 'enum lru_list' to different enumeration type 'enum node_stat_item'
> [-Wenum-conversion]
>         file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);

Interesting, it doesn't show these for me with gcc-9.2.0.

We should definitely fix these!

> @@ -2213,8 +2213,9 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
>  	unsigned long inactive_ratio;
>  	unsigned long gb;
>  
> -	inactive = lruvec_page_state(lruvec, inactive_lru);
> -	active = lruvec_page_state(lruvec, active_lru);
> +	inactive = lruvec_page_state(lruvec,
> +				     (enum node_stat_item)inactive_lru);
> +	active = lruvec_page_state(lruvec, (enum node_stat_item)active_lru);

This is fragile, as it relies on the absolute values being identical,
which we don't guarantee. However, we do guarantee the relative order
between the LRU items, and we use NR_LRU_BASE for the translation.

Please use NR_LRU_BASE + (in)active_lru here.

> @@ -2743,7 +2744,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	 * thrashing, try to reclaim those first before touching
>  	 * anonymous pages.
>  	 */
> -	file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
> +	file = lruvec_page_state(target_lruvec,
> +				 (enum node_stat_item)LRU_INACTIVE_FILE);

This should just directly use NR_INACTIVE_FILE instead.

Thanks
