Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D76C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02506207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfJNGag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:30:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:45488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729903AbfJNGag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:30:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D9F34B310;
        Mon, 14 Oct 2019 06:30:34 +0000 (UTC)
Date:   Sun, 13 Oct 2019 23:29:19 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Manfred Spraul <manfred@colorfullife.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/5] ipc/mqueue.c: Update/document memory barriers
Message-ID: <20191014062919.rr56mj5uzyb7sj6r@linux-p48b>
References: <20191011112009.2365-1-manfred@colorfullife.com>
 <20191011112009.2365-3-manfred@colorfullife.com>
 <20191011165527.bsdiw6gu2sk7yrnl@linux-p48b>
 <5e08cb89-563c-4763-dd88-94edaf9d883b@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5e08cb89-563c-4763-dd88-94edaf9d883b@colorfullife.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2019, Manfred Spraul wrote:
>But you are right, there are two different scenarios:
>
>1) thread already in another wake_q, wakeup happens immediately after 
>the cmpxchg_relaxed().
>
>This scenario is safe, due to the smp_mb__before_atomic() in wake_q_add()
>
>2) thread woken up but e.g. a timeout, see ->state=STATE_READY, 
>returns to user space, calls sys_exit.
>
>This must not happen before get_task_struct acquired a reference.
>
>And this appears to be unsafe: get_task_struct() is refcount_inc(), 
>which is refcount_inc_checked(), which is according to lib/refcount.c 
>fully unordered.
>
>Thus: ->state=STATE_READY can execute before the refcount increase.
>
>Thus: ->state=STATE_READY needs a smp_store_release(), correct?

What if we did the reference count explicitly, and then just use
wake_q_add_safe()? That would avoid the extra barrier, __pipelined_op()
would become:

      list_del();
      get_task_struct();
      wake_q_add_safe();
      WRITE_ONCE(->state, STATE_READY);

Thanks,
Davidlohr
