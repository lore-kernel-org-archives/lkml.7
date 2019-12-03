Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1EEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BAD206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="L22xBp2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfLCQ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:58:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43106 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLCQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:58:48 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so4086568qkn.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=awAZi9esbUnXwgXhwi5bh2eBiqCu026SUTMkAv+bcuk=;
        b=L22xBp2gKa6uy6Xb4JW/SOWjMtUgH90CP7cHfER4JiCqbsofhlGIkYBC8S714MZd0t
         JAc4BN2VdOXH1g5oVGh8kWYTew/jD17g0YkmUCJX94s7pIYrgAg3YB0K6+gALQ/CiJJn
         Jy3N4G13IuXQ5AfbjEVSd0l8y0VL9AoMYh7fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=awAZi9esbUnXwgXhwi5bh2eBiqCu026SUTMkAv+bcuk=;
        b=Nne5rGsXZl/efxEvfoVZYTpnNoSk5NIiBRvgj64r2QUYqXrdnW8rIeUk+3ukij8Clo
         kx/W8orH88YPqZ23sdv3L+dLCdGHxLGLSKYknQoLZkBSPfCBvtF3XdPzEiNxAVPf/q1l
         KqefC/F/4j0mTUZEhVHCi+S9Gu5I2t/2fY+UaV2YfmhkHtNVARfqrNMd+J6wJqDbie7n
         Ti0AODdPs3u9MUWXqRDxj2arifb374SK1tRzQUhqde6vtBT7LxihY0XPUBby+2Qk/hb4
         9KoElUDY/xeY+djTGZXbT4HJfo2T+Ag6mAaohe3E3jbG+RzKHn6bxNisPB+prmMDOTSB
         KGpw==
X-Gm-Message-State: APjAAAV9TWR+faAfJO4WOB1FJhI0ohCu1eOOwmPqn1/jZxm81jHxxvEH
        P3/Q2Ze1IQmyR8Reqry6Ms14fA==
X-Google-Smtp-Source: APXvYqzPRcP0xDwFOlYh6VQJvJ3upogxLDCfmpeKQJYYXPnQMvIQnXAR62SHl+8BMMa/0Qr4zaQT0Q==
X-Received: by 2002:a37:4782:: with SMTP id u124mr6238808qka.8.1575392327688;
        Tue, 03 Dec 2019 08:58:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:49ea])
        by smtp.gmail.com with ESMTPSA id y10sm1959520qky.6.2019.12.03.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:58:47 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:58:47 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH kselftest-next 2/2] kselftests: memcg: speed up the
 memory.high test
Message-ID: <20191203165847.GB607734@chrisdown.name>
References: <20191202234212.4134802-1-guro@fb.com>
 <20191202234212.4134802-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191202234212.4134802-2-guro@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin writes:
>After commit 0e4b01df8659 ("mm, memcg: throttle allocators when
>failing reclaim over memory.high") allocating memory over memory.high
>became very time consuming. But it's exactly what the memory.high
>test from cgroup kselftests is doing: it tries to allocate 100M with
>30M memory.high value. It takes forever to complete.
>
>In order to keep it passing (or failing) in a reasonable amount of
>time let's try to allocate only a little over 30M: 31M to be precise.
>
>With this change test_memcontrol finishes in a reasonable amount of
>time:
>  $ time ./test_memcontrol
>  ok 1 test_memcg_subtree_control
>  ok 2 test_memcg_current
>  ok 3 test_memcg_min
>  ok 4 test_memcg_low
>  ok 5 test_memcg_high
>  ok 6 test_memcg_max
>  ok 7 test_memcg_oom_events
>  ok 8 test_memcg_swap_max
>  ok 9 test_memcg_sock
>  ok 10 test_memcg_oom_group_leaf_events
>  ok 11 test_memcg_oom_group_parent_events
>  ok 12 test_memcg_oom_group_score_events
>
>  real	0m2.273s
>  user	0m0.064s
>  sys	0m0.739s
>
>Signed-off-by: Roman Gushchin <guro@fb.com>
>Cc: Chris Down <chris@chrisdown.name>
>Cc: Johannes Weiner <hannes@cmpxchg.org>

Thanks, this makes sense.

Reviewed-by: Chris Down <chris@chrisdown.name>
