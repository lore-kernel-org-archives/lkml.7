Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E5320851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oCWPh5yR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCGUmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:42:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCGUmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LpGbehVdKUKrNATzVDfYDcNu6q8sam0RtgAyRu95q3M=; b=oCWPh5yRGZGApaQh0HmbV9mu1
        5mQalJzXgY5SUXDZCPVbviXtgy+goyN+YVha6XkxI3HaXna7oocvHgmMhBnVI1VJFIV32tVhDOAV1
        g5Mnnm3Ycv3baeU8UKXpoDYL817wiqW3PAVpnTs+WbL92SqYc/31nT+bh8su0ryuKDnTOty16cB9H
        dXc6vM0+ihMVXtTeVY19dIdRnKFIKLEZEVvCJUlfoUlRZxEgwgHy7IReEZiNwZ/JrdQBcCuhOUd2x
        AF3CqEMkAKUsCoOgFef6vfUS1an+WsITW4NdtdsJ9J+xqStGtBAtQsJdP8wRApdu/wJ9g7M3d8GRC
        1hIJMBSXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1zqj-0002SS-GR; Thu, 07 Mar 2019 20:42:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03E992028B0E5; Thu,  7 Mar 2019 21:42:39 +0100 (CET)
Date:   Thu, 7 Mar 2019 21:42:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/20] objtool: Add UACCESS validation
Message-ID: <20190307204239.GF32534@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <6a4875bd-2b22-91e4-cbe2-b01c12786a1b@virtuozzo.com>
 <20190307203318.GM32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307203318.GM32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:33:18PM +0100, Peter Zijlstra wrote:

> Ooh shiny. Clearly my tree still has them; what commit do I need to look
> for?

30be39d1e1dc ("kasan: remove use after scope bugs detection.")
