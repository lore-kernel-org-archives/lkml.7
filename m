Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CD1C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6899420C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbfHFSdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:33:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:33316 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732489AbfHFSdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:33:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 11:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="168378909"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2019 11:33:12 -0700
Message-ID: <9a09db3d4827bc6bf49c4579d495d71015f2c5a6.camel@intel.com>
Subject: Re: [PATCH V2] fork: Improve error message for corrupted page tables
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Date:   Tue, 06 Aug 2019 11:30:02 -0700
In-Reply-To: <73b77479-cdd2-6d53-14ae-25ec4c4c3d25@intel.com>
References: <3ef8a340deb1c87b725d44edb163073e2b6eca5a.1565059496.git.sai.praneeth.prakhya@intel.com>
         <73b77479-cdd2-6d53-14ae-25ec4c4c3d25@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-06 at 09:30 -0700, Dave Hansen wrote:
> On 8/5/19 8:05 PM, Sai Praneeth Prakhya wrote:
> > +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> > +	[MM_FILEPAGES]		= "MM_FILEPAGES",
> > +	[MM_ANONPAGES]		= "MM_ANONPAGES",
> > +	[MM_SWAPENTS]		= "MM_SWAPENTS",
> > +	[MM_SHMEMPAGES]		= "MM_SHMEMPAGES",
> > +};
> 
> One trick to ensure that this gets updated if the names are ever
> updated.  You can do:
> 
> #define NAMED_ARRAY_INDEX(x)	[x] = __stringify(x),
> 
> and
> 
> static const char * const resident_page_types[NR_MM_COUNTERS] = {
> 	NAMED_ARRAY_INDEX(MM_FILE_PAGES),
> 	NAMED_ARRAY_INDEX(MM_SHMEMPAGES),
> 	...
> };

Thanks for the suggestion Dave. I will add this in V3.
Even with this, (if ever) anyone who changes the name of page types or adds an
new entry would still need to update struct resident_page_types[]. So, I will
add the comment as suggested by Vlastimil.

> 
> That makes sure that any name changes make it into the strings.  Then
> stick a:
> 
> 	BUILD_BUG_ON(NR_MM_COUNTERS != ARRAY_SIZE(resident_page_types));
> 
> somewhere.  That makes sure that any new array indexes get a string
> added in the array.  Otherwise you get nice, early, compile-time errors.

Sure! this sounds good and a small nit-bit :)
For the BUILD_BUG_ON() to work, the definition of struct should be changed as
below

static const char * const resident_page_types[] = {
...
}

i.e. we should not specify the size of array.

Regards,
Sai

