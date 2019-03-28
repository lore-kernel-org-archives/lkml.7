Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B201A21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfC1XYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:24:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbfC1XYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:24:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E5A6859FF;
        Thu, 28 Mar 2019 23:24:07 +0000 (UTC)
Received: from redhat.com (ovpn-121-118.rdu2.redhat.com [10.10.121.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 978C519C5A;
        Thu, 28 Mar 2019 23:24:06 +0000 (UTC)
Date:   Thu, 28 Mar 2019 19:24:04 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 10/11] mm/hmm: add helpers for driver to safely take
 the mmap_sem v2
Message-ID: <20190328232404.GK13560@redhat.com>
References: <20190325144011.10560-11-jglisse@redhat.com>
 <9df742eb-61ca-3629-a5f4-8ad1244ff840@nvidia.com>
 <20190328213047.GB13560@redhat.com>
 <a16efd42-3e2b-1b72-c205-0c2659de2750@nvidia.com>
 <20190328220824.GE13560@redhat.com>
 <068db0a8-fade-8ed1-3b9d-c29c27797301@nvidia.com>
 <20190328224032.GH13560@redhat.com>
 <0b698b36-da17-434b-b8e7-4a91ac6c9d82@nvidia.com>
 <20190328230543.GI13560@redhat.com>
 <9e414b8c-0f98-a2f7-4f46-d335c015fc1b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e414b8c-0f98-a2f7-4f46-d335c015fc1b@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 28 Mar 2019 23:24:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:20:37PM -0700, John Hubbard wrote:
> On 3/28/19 4:05 PM, Jerome Glisse wrote:
> > On Thu, Mar 28, 2019 at 03:43:33PM -0700, John Hubbard wrote:
> >> On 3/28/19 3:40 PM, Jerome Glisse wrote:
> >>> On Thu, Mar 28, 2019 at 03:25:39PM -0700, John Hubbard wrote:
> >>>> On 3/28/19 3:08 PM, Jerome Glisse wrote:
> >>>>> On Thu, Mar 28, 2019 at 02:41:02PM -0700, John Hubbard wrote:
> >>>>>> On 3/28/19 2:30 PM, Jerome Glisse wrote:
> >>>>>>> On Thu, Mar 28, 2019 at 01:54:01PM -0700, John Hubbard wrote:
> >>>>>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> >>>>>>>>> From: Jérôme Glisse <jglisse@redhat.com>
> >>>> [...]
> >>>> OK, so let's either drop this patch, or if merge windows won't allow that,
> >>>> then *eventually* drop this patch. And instead, put in a hmm_sanity_check()
> >>>> that does the same checks.
> >>>
> >>> RDMA depends on this, so does the nouveau patchset that convert to new API.
> >>> So i do not see reason to drop this. They are user for this they are posted
> >>> and i hope i explained properly the benefit.
> >>>
> >>> It is a common pattern. Yes it only save couple lines of code but down the
> >>> road i will also help for people working on the mmap_sem patchset.
> >>>
> >>
> >> It *adds* a couple of lines that are misleading, because they look like they
> >> make things safer, but they don't actually do so.
> > 
> > It is not about safety, sorry if it confused you but there is nothing about
> > safety here, i can add a big fat comment that explains that there is no safety
> > here. The intention is to allow the page fault handler that potential have
> > hundred of page fault queue up to abort as soon as it sees that it is pointless
> > to keep faulting on a dying process.
> > 
> > Again if we race it is _fine_ nothing bad will happen, we are just doing use-
> > less work that gonna be thrown on the floor and we are just slowing down the
> > process tear down.
> > 
> 
> In addition to a comment, how about naming this thing to indicate the above 
> intention?  I have a really hard time with this odd down_read() wrapper, which
> allows code to proceed without really getting a lock. It's just too wrong-looking.
> If it were instead named:
> 
> 	hmm_is_exiting()

What about: hmm_lock_mmap_if_alive() ?


> 
> and had a comment about why racy is OK, then I'd be a lot happier. :)

Will add fat comment.

Cheers,
Jérôme
