Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3568C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F9527F11
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfFCKCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:02:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfFCKCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:02:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B558DAFE1;
        Mon,  3 Jun 2019 10:02:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 Jun 2019 12:02:22 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     azat@libevent.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] epoll: introduce helpers for adding/removing
 events to uring
In-Reply-To: <20190603090906.GE3436@hirez.programming.kicks-ass.net>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-7-rpenyaev@suse.de>
 <20190531095607.GC17637@hirez.programming.kicks-ass.net>
 <274e29d102133f3be1f309c66cb0af36@suse.de>
 <20190531125636.GZ2606@hirez.programming.kicks-ass.net>
 <98e74ceeefdffc9b50fb33e597d270f7@suse.de>
 <20190531165144.GE2606@hirez.programming.kicks-ass.net>
 <9e13f80872e5b6c96e9cd3343e27b1f1@suse.de>
 <20190603090906.GE3436@hirez.programming.kicks-ass.net>
Message-ID: <904d7aea51552c9be9afb3b19bfac66b@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-03 11:09, Peter Zijlstra wrote:
> On Fri, May 31, 2019 at 08:58:19PM +0200, Roman Penyaev wrote:
>> On 2019-05-31 18:51, Peter Zijlstra wrote:
> 
>> > But like you show, it can be done. It also makes the thing wait-free, as
>> > opposed to merely lockless.
>> 
>> You think it's better?  I did not like this variant from the very
>> beginning because of the unnecessary complexity.  But maybe you're
>> right.  No busy loops on user side makes it wait-free.  And also
>> I can avoid c11 in kernel using cmpxchg along with atomic_t.
> 
> Imagine the (v)CPU going for an extended nap right between publishing 
> the
> new tail and writing the !0 entry. Then your userspace is stuck burning
> cycles without getting anything useful done.

Yes, that is absolutely not nice.  That also worries me.  I wanted
to minimize number of atomic ops on hot path, and of course in that
respect this busy-loop is more attractive.

I will polish and switch back to the wait-free variant and resend the
whole patchset.  Could you please take a look?  Will add you to CC.

--
Roman
