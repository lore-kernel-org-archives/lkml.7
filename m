Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2138EC4646C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E750920663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfFYAY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:24:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39668 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfFYAY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:24:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9C87D1F461;
        Tue, 25 Jun 2019 00:24:56 +0000 (UTC)
Date:   Tue, 25 Jun 2019 00:24:56 +0000
From:   Eric Wong <e@80x24.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Azat Khuzhin <azat@libevent.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] epoll: support pollable epoll from userspace
Message-ID: <20190625002456.unhdqihvs5lqcjn6@dcvr>
References: <20190624144151.22688-1-rpenyaev@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624144151.22688-1-rpenyaev@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Penyaev <rpenyaev@suse.de> wrote:
> Hi all,

+cc Jason Baron
 
> ** Limitations

<snip>

> 4. No support for EPOLLEXCLUSIVE
>      If device does not pass pollflags to wake_up() there is no way to
>      call poll() from the context under spinlock, thus special work is
>      scheduled to offload polling.  In this specific case we can't
>      support exclusive wakeups, because we do not know actual result
>      of scheduled work and have to wake up every waiter.

Lacking EPOLLEXCLUSIVE support is probably a showstopper for
common applications using per-task epoll combined with
non-blocking accept4() (e.g. nginx).


Fwiw, I'm still a weirdo who prefers a dedicated thread doing
blocking accept4 for distribution between tasks (so epoll never
sees a listen socket).  But, depending on what runtime/language
I'm using, I can't always dedicate a blocking thread, so I
recently started using EPOLLEXCLUSIVE from Perl5 where I
couldn't rely on threads being available.


If I could dedicate time to improving epoll; I'd probably
add writev() support for batching epoll_ctl modifications
to reduce syscall traffic, or pick-up the kevent()-like interface
started long ago:
https://lore.kernel.org/lkml/1393206162-18151-1-git-send-email-n1ght.4nd.d4y@gmail.com/
(but I'm not sure I want to increase the size of the syscall table).
