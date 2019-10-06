Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3C0ECE58B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D77222CB
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570322667;
	bh=dUxtV3Ibs0G3juj9sXutxwx0gZ5As2EPiNLj7fplnKQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Uvu6CY94LqhHwRiJJc0F8M4wrokUlHDMJbOu1HvqHdua43llaTyEPUaShWNdqfpHd
	 DEVv8ErkD/9ELFgO003x1saUQvLa7P8vvQOmcgcVZqnAm/NRb6MxqWL8g9YhXVbOem
	 rBYScMDFk8r6sBScIP6m/+SnL8i2gbWyqZUFyv0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfJFAo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 20:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfJFAo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 20:44:26 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133D9222BE;
        Sun,  6 Oct 2019 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570322664;
        bh=dUxtV3Ibs0G3juj9sXutxwx0gZ5As2EPiNLj7fplnKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p5R8C/TRAM3HJGWS9MrFubrQpgBWerX+WPHkeIOg9125GDTs4xiBGy+zxaf+UKyw7
         IqDy1QM8bL8oEHmsxA9WZLd1jwmEaVdHq3BVBu5WkfzrltLzKwGU5bnzfDgzoY+EMK
         HEyJwv9fs/1TbhB0VqFdLO13wftbwdzPxkB4Sy2A=
Date:   Sat, 5 Oct 2019 17:44:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mhocko@kernel.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_isolation: fix a deadlock with printk()
Message-Id: <20191005174423.23f2db80872a9365009f398a@linux-foundation.org>
In-Reply-To: <49F0AD04-6F61-4A1D-BFD5-E0769EC6F103@lca.pw>
References: <20191005162942.b392b9336b860e245106faa2@linux-foundation.org>
        <49F0AD04-6F61-4A1D-BFD5-E0769EC6F103@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2019 20:10:47 -0400 Qian Cai <cai@lca.pw> wrote:

> 
> 
> >> the existing dependency chain (in reverse order) is:
> >> 
> >> -> #2 (&(&zone->lock)->rlock){-.-.}:
> >>       lock_acquire+0x21a/0x468
> >>       _raw_spin_lock+0x54/0x68
> >>       get_page_from_freelist+0x8b6/0x2d28
> >>       __alloc_pages_nodemask+0x246/0x658
> >>       __get_free_pages+0x34/0x78
> >>       sclp_init+0x106/0x690
> >>       sclp_register+0x2e/0x248
> >>       sclp_rw_init+0x4a/0x70
> >>       sclp_console_init+0x4a/0x1b8
> >>       console_init+0x2c8/0x410
> >>       start_kernel+0x530/0x6a0
> >>       startup_continue+0x70/0xd0
> > 
> > This appears to be the core of our problem?
> 
> No, that is just one of those many places could form the lock chain. 
> 
> console_lock -> other locks -> zone_lock
> 
> Another example is,
> 
> https://lore.kernel.org/lkml/1568823006.5576.178.camel@lca.pw/

There is no "console_lock".  Please be much more specific.

> It is easier to avoid,
> 
> zone_lock -> console_lock
> 
> rather than fixing the opposite.

"ease" isn't the main objective.  A more important question is "what
makes sense".  We should be able to call printk() from anywhere, any
time under any conditions.  That can't be done 100% but it is the
objective.  printk() should be robust and not being able to call
printk() while holding zone->lock isn't robust!

btw, this:

: It is unsafe to call printk() while zone->lock was held, i.e.,
:
:	zone->lock --> console_sem

doesn't make a lot of sense.  console_sem is a sleeping lock so
attempting to acquire it (with down()!) under spinlock is a huge bug. 
Again, please be careful with the descriptions.

