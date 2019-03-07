Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE0420851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCGS42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfCGS41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:56:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A060F30917A8;
        Thu,  7 Mar 2019 18:56:26 +0000 (UTC)
Received: from redhat.com (ovpn-125-54.rdu2.redhat.com [10.10.125.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2D7F19C65;
        Thu,  7 Mar 2019 18:56:25 +0000 (UTC)
Date:   Thu, 7 Mar 2019 13:56:23 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
Message-ID: <20190307185623.GD3835@redhat.com>
References: <CAPcyv4hZMcJ6r0Pw5aJsx37+YKx4qAY0rV4Ascc9LX6eFY8GJg@mail.gmail.com>
 <20190130030317.GC10462@redhat.com>
 <CAPcyv4jS7Y=DLOjRHbdRfwBEpxe_r7wpv0ixTGmL7kL_ThaQFA@mail.gmail.com>
 <20190130183616.GB5061@redhat.com>
 <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
 <20190131041641.GK5061@redhat.com>
 <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
 <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
 <20190307094654.35391e0066396b204d133927@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307094654.35391e0066396b204d133927@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 07 Mar 2019 18:56:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:46:54AM -0800, Andrew Morton wrote:
> On Tue, 5 Mar 2019 20:20:10 -0800 Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > My hesitation would be drastically reduced if there was a plan to
> > avoid dangling unconsumed symbols and functionality. Specifically one
> > or more of the following suggestions:
> > 
> > * EXPORT_SYMBOL_GPL on all exports to avoid a growing liability
> > surface for out-of-tree consumers to come grumble at us when we
> > continue to refactor the kernel as we are wont to do.
> 
> The existing patches use EXPORT_SYMBOL() so that's a sticking point. 
> Jerome, what would happen is we made these EXPORT_SYMBOL_GPL()?

So Dan argue that GPL export solve the problem of out of tree user and
my personnal experience is that it does not. The GPU sub-system has tons
of GPL drivers that are not upstream and we never felt that we were bound
to support them in anyway. We always were very clear that if you are not
upstream that you do not have any voice on changes we do.

So my exeperience is that GPL does not help here. It is just about being
clear and ignoring anyone who does not have an upstream driver ie we have
free hands to update HMM in anyway as long as we keep supporting the
upstream user.

That being said if the GPL aspect is that much important to some then
fine let switch all HMM symbol to GPL.

> 
> > * A commitment to consume newly exported symbols in the same merge
> > window, or the following merge window. When that goal is missed revert
> > the functionality until such time that it can be consumed, or
> > otherwise abandoned.
> 
> It sounds like we can tick this box.

I wouldn't be too strick either, when adding something in release N
the driver change in N+1 can miss N+1 because of bug or regression
and be push to N+2.

I think a better stance here is that if we do not get any sign-off
on the feature from driver maintainer for which the feature is intended
then we just do not merge. If after few release we still can not get
the driver to use it then we revert.

It just feels dumb to revert at N+1 just to get it back in N+2 as
the driver bit get fix.

> 
> > * No new symbol exports and functionality while existing symbols go unconsumed.
> 
> Unsure about this one?

With nouveau upstream now everything is use. ODP will use some of the
symbol too. PPC has patchset posted to use lot of HMM too. I have been
working with other vendor that have patchset being work on to use HMM
too.

I have not done all those function just for the fun of it :) They do
have real use and user. It took a longtime to get nouveau because of
userspace we had a lot of catchup to do in mesa and llvm and we are
still very rough there.

Cheers,
Jérôme
