Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33361C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99CF21850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfDKVug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:50:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:57372 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfDKVug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:50:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 14:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,338,1549958400"; 
   d="scan'208";a="335989192"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga006.fm.intel.com with ESMTP; 11 Apr 2019 14:50:35 -0700
Date:   Thu, 11 Apr 2019 14:50:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jglisse@redhat.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, kvm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 7/8] mm/mmu_notifier: pass down vma and reasons why
 mmu notifier is happening v2
Message-ID: <20190411215033.GH22989@iweiny-DESK2.sc.intel.com>
References: <20190326164747.24405-1-jglisse@redhat.com>
 <20190326164747.24405-8-jglisse@redhat.com>
 <20190410234124.GE22989@iweiny-DESK2.sc.intel.com>
 <20190411054130.GY3201@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411054130.GY3201@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:41:30AM +0300, Leon Romanovsky wrote:
> On Wed, Apr 10, 2019 at 04:41:57PM -0700, Ira Weiny wrote:
> > On Tue, Mar 26, 2019 at 12:47:46PM -0400, Jerome Glisse wrote:
> > > From: Jérôme Glisse <jglisse@redhat.com>
> > >

[snip]

> > > diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> > > index 62f94cd85455..0379956fff23 100644
> > > --- a/include/linux/mmu_notifier.h
> > > +++ b/include/linux/mmu_notifier.h
> > > @@ -58,10 +58,12 @@ struct mmu_notifier_mm {
> > >  #define MMU_NOTIFIER_RANGE_BLOCKABLE (1 << 0)
> > >
> > >  struct mmu_notifier_range {
> > > +	struct vm_area_struct *vma;
> > >  	struct mm_struct *mm;
> > >  	unsigned long start;
> > >  	unsigned long end;
> > >  	unsigned flags;
> > > +	enum mmu_notifier_event event;
> > >  };
> > >
> > >  struct mmu_notifier_ops {
> > > @@ -363,10 +365,12 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
> > >  					   unsigned long start,
> > >  					   unsigned long end)
> > >  {
> > > +	range->vma = vma;
> > > +	range->event = event;
> > >  	range->mm = mm;
> > >  	range->start = start;
> > >  	range->end = end;
> > > -	range->flags = 0;
> > > +	range->flags = flags;
> >
> > Which of the "user patch sets" uses the new flags?
> >
> > I'm not seeing that user yet.  In general I don't see anything wrong with the
> > series and I like the idea of telling drivers why the invalidate has fired.
> >
> > But is the flags a future feature?
> 
> It seems that it is used in HMM ODP patch.
> https://patchwork.kernel.org/patch/10894281/

AFAICT the flags in that patch are "hmm_range->flags"  not
"mmu_notifier_range->flags"

They are not the same.

Ira

> 
> Thanks
> 
> >
> > For the series:
> >
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> >
> > Ira
> >
> > >  }
> > >
> > >  #define ptep_clear_flush_young_notify(__vma, __address, __ptep)		\
> > > --
> > > 2.20.1
> > >


