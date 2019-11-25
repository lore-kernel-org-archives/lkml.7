Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01640C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AE920679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfKYG6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:58:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44338 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKYG6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:58:33 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 82D2E14CD13D9;
        Sun, 24 Nov 2019 22:58:32 -0800 (PST)
Date:   Sun, 24 Nov 2019 22:58:29 -0800 (PST)
Message-Id: <20191124.225829.1932718160868176214.davem@davemloft.net>
To:     dong.menglong@zte.com.cn
Cc:     petrm@mellanox.com, jiri@mellanox.com, gustavo@embeddedor.com,
        liuhangbin@gmail.com, ap420073@gmail.com, jwi@linux.ibm.com,
        mcroce@redhat.com, tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn
Subject: Re: [PATCH] macvlan.c: schedule port->bc_work even if error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1574665143-21650-1-git-send-email-dong.menglong@zte.com.cn>
References: <1574665143-21650-1-git-send-email-dong.menglong@zte.com.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Nov 2019 22:58:33 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>
Date: Mon, 25 Nov 2019 14:59:03 +0800

> While enqueueing a broadcast skb to port->bc_queue, schedule_work()
> is called to add port->bc_work, which processes the skbs in
> bc_queue, to "events" work queue. If port->bc_queue is full, the
> skb will be discarded and schedule_work(&port->bc_work) won't be
> called. However, if port->bc_queue is full and port->bc_work is not
> running or pending, port->bc_queue will keep full and schedule_work()
> won't be called any more, and all broadcast skbs to macvlan will be
> discarded. This case can happen:
> 
> macvlan_process_broadcast() is the pending function of port->bc_work,
> it moves all the skbs in port->bc_queue to the queue "list", and
> processes the skbs in "list". During this, new skbs will keep being
> added to port->bc_queue in macvlan_broadcast_enqueue(), and
> port->bc_queue may already full when macvlan_process_broadcast()
> return. This may happen, especially when there are a lot of real-time
> threads and the process is preempted.
> 
> Fix this by calling schedule_work(&port->bc_work) even if
> port->bc_work is full in macvlan_broadcast_enqueue()
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

The subsystem prefix in your Subject line should not be a source
file, but the name of the module or area you are making changes
to.

Therefore this should be "macvlan: " not "macvlan.c: "

You must also provide an appropriate Fixes: tag when fixing a problem
like this.

Thank you.
