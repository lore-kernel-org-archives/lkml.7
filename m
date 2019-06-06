Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E598C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F1920693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ijxw7vsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfFFJEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:04:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfFFJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ys6rGbN6Yk8y8bdYPTIE+k8Cxoa95HDhIkR7mf6kmvQ=; b=ijxw7vsDMWsNOgxy/c33A4hgO
        TaCg/tMbcQCjbhquqD9Q50H9GBWO2MHJ3bexxMHgkm+/PTUjrSxEpFe5ctXK7EwyX2agMVuPOOcmm
        XLvLi1HKrAZdgluIEKxEJ2QYT2kCUpFl685349wKz/y8b304ug5ZIcRHVwmoTtXW4vCSTNqsszWcu
        7An5QjIQGYL4CRoQqy8eWQ4O0UwHTtd5UDv/FUnrwZFfiSQ6Ejspd/CKyxHC/6G+R+64HJ7+liA0d
        nugKJZ/njUTT/y6WRDcyUe9LD3Vo96wS1s5LIZeAmwpnpZE7v3hAra44tOfLvd6k9zrUJgd2Ji79h
        7xwqhoZhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYoK9-00042T-Lv; Thu, 06 Jun 2019 09:04:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79683209697B8; Thu,  6 Jun 2019 11:04:39 +0200 (CEST)
Date:   Thu, 6 Jun 2019 11:04:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] Documentation/atomic_t.txt: Clarify pure
 non-rmw usage
Message-ID: <20190606090439.GK3419@hirez.programming.kicks-ass.net>
References: <20190524115231.GN2623@hirez.programming.kicks-ass.net>
 <tip-fff9b6c7d26943a8eb32b58364b7ec6b9369746a@git.kernel.org>
 <20190606084421.GA5523@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606084421.GA5523@andrea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:44:21AM +0200, Andrea Parri wrote:
> On Mon, Jun 03, 2019 at 06:46:54AM -0700, tip-bot for Peter Zijlstra wrote:
> > Commit-ID:  fff9b6c7d26943a8eb32b58364b7ec6b9369746a
> > Gitweb:     https://git.kernel.org/tip/fff9b6c7d26943a8eb32b58364b7ec6b9369746a
> > Author:     Peter Zijlstra <peterz@infradead.org>
> > AuthorDate: Fri, 24 May 2019 13:52:31 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 3 Jun 2019 12:32:57 +0200
> > 
> > Documentation/atomic_t.txt: Clarify pure non-rmw usage
> > 
> > Clarify that pure non-RMW usage of atomic_t is pointless, there is
> > nothing 'magical' about atomic_set() / atomic_read().
> > 
> > This is something that seems to confuse people, because I happen upon it
> > semi-regularly.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Link: https://lkml.kernel.org/r/20190524115231.GN2623@hirez.programming.kicks-ass.net
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> I'd appreciate if you could Cc: me in future changes to this doc.
> (as currently suggested by get_maintainer.pl).
> 
> This is particularly annoying when you spend time to review such
> changes:
> 
>   https://lkml.kernel.org/r/20190528111558.GA9106@andrea

Sure, I hadn't realized the LKMM entry had appropriated this file, I
considered it part of the ATOMIC entry there.

