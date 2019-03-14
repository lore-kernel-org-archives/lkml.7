Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F289AC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C8D2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 19:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KiqH6+ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfCNTzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:55:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfCNTy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 15:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lTpiTYD7ovPNPgeqoeGc4xtg3O2FyyikIavWESV5UzI=; b=KiqH6+geW4z7X5jxe5e+DbFcTt
        r76jcG+Nh00ID1ZnYuhhAiLitYKgJ3vN1VPR+XY3ajLLY37SadsPg5Xd4xGmonmtXRdh7I9BLet9X
        w6/zl0HgCrP77+p5tHMIrkPCRd4nXHZwYDG7y8vpPXDgCRNbGocT6ECHprhjH+jhG4lkw2OS1fQZI
        yuqylyWRjcz3H/F4YWmzhD/XpOeq+87zaplRfbf08eHtTY2F8IrsEPLnZUEL5rTLzWEuONQl+CONB
        xiCP14UIID+4kKnjp1nXOFJB5/Lf5WUVWlyCReIFAtKp3U8WWxPC2IOvaH4Fw+UQuba0agXcREoJm
        SoPIKcTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4WRK-0003kI-36; Thu, 14 Mar 2019 19:54:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BD2C2011BC55; Thu, 14 Mar 2019 20:54:52 +0100 (CET)
Date:   Thu, 14 Mar 2019 20:54:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Numan =?utf-8?B?RGVtaXJkw7bEn2Vu?= <if.gnu.linux@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, jason.low2@hpe.com,
        Waiman.Long@hpe.com, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, dmitry.torokhov@gmail.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [regression, bisected] Keyboard not responding after resuming
 from suspend/hibernate
Message-ID: <20190314195451.GC6058@hirez.programming.kicks-ass.net>
References: <20180831215121.1b1f66bf@korsan.localdomain>
 <20181019102031.77015d44@korsan.localdomain>
 <20181025074903.GA9323@amd>
 <20181028220654.7e77e5d7@ubuntu>
 <20181130154455.21578c4d@korsan.localdomain>
 <20181202222809.GA29467@amd>
 <20181218102302.2b029612@korsan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218102302.2b029612@korsan.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 10:23:02AM +0300, Numan Demirdöğen wrote:
> I found that passing the options i8042.reset=1 i8042.dumbkbd=1 i8042.direct=1
> results in the keyboard functioning after resume. However, there is a
> long delay before the keyboard or mouse will respond to input on the
> lock screen.[1]

So the thing is, the mutex works, there's nothing wrong or broken about
it (or we'd have known, the kernel would crash and burn). The hand-off
stuff fixed at least one known starvation case as well.

What it does do, is change timing behaviour. But that is something that
is not guaranteed anyway.

This all smells like there's some timing dependent behaviour (aka. race
condition) in the suspend/keyboard interaction _somewhere_.

Now, I know absolutely nothing about either suspend or keyboard stuff,
so I really can't help there. The best idea is to add trace_printk()
throughout the keyboard suspend/resume code and see if there's a clue to
be had there (using remote access to dump the trace buffer after resume,
because of lack of keyboard).

Obviously that takes someone who knows how that should work ...
