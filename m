Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74375C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447142082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDAV74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:59:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38814 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDAV74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:59:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E6AB2108DB21B;
        Mon,  1 Apr 2019 14:59:55 -0700 (PDT)
Date:   Mon, 01 Apr 2019 14:59:55 -0700 (PDT)
Message-Id: <20190401.145955.684115838616729274.davem@davemloft.net>
To:     jslaby@suse.cz
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkubecek@suse.cz
Subject: Re: [PATCH] kcm: switch order of device registration to fix a crash
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190329111946.19061-1-jslaby@suse.cz>
References: <20190329111946.19061-1-jslaby@suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 14:59:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>
Date: Fri, 29 Mar 2019 12:19:46 +0100

> When kcm is loaded while many processes try to create a KCM socket, a
> crash occurs:
>  BUG: unable to handle kernel NULL pointer dereference at 000000000000000e
>  IP: mutex_lock+0x27/0x40 kernel/locking/mutex.c:240
>  PGD 8000000016ef2067 P4D 8000000016ef2067 PUD 3d6e9067 PMD 0
>  Oops: 0002 [#1] SMP KASAN PTI
>  CPU: 0 PID: 7005 Comm: syz-executor.5 Not tainted 4.12.14-396-default #1 SLE15-SP1 (unreleased)
>  RIP: 0010:mutex_lock+0x27/0x40 kernel/locking/mutex.c:240
>  RSP: 0018:ffff88000d487a00 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: 000000000000000e RCX: 1ffff100082b0719
>  ...
>  CR2: 000000000000000e CR3: 000000004b1bc003 CR4: 0000000000060ef0
>  Call Trace:
>   kcm_create+0x600/0xbf0 [kcm]
>   __sock_create+0x324/0x750 net/socket.c:1272
>  ...
> 
> This is due to race between sock_create and unfinished
> register_pernet_device. kcm_create tries to do "net_generic(net,
> kcm_net_id)". but kcm_net_id is not initialized yet.
> 
> So switch the order of the two to close the race.
> 
> This can be reproduced with mutiple processes doing socket(PF_KCM, ...)
> and one process doing module removal.
> 
> Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
> Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied and queued up for -stable, thanks.
