Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891FC10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CE520811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfCYWWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:22:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:34864 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfCYWWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:22:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 15:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,270,1549958400"; 
   d="scan'208";a="143760397"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2019 15:22:36 -0700
Date:   Mon, 25 Mar 2019 07:21:25 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Message-ID: <20190325142125.GH16366@iweiny-DESK2.sc.intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
 <20190325164713.GC9949@ziepe.ca>
 <20190325092314.GF16366@iweiny-DESK2.sc.intel.com>
 <20190325175150.GA21008@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325175150.GA21008@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:51:50PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2019 at 02:23:15AM -0700, Ira Weiny wrote:
> > > > Unfortunately holding the lock is required to support FOLL_LONGTERM (to check
> > > > the VMAs) but we don't want to hold the lock to be optimal (specifically allow
> > > > FAULT_FOLL_ALLOW_RETRY).  So I'm maintaining the optimization for *_fast users
> > > > who do not specify FOLL_LONGTERM.
> > > > 
> > > > Another way to do this would have been to define __gup_longterm_unlocked with
> > > > the above logic, but that seemed overkill at this point.
> > > 
> > > get_user_pages_unlocked() is an exported symbol, shouldn't it work
> > > with the FOLL_LONGTERM flag?
> > > 
> > > I think it should even though we have no user..
> > > 
> > > Otherwise the GUP API just gets more confusing.
> > 
> > I agree WRT to the API.  But I think callers of get_user_pages_unlocked() are
> > not going to get the behavior they want if they specify FOLL_LONGTERM.
> 
> Oh? Isn't the only thing FOLL_LONGTERM does is block the call on DAX?

From an API yes.

> Why does the locking mode matter to this test?

DAX checks for VMA's being Filesystem DAX.  Therefore, it requires collection
of VMA's as the GUP code executes.  The unlocked version can drop the lock and
therefore the VMAs may become invalid.  Therefore, the 2 code paths are
incompatible.

Users of GUP unlocked are going to want the benefit of FAULT_FOLL_ALLOW_RETRY.
So I don't anticipate anyone using FOLL_LONGTERM with
get_user_pages_unlocked().

FWIW this thread is making me think my original patch which simply implemented
get_user_pages_fast_longterm() would be more clear.  There is some evidence
that the GUP API was trending that way (see get_user_pages_remote).  That seems
wrong but I don't know how to ensure users don't specify the wrong flag.

> 
> > What I could do is BUG_ON (or just WARN_ON) if unlocked is called with
> > FOLL_LONGTERM similar to the code in get_user_pages_locked() which does not
> > allow locked and vmas to be passed together:
> 
> The GUP call should fail if you are doing something like this. But I'd
> rather not see confusing specialc cases in code without a clear
> comment explaining why it has to be there.

Code comment would be necessary, sure.  Was just throwing ideas out there.

Ira

