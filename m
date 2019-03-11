Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94805C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6D2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfCKVGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:06:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59888 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfCKVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:06:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h3S7m-0001iF-B8; Mon, 11 Mar 2019 21:06:18 +0000
Date:   Mon, 11 Mar 2019 21:06:18 +0000
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
Subject: Re: [PATCH 4/8] Fix aio_poll() races
Message-ID: <20190311210618.GL2217@ZenIV.linux.org.uk>
References: <20190310070606.GA10138@ZenIV.linux.org.uk>
 <20190310070822.11564-1-viro@ZenIV.linux.org.uk>
 <20190310070822.11564-4-viro@ZenIV.linux.org.uk>
 <20190311195831.GA12807@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311195831.GA12807@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:58:31PM +0100, Christoph Hellwig wrote:
> Where do we put the second iocb reference in case we return from
> vfs_poll without ever being woken?

Depends.  If mask is non-zero (i.e. vfs_poll() has returned something
we care about) and it has never been woken, we steal it and drop the
reference ourselves.  If it is zero and we see that ->poll() has tried
to put it on two queues, we steal it (again, assuming it's not on
waitqueue and _can_ be stolen) and return -EINVAL.  In that case
__io_submit_one() (or, by the end of the series, io_submit_one())
will call iocb_destroy().  And in the normal waiting case (nothing
interesting reported and no errors) it will end up on the list of
cancellables.  Then it either will get completed by later wakeup, which
will drop the reference, or it will get eventually cancelled, which will
hit the same aio_poll_complete_work() and drop the reference...

> Also it seems like the complete code would still benefit from a little
> helper, something like:

Umm...  Not sure I like the name (something like aio_poll_done() seems
to be better), but other than that - no problem.
