Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A5CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EC120678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfK0Nyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:54:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:35182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbfK0Nyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:54:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDB51AD54;
        Wed, 27 Nov 2019 13:54:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8D30DA733; Wed, 27 Nov 2019 14:54:36 +0100 (CET)
Date:   Wed, 27 Nov 2019 14:54:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Message-ID: <20191127135436.GR2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
 <11377b99-b66c-fdc3-5c8f-0bae34c92c03@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11377b99-b66c-fdc3-5c8f-0bae34c92c03@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 02:42:20PM +0100, Zaslonko Mikhail wrote:
> Hello,
> 
> On 26.11.2019 16:52, Josef Bacik wrote:
> > On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
> >> Due to the small size of zlib buffer (1 page) set in btrfs code, s390
> >> hardware compression is rather limited in terms of performance. Increasing
> >> the buffer size to 4 pages would bring significant benefit for s390
> >> hardware compression (up to 60% better performance compared to the
> >> PAGE_SIZE buffer) and should not bring much overhead in terms of memory
> >> consumption due to order 2 allocations.
> >>
> >> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> > 
> > We may have to make these allocations under memory pressure in the IO context,
> > order 2 allocations here is going to be not awesome.  If you really want it then
> > you need to at least be able to fall back to single page if you fail to get the
> > allocation.  Thanks,
> 
> As far as I understand GFP_KERNEL allocations would never fail for the order <= 
> PAGE_ALLOC_COSTLY_ORDER.

There's no guaranteed no-fail semantics for GFP flags (obviously besides
__GFP_NOFAIL), GFP_KERNEL can fail and GFP_NOFS is unlikely to fail for
order below costly allocations. This depends on the allocator internals
and has never been an API-level guarantee AFAIK. There's ongoing to work
to relax the allocator constraints and allow to fail in more cases
(like for GFP_NOFS).

> How else can the memory pressure condition be identified
> here?

All data write paths must consider what happens under memory pressure,
because the reason to write the data could be started by an allocation
that can get free memory by writing dirty data. So it's kind of implied
here.
