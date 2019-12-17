Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA325C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5D7207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576575107;
	bh=2oizlHtCkEl+41rbiYyWPRKT0q0V8kb19/FqQnvUrjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nDFRDUSvDJTQbmowx0jxjiuSIIEUDxBrIgsy/7DryOZvlsS4gnZVfZ9mTV84Uu5K3
	 EtxKDiinz7rnTPpKp/xNuEl8W5u4HgoumEUszgLptTg7m8vmv2ZLCx9lH4lPLTDcTu
	 zsqv4kHKX7d0lGY9eYyy1QX8RDJszTiZOD9Kw6qM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfLQJbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:31:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39455 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:31:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id b72so2256090wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 01:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jCNLk3ysTa7drVwjPrE0QpXknGVHoz5c/ceSyho58q8=;
        b=LF07oXr5TjNmJbuo2WHwY0x+8y+nK21tl/ZQcPIc3LYctcQfMvO3DldcZJ+aLAPJJ1
         8nFMHp2ydPFFur+ek88QXxl8PcGw80DgUS3FSNj4l7DkQKE9J3GJyESujl1WdilH0HMI
         1Tu0+H8KmlJVFCn3SL9tgwmHVuPO7m1zC96zDZQ324aDuqRiO96T3/4zEHOIpzqeTuxk
         XToCkY6oEgXXnZGYGRKele5b/Gft6ccYeTIaPyiLXMZMqrjOFDJJZLekftK6HdGltxBu
         p8o1vK/IrBlMJe9NYEI66CQXfbbP/iaIV8eNdI0D5OTmoPEM+qs4MMg/NOUd1/yUqSoW
         e/rA==
X-Gm-Message-State: APjAAAVM5vDtWcKGeQB2j66LEssAHpybdEbFI7vdR6sFoob0bhM87je3
        Rp7s0Fp3MU3jsKts1JylE0E=
X-Google-Smtp-Source: APXvYqxB4qae84Gbted6ihgN3WcOBe6ZO2qabJbzOA2Q1KbNDFu7kMHAinnSOV2FdCilwtV/hdYduA==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr4237266wmh.35.1576575104198;
        Tue, 17 Dec 2019 01:31:44 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h66sm2467362wme.41.2019.12.17.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 01:31:43 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:31:43 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] mm/hugetlb: Defer freeing of huge pages if in
 non-task context
Message-ID: <20191217093143.GC31063@dhcp22.suse.cz>
References: <20191217012508.31495-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217012508.31495-1-longman@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-12-19 20:25:08, Waiman Long wrote:
[...]
> Both the hugetbl_lock and the subpool lock can be acquired in
> free_huge_page(). One way to solve the problem is to make both locks
> irq-safe.

Please document why we do not take this, quite natural path and instead
we have to come up with an elaborate way instead. I believe the primary
motivation is that some operations under those locks are quite
expensive. Please add that to the changelog and ideally to the code as
well. We probably want to fix those anyway and then this would be a
temporary workaround.

> Another alternative is to defer the freeing to a workqueue job.
> 
> This patch implements the deferred freeing by adding a
> free_hpage_workfn() work function to do the actual freeing. The
> free_huge_page() call in a non-task context saves the page to be freed
> in the hpage_freelist linked list in a lockless manner.

Do we need to over complicate this (presumably) rare event by a lockless
algorithm? Why cannot we use a dedicated spin lock for for the linked
list manipulation? This should be really a trivial code without an
additional burden of all the lockless subtleties.

> +	pr_debug("HugeTLB: free_hpage_workfn() frees %d huge page(s)\n", cnt);

Why do we need the debugging message here?
-- 
Michal Hocko
SUSE Labs
