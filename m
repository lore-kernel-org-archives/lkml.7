Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5565C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84A720B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 03:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfHFDNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 23:13:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:62755 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbfHFDNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 23:13:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 20:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; 
   d="scan'208";a="202666879"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga002.fm.intel.com with ESMTP; 05 Aug 2019 20:13:09 -0700
Message-ID: <1c6a18dd63e6005045034ccc7b04390ab3c605e5.camel@intel.com>
Subject: Re: [PATCH] fork: Improve error message for corrupted page tables
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 05 Aug 2019 20:09:59 -0700
In-Reply-To: <4236c0c5-9671-b9fe-b5eb-7d1908767905@suse.cz>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
         <20190731152753.b17d9c4418f4bf6815a27ad8@linux-foundation.org>
         <a05920e5994fb74af480255471a6c3f090f29b27.camel@intel.com>
         <20190731212052.5c262ad084cbd6cf475df005@linux-foundation.org>
         <FFF73D592F13FD46B8700F0A279B802F4F9D61B5@ORSMSX114.amr.corp.intel.com>
         <4236c0c5-9671-b9fe-b5eb-7d1908767905@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 15:28 +0200, Vlastimil Babka wrote:
> On 8/2/19 8:46 AM, Prakhya, Sai Praneeth wrote:
> > > > > > +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> > > > > > +	"MM_FILEPAGES",
> > > > > > +	"MM_ANONPAGES",
> > > > > > +	"MM_SWAPENTS",
> > > > > > +	"MM_SHMEMPAGES",
> > > > > > +};
> > > > > 
> > > > > But please let's not put this in a header file.  We're asking the
> > > > > compiler to put a copy of all of this into every compilation unit
> > > > > which includes the header.  Presumably the compiler is smart enough
> > > > > not to do that, but it's not good practice.
> > > > 
> > > > Thanks for the explanation. Makes sense to me.
> > > > 
> > > > Just wanted to check before sending V2, Is it OK if I add this to
> > > > kernel/fork.c? or do you have something else in mind?
> > > 
> > > I was thinking somewhere like mm/util.c so the array could be used by
> > > other
> > > code.  But it seems there is no such code.  Perhaps it's best to just
> > > leave fork.c as
> > > it is now.
> > 
> > Ok, so does that mean have the struct in header file itself?
> 
> If the struct definition (including the string values) was in mm/util.c,
> there would have to be a declaration in a header. If it's in fork.c with
> the only users, there doesn't need to be separate declaration in a header.

Makes sense.

> 
> > Sorry! for too many questions. I wanted to check with you before changing 
> > because it's *the* fork.c file (I presume random changes will not be
> > encouraged here)
> > 
> > I am not yet clear on what's the right thing to do here :(
> > So, could you please help me in deciding.
> 
> fork.c should be fine, IMHO

I was leaning to add struct definition in fork.c as well but just wanted to
check with Andrew before posting V2.

Thanks for the reply though :)

Regards,
Sai

