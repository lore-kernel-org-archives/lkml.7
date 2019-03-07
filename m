Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E14C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DE820840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 20:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yhe9w0l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfCGUXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 15:23:37 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56030 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfCGUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 15:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iaI6XeEEu4SJCagaIHkTGqUt1vBjx7JvMKxV3byT/T4=; b=Yhe9w0l65nicgS2wWJEh9Qstm
        rTngypMgC0ExKUhkWYqyA5OLUN3vBwI5006PPzR0yBHYJPdIg/ilmD1LpXucyz2zYhbs2esnPdz/U
        752aiTvQ5s3vq7V8w+a7ugCQiwfIQV2DQxlLhhUpQVgpOXWpC8pfjjotQhMb6bwV4TQf9JaaXvpdj
        kDTM1zo03j1NFdnJwoz/5AXgXBFdBa8KYImbQU7I+Bx1oN1WpJGIjteGffDMZ2Hg1ZaPmrrtxyUuv
        KbBS1PlHrcg6fOXnICLynKbDvpzCSQUTj0ArzinJHzgpJOWl8xnhW6JE95V5PJyX/wCYahbX9PUg5
        1aYZWkNWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1zY1-000178-Uk; Thu, 07 Mar 2019 20:23:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F43920297BC0; Thu,  7 Mar 2019 21:23:19 +0100 (CET)
Date:   Thu, 7 Mar 2019 21:23:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
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
Message-ID: <20190307202319.GD32534@hirez.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.697533978@infradead.org>
 <CAHk-=wgKDSSoV5WvO018hoPPSHO=TQ3wwnfOtCpaENceBe0Z6Q@mail.gmail.com>
 <20190307174135.GJ32477@hirez.programming.kicks-ass.net>
 <CAHk-=wgGZWXQj-J2xo0DY7150VrXOSqoD5Dj1_LGYaotqA6Z-Q@mail.gmail.com>
 <20190307184813.GL32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307184813.GL32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 07:48:13PM +0100, Peter Zijlstra wrote:
> Another thing I need to look at is why objtool only found memset_orig
> (from __memset) but not memset_erms, which if I read the code right, is
> a possible alternative there.

Turns out we only look for sibling calls in the original instruction
stream, not in any alternatives; which in general seems like a fair
enough assumption.
