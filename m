Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FC62084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Msrizkcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDJVxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:53:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36246 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDJVxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:53:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id ck15so2217699plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3p4NjpgsoDwbHSH6o2K2Uu1LYIhK93bOWHp3cUQbm2A=;
        b=MsrizkcsUEOZCuBtc2jjJ33ioMjLFHRiq8EFcPhxHCxgPgPD0/aZP86p7dL55H6EkJ
         NgWmq+jptlJZdv043JixiEwvFb7TZKI7KHbJn30hSDYNhwzSV5yliJ37T7PSzn1vSXUZ
         SFL4WG4WJiRMozOWJov6H5uI5Iwv0WRgqGDmdscGoDpEJGFSrYfOOVp73gi0JJp9NzOF
         Do4Mxw4mxX/ucfurwHCr+/exhwgraTzHqinP9/gK9uBaTY6B+RjK0HrkhoqfDMdsndxq
         f76oQL5lDV8iQZ/JbsJ63T5Lqe0AZ+d3zKSnUAYQAVpFRSK4vOGAjlL/FdKKyWkeaMKB
         4sGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3p4NjpgsoDwbHSH6o2K2Uu1LYIhK93bOWHp3cUQbm2A=;
        b=Ib09KYvn7Ix6mBjjQzDvMYv4mBSJRjymMMFVbNuYQXN5x4QA+dZ0lm8SmxD7B7PlTZ
         7QsXY+MqltHVwOZ65ks5AdNbLI/vYtNc1HY+Tu5G7iWfRIaaFPjIKRIoP8rkxCy/spYM
         YV/obrofAH7wY2Jy14lx1zd5Ni2JDo44WBiGpQVbmOIy4tH1K2+HkkKKHg/sqQ640Ze3
         jTsBxcR1gV6x6zOLowfVxk0H4lpLfxDxMAd/jjZZU8ANAD0/0YTyqlJdFyPRTwAhCDNX
         w1Eyys79ymn3VhpzIphg4DmEAZPs8XnGkJ85ZPbKkofOox8eWaQu0WVR443CtHEyxOF1
         ZM6w==
X-Gm-Message-State: APjAAAUZXi6nR/YyTXhhlIQf4FasIvjSDepQqcszTAbL4GQ1oTF/d+xl
        TvZgmlceZALO2uRYJMNT7Oxh3w==
X-Google-Smtp-Source: APXvYqxGdiqeWQvkUegBTUaHtm5pmYo5S6GNdOzi04jd1a95COMWNcI4JqF9CNZ55MCrPvzoo7ut9w==
X-Received: by 2002:a17:902:be09:: with SMTP id r9mr44752098pls.215.1554933215988;
        Wed, 10 Apr 2019 14:53:35 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v19sm66087651pfa.138.2019.04.10.14.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 14:53:35 -0700 (PDT)
Date:   Wed, 10 Apr 2019 14:53:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
In-Reply-To: <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
Message-ID: <alpine.DEB.2.21.1904101452340.100430@chino.kir.corp.google.com>
References: <20190410024714.26607-1-tobin@kernel.org> <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2019, Vlastimil Babka wrote:

> On 4/10/19 4:47 AM, Tobin C. Harding wrote:
> > Recently a 2 year old bug was found in the SLAB allocator that crashes
> > the kernel.  This seems to imply that not that many people are using the
> > SLAB allocator.
> 
> AFAIK that bug required CONFIG_DEBUG_SLAB_LEAK, not just SLAB. That
> seems to imply not that many people are using SLAB when debugging and
> yeah, SLUB has better debugging support. But I wouldn't dare to make the
> broader implication :)
> 
> > Currently we have 3 slab allocators.  Two is company three is a crowd -
> > let's get rid of one. 
> > 
> >  - The SLUB allocator has been the default since 2.6.23
> 
> Yeah, with a sophisticated reasoning :)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a0acd820807680d2ccc4ef3448387fcdbf152c73
> 
> >  - The SLOB allocator is kinda sexy.  Its only 664 LOC, the general
> >    design is outlined in KnR, and there is an optimisation taken from
> >    Knuth - say no more.
> > 
> > If you are using the SLAB allocator please speak now or forever hold your peace ...
> 
> FWIW, our enterprise kernel use it (latest is 4.12 based), and openSUSE
> kernels as well (with openSUSE Tumbleweed that includes latest
> kernel.org stables). AFAIK we don't enable SLAB_DEBUG even in general
> debug kernel flavours as it's just too slow.
> 
> IIRC last time Mel evaluated switching to SLUB, it wasn't a clear
> winner, but I'll just CC him for details :)
> 

We also use CONFIG_SLAB and disable CONFIG_SLAB_DEBUG for the same reason.
