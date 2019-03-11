Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B502087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCKWwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:52:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33012 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKWwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:52:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h3TmY-0004JL-AH; Mon, 11 Mar 2019 22:52:30 +0000
Date:   Mon, 11 Mar 2019 22:52:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH 3/8] aio: store event at final iocb_put()
Message-ID: <20190311225230.GP2217@ZenIV.linux.org.uk>
References: <20190310070606.GA10138@ZenIV.linux.org.uk>
 <20190310070822.11564-1-viro@ZenIV.linux.org.uk>
 <20190310070822.11564-3-viro@ZenIV.linux.org.uk>
 <20190311194431.GD12602@lst.de>
 <20190311211328.GN2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311211328.GN2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 09:13:28PM +0000, Al Viro wrote:
> On Mon, Mar 11, 2019 at 08:44:31PM +0100, Christoph Hellwig wrote:
> > On Sun, Mar 10, 2019 at 07:08:17AM +0000, Al Viro wrote:
> > > From: Al Viro <viro@zeniv.linux.org.uk>
> > > 
> > > Instead of having aio_complete() set ->ki_res.{res,res2}, do that
> > > explicitly in its callers, drop the reference (as aio_complete()
> > > used to do) and delay the rest until the final iocb_put().
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  fs/aio.c | 45 ++++++++++++++++++++-------------------------
> > >  1 file changed, 20 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/fs/aio.c b/fs/aio.c
> > > index 2249a7a1d6b3..b9c4c1894020 100644
> > > --- a/fs/aio.c
> > > +++ b/fs/aio.c
> > > @@ -1077,24 +1077,10 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
> > >  	kmem_cache_free(kiocb_cachep, iocb);
> > >  }
> > >  
> > > -static inline void iocb_put(struct aio_kiocb *iocb)
> > > -{
> > > -	if (refcount_dec_and_test(&iocb->ki_refcnt))
> > > -		iocb_destroy(iocb);
> > > -}
> > 
> > Maybe iocb_put should just have been added in the place you move
> > it to in patch 1?
> 
> Might as well...

Actually, that wouldn't be any better - it would need at least a declaration
before aio_complete(), since in the original patch aio_complete() calls it.
So that wouldn't be less noisy...
