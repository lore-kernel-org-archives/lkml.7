Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F118AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05B5207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCJHHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 03:07:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35298 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfCJHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 03:07:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h2sXK-0002pS-Qr; Sun, 10 Mar 2019 07:06:24 +0000
Date:   Sun, 10 Mar 2019 07:06:18 +0000
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
Message-ID: <20190310070606.GA10138@ZenIV.linux.org.uk>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
 <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com>
 <20190307004159.GY2217@ZenIV.linux.org.uk>
 <20190307004828.GZ2217@ZenIV.linux.org.uk>
 <20190307012036.GA2217@ZenIV.linux.org.uk>
 <CAHk-=whn7iJsbr=_ab3Ghvd1pzxvio3sktrBuMr6aG=gFLFtEg@mail.gmail.com>
 <20190308033650.GD2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308033650.GD2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:36:50AM +0000, Al Viro wrote:

> See vfs.git#work.aio; the crucial bits are in these commits:
>       keep io_event in aio_kiocb
>       get rid of aio_complete() res/res2 arguments
>       move aio_complete() to final iocb_put(), try to fix aio_poll() logics
> The first two are preparations, the last is where the fixes (hopefully)
> happen.

OK, refactored, cleaned up and force-pushed.  Current state:
Al Viro (7):
      keep io_event in aio_kiocb
      aio: store event at final iocb_put()
      Fix aio_poll() races
      make aio_read()/aio_write() return int
      move dropping ->ki_eventfd into iocb_destroy()
      deal with get_reqs_available() in aio_get_req() itself
      aio: move sanity checks and request allocation to io_submit_one()

Linus Torvalds (1):
      pin iocb through aio.

 fs/aio.c | 327 ++++++++++++++++++++++++++++-----------------------------------
 1 file changed, 146 insertions(+), 181 deletions(-)
