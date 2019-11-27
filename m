Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61209C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401BD2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0MO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:14:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:54400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfK0MO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:14:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C33C1ADB3;
        Wed, 27 Nov 2019 12:14:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6649CDA733; Wed, 27 Nov 2019 13:14:23 +0100 (CET)
Date:   Wed, 27 Nov 2019 13:14:23 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs: Increase buffer size for zlib functions
Message-ID: <20191127121423.GQ2734@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Richard Purdie <rpurdie@rpsys.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191126144130.75710-1-zaslonko@linux.ibm.com>
 <20191126144130.75710-6-zaslonko@linux.ibm.com>
 <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126155249.j2dktiggykfoz4iz@MacBook-Pro-91.local>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:52:49AM -0500, Josef Bacik wrote:
> On Tue, Nov 26, 2019 at 03:41:30PM +0100, Mikhail Zaslonko wrote:
> > Due to the small size of zlib buffer (1 page) set in btrfs code, s390
> > hardware compression is rather limited in terms of performance. Increasing
> > the buffer size to 4 pages would bring significant benefit for s390
> > hardware compression (up to 60% better performance compared to the
> > PAGE_SIZE buffer) and should not bring much overhead in terms of memory
> > consumption due to order 2 allocations.
> > 
> > Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> 
> We may have to make these allocations under memory pressure in the IO context,
> order 2 allocations here is going to be not awesome.  If you really want it then
> you need to at least be able to fall back to single page if you fail to get the
> allocation.  Thanks,

The allocation is only for the workspace and it does not happen on the
IO path for each call. There's the pool and if

btrfs_get_workspace
  alloc_workspace

fails, then there's fallback path to wait for an existing workspace to
be free.

The order 2 allocation can put more pressure on the allocator though so
it's possible to have effects in some corner cases, but not in general.
I don't think the single page fallback code is needed.

And of course evaluation of the effects of the larger zlib buffer should
be done, it could improve compression but probably at the cost of cpu
time. Also decompression of blocks created on new code (4 pages) must
work on the old code (1 page).
