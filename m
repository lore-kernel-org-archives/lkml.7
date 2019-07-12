Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4035EC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFC920863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 07:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v2iLtOXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfGLH2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 03:28:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60246 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfGLH2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 03:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7lv5lUDbMxC5xZnoZXXX5d4XuUY9QilotWxJmSmC4aQ=; b=v2iLtOXlFyUJi7Eo8afZTFMrL
        KqVcjkxXVdSX5HbQ2Wjw3aaFnwQSwrtD4cuemDVQ2ToScdIEEvfosbdi/nYErqzwIA2wPaT7UhcMw
        MUJQZ/1FA4ti7Uc58f/ifQ4XtUdx6EPCk7JPTbz8cdejk7gEzLcDsW9D2xzz+yIlwxLsRtdpngMu2
        sUrj0t78fzTz8te9ZFDOsbsHDBqVwB28A9dufvzv8DWK9LKfs8HxGZggZtI+/MVoftey5CsZZ82gw
        /9WtT1B8MKIIj6PvbkgkgszWtY/6yaLtog6hKT6dQpSDImOe+nSQWrozQDEb7DWYzbiBm38d1S0V3
        74NbRb/iQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlpyc-0002tC-O9; Fri, 12 Jul 2019 07:28:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6AFD20AB373B; Fri, 12 Jul 2019 09:28:15 +0200 (CEST)
Date:   Fri, 12 Jul 2019 09:28:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] waitqueue: fix clang -Wuninitialized warnings
Message-ID: <20190712072815.GL3402@hirez.programming.kicks-ass.net>
References: <20190703081119.209976-1-arnd@arndb.de>
 <20190703175845.GA68011@archlinux-epyc>
 <CAK8P3a041S8KFTz4ZjmByDUTM9pDxsWi=hGPeamkFfn4B1dcxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a041S8KFTz4ZjmByDUTM9pDxsWi=hGPeamkFfn4B1dcxQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:27:17PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 3, 2019 at 7:58 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Wed, Jul 03, 2019 at 10:10:55AM +0200, Arnd Bergmann wrote:
> > > When CONFIG_LOCKDEP is set, every use of DECLARE_WAIT_QUEUE_HEAD_ONSTACK()
> > > produces an annoying warning from clang, which is particularly annoying
> > > for allmodconfig builds:
> > >
> > > fs/namei.c:1646:34: error: variable 'wq' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
> > >         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> > >                                         ^~
> > > include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
> > >         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
> > >                                ~~~~                                  ^~~~
> > > include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
> > >         ({ init_waitqueue_head(&name); name; })
> > >                                        ^~~~
> > >
> > > After playing with it for a while, I have found a way to rephrase the
> > > macro in a way that should work well with both gcc and clang and not
> > > produce this warning. The open-coded __WAIT_QUEUE_HEAD_INIT_ONSTACK
> > > is a little more verbose than the original version by Peter Zijlstra,
> > > but avoids the gcc-ism that suppresses warnings when assigning a
> > > variable to itself.
> > >
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> > Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Who would be the right person to pick this patch up for mainline?

That would be me; but like Andrew, I'm not a fan of this patch.
