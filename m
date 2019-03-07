Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD364C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CE220663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCGAmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:42:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40556 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGAmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:42:12 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1h6l-0000hR-Vr; Thu, 07 Mar 2019 00:42:00 +0000
Date:   Thu, 7 Mar 2019 00:41:59 +0000
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
Message-ID: <20190307004159.GY2217@ZenIV.linux.org.uk>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
 <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 04:23:04PM -0800, Linus Torvalds wrote:
> On Wed, Mar 6, 2019 at 4:03 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > "aio: remove the extra get_file/fput pair in io_submit_one" was
> > too optimistic - not dereferencing file pointer after e.g.
> > ->write_iter() returns is not enough; that reference might've been
> > the only thing that kept alive objects that are referenced
> > *before* the method returns.  Such as inode, for example...
> 
> I still; think that this is actually _worse_ than just having the
> refcount on the req instead.
> 
> As it is, we have that completely insane "ref can go away from under
> us", because nothing keeps that around, which then causes all those
> other crazy issues with "woken" etc garbage.
>
> I think we should be able to get rid of those entirely. Make the
> poll() case just return zero if it has added the entry successfully to
> poll queue.  No need for "woken", no need for all that odd "oh, but
> now the req might no longer exist".

Not really.  Sure, you can get rid of "might no longer exist"
considerations, but you still need to decide which way do we want to
handle it.  There are 3 cases:
	* it's already taken up; don't put on the list for possible
cancel, don't call aio_complete().
	* will eventually be woken up; put on the list for possible
cancle, don't call aio_complete().
	* wanted to be on several queues, fortunately not woken up
yet.  Make sure it's gone from queue, return an error.
	* none of the above, and ->poll() has reported what we wanted
from the very beginning.  Remove from queue, call aio_complete().

You'll need some logics to handle that.  I can buy the "if we know
the req is still alive, we can check if it's still queued instead of
separate woken flag", but but it won't win you much ;-/
