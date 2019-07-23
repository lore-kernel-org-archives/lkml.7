Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE80C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A109D2239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563899491;
	bh=DVgWAuPlSXeESloMLra7M+Oy9YE7c5paqKGLe634iHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jdZk8YEEdWZEOu5P9Nydz1qRJKH82wN9RXf8ofWbC0vRP6/2Qdt2ikfua18tgvNvY
	 WqGtV0C4R3kW6J0odJY9JrF06PYrWBo7YUPaI9A1CN92MDzfLMHxtmlhiod+GQ4+OE
	 dUJisiN4xXtCyAtOcVvvpGQfANfAZ3Ie0nnJda6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbfGWQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388018AbfGWQb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:31:29 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8535D20840;
        Tue, 23 Jul 2019 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563899488;
        bh=DVgWAuPlSXeESloMLra7M+Oy9YE7c5paqKGLe634iHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLGYG7lyHmYpAtSxQvv5a3OSvZs6KQmO5QRnnXq1ivh54zybywfjiy2f720HJ3hXK
         1r1kpO8hNlam9eAS+EYtg/bJVQ+WL/RL0jWpe5kcPyJGkQbRnTzGtYyBCY8Af4vvlO
         CrkhMAUc6MAk+8UY3MSDlBJB5ZglsiVyVBaAQiPo=
Date:   Tue, 23 Jul 2019 09:31:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+4d497898effeb1936245@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, mwb@linux.vnet.ibm.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: linux-next boot error: WARNING: workqueue cpumask: online
 intersect > possible intersect
Message-ID: <20190723163126.GB23641@gmail.com>
Mail-Followup-To: Dmitry Vyukov <dvyukov@google.com>,
        Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+4d497898effeb1936245@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, mwb@linux.vnet.ibm.com,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000f19676058ab7adc4@google.com>
 <CACT4Y+ZZy5nqduErU8hjKrwThHiybGpwd3QzOviAWftZFZ4d2A@mail.gmail.com>
 <20190611185206.GG3341036@devbig004.ftw2.facebook.com>
 <CACT4Y+ZNTh=t62oj_Y5XyQwjOJp3AWwWi8c-4DrX+jKNCVqzzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZNTh=t62oj_Y5XyQwjOJp3AWwWi8c-4DrX+jKNCVqzzg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:16:24AM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> On Tue, Jun 11, 2019 at 8:52 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Fri, Jun 07, 2019 at 10:45:45AM +0200, Dmitry Vyukov wrote:
> > > +workqueue maintainers and Michael who added this WARNING
> > >
> > > The WARNING was added in 2017, so I guess it's a change somewhere else
> > > that triggered it.
> > > The WARNING message does not seem to give enough info about the caller
> > > (should it be changed to WARN_ONCE to print a stack?). How can be root
> > > cause this and unbreak linux-next?
> >
> > So, during boot, workqueue builds masks of possible cpus of each node
> > and stores them on wq_numa_possible_cpumask[] array.  The warning is
> > saying that somehow online cpumask of a node became a superset of the
> > possible mask, which should never happen.
> >
> > Dumping all masks in wq_numa_possible_cpumasks[] and cpumask_of_node()
> > of each node should show what's going on.
> 
> This has reached upstream and all subsystem subtrees, now all Linux
> trees are boot broken (except for few that still lack behind):
> https://syzkaller.appspot.com/upstream
> 
> No new Linux code is tested by syzbot at this point.
> 

AFAICS, what's actually happening is that the boot fails due to a different bug,
"general protection fault in dma_direct_max_mapping_size" -- which is a real
boot error, not just a warning; see
https://lkml.kernel.org/lkml/20190723161425.GA23641@gmail.com/

syzbot then sees "WARNING: workqueue cpumask: online intersect > possible
intersect" in the console output prior to that, and uses that as the bug title.

It's not obvious that syzbot would report "WARNING: workqueue cpumask: online
intersect > possible intersect" without the real boot error too.

Nevertheless the issue is still there and something needs to be done about it.

- Eric
