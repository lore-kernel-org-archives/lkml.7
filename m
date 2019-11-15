Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A05EC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB5E2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XPmJB/Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKOQWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:22:10 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:36204 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfKOQWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:22:09 -0500
Received: by mail-qv1-f46.google.com with SMTP id cv8so3834065qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w7jUeJOoUXH4Qqizv6WofWArxITzVZUe1/AouJiaEWs=;
        b=XPmJB/TrxXdwntPZQn/pG6IoPfqIvTjFs+9AtqLINMFVbip/eogNS3LiL73jcgCDqt
         qzmOneG1K5ysjBPQWNRkd/re3r84pvUlKqyLRvf/6UxeGHDKbYY0u2IyrGO1BPXCUiQA
         qwxOnRh6mUS8vkcCXw2gsbSavUaw+O0d6FsOOWrEOpEo02JStDLR5KCW2RJ0k10pYpta
         siowDyjSw9vKOeMs3VmH7Qu3v3zTjz9b/JKw4CVYUcFMkqQeXKTObbCv1cmZm+hKdkkv
         NCeUdwxFTXohiIMUyWoLBhStmLB0UF7DP3HPMpGqAwjXfd1xRAq2UCd13nKp//Vlslfy
         VFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7jUeJOoUXH4Qqizv6WofWArxITzVZUe1/AouJiaEWs=;
        b=EuvDHdeNpqn83x3QRu96LcEHmuD2imx+3TtppKQSjWJjT4U4TchAocn6hmXP2rI8Gz
         zWBKITJu7PXEHHLLYrCf14S41rIwzwPv5F1Fi+VV95arcCPFcZ47V29zuF5f+YW9V6ZU
         wu7B8FNdPs5rh7dqSS/bjymmpBl0qbXnthDLHtDyplAT5dcUnF8R+8EzPWgIjNMV2YtT
         YciQQ/CmgJcREd9Qa+aMkv056Bd6DMS1a4RYPngA5+8k/djR3kNtJdjyndXlRHSD2W5C
         uKWRLo+NiAUu4WZmscgWmP9YZsyYsUWyzjZLSBCNwjSru9js0sbx2newjws17Q0QfUxa
         bmLw==
X-Gm-Message-State: APjAAAV07niNVO4gOLDxmLtVBDldxuQBj4ImMuI+w0tRmgQDelXuWdQV
        9FzAYWdYGPF4nWIewdrouIQieg==
X-Google-Smtp-Source: APXvYqyjlk1Foro5VxpnbnLOuSGsg14UtbsKQ/fmNm8FzqdVwfvXbEY4e5nIUOhxpANgsHD4qBiyEQ==
X-Received: by 2002:a0c:a998:: with SMTP id a24mr9881957qvb.117.1573834927156;
        Fri, 15 Nov 2019 08:22:07 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q17sm5356533qtq.58.2019.11.15.08.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 08:22:06 -0800 (PST)
Message-ID: <1573834925.5937.127.camel@lca.pw>
Subject: Re: [PATCH -next] mm/vmscan: fix some -Wenum-conversion warnings
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, surenb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 11:22:05 -0500
In-Reply-To: <20191115161723.GB309754@cmpxchg.org>
References: <1573826697-869-1-git-send-email-cai@lca.pw>
         <20191115161723.GB309754@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 11:17 -0500, Johannes Weiner wrote:
> On Fri, Nov 15, 2019 at 09:04:57AM -0500, Qian Cai wrote:
> > The -next commit "mm: vmscan: enforce inactive:active ratio at the
> > reclaim root" [1] introduced some GCC -Wenum-conversion warnings,
> > 
> > mm/vmscan.c:2216:39: warning: implicit conversion from enumeration type
> > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > [-Wenum-conversion]
> >         inactive = lruvec_page_state(lruvec, inactive_lru);
> >                    ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~~~
> > mm/vmscan.c:2217:37: warning: implicit conversion from enumeration type
> > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > [-Wenum-conversion]
> >         active = lruvec_page_state(lruvec, active_lru);
> >                  ~~~~~~~~~~~~~~~~~         ^~~~~~~~~~
> > mm/vmscan.c:2746:42: warning: implicit conversion from enumeration type
> > 'enum lru_list' to different enumeration type 'enum node_stat_item'
> > [-Wenum-conversion]
> >         file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
> 
> Interesting, it doesn't show these for me with gcc-9.2.0.

Sorry, I meant to say it is clang.

> 
> We should definitely fix these!
> 
> > @@ -2213,8 +2213,9 @@ static bool inactive_is_low(struct lruvec *lruvec, enum lru_list inactive_lru)
> >  	unsigned long inactive_ratio;
> >  	unsigned long gb;
> >  
> > -	inactive = lruvec_page_state(lruvec, inactive_lru);
> > -	active = lruvec_page_state(lruvec, active_lru);
> > +	inactive = lruvec_page_state(lruvec,
> > +				     (enum node_stat_item)inactive_lru);
> > +	active = lruvec_page_state(lruvec, (enum node_stat_item)active_lru);
> 
> This is fragile, as it relies on the absolute values being identical,
> which we don't guarantee. However, we do guarantee the relative order
> between the LRU items, and we use NR_LRU_BASE for the translation.
> 
> Please use NR_LRU_BASE + (in)active_lru here.
> 
> > @@ -2743,7 +2744,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  	 * thrashing, try to reclaim those first before touching
> >  	 * anonymous pages.
> >  	 */
> > -	file = lruvec_page_state(target_lruvec, LRU_INACTIVE_FILE);
> > +	file = lruvec_page_state(target_lruvec,
> > +				 (enum node_stat_item)LRU_INACTIVE_FILE);
> 
> This should just directly use NR_INACTIVE_FILE instead.
> 
> Thanks
