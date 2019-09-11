Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE43C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC3C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfIKPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbfIKPtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:49:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E668C05AA56;
        Wed, 11 Sep 2019 15:49:16 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8080B5D9E2;
        Wed, 11 Sep 2019 15:49:10 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id x8BFnAUQ013042;
        Wed, 11 Sep 2019 11:49:10 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id x8BFnAUi013038;
        Wed, 11 Sep 2019 11:49:10 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 11 Sep 2019 11:49:10 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Mike Snitzer <snitzer@redhat.com>
cc:     Martijn Coenen <maco@android.com>, agk@redhat.com,
        dm-devel@redhat.com, dariofreni@google.com, jiyong@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        maco@google.com, ioffe@google.com, narayan@google.com,
        kernel-team@android.com
Subject: Re: dm-bufio: Allow clients to specify an upper bound on cache
 size.
In-Reply-To: <20190909145703.GA16249@redhat.com>
Message-ID: <alpine.LRH.2.02.1909111142400.11772@file01.intranet.prod.int.rdu2.redhat.com>
References: <20190906074526.169194-1-maco@android.com> <20190909145703.GA16249@redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 11 Sep 2019 15:49:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Sep 2019, Mike Snitzer wrote:

> On Fri, Sep 06 2019 at  3:45am -0400,
> Martijn Coenen <maco@android.com> wrote:
> 
> > The upper limit on the cache size of a client is currently determined by
> > dividing the total cache size by the number of clients. However, in some
> > cases it is beneficial to give one client a higher limit than others; an
> > example is a device with many dm-verity targets, where one target has a
> > very large hashtree, and all the others have a small hashtree. Giving
> > the target with the large hashtree a higher limit will be beneficial.
> > Another example is dm-verity-fec: FEC is only used in (rare) error
> > conditions, yet for every dm-verity target with FEC, we create two FEC
> > dm-bufio clients, which together have a higher cache limit than the
> > dm-verity target itself.
> > 
> > This patchset allows a client to indicate a maximum cache size for its
> > client; if that maximum is lower than the calculated per-client limit,
> > that maximum will be used instead, and the freed up cache size will be
> > allocated to other clients (that haven't set a maximum).
> > 
> > Note that this algorithm is not perfect; if we have 100MB with 3
> > clients, where the first set a max of 1MB, the second set a max of 40MB,
> > and the third set no maximumm, the ideal allocation would be 1:40:59,
> > respectively. However, because the initial per-client limit is 100 / 3
> > =~33MB, the requested max of 40MB is over the per-client limit, and
> > instead the allocation will end up being ~ 1:40:49. This is still better
> > than the original 33:33:33 allocation. An iterative algorithm could do
> > better, but it also complicates the code significantly.
> 
> Definitely not very intuitive.. but yes I think it is a reasonable
> tradeoff between your goals and further code complexity to be able to
> achieve the "ideal".
> 
> Think the documented example can be made clearer by documenting that
> dm_bufio_cache_size_per_client = 49.  And that _that_ is the reason why
> the client that didn't set a maximum is bounded to 49.
> 
> Overall I think this patch looks reasonable, but I'd like Mikulas to
> review this closer before I pick it up.
> 
> Thanks,
> Mike

I think the proper way how to solve this problem with large amount of 
clients is to have a global queue holding all the buffers and clean up the 
oldest buffers in the queue.

So that if one instance of the dm-verity target uses the buffer cache 
heavily, it can evict buffers loaded by other inactive dm-verity 
instances.

I am now working on the global queue patch.

Mikulas
