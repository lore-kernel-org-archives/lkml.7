Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95283C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649832176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lgUgbxt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfLQTdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:33:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfLQTdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GnokyztFg1DrYU8iij3eOiPO8udMbVo2S5pAbtFt5ys=; b=lgUgbxt+e5hQ8D72Q9a/UvNcL
        9mgkGlBV78kun+06E/0o6K/CcPbOL/RVYtzQwGnoOz8OF5lco0EveCv6Ygjg9Y9k5bt6FIaSRXPF2
        2SECRY8jH8+iZqqqwiiFObsKdR3r3Agaf40gAFLz3GRBy4JP0Hu7xnz6sL2dhkLhyIN5KLFpl5TI9
        rjqg6ZmpTleGVr1OoMcY40tliT1dWy+BaWp/thI46n2MPVxdTm4tzct/PznxbUZyqLXtVcwPKB1bK
        yxc0JQwf4eUkR/PemEUFtqqUXH/opU+QUmiBFeciYnEHMnwPwPCYaIZA+o7g5thtbWUZNc1srn+5U
        t32jI8Y0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihIar-00062W-Oc; Tue, 17 Dec 2019 19:33:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 654F930038D;
        Tue, 17 Dec 2019 20:31:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15D4C2B2CEC1B; Tue, 17 Dec 2019 20:33:15 +0100 (CET)
Date:   Tue, 17 Dec 2019 20:33:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     chenqiwu <qiwuchen55@gmail.com>, christian.brauner@ubuntu.com,
        mingo@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191217193315.GG2844@hirez.programming.kicks-ass.net>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
 <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
 <20191217105042.GA21784@cqw-OptiPlex-7050>
 <20191217142515.GB23152@redhat.com>
 <20191217145620.GA26585@cqw-OptiPlex-7050>
 <20191217152333.GC23152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217152333.GC23152@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 04:23:33PM +0100, Oleg Nesterov wrote:
> On 12/17, chenqiwu wrote:
> >
> > But in fact, I think atomic_read()
> > can avoid the racy even if both threads exit in parallel, since it is
> > an atomic operation forever.
> 
> Hmm, not sure I understand. atomic_read() is just READ_ONCE(), it can't be
> re-ordered but that is all.

That, atomic_read() is just a read. It doesn't modify the variable,
therefore there isn't anything 'atomic' even remotely possible.
