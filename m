Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E058C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADEB20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfHBGqY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:46:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:16775 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388295AbfHBGqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:46:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 23:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,337,1559545200"; 
   d="scan'208";a="167149268"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2019 23:46:23 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 1 Aug 2019 23:46:23 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.96]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.94]) with mapi id 14.03.0439.000;
 Thu, 1 Aug 2019 23:46:23 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH] fork: Improve error message for corrupted page tables
Thread-Topic: [PATCH] fork: Improve error message for corrupted page tables
Thread-Index: AQHVSCCBTlnukuaks0aiZwfZ/9aV0qbnaerQ
Date:   Fri, 2 Aug 2019 06:46:23 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4F9D61B5@ORSMSX114.amr.corp.intel.com>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
        <20190731152753.b17d9c4418f4bf6815a27ad8@linux-foundation.org>
        <a05920e5994fb74af480255471a6c3f090f29b27.camel@intel.com>
 <20190731212052.5c262ad084cbd6cf475df005@linux-foundation.org>
In-Reply-To: <20190731212052.5c262ad084cbd6cf475df005@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTA1ZTgzNWMtZTdlZS00NjAxLWEzYWEtNDMxMDE2NzU0MDQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9vODNtelwvV0pQeHloZ2YzM0czTnRRSVYrRXNoVzlSU3hZWDRPa1RYcmppbkN2NjVUQmRUcVJaSHRGdld4cVljIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> > > > +	"MM_FILEPAGES",
> > > > +	"MM_ANONPAGES",
> > > > +	"MM_SWAPENTS",
> > > > +	"MM_SHMEMPAGES",
> > > > +};
> > >
> > > But please let's not put this in a header file.  We're asking the
> > > compiler to put a copy of all of this into every compilation unit
> > > which includes the header.  Presumably the compiler is smart enough
> > > not to do that, but it's not good practice.
> >
> > Thanks for the explanation. Makes sense to me.
> >
> > Just wanted to check before sending V2, Is it OK if I add this to
> > kernel/fork.c? or do you have something else in mind?
> 
> I was thinking somewhere like mm/util.c so the array could be used by other
> code.  But it seems there is no such code.  Perhaps it's best to just leave fork.c as
> it is now.

Ok, so does that mean have the struct in header file itself?
Sorry! for too many questions. I wanted to check with you before changing 
because it's *the* fork.c file (I presume random changes will not be encouraged here)

I am not yet clear on what's the right thing to do here :(
So, could you please help me in deciding.

Regards,
Sai
