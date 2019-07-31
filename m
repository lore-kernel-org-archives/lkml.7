Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21362C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E735B20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 22:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfGaWkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 18:40:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:36651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfGaWkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 18:40:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 15:40:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,331,1559545200"; 
   d="scan'208";a="191399007"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jul 2019 15:40:07 -0700
Message-ID: <a05920e5994fb74af480255471a6c3f090f29b27.camel@intel.com>
Subject: Re: [PATCH] fork: Improve error message for corrupted page tables
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 31 Jul 2019 15:36:49 -0700
In-Reply-To: <20190731152753.b17d9c4418f4bf6815a27ad8@linux-foundation.org>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
         <20190731152753.b17d9c4418f4bf6815a27ad8@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > With patch:
> > -----------
> > [   69.815453] mm/pgtable-generic.c:29: bad p4d
> > 0000000084653642(800000025ca37467)
> > [   69.815872] BUG: Bad rss-counter state mm:00000000014a6c03
> > type:MM_FILEPAGES val:2
> > [   69.815962] BUG: Bad rss-counter state mm:00000000014a6c03
> > type:MM_ANONPAGES val:5
> > [   69.816050] BUG: non-zero pgtables_bytes on freeing mm: 20480
> 
> Seems useful.
> 
> > --- a/include/linux/mm_types_task.h
> > +++ b/include/linux/mm_types_task.h
> > @@ -44,6 +44,13 @@ enum {
> >  	NR_MM_COUNTERS
> >  };
> >  
> > +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> > +	"MM_FILEPAGES",
> > +	"MM_ANONPAGES",
> > +	"MM_SWAPENTS",
> > +	"MM_SHMEMPAGES",
> > +};
> 
> But please let's not put this in a header file.  We're asking the
> compiler to put a copy of all of this into every compilation unit which
> includes the header.  Presumably the compiler is smart enough not to
> do that, but it's not good practice.

Thanks for the explanation. Makes sense to me.

Just wanted to check before sending V2,
Is it OK if I add this to kernel/fork.c? or do you have something else in
mind?

Regards,
Sai

