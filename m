Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2014C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8579B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfEMSKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:10:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbfEMSKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:10:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E75513087951;
        Mon, 13 May 2019 18:10:04 +0000 (UTC)
Received: from redhat.com (ovpn-112-54.rdu2.redhat.com [10.10.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B974E18A5D;
        Mon, 13 May 2019 18:10:02 +0000 (UTC)
Date:   Mon, 13 May 2019 14:10:00 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] mm/hmm: HMM documentation updates and code fixes
Message-ID: <20190513181000.GA30726@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190512150832.GB4238@redhat.com>
 <89c6ce48-190b-65df-7c35-a0eb0f5d936f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89c6ce48-190b-65df-7c35-a0eb0f5d936f@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 13 May 2019 18:10:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 10:26:59AM -0700, Ralph Campbell wrote:
> 
> 
> On 5/12/19 8:08 AM, Jerome Glisse wrote:
> > On Mon, May 06, 2019 at 04:29:37PM -0700, rcampbell@nvidia.com wrote:
> > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > 
> > > I hit a use after free bug in hmm_free() with KASAN and then couldn't
> > > stop myself from cleaning up a bunch of documentation and coding style
> > > changes. So the first two patches are clean ups, the last three are
> > > the fixes.
> > > 
> > > Ralph Campbell (5):
> > >    mm/hmm: Update HMM documentation
> > >    mm/hmm: Clean up some coding style and comments
> > >    mm/hmm: Use mm_get_hmm() in hmm_range_register()
> > >    mm/hmm: hmm_vma_fault() doesn't always call hmm_range_unregister()
> > >    mm/hmm: Fix mm stale reference use in hmm_free()
> > 
> > This patchset does not seems to be on top of
> > https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.2-v3
> > 
> > So here we are out of sync, on documentation and code. If you
> > have any fix for https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.2-v3
> > then please submit something on top of that.
> > 
> > Cheers,
> > Jérôme
> > 
> > > 
> > >   Documentation/vm/hmm.rst | 139 ++++++++++++++++++-----------------
> > >   include/linux/hmm.h      |  84 ++++++++++------------
> > >   mm/hmm.c                 | 151 ++++++++++++++++-----------------------
> > >   3 files changed, 174 insertions(+), 200 deletions(-)
> > > 
> > > -- 
> > > 2.20.1
> 
> The patches are based on top of Andrew's mmotm tree
> git://git.cmpxchg.org/linux-mmotm.git v5.1-rc6-mmotm-2019-04-25-16-30.
> They apply cleanly to that git tag as well as your hmm-5.2-v3 branch
> so I guess I am confused where we are out of sync.

No disregard my email, i was trying to apply on top of wrong
branch yesterday morning while catching up on big backlog of
email. Failure was on my side.

Cheers,
Jérôme
