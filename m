Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FBC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD34215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pyD+v/H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfJAIp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:45:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJAIp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mF3/fd7P0Rq3M0sPBe2764euN8GKHuf61uE85D6TBMI=; b=pyD+v/H3OMJvvbdz4cwbTDBnK
        O5Mo4Bk0nUWzFLLGP6W5S1S76jg+Ywr1Cd4Lu7Pr11a1bYWcp+pScCWqIARrA0b5GX5S9B9jtnkQY
        Uyf1RdzyT2A7EGksLFhrpu9ybJqfcjwLzjKr8T/crLXnorVd8+mrmW3mLsQtqcPrGDMyQWHZ/irh9
        DR/BO+uElkmE7VFbUc0uQFiCa0SaM2c9YJReLnG8NbCvvoU9FRE+NBy8oy5vo/LvMUkftas+HwG3c
        F5WLsDlpf1lu/hGv5y8GQSbvbyyTtOkm3gnGg/e7FDrdf7ndhTnM2HkVY2Xoc8+r9rGLTnDX40ltp
        zliq5qYDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFDmc-0006jw-08; Tue, 01 Oct 2019 08:45:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08CFC304B4C;
        Tue,  1 Oct 2019 10:44:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52182265261AD; Tue,  1 Oct 2019 10:45:20 +0200 (CEST)
Date:   Tue, 1 Oct 2019 10:45:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+0e1a9dce275f13907b4e@syzkaller.appspotmail.com>
Cc:     dvhart@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: WARNING in rcu_note_context_switch
Message-ID: <20191001084520.GN4519@hirez.programming.kicks-ass.net>
References: <000000000000d2661c0593d4dd89@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d2661c0593d4dd89@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 01:09:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    54ecb8f7 Linux 5.4-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14972bf3600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fb0b431ccdf08c1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e1a9dce275f13907b4e
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16875a35600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104bd519600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0e1a9dce275f13907b4e@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 7994 at kernel/rcu/tree_plugin.h:293
> rcu_note_context_switch+0xdde/0xee0 kernel/rcu/tree_plugin.h:293
> Kernel panic - not syncing: panic_on_warn set ...

https://lkml.kernel.org/r/20191001071921.GJ4519@hirez.programming.kicks-ass.net
