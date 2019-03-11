Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E160D2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCKMsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:48:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40025 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCKMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:48:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id f11so4794898qti.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PGJ8zbf+GI7ZC/qAnsaCLtDgJXBhsk00TKBeRn8gflg=;
        b=oQGzgnaXmxp/otebK55HX8YXzP4AlEA3kPx6UlUhiEtYUmwU/sAe4aIVRzoHUyysxo
         sx04ITgofhw1Bx5wvyjAdeUUKW0mWGmO3rP+XcoEmjbhhDD5evEjEgwryHc0ejD4owPt
         tOkYAYFhk7KeD2M0BTjSt2E3UqO1gm7OiKf89eweSr44bFsmfvWR2lyU6w9Z/bUaxAEW
         aQXkffEI72Y5mxeNMEFHNkfxEreNVYrgSBMnD7jy3F+2RgjtiOX5A2TV2hCFJZ9kRSbv
         Dkk6zRXStGb3eko3q4RBn12ZXUfvZ2inO81GH+FeQY8l6+pWNEOW1T5FwJh0tEULPW+O
         uuYA==
X-Gm-Message-State: APjAAAVndWLw9ML0IpIsPTQ6niTBdQyt05D8WfCjYl1tQRYCcHevftPx
        rUUQ015L/clVwxWNLIT4w7VelQ==
X-Google-Smtp-Source: APXvYqxitHgoNrrmoC1MNnHg0e8hERINGOglRw7Z0VJ/zXaiPKexOixiLmMkua/cdJCvwC/0bEHapg==
X-Received: by 2002:a0c:d849:: with SMTP id i9mr1325157qvj.207.1552308520546;
        Mon, 11 Mar 2019 05:48:40 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id l6sm3005169qkc.36.2019.03.11.05.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 05:48:39 -0700 (PDT)
Date:   Mon, 11 Mar 2019 08:48:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20190311084525-mutt-send-email-mst@kernel.org>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
 <1551856692-3384-6-git-send-email-jasowang@redhat.com>
 <20190307103503-mutt-send-email-mst@kernel.org>
 <20190307124700-mutt-send-email-mst@kernel.org>
 <20190307191622.GP23850@redhat.com>
 <e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
 <20190308194845.GC26923@redhat.com>
 <8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:40:31PM +0800, Jason Wang wrote:
> 
> On 2019/3/9 上午3:48, Andrea Arcangeli wrote:
> > Hello Jeson,
> > 
> > On Fri, Mar 08, 2019 at 04:50:36PM +0800, Jason Wang wrote:
> > > Just to make sure I understand here. For boosting through huge TLB, do
> > > you mean we can do that in the future (e.g by mapping more userspace
> > > pages to kenrel) or it can be done by this series (only about three 4K
> > > pages were vmapped per virtqueue)?
> > When I answered about the advantages of mmu notifier and I mentioned
> > guaranteed 2m/gigapages where available, I overlooked the detail you
> > were using vmap instead of kmap. So with vmap you're actually doing
> > the opposite, it slows down the access because it will always use a 4k
> > TLB even if QEMU runs on THP or gigapages hugetlbfs.
> > 
> > If there's just one page (or a few pages) in each vmap there's no need
> > of vmap, the linearity vmap provides doesn't pay off in such
> > case.
> > 
> > So likely there's further room for improvement here that you can
> > achieve in the current series by just dropping vmap/vunmap.
> > 
> > You can just use kmap (or kmap_atomic if you're in preemptible
> > section, should work from bh/irq).
> > 
> > In short the mmu notifier to invalidate only sets a "struct page *
> > userringpage" pointer to NULL without calls to vunmap.
> > 
> > In all cases immediately after gup_fast returns you can always call
> > put_page immediately (which explains why I'd like an option to drop
> > FOLL_GET from gup_fast to speed it up).
> > 
> > Then you can check the sequence_counter and inc/dec counter increased
> > by _start/_end. That will tell you if the page you got and you called
> > put_page to immediately unpin it or even to free it, cannot go away
> > under you until the invalidate is called.
> > 
> > If sequence counters and counter tells that gup_fast raced with anyt
> > mmu notifier invalidate you can just repeat gup_fast. Otherwise you're
> > done, the page cannot go away under you, the host virtual to host
> > physical mapping cannot change either. And the page is not pinned
> > either. So you can just set the "struct page * userringpage = page"
> > where "page" was the one setup by gup_fast.
> > 
> > When later the invalidate runs, you can just call set_page_dirty if
> > gup_fast was called with "write = 1" and then you clear the pointer
> > "userringpage = NULL".
> > 
> > When you need to read/write to the memory
> > kmap/kmap_atomic(userringpage) should work.
> 
> 
> Yes, I've considered kmap() from the start. The reason I don't do that is
> large virtqueue may need more than one page so VA might not be contiguous.
> But this is probably not a big issue which just need more tricks in the
> vhost memory accessors.
> 
> 
> > 
> > In short because there's no hardware involvement here, the established
> > mapping is just the pointer to the page, there is no need of setting
> > up any pagetables or to do any TLB flushes (except on 32bit archs if
> > the page is above the direct mapping but it never happens on 64bit
> > archs).
> 
> 
> I see, I believe we don't care much about the performance of 32bit archs (or
> we can just fallback to copy_to_user() friends).

Using copyXuser is better I guess.

> Using direct mapping (I
> guess kernel will always try hugepage for that?) should be better and we can
> even use it for the data transfer not only for the metadata.
> 
> Thanks

We can't really. The big issue is get user pages. Doing that on data
path will be slower than copyXuser. Or maybe it won't with the
amount of mitigations spread around. Go ahead and try.


> 
> > 
> > Thanks,
> > Andrea
