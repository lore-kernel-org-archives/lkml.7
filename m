Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EDEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BF42087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCQOg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:36:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56495 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCQOg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:36:57 -0400
Received: from [2a01:598:b88d:24ef:fc90:b8ff:fed0:1fb6] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h5WuB-00068z-O4; Sun, 17 Mar 2019 15:36:53 +0100
Date:   Sun, 17 Mar 2019 15:36:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     chenjie6@huawei.com, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, mingo@redhat.com, zengweilin@huawei.com
Subject: Re: [PATCH] futex:fix robust futex alignment exception
In-Reply-To: <20190315084131.GS5996@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1903171534590.9068@nanos.tec.linutronix.de>
References: <1552621478-119787-1-git-send-email-chenjie6@huawei.com> <20190315084131.GS5996@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019, Peter Zijlstra wrote:

> On Fri, Mar 15, 2019 at 03:44:38AM +0000, chenjie6@huawei.com wrote:
> > From: chen jie <chenjie6@huawei.com>
> 
> > [11542.215247] [<c017b1d4>] (cmpxchg_futex_value_locked) from [<c017da50>] (handle_futex_death+0x78/0xcc)
> > [11542.215259] [<c017da50>] (handle_futex_death) from [<c017dba8>] (exit_robust_list+0x104/0x160)
> > [11542.215273] [<c017dba8>] (exit_robust_list) from [<c011b40c>] (mm_release+0x1c/0x108)
> > [11542.215287] [<c011b40c>] (mm_release) from [<c011f9a4>] (do_exit+0x218/0x9a4)
> > [11542.215299] [<c011f9a4>] (do_exit) from [<c0120250>] (do_group_exit+0xac/0xf4)
> > [11542.215311] [<c0120250>] (do_group_exit) from [<c01202a8>] (__wake_up_parent+0x0/0x18)
> 
> > Signed-off-by: chen jie <chenjie6@huawei.com>
> 
> Reviewed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> However, should there not also be alignment tests on set_robust_list()?
> 
> Also; do_futex() should probably check uaddr and uaddr2.
> 
> That is; why aren't there any alignment tests anywhere? Or am I just
> gone blind?

uaddrs for the futex syscalls are checked in get_futex_key().

Thanks,

	tglx
