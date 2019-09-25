Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B80C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D392B21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jblpeYxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfIYWEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:04:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43767 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfIYWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:04:05 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so931111iob.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhSXr0xwJou4CoHBVDkYpqEBKlvURobJgoh1V6NDSjs=;
        b=jblpeYxKQoyJmfsZMCmiDcmuM+FHKLJTEP5QO8aqTtsPSA162GLOOMY3I1QvTVagmR
         La3h7pZ71pbLo35PzU6woYBU3jvuLcYdgR1/NDzFhZYf/WRwZje7zyIuYHgi28z1703K
         8nEZ9pnX5ZyvreXvrTK07tJ4OBeo0Dq/fPdMrXnydLlEde3EGaYx+0jhEq2wn7tjgYWM
         Q+dAosbXaZGoVrsNFmjknJ/M8YTn8mMKQmLadL54FxuQYRXZPyPv4mY5eXhLieCXbtJD
         s2C7LEcUR65NjG7xXUCtfyBtZOVFAjrza2HtAgB1GaVK/K4bk/U11pAdiSAAi5ZFpm6g
         k8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhSXr0xwJou4CoHBVDkYpqEBKlvURobJgoh1V6NDSjs=;
        b=epgmO6PIBkHmbSpjkNiu/cKh5zYxMc+1+HwlHddUmc9M2LhX+vFk/8yjNfivTsRBee
         rxF9F1G4LbFaR0/7tFEx7ZS/uve75yt5/ckvGjCnpfmY9MDc/gJrw63M+OTNZml+wcMv
         PSWWkDc3wTuK8suQguV8Djz/XBOicgLu0rPWOucY67zMJ8TMGvemtuaYNDmNb1lXnPhH
         UDJbOzTB2zQLMIh9xoYOyw6UKBl4vQlUF8XvSRHuhADt/5t9vEv9J50iCucyFVpSj85H
         RrOPh/xNWTwpW7tnnEqNVc0gw6ooJtFJKmvGXROvG6cwNBkJIbpcre9IqT34Uur193K9
         xRLw==
X-Gm-Message-State: APjAAAVaEyZXqGh1sz3OtCXXaD17E/vhjGj7fQuknTmiFmhrYHrkL9eZ
        +kN6wy4HE284netkUOJ9z97ekw==
X-Google-Smtp-Source: APXvYqy0FhjpHx52fw8cVLnKaT3mISXokIpYLz5tzwz8cwp42mILIHWjKtVz8t1TqzCc2JV+cmz07g==
X-Received: by 2002:a5e:d817:: with SMTP id l23mr232373iok.142.1569449043502;
        Wed, 25 Sep 2019 15:04:03 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id t8sm58874ild.7.2019.09.25.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:04:02 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:03:57 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 4/4] mm: remove unnecessary smp_wmb() in
 __SetPageUptodate()
Message-ID: <20190925220357.GA162930@google.com>
References: <20190914070518.112954-1-yuzhao@google.com>
 <20190924232459.214097-1-yuzhao@google.com>
 <20190924232459.214097-4-yuzhao@google.com>
 <20190924235036.GA24516@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924235036.GA24516@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 04:50:36PM -0700, Matthew Wilcox wrote:
> On Tue, Sep 24, 2019 at 05:24:59PM -0600, Yu Zhao wrote:
> > +/*
> > + * Only use this function when there is a following write barrier, e.g.,
> > + * an explicit smp_wmb() and/or the page will be added to page or swap
> > + * cache locked.
> > + */
> >  static __always_inline void __SetPageUptodate(struct page *page)
> >  {
> >  	VM_BUG_ON_PAGE(PageTail(page), page);
> > -	smp_wmb();
> >  	__set_bit(PG_uptodate, &page->flags);
> >  }
> 
> Isn't this now the same as __SETPAGEFLAG(uptodate, Uptodate, PF_NO_TAIL)?

Indeed. I'll use the macro in the next version.
