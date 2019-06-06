Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A9C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E064E20693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C0XtFCHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFFRED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:04:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38986 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfFFRED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nuCiH7vt3Q92Rwmy7C7c/3Ld69OjA8cidRQEKNLNiEw=; b=C0XtFCHsc8M6vzDTzFa76F4I5P
        0T6k57QI7ay8qLNDvHhGl7tTESoFa/ab3BSi88Iyux4VyrnZMUlXX8CqvDGKEO5fKKaIlgRWSFIqF
        aIaBdW45oznA7Em0xqL+uBqMJb1gRDhw7sNX/jLQ4+REij5D9EQ8wnsGZ8Hn7ANTHLmnJVgW5TzPH
        U6n7h6tQYU7Ea4alyZITuRMzPME6okr7XZSE1Cfls8mO48TKqmVbOg+AIiGCFaos2e9IbPRpE9otw
        d/Dk9LqYm4ASuK2/6A1vv7knbv9uiEmGi/t/9KJUydrFpq8CSX2yKURwqt1C7ZbxZIJHgjpNvnXkR
        Jx8d6Z6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYvns-00047Q-LV; Thu, 06 Jun 2019 17:03:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AEBA2022711B; Thu,  6 Jun 2019 19:03:50 +0200 (CEST)
Date:   Thu, 6 Jun 2019 19:03:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Vishnu DASA <vdasa@vmware.com>,
        Adit Ranadive <aditr@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] VMCI: Fixup atomic64_t abuse
Message-ID: <20190606170350.GL3419@hirez.programming.kicks-ass.net>
References: <20190606093428.GF3402@hirez.programming.kicks-ass.net>
 <BC2D213B-89E4-4C14-A093-AC61EAB56830@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BC2D213B-89E4-4C14-A093-AC61EAB56830@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 03:54:24PM +0000, Jorgen Hansen wrote:
> 
> 
> > On 6 Jun 2019, at 11:34, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > 
> > The VMCI driver is abusing atomic64_t and atomic_t, there is no actual
> > atomic RmW operations around.
> > 
> > Rewrite the code to use a regular u64 with READ_ONCE() and
> > WRITE_ONCE() and a cast to 'unsigned long'. This fully preserves
> > whatever broken there was (it's not endian-safe for starters, and also
> > looks to be missing ordering).
> 
> Thanks for the cleanup.
> 
> This code is only intended for use with the vmci device driver, and
> that is X86 only, so during the original upstreaming no effort was
> made to make this work correctly on anything else.

Even x86 needs compiler barriers to ensure the compiler emits the
instructions in the expected order.

> We’ll be updating the vmci device driver to work on other
> architectures soonish, so will be adding barriers to enforce ordering
> as well at that point. If you want to leave your patch as is, we can
> address the type casting then.

You might want to have a look at smp_store_release() and
smp_load_acquire() I suppose.
