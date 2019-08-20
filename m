Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A4C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9052C23A85
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566289109;
	bh=EB4zPHil68OfUBNHJhGs89GGhzTtLh3a1pCQRV0xqJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E3av9YDWs2UVbvRtIDLt//d0VsCHwfHogAVjE8pXdFX3MG8PhFkXFZZpFIC8likf8
	 u4AujT3LB69+Sw33rY8aeo0r1D/4HTIbUH5mO4uFgiw9xPMXA3V+lBoCpmrBtbhJeE
	 yjx1srdjV88NsHPjJL5eFS8hlJUl3ttGMXCsSZ2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfHTIS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:18:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729345AbfHTIS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:18:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 236DBB009;
        Tue, 20 Aug 2019 08:18:26 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:18:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org DRI Development" 
        <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wei Wang <wvw@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/5] kernel.h: Add non_block_start/end()
Message-ID: <20190820081825.GJ3111@dhcp22.suse.cz>
References: <20190815174207.GR9477@dhcp22.suse.cz>
 <20190815182448.GP21596@ziepe.ca>
 <20190815190525.GS9477@dhcp22.suse.cz>
 <20190815191810.GR21596@ziepe.ca>
 <20190815193526.GT9477@dhcp22.suse.cz>
 <20190815201323.GU21596@ziepe.ca>
 <20190816081029.GA27790@dhcp22.suse.cz>
 <20190816121906.GC5398@ziepe.ca>
 <20190816122625.GA10499@dhcp22.suse.cz>
 <20190816143145.GD5398@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816143145.GD5398@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-08-19 11:31:45, Jason Gunthorpe wrote:
> On Fri, Aug 16, 2019 at 02:26:25PM +0200, Michal Hocko wrote:
[...]
> > I believe I have given some examples when introducing __GFP_NOLOCKDEP.
> 
> Okay, I think that is 7e7844226f10 ("lockdep: allow to disable reclaim
> lockup detection") Hmm, sadly the lkml link in the commit is broken.
> 
> Hum. There are no users of __GFP_NOLOCKDEP today?? Could all the false
> positives have been fixed??

I would be more than surprised. Those false possitives were usually
papered over by using GFP_NOFS. And the original plan was to convert
those back to GFP_KERNEL like allocations and use __GFP_NOLOCKDEP.
 
> Keep in mind that this fs_reclaim was reworked away from the hacky
> interrupt context flag to a fairly elegant real lock map.

I am glad to hear that because that was just too ugly to live.

> Based on my read of the commit message, my first reaction would be to
> suggest lockdep_set_class() to solve the problem described, ie
> different classes for 'inside transaction' and 'outside transaction'
> on xfs_refcountbt_init_cursor()

No this just turned out to be unmaintainable. The number of lock classes
was growing high. I recommend on of the Dave Chinner's rant. Sorry not
link handy.

> I understood that generally that is the way to handle lockdep false
> positives.
> 
> Anyhow, if you are willing to consider that lockdep isn't broken, I
> have some ideas on how to make this clearer and increase
> coverage. Would you be willing to look at patches on this topic? (not
> soon, I have to finish my mmu notifier stuff)

I haven't claimed that the lockdep is broken. It just had problems to
capture some code paths and generated false positives. I would recommend
talking to lockdep maintainers much more than to me because I would have
to dive into the code much more to be useful. I can still comment on the
MM side of the thing of course if that is helpful.

> > > I would like to inject it into the notifier path as this is very
> > > difficult for driver authors to discover and know about, but I'm
> > > worried about your false positive remark.
> > > 
> > > I think I understand we can use only GFP_ATOMIC in the notifiers, but
> > > we need a strategy to handle OOM to guarentee forward progress.
> > 
> > Your example is from the notifier registration IIUC. 
> 
> Yes, that is where this commit hit it.. Triggering this under an
> actual notifier to get a lockdep report is hard.

All you need is to generate a memory pressure. That shouldn't be that
hard.
-- 
Michal Hocko
SUSE Labs
