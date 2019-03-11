Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA95C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F9B2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552347472;
	bh=j5ykj7uQK8UxtRUbvSqhF/KYo9f3skYTK9Wb8Qb5Zhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vBhbZTc9Hylt2XkeWj8CXqi4liCh7FhbD2FxpmSk/xtnmRzlH3UDYb7YL1/aic4b0
	 JY/YEwON+Bf/jwqMsDL/9PJ4h7AgpqnkKfzPAXp99ZjMg6AqU4UdBmwEOOwFdUfLJc
	 jpT2e2244oZbycooJwW4bRoUzM9DlOkAChOFq+fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCKXhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:37:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfCKXhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:37:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6555AD2E;
        Mon, 11 Mar 2019 23:37:49 +0000 (UTC)
Date:   Mon, 11 Mar 2019 16:37:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com>
Cc:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, mhocko@suse.com, sfr@canb.auug.org.au,
        shakeelb@google.com, syzkaller-bugs@googlegroups.com,
        vdavydov.dev@gmail.com
Subject: Re: KASAN: null-ptr-deref Read in reclaim_high
Message-Id: <20190311163747.f56cceebd9c2661e4519bdfc@linux-foundation.org>
In-Reply-To: <0000000000001fd5780583d1433f@google.com>
References: <0000000000001fd5780583d1433f@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 06:08:01 -0700 syzbot <syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com> wrote:

> syzbot has bisected this bug to:
> 
> commit 29a4b8e275d1f10c51c7891362877ef6cffae9e7
> Author: Shakeel Butt <shakeelb@google.com>
> Date:   Wed Jan 9 22:02:21 2019 +0000
> 
>      memcg: schedule high reclaim for remote memcgs on high_work
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155bf5db200000
> start commit:   29a4b8e2 memcg: schedule high reclaim for remote memcgs on..
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=175bf5db200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=135bf5db200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=611f89e5b6868db
> dashboard link: https://syzkaller.appspot.com/bug?extid=fa11f9da42b46cea3b4a
> userspace arch: amd64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14259017400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141630a0c00000
> 
> Reported-by: syzbot+fa11f9da42b46cea3b4a@syzkaller.appspotmail.com
> Fixes: 29a4b8e2 ("memcg: schedule high reclaim for remote memcgs on  
> high_work")

The following patch
memcg-schedule-high-reclaim-for-remote-memcgs-on-high_work-v3.patch
might have fixed this.  Was it applied?
