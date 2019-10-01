Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5D0C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130AD215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QeGWiE1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbfJAIpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:45:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34144 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJAIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vAyI0/IqfKtg27NjkVN0J7lLOBnn0EBImm7wCc67a1Y=; b=QeGWiE1gSJRrkjtogdlwI+JRc
        y9HYd8MDarEx7hsx7JSh56yK+pJnydYyYWM8+eKo0IMemAsS/N9/1Z/cEERn2dRW/BLF5S+FAbKRP
        tFmSwGKJUhtt/+/U1FhrxbTu/7Q6IfsQph+mLRv2unWyfe6UgWK3XLECzJ8C4RqTVmMBWaKIl+TOh
        oPwp6AON6VUcvApnI/BqfEuCa4Ye42Am0OvEcoVJEK6puPxH5xRrsVLBUHghFDTrq5X3Sl11gFKS8
        ZKUri4PPH4GNl9t4ugQzfOoeoL09ZvTQIwtBAQgGNmSlSedE/jAYYnJ270iQrT8l6PJaTl/iryLbt
        qqN2trgyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFDmw-0006lV-3y; Tue, 01 Oct 2019 08:45:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D354305E4E;
        Tue,  1 Oct 2019 10:44:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 627FD265261AD; Tue,  1 Oct 2019 10:45:40 +0200 (CEST)
Date:   Tue, 1 Oct 2019 10:45:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+6b6a46cc150b19f54ad6@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: WARNING: lock held when returning to user space in
 membarrier_private_expedited
Message-ID: <20191001084540.GO4519@hirez.programming.kicks-ass.net>
References: <000000000000ceadfd0593d4dd55@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ceadfd0593d4dd55@google.com>
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
> HEAD commit:    afb37288 Add linux-next specific files for 20191001
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17619635600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=659cb5bf73e72c6c
> dashboard link: https://syzkaller.appspot.com/bug?extid=6b6a46cc150b19f54ad6
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176faa13600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b825cd600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6b6a46cc150b19f54ad6@syzkaller.appspotmail.com
> 
> ================================================
> WARNING: lock held when returning to user space!
> 5.4.0-rc1-next-20191001 #0 Not tainted
> ------------------------------------------------
> syz-executor589/9088 is leaving the kernel with locks still held!
> 1 lock held by syz-executor589/9088:
>  #0: ffffffff88faadc0 (rcu_read_lock){....}, at:
> membarrier_private_expedited+0x180/0x590 kernel/sched/membarrier.c:150

https://lkml.kernel.org/r/20191001071921.GJ4519@hirez.programming.kicks-ass.net
