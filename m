Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B75C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC312087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfCHPvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:51:03 -0500
Received: from verein.lst.de ([213.95.11.211]:54709 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfCHPvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:51:02 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B0FB368C4E; Fri,  8 Mar 2019 16:50:56 +0100 (CET)
Date:   Fri, 8 Mar 2019 16:50:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
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
        linux-aio@kvack.org, houtao1@huawei.com, yi.zhang@huawei.com,
        avi@scylladb.com
Subject: Re: [PATCH 1/8] aio: make sure file is pinned
Message-ID: <20190308155056.GA20563@lst.de>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com> <20190307000316.31133-1-viro@ZenIV.linux.org.uk> <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com> <20190307004159.GY2217@ZenIV.linux.org.uk> <20190307004828.GZ2217@ZenIV.linux.org.uk> <20190307012036.GA2217@ZenIV.linux.org.uk> <CAHk-=whn7iJsbr=_ab3Ghvd1pzxvio3sktrBuMr6aG=gFLFtEg@mail.gmail.com> <20190308033650.GD2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308033650.GD2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

Looks sensible.  I'll try to run the tests over it, and I've added
Avi so that maybe he can make sure that scylladb is also happy with it,
that was usually the best way to find aio poll bugs..
