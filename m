Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37CC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22C7207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 03:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQOIJ9+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391791AbfIZD6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 23:58:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34807 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfIZD6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 23:58:52 -0400
Received: by mail-io1-f65.google.com with SMTP id q1so2883098ion.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=za27vP7fGm8+9PT7f7IK3Uqx3fTObgHXvmu/wu/VnKE=;
        b=bQOIJ9+vstWnZjmXdBcwCGCSRzuy7zvFQTAPM566qtEfDGKnPCRhVMGN4ogtSaMOYV
         XPgKrngFrGhArdMrEi4JEYFHBD1wx6WFwIrSvnQd4geTHIqD8F9+YwCz+CxP9vG2Tk9d
         rwhpU+VLuk4Ar6Fe+Enaxf9ZmumDvXtw21O99e8HFZFax/2Li8RxNPqu1aS8e91yVagw
         YAg5DzWMLYoEtoYC7G5BhpytddOzrX45SdFs+NFz6ZCNu/rOfdeMmDiwjKebU0T0lZys
         69mQJgNSz3icCde/nVlcDeyQE1Yzio40/M4A8yNSnEwj5lk+gUSIc87nTB5OOmKJ9rqh
         JudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=za27vP7fGm8+9PT7f7IK3Uqx3fTObgHXvmu/wu/VnKE=;
        b=Sx3S6lVJZbm0bKF6b9vwUhgS2JbgDbWLScoyPzwFk+4t6z5h5Lt0WXDDu0J3wTC20f
         V4MS/2F8/Ozh7ZvFQ4o0paGvAqLxAbuibSIrShO5XVUjiHOlQ4+fwieS9qQPUEmuD2rk
         VUFVYXnSp4PZXM5fTFf424e4rvVTdTi3cYj35MRFsMfizaffBnV/SHqJQxrOqNTvXeXV
         hxnlcWkXi0wZ/+ZWEX4B4BB7iShrE0mpLTg2sxcq7xZoIgCqkQF9Hhoi/V+T9XUmc7+H
         mh7eNFlagBq3NN2Be5Y1210Y01crh0dtgQXxPqkcnwJwgGGOytlC683EewroHL7bQFnO
         hCGw==
X-Gm-Message-State: APjAAAWqlbRIDchvWMWI53LFO7m04I4lBD1qiYxIICVRfoDosQ/NXtis
        SKUrSdZahdJ/RwmadtL9GtrT4Q==
X-Google-Smtp-Source: APXvYqzbjuY36NAHvnwG6gani3YnYtPbtOfFr+IIEKelTfYxnI9Yz/t8H6n0kADFfx/fiL9VkUgoKQ==
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr1596276iom.118.1569470331139;
        Wed, 25 Sep 2019 20:58:51 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id z10sm455431iog.41.2019.09.25.20.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 20:58:50 -0700 (PDT)
Date:   Wed, 25 Sep 2019 21:58:44 -0600
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
Message-ID: <20190926035844.GA89510@google.com>
References: <20190514230751.GA70050@google.com>
 <20190914070518.112954-1-yuzhao@google.com>
 <20190924112316.324l7gqpdzhpiliq@box>
 <20190924220550.GA123810@google.com>
 <20190925121750.zxrt2zkc4g73h6cp@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925121750.zxrt2zkc4g73h6cp@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:17:50PM +0300, Kirill A. Shutemov wrote:
> On Tue, Sep 24, 2019 at 04:05:50PM -0600, Yu Zhao wrote:
> > On Tue, Sep 24, 2019 at 02:23:16PM +0300, Kirill A. Shutemov wrote:
> > > On Sat, Sep 14, 2019 at 01:05:18AM -0600, Yu Zhao wrote:
> > > > We don't want to expose page to fast gup running on a remote CPU
> > > > before all local non-atomic ops on page flags are visible first.
> > > > 
> > > > For anon page that isn't in swap cache, we need to make sure all
> > > > prior non-atomic ops, especially __SetPageSwapBacked() in
> > > > page_add_new_anon_rmap(), are order before set_pte_at() to prevent
> > > > the following race:
> > > > 
> > > > 	CPU 1				CPU1
> > > > set_pte_at()			get_user_pages_fast()
> > > > page_add_new_anon_rmap()		gup_pte_range()
> > > > 	__SetPageSwapBacked()			SetPageReferenced()
> > > 
> > > Is there a particular codepath that has what you listed for CPU?
> > > After quick look, I only saw that we page_add_new_anon_rmap() called
> > > before set_pte_at().
> > 
> > I think so. One in do_swap_page() and another in unuse_pte(). Both
> > are on KSM paths. Am I referencing a stale copy of the source?
> 
> I *think* it is a bug. Setting a pte before adding the page to rmap may
> lead to rmap (like try_to_unmap() or something) to miss the VMA.
> 
> Do I miss something?

We have the pages locked in those two places, so for try_to_unmap()
and the rest of page_vma_mapped_walk() users, they will block on
the page lock:
	CPU 1			CPU 2
	lock_page()
	set_pte_at()
	unlock_page()
				lock_page()
				try_to_unmap()
				  page_vma_mapped_walk()
				    pte_present() without holding ptl
				unlock_page()

For others that don't use page_vma_mapped_walk(), they should either
lock pages or grab ptl before checking pte_present().

AFAIK, the fast gup is the only one doesn't fall into the either
category.
