Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70A2C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAB721848
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558785005;
	bh=LtH30bTMpVugqJb0RDPHDfIAVmtJU8kSeIcC+cxTH6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FBwR9suwGf2sEOkZLWAgImTZC7cz3L1awi1atLWduCyTRSnlSYCeW1WICXQSqQ+m7
	 nRfRWYmkuKoXr8/hWEc2yYEzQfbieZBrTI96Uf6EZGuwzwJlW8bMNa61wcyiEfDPRb
	 4BcdFKugrdqG65qJ0QdakRsh8yEbUg3w1Mg00G8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfEYLtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 07:49:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39924 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfEYLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 07:49:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so7483127wma.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UaeK3mpcxtQ8DilQSPxFFqvKnnJ4UJsxo8ix82U8d1I=;
        b=mqdlnr6/PXhU5Z4V/2Fmjtc7WED9oLTl7naxIRlu6c7y9Hitu3eWF8QMs0xJV8WmOu
         8bfzvbg1aSF/aIsEH+ROvpMsjc8ssNgD8I/RAvppxiu+WlDxXbRPizup4uA7nw5VF6ym
         7w00zTxzGmY7PQpPebBYIw0DZ9vmIewF6FCeOfCKExVMLKteGImGS3uIiGJkQPowsDOV
         jiP+hm9ud1llJTkjlizX5Hj+c4UIu3Nip5ZUIZTqOay5vpQwiw/KSnfO3ZfKJI8ppHAk
         tmLkxWXa45hGWfk2zs5XAKqORcCpivnWJ9O8QDDq1m4OTlnrB5nENkRnbehQecQNjjFP
         dHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UaeK3mpcxtQ8DilQSPxFFqvKnnJ4UJsxo8ix82U8d1I=;
        b=Io+pz6egXXhDXcvBSd6DqKPfxSwUP55Rs7N+gnQb/B6Fh59L74qtHsJuEK71cF/NkG
         FT2HUbnHhvOdzRaAK3nSW+ondCB02cZwYoqFKEhHBwmnIM5a/5/4FBPEN/4dqJG7FZn4
         9GKlan0k1Lq5BS9Yj8HZTx5djxekz4C1Hn0OsGfBR3kynrjxMRVf49vgmm0oD45Y94GH
         A28H2Vjm4VD9i+r/IR/MGWeRQUlQl4V/Bh5UMwAjv3XWLJVs5BC0zQ0gW4jsqVcRDMbF
         kWcRpQIInNcfqsBxx6LTDMJXWk2yDvAr+zzdwwatmLYpWdP0WijmbmZKK/COXZyt3OzP
         KZjQ==
X-Gm-Message-State: APjAAAVPN5fetOoxNS+ju2JLDUJhajZP7jIdNE1SGN7j1mHd1uTlA2uM
        RcUjzWuR9Li8Rxs4+1K0iQ//oO3l
X-Google-Smtp-Source: APXvYqwL6esy1siZjGnXYNaE9NpPgc5irvL6nCTfjq/qIUhxiacUxffsdn6DUJLlwrVjliryXAzfag==
X-Received: by 2002:a7b:cb57:: with SMTP id v23mr3517023wmj.60.1558784991209;
        Sat, 25 May 2019 04:49:51 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k17sm3658762wrm.73.2019.05.25.04.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 04:49:50 -0700 (PDT)
Date:   Sat, 25 May 2019 13:49:48 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Qian Cai <cai@lca.pw>, LKP <lkp@01.org>,
        linux-kernel@vger.kernel.org, philip.li@intel.com
Subject: Re: 8d2bd61bd8 ("sched/core: Clean up sched_init() a bit"):  BUG:
 unable to handle page fault for address: 00ba0396
Message-ID: <20190525114948.GA24312@gmail.com>
References: <5ce91b39.Txl3DDmbeNsPYyrE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce91b39.Txl3DDmbeNsPYyrE%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kernel test robot <lkp@intel.com> wrote:

> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> 
> commit 8d2bd61bd89260d5da5eaef7cf264587f19a7e0d
> Author:     Qian Cai <cai@lca.pw>
> AuthorDate: Wed May 22 14:20:06 2019 -0400
> Commit:     Ingo Molnar <mingo@kernel.org>
> CommitDate: Fri May 24 08:57:29 2019 +0200
> 
>     sched/core: Clean up sched_init() a bit
>     
>     Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
>     will generate a warning using W=1:
>     
>       kernel/sched/core.c: In function 'sched_init':
>       kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
>     
>     Use this opportunity to tidy up a code a bit by removing unnecssary
>     indentations and lines.
>     
>     Signed-off-by: Qian Cai <cai@lca.pw>
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Link: http://lkml.kernel.org/r/1558549206-13031-1-git-send-email-cai@lca.pw
>     [ Also remove some of the unnecessary #endif comments. ]
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>

I've removed this commit for the time being.

Thanks,

	Ingo
