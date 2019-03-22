Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D61C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D3E2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="t33VxRIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCVWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:00:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34323 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:00:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so3931783wrq.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z3kNb4x6nZaDJzrLCkv/8bMkNzuRCuubIRRX4PjKw9k=;
        b=t33VxRIuRm3bprIjzdNlkZlPsKCoiKyBSPHzogx7bBAS/0Me5ORQuRWJPkoVAb30lf
         WWGBbCUiJE/BUNBvPVoeD/FvsAqwyOPJrFQNHfPKqCwFogqxeBdfod9IT8SeXk83lwBq
         U9Nu+yf0n+hoiMALOIPPIDxC2I56pXMvLTrQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z3kNb4x6nZaDJzrLCkv/8bMkNzuRCuubIRRX4PjKw9k=;
        b=M1NT8wfHYU1Imeoo2AQ8eoDB0BBVo3xD8hlj5Y3PQvC0TPNQnvyWaiVR565+utik1C
         V3ke+eu6W/O9fjtecdSm16fQXXkDZ+59bK9AhKhERS2Ride221Q5nYzwXzKvuqVqZlOg
         C9oNd8cZgEJNgJClbJ/9vp7i319kjDSWKGGMfeH2r5zznTXSjke0/NwYHGvS0VpSDtuu
         OROVzAmQ8/O+NCkFN7pkYmrMGk7xIPeKA5Hl5jEZK7UeTzqv2WTu4wDAN79Hy1PSjguf
         nTBRu87khvSg8RFJY1TapD81Z4Niva7wFJ4AP8fxO+AwIs0BnmZBK38yf4WHsemt5Pfq
         hZrg==
X-Gm-Message-State: APjAAAWu2Yi3mnAWhyYdxSnBLuFVc39Kf5KgKRIyutCx7RJinwyH+nfw
        DpAQ7Pso/Rsd1TtUHZ9KJKuDAg==
X-Google-Smtp-Source: APXvYqy+28Y3POG72bfdj4XQtGplLT42sVDH12SaEUvGcCk2zH+sIkLmuKXHO/djaQJK+QEHIIdWfQ==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr7629173wrm.277.1553292047861;
        Fri, 22 Mar 2019 15:00:47 -0700 (PDT)
Received: from localhost ([89.36.66.5])
        by smtp.gmail.com with ESMTPSA id 93sm18584487wrh.15.2019.03.22.15.00.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 15:00:46 -0700 (PDT)
Date:   Fri, 22 Mar 2019 22:00:46 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190322220046.GA7667@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190322131015.05edf9fac014f4cacf10dd2a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190322131015.05edf9fac014f4cacf10dd2a@linux-foundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
>Could you please provide more description of the effect this has upon 
>userspace?  Preferably in real-world cases.  What problems were being 
>observed and how does this improve things?

Sure! The previous patch's behaviour isn't so much problematic as it is just 
not as featureful as it could be.

This change doesn't change the experience for the user in the normal case too 
much. One benefit is that it replaces the (somewhat arbitrary) 100% cutoff with 
an indefinite slope, which makes it easier to ballpark a memory.low value.

As well as this, the old methodology doesn't quite apply generically to 
machines with varying amounts of physical memory. Let's say we have a top level 
cgroup, workload.slice, and another top level cgroup, system-management.slice.  
We want to roughly give 12G to system-management.slice, so on a 32GB machine we 
set memory.low to 20GB in workload.slice, and on a 64GB machine we set 
memory.low to 52GB. However, because these are relative amounts to the total 
machine size, while the amount of memory we want to generally be willing to 
yield to system.slice is absolute (12G), we end up putting more pressure on 
system.slice just because we have a larger machine and a larger workload to 
fill it, which seems fairly unintuitive. With this new behaviour, we don't end 
up with this unintended side effect.
