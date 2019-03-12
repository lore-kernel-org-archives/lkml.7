Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9025C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4012077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCLTSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:18:09 -0400
Received: from verein.lst.de ([213.95.11.211]:48500 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfCLTSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:18:09 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9AED568C4E; Tue, 12 Mar 2019 20:18:01 +0100 (CET)
Date:   Tue, 12 Mar 2019 20:18:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH 4/8] Fix aio_poll() races
Message-ID: <20190312191801.GA5236@lst.de>
References: <20190310070606.GA10138@ZenIV.linux.org.uk> <20190310070822.11564-1-viro@ZenIV.linux.org.uk> <20190310070822.11564-4-viro@ZenIV.linux.org.uk> <20190311195831.GA12807@lst.de> <20190311210618.GL2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311210618.GL2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 09:06:18PM +0000, Al Viro wrote:
> On Mon, Mar 11, 2019 at 08:58:31PM +0100, Christoph Hellwig wrote:
> > Where do we put the second iocb reference in case we return from
> > vfs_poll without ever being woken?
> 
> Depends.  If mask is non-zero (i.e. vfs_poll() has returned something
> we care about) and it has never been woken, we steal it and drop the
> reference ourselves.  If it is zero and we see that ->poll() has tried
> to put it on two queues, we steal it (again, assuming it's not on
> waitqueue and _can_ be stolen) and return -EINVAL.  In that case
> __io_submit_one() (or, by the end of the series, io_submit_one())
> will call iocb_destroy().  And in the normal waiting case (nothing
> interesting reported and no errors) it will end up on the list of
> cancellables.  Then it either will get completed by later wakeup, which
> will drop the reference, or it will get eventually cancelled, which will
> hit the same aio_poll_complete_work() and drop the reference...

Ok, seems like the logic is sane.  I was missing how the actual
mask logic worked in aio_poll().

> > Also it seems like the complete code would still benefit from a little
> > helper, something like:
> 
> Umm...  Not sure I like the name (something like aio_poll_done() seems
> to be better), but other than that - no problem.

I don't care about the name.  Feel free to change it to whatever suits
you.
