Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA5C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B642146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 15:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfELP2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 11:28:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbfELP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 11:28:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11849308218D;
        Sun, 12 May 2019 15:28:19 +0000 (UTC)
Received: from redhat.com (ovpn-120-196.rdu2.redhat.com [10.10.120.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CB7818A24;
        Sun, 12 May 2019 15:28:17 +0000 (UTC)
Date:   Sun, 12 May 2019 11:28:15 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call
 hmm_range_unregister()
Message-ID: <20190512152814.GC4238@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-5-rcampbell@nvidia.com>
 <CAFqt6zbhLQuw2N5-=Nma-vHz1BkWjviOttRsPXmde8U1Oocz0Q@mail.gmail.com>
 <fa2078fd-3ec7-5503-94d7-c4d1a766029a@nvidia.com>
 <20190512150724.GA4238@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190512150724.GA4238@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 12 May 2019 15:28:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 11:07:24AM -0400, Jerome Glisse wrote:
> On Tue, May 07, 2019 at 11:12:14AM -0700, Ralph Campbell wrote:
> > 
> > On 5/7/19 6:15 AM, Souptick Joarder wrote:
> > > On Tue, May 7, 2019 at 5:00 AM <rcampbell@nvidia.com> wrote:
> > > > 
> > > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > > 
> > > > The helper function hmm_vma_fault() calls hmm_range_register() but is
> > > > missing a call to hmm_range_unregister() in one of the error paths.
> > > > This leads to a reference count leak and ultimately a memory leak on
> > > > struct hmm.
> > > > 
> > > > Always call hmm_range_unregister() if hmm_range_register() succeeded.
> > > 
> > > How about * Call hmm_range_unregister() in error path if
> > > hmm_range_register() succeeded* ?
> > 
> > Sure, sounds good.
> > I'll include that in v2.
> 
> NAK for the patch see below why
> 
> > 
> > > > 
> > > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Cc: Matthew Wilcox <willy@infradead.org>
> > > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > ---
> > > >   include/linux/hmm.h | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > > > index 35a429621e1e..fa0671d67269 100644
> > > > --- a/include/linux/hmm.h
> > > > +++ b/include/linux/hmm.h
> > > > @@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> > > >                  return (int)ret;
> > > > 
> > > >          if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> > > > +               hmm_range_unregister(range);
> > > >                  /*
> > > >                   * The mmap_sem was taken by driver we release it here and
> > > >                   * returns -EAGAIN which correspond to mmap_sem have been
> > > > @@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
> > > > 
> > > >          ret = hmm_range_fault(range, block);
> > > >          if (ret <= 0) {
> > > > +               hmm_range_unregister(range);
> > > 
> > > what is the reason to moved it up ?
> > 
> > I moved it up because the normal calling pattern is:
> >     down_read(&mm->mmap_sem)
> >     hmm_vma_fault()
> >         hmm_range_register()
> >         hmm_range_fault()
> >         hmm_range_unregister()
> >     up_read(&mm->mmap_sem)
> > 
> > I don't think it is a bug to unlock mmap_sem and then unregister,
> > it is just more consistent nesting.
> 
> So this is not the usage pattern with HMM usage pattern is:
> 
> hmm_range_register()
> hmm_range_fault()
> hmm_range_unregister()
> 
> The hmm_vma_fault() is gonne so this patch here break thing.
> 
> See https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.2-v3

Sorry not enough coffee on sunday morning, so yeah this patch
looks good except that you do not need to move it up.

Note that hmm_vma_fault() is a gonner once ODP to HMM is upstream
and i converted nouveau/amd to new API then we can remove that
one.

Cheers,
Jérôme
