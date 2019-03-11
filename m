Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C628C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA432087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfCKVMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:12:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59990 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfCKVMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:12:45 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h3SDr-0001sB-PQ; Mon, 11 Mar 2019 21:12:35 +0000
Date:   Mon, 11 Mar 2019 21:12:35 +0000
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
Subject: Re: [PATCH 8/8] aio: move sanity checks and request allocation to
 io_submit_one()
Message-ID: <20190311211235.GM2217@ZenIV.linux.org.uk>
References: <20190310070606.GA10138@ZenIV.linux.org.uk>
 <20190310070822.11564-1-viro@ZenIV.linux.org.uk>
 <20190310070822.11564-8-viro@ZenIV.linux.org.uk>
 <20190311194830.GH12602@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311194830.GH12602@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 08:48:30PM +0100, Christoph Hellwig wrote:
> On Sun, Mar 10, 2019 at 07:08:22AM +0000, Al Viro wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > makes for somewhat cleaner control flow in __io_submit_one()
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> I wonder if we should even bother keeping __io_submit_one.  Splitting
> that out was prep work from Jens for something that eventually turned
> into io_uring.

*shrug*

I think it's a bit easier to keep track of control flow - failure exits
are simpler that way.
