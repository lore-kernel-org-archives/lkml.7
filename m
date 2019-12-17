Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A75AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC7E24676
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="crKI2Mrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfLQPJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:09:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40956 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfLQPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:09:24 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so11688836wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRifrYHkApcXnKzKR9sZGrhWwRmDmhE0ikbPGadvDHM=;
        b=crKI2MrdTHir1/QxP/Gc2TF/K5LQOSpYr8URTRvZSMKKZd2IgIojFD0O83S/Bq7wBT
         yjLxMTafYMdzf3fF/MvlxezrtHOD813wOAA/PfVag2ndv+LWndeMEvvqrBl174t8ahcL
         v1msU5U/qfNvNJUvqwR/V3PDAfi2JdKH0xG5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRifrYHkApcXnKzKR9sZGrhWwRmDmhE0ikbPGadvDHM=;
        b=iqFLoTB/rJvsWxccRVcW90y2A48hB6pM/WLcLwr8lBSmU/ioBUz9T5eeQIHXHlHjQq
         GJr4e+4ii73YdAKHmFj/jgBMoKiSq2gUMUlAZnQO01P8DfUZQYWX/FNYyC3hEJx1y+GR
         6BbW4tPhdFoYKlUyWLo7lpelcSjB8xv+vuYwB3rkVRWqlRm3hc8Q2uiHboYS4FV7AeJ3
         THYkdXp8c7fdunY0a7pV0gXIj9HCjHj8ihD21OrQpPVYRmlvLk5pQxeKg7VRS6X0DdvR
         GJ+reybFFG9PQyCdusQOPv4lURLYiw/Hn/H+YxVPxeJRFzc27mLi0kMHBZQbSx14/mb9
         kGbA==
X-Gm-Message-State: APjAAAWj2Q76J+QnRIGAYImHCnAIhGyywjofbM3+Ep0N1DQ+CI5Ne38t
        KfKmCncUB0YosIfuN7c+8f7AEw==
X-Google-Smtp-Source: APXvYqzeUsLeKJ7XhryK7P6j9t84VV3/9Mp+BIfZchRwfo5wRv+dxszHt3anMOTe1fiYJf76De6TAA==
X-Received: by 2002:adf:fac1:: with SMTP id a1mr36184936wrs.376.1576595362242;
        Tue, 17 Dec 2019 07:09:22 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id u18sm25429092wrt.26.2019.12.17.07.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:09:21 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:09:21 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217150921.GA136178@chrisdown.name>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217144652.GA7272@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>yes, I would just ignore this warning. Btw. it seems that this is
>enabled by default for -Wall. Is this useful for kernel builds at
>all? Does it realistically help discovering real issues? If not then
>can we simply blacklist it?

There's no way we're the first people to encounter these problems, so what did 
we do in the past when situations like this (adding a generic API which is not 
yet used by non-configurable code) came up, and in retrospect did they work 
well?

As far as I know -Wunused-function also guards against other errors, like when 
a function is prototyped but not actually defined, which might be more useful 
to know about.

(Side note: I'm moderately baffled that a tightly scoped __maybe_unused is 
considered sinister but somehow disabling -Wunused-function is on the table 
:-))
