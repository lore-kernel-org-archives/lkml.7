Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51340C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212242087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553717401;
	bh=qoxXihE2jCNpvgqulItoSnmOQTjpH4OkDlNKARkUM4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0wvLy4EcOrCD+ku7FhmBKArRi1u10pgjPCdOy8QjqZRS1CQfiU9i7ghFLGrV2AbVb
	 W1wuwiUVcufifnkzVKecWDE9oNNv4LivGTDt3XDsauZDLg7YNYhValJiSt6ahKqpeU
	 tTVUv5fJ2lBXlD0r1lALZ5INyl4zui1QkgeiOLJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfC0UJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:09:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39779 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfC0UJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:09:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so1425441wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BxdlZA20V+nvmp9SYsJwRytC0uJFbrzmx7O1ApfI0ek=;
        b=jV4dqc6U6Nvklx0CDi6qZnN5086z4qfrPLqRd5PQpJtHmOW+Qz+xciLFt5B4wvpc+W
         +4l8U+BoPU2c4zWeDLDi/1TPM9VndCuC0ZC2fDdh3nfx7OkHGE9D9GQOYj7CKgTS1530
         UbT0gTc0FJBq91C8UZT9c4T9kgFGW/uNCxEPInN26v+FKkNtUDMQBcovp+pch887YI62
         Ed7r8nvTLMxbxVimN0cCL+rcag8ITAMqedaT4uJsPKrvK+cEU82aDMuo/i7XF4ce/b8O
         +wNB7P/ZEtpXcl5o5g7upmnDFxtp0Kd4xJ5Q2PURSL62fn+Mz7ZH2W1XgYYPzBI4oXgU
         cYQQ==
X-Gm-Message-State: APjAAAUOIMoqMQqJn0HfyuXjhzYSI5HEHhj5asG2/aCqdMxJGKPgfNGN
        4yksmsiRzs/xZYdRYeaIbBY=
X-Google-Smtp-Source: APXvYqyPIA2q4k2Xqf3l9eGLTWp7uk5RUzI1vR0hg5JFg9hwl3QocHsf9kX1F7RBMXysFcWsuTwneA==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr9646587wma.57.1553717397215;
        Wed, 27 Mar 2019 13:09:57 -0700 (PDT)
Received: from localhost (ip-37-188-250-59.eurotel.cz. [37.188.250.59])
        by smtp.gmail.com with ESMTPSA id b8sm7577541wrr.64.2019.03.27.13.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 13:09:56 -0700 (PDT)
Date:   Wed, 27 Mar 2019 21:09:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190327193918.GP11927@dhcp22.suse.cz>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz>
 <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz>
 <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
 <20190327090100.GD11927@dhcp22.suse.cz>
 <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
 <c3690a19-e2a6-7db7-b146-b08aa9b22854@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3690a19-e2a6-7db7-b146-b08aa9b22854@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-03-19 11:59:28, Yang Shi wrote:
> 
> 
> On 3/27/19 10:34 AM, Dan Williams wrote:
> > On Wed, Mar 27, 2019 at 2:01 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > On Tue 26-03-19 19:58:56, Yang Shi wrote:
[...]
> > > > It is still NUMA, users still can see all the NUMA nodes.
> > > No, Linux NUMA implementation makes all numa nodes available by default
> > > and provides an API to opt-in for more fine tuning. What you are
> > > suggesting goes against that semantic and I am asking why. How is pmem
> > > NUMA node any different from any any other distant node in principle?
> > Agree. It's just another NUMA node and shouldn't be special cased.
> > Userspace policy can choose to avoid it, but typical node distance
> > preference should otherwise let the kernel fall back to it as
> > additional memory pressure relief for "near" memory.
> 
> In ideal case, yes, I agree. However, in real life world the performance is
> a concern. It is well-known that PMEM (not considering NVDIMM-F or HBM) has
> higher latency and lower bandwidth. We observed much higher latency on PMEM
> than DRAM with multi threads.

One rule of thumb is: Do not design user visible interfaces based on the
contemporary technology and its up/down sides. This will almost always
fire back.

Btw. if you keep arguing about performance without any numbers. Can you
present something specific?

> In real production environment we don't know what kind of applications would
> end up on PMEM (DRAM may be full, allocation fall back to PMEM) then have
> unexpected performance degradation. I understand to have mempolicy to choose
> to avoid it. But, there might be hundreds or thousands of applications
> running on the machine, it sounds not that feasible to me to have each
> single application set mempolicy to avoid it.

we have cpuset cgroup controller to help here.

> So, I think we still need a default allocation node mask. The default value
> may include all nodes or just DRAM nodes. But, they should be able to be
> override by user globally, not only per process basis.
> 
> Due to the performance disparity, currently our usecases treat PMEM as
> second tier memory for demoting cold page or binding to not memory access
> sensitive applications (this is the reason for inventing a new mempolicy)
> although it is a NUMA node.

If the performance sucks that badly then do not use the pmem as NUMA,
really. There are certainly other ways to export the pmem storage. Use
it as a fast swap storage. Or try to work on a swap caching mechanism
that still allows much faster access than a slow swap storage. But do
not try to pretend to abuse the NUMA interface while you are breaking
some of its long term established semantics.
-- 
Michal Hocko
SUSE Labs
