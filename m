Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CD9C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79F220873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeBaiWZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfJCTl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:41:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35502 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbfJCTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:41:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id p30so278424pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 12:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WqnDNpxNJ9d9Ouc08nAl1wk/JWgZ2JMo7PTKSIvFr54=;
        b=oeBaiWZuuazODZGGgj9OjBe+kOivMqRldWHKZZ72DgA86q5Bmn7toKuhzK3oD07KbP
         nzWOirJi1qZF/+kx6/KkffOjv6Ef0K/OKsykCGkH5PtDcXuWnuQK9BO42XotJH36GMiO
         0A8CTywz2Y15ZATut2Oq9ebVXsxwxp39DxLd6aaGSM6JvkqmByg1pg9UVY0zgfcmReVW
         wFoMrh0wgR5++q7FJisXKPfc6ExSVHJveQ49rEaSlo9kjbC0nkVjmcB9zhOPZ6Ex8s4E
         DvVlONXg7N+fAShn3FMLr18JXSP1tS/CQNQYCHi1KFv+IDIlkObdEVJ6V9ypCO1nfZdL
         /TDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WqnDNpxNJ9d9Ouc08nAl1wk/JWgZ2JMo7PTKSIvFr54=;
        b=fzOWLB2PT74k2Aqzvh7dAEUVUQql/wZgT3lyybr+VFYs7uDu0O0z+tmdum+n5Q4/rg
         AjNL1u62X4v+SUeANa22l9/brfk9WJyWpxXP4olbQKT/MjGid3bkEPronrRNM8yeGwZI
         fUmIhQxCVDKi152vUgK+NlMrbysJY/Png41aU5dfjmtbdZ5WN2t/sBcLqwyiBw85R7xj
         pi9v8NQanWuQQ+SuYXqZqwXtT1KqjswH3JWjR6Y3+Kj8wMHIVALfpcoirMiBS8MItH7c
         SxtB/7w/HZF8UrhVuzQKZ4ILCOu/xfQbcH9Z+lZA+oqE43m4XX67Lo1KmA8LMfdPpCuF
         LSVQ==
X-Gm-Message-State: APjAAAXcDcw8GYa/8I+1KY2/V4twE/siBSH2cNFUgmo1MumU8PEqt0M7
        nj8w9ZMxm2l7tud6H0/Id1yDwg==
X-Google-Smtp-Source: APXvYqznYGmNd28LWoxGottlOF0mXioQrzWcto6GOK5OyHZzDF3NyaSndKmbLNindJw8P0iLQdukhg==
X-Received: by 2002:a63:1101:: with SMTP id g1mr11311953pgl.320.1570131685547;
        Thu, 03 Oct 2019 12:41:25 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w134sm4632474pfd.4.2019.10.03.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 12:41:24 -0700 (PDT)
Date:   Thu, 3 Oct 2019 12:41:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     mgorman@techsingularity.net, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: remove unused scan_control parameter from
 pageout()
In-Reply-To: <1570124498-19300-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1910031241141.88296@chino.kir.corp.google.com>
References: <1570124498-19300-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019, Yang Shi wrote:

> Since lumpy reclaim was removed in v3.5 scan_control is not used by
> may_write_to_{queue|inode} and pageout() anymore, remove the unused
> parameter.
> 
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: David Rientjes <rientjes@google.com>
