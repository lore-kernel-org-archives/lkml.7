Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C8C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0AD20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 03:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCHDhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 22:37:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59130 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfCHDhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 22:37:06 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h26JW-0007sr-Pl; Fri, 08 Mar 2019 03:36:50 +0000
Date:   Fri, 8 Mar 2019 03:36:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon kim <kyeongdon.kim@lge.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, houtao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 1/8] aio: make sure file is pinned
Message-ID: <20190308033650.GD2217@ZenIV.linux.org.uk>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
 <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com>
 <20190307004159.GY2217@ZenIV.linux.org.uk>
 <20190307004828.GZ2217@ZenIV.linux.org.uk>
 <20190307012036.GA2217@ZenIV.linux.org.uk>
 <CAHk-=whn7iJsbr=_ab3Ghvd1pzxvio3sktrBuMr6aG=gFLFtEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whn7iJsbr=_ab3Ghvd1pzxvio3sktrBuMr6aG=gFLFtEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 05:30:21PM -0800, Linus Torvalds wrote:
> On Wed, Mar 6, 2019 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I'll try to massage that series on top of your patch; I still hate the
> > post-vfs_poll() logics in aio_poll() ;-/  Give me about half an hour
> > and I'll have something to post.
> 
> No inherent hurry, I sent the ping just to make sure it hadn't gotten lost.
> 
> And yeah, I think the post-vfs_poll() logic cannot possibly be
> necessary. My gut feel is that *if* we have the refcounting right,
> then we should be able to just let the wakeup come in at any later
> point, and ordering shouldn't matter all that much, and we shouldn't
> even need any locking.
> 
> I'd like to think that it can be done with something like "just 'or'
> in the mask atomically" (so that we don't care about ordering between
> the synchronous vfs_poll() and the async poll wakeup), together with
> "when refcount goes to zero, finish the thing off and complete it" (so
> that we don't care who finishes first).
> 
> No "woken" logic, no "who fired first" logic, no BS. Just make the
> operations work regardless of ordering.
> 
> And maybe it can't be done. But the current model seems just so hacky
> that it can't be the right model.

Umm...  It is kinda-sorta doable; we do need something vaguely similar
to ->woken ("should we add it to the list of cancellables, or is the
async reference already gone?"), but other than that it seems to be
feasible.

See vfs.git#work.aio; the crucial bits are in these commits:
      keep io_event in aio_kiocb
      get rid of aio_complete() res/res2 arguments
      move aio_complete() to final iocb_put(), try to fix aio_poll() logics
The first two are preparations, the last is where the fixes (hopefully)
happen.

The logics in aio_poll() after vfs_poll():
	* we might want to steal the async reference (e.g. due to event
returned from the very beginning, or due to attempt to put on more than
one waitqueue, which makes results unreliable).  That's _NOT_ possible
if the thing had been put on a waitqueue, but currently isn't there.
It might be either due to early wakeup having done everything or the
same having scheduled aio_poll_complete_work().  In either case, the
best we can do is to ignore the return value of vfs_poll() and, in
case of error, mark the sucker cancelled.  We *can't* return an error
in that case.

	* if we want and can steal the async reference, rip it from
waitqueue; otherwise, put it on the "cancellable" list, unless it's
already gone or unless we are simulating the cancel ourselves.

	* if vfs_poll() has reported something we want and we have
successufully stolen the iocb, put it there, have the reference
we'd taken over dropped and return 0

Comments?
