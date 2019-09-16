Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3FBC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12212206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391048AbfIPTv2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:51:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40017 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388437AbfIPTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:51:28 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i9x1n-0001Jk-L7; Mon, 16 Sep 2019 21:51:15 +0200
Date:   Mon, 16 Sep 2019 21:51:15 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Qian Cai <cai@lca.pw>
Cc:     peterz@infradead.org, mingo@redhat.com, akpm@linux-foundation.org,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] mm/slub: fix a deadlock in shuffle_freelist()
Message-ID: <20190916195115.g4hj3j3wstofpsdr@linutronix.de>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
 <20190916090336.2mugbds4rrwxh6uz@linutronix.de>
 <1568642487.5576.152.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1568642487.5576.152.camel@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-16 10:01:27 [-0400], Qian Cai wrote:
> On Mon, 2019-09-16 at 11:03 +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-09-13 12:27:44 [-0400], Qian Cai wrote:
> > …
> > > Chain exists of:
> > >   random_write_wait.lock --> &rq->lock --> batched_entropy_u32.lock
> > > 
> > >  Possible unsafe locking scenario:
> > > 
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(batched_entropy_u32.lock);
> > >                                lock(&rq->lock);
> > >                                lock(batched_entropy_u32.lock);
> > >   lock(random_write_wait.lock);
> > 
> > would this deadlock still occur if lockdep knew that
> > batched_entropy_u32.lock on CPU0 could be acquired at the same time
> > as CPU1 acquired its batched_entropy_u32.lock?
> 
> I suppose that might fix it too if it can teach the lockdep the trick, but it
> would be better if there is a patch if you have something in mind that could be
> tested to make sure.

get_random_bytes() is heavier than get_random_int() so I would prefer to
avoid its usage to fix what looks like a false positive report from
lockdep.
But no, I don't have a patch sitting around. A lock in per-CPU memory
could lead to the scenario mentioned above if the lock could be obtained
cross-CPU it just isn't so in that case. So I don't think it is that
simple.

Sebastian
