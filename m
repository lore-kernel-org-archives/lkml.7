Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AA2C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 22:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DA220872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 22:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHpJEebm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442023AbfIXWF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 18:05:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41811 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387542AbfIXWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 18:05:56 -0400
Received: by mail-io1-f66.google.com with SMTP id r26so8312583ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l11MQ+lA+OctjrXx4RVwP5DBxpG6bC0YG4oKg9f4dBc=;
        b=OHpJEebmt1koUbYUVd8ncvkV9ubqcGE7mtrWdS/c65uTLTqMphgV1caO7X4bPYYKIS
         f2A1vBtXhAq4sSHqbYEsgWREsC+eh4cYwwTEko1y7I7X/X9C4L8m4dCj+zCTdOxu9MOg
         z5WkbHoGkzNQt8S2Q64sRCVabMMZma3bVBqeaF42X5606EK03hy9wD8wUWFfVDAynwHT
         uwO8mqrqQQf35Jvi1RCtJfHzvYKK7r9TA7FXAzl0n7GcIlFhdV79K6W1FD8TJI8Eg9Qg
         Yotfk/n/C9BcCVCmd4G154js4Mko5Fpka3nFphpRFSKO/u9a7PBsYWEjQM5TA36D+vq8
         F5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l11MQ+lA+OctjrXx4RVwP5DBxpG6bC0YG4oKg9f4dBc=;
        b=t0+Agnrs7CdPe6g2cj52sUfeW6+6zKeVdK7+uA0hBT5OCnTLltFkO05vf52IaoB4jK
         hGfTr0gX9fM2GPSIU+l/hGjC8kgpV9g0jspYcC0KyeiSsBTSEPd2caffWJsJQ9CJjt5s
         sHOQYerNgbssGbcGDYWpAqnxVyRrU+65tVvbF9x5jDENkjOZLVS3RIDDjd8wNTN2Jnmz
         84sQNcqsdCpJVYYDvEMQO3+fBVHDGqhiQxJaZypB0wX44FpB2w2MDWKN6zrMl6sKKNTj
         4hhikrSTh8q9/65Wjka9ZVVAGtu8mPWONmUehfhwbI0sBUyRtQcfX1wJ8wRRvkbOeG+o
         cUjA==
X-Gm-Message-State: APjAAAX5MsdeRoRMAi0MK7H8bZZHehT6LpOhJs7wZTbgE209B2k+fHIr
        LVOk6mRo/331CTKqsOHAPzSxAA==
X-Google-Smtp-Source: APXvYqy0q9UE81FUZmx9HjZuQrw+R0WHHAHqbnuLQUlSW8gIKlKykk3AQTIV+navbqB0cIVqup0GjQ==
X-Received: by 2002:a02:683:: with SMTP id 125mr1373599jav.132.1569362755310;
        Tue, 24 Sep 2019 15:05:55 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id v3sm5236863ioh.51.2019.09.24.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 15:05:54 -0700 (PDT)
Date:   Tue, 24 Sep 2019 16:05:50 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: don't expose page to fast gup prematurely
Message-ID: <20190924220550.GA123810@google.com>
References: <20190514230751.GA70050@google.com>
 <20190914070518.112954-1-yuzhao@google.com>
 <20190924112316.324l7gqpdzhpiliq@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924112316.324l7gqpdzhpiliq@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 02:23:16PM +0300, Kirill A. Shutemov wrote:
> On Sat, Sep 14, 2019 at 01:05:18AM -0600, Yu Zhao wrote:
> > We don't want to expose page to fast gup running on a remote CPU
> > before all local non-atomic ops on page flags are visible first.
> > 
> > For anon page that isn't in swap cache, we need to make sure all
> > prior non-atomic ops, especially __SetPageSwapBacked() in
> > page_add_new_anon_rmap(), are order before set_pte_at() to prevent
> > the following race:
> > 
> > 	CPU 1				CPU1
> > set_pte_at()			get_user_pages_fast()
> > page_add_new_anon_rmap()		gup_pte_range()
> > 	__SetPageSwapBacked()			SetPageReferenced()
> 
> Is there a particular codepath that has what you listed for CPU?
> After quick look, I only saw that we page_add_new_anon_rmap() called
> before set_pte_at().

I think so. One in do_swap_page() and another in unuse_pte(). Both
are on KSM paths. Am I referencing a stale copy of the source?
