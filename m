Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73544C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E172207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4w6Ytqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfCJNND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:13:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfCJNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 09:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=57HnqGhREXi8qMK38desgY/Cw4GhXoqjasyjZAWPzwU=; b=W4w6YtquAr8OTg7R1aEVA22a8
        r+WOfeSxRTIXoLPSsFJ2v8oBsBYlEa7Egz3poAjmkrXnD/Mc4fCx3/H5Wh0pa+sKeLvok8u4pRql1
        j8mkIIzx3bFXdt7uopGaW5avt+KN9VNv4l/E7jYlc/8IfHU4Sf0LZcbHvJ2VLaeMdCSfdJcD3NVBq
        PZH/+FH+x+gYwwKsc75aZKZ2ODBxbHkwaVKY8hIFyIuQhoOoZAHkmO91Rw6qe5+HGDbvKF52sVAsL
        dGUPTK8QmqrtZsgV7utXQsYcloDhGrTQrgtSDhiruIczEJ5Dyd2lgN6k3Y/1FQ0dB9nbOUYelNL0h
        mu0xHu+Vw==;
Received: from [188.207.104.17] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2yG5-0006p3-5Y; Sun, 10 Mar 2019 13:12:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F651981BBE; Sun, 10 Mar 2019 14:12:51 +0100 (CET)
Date:   Sun, 10 Mar 2019 14:12:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 19/20] objtool: uaccess PUSHF/POPF support
Message-ID: <20190310131251.GJ2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.784815194@infradead.org>
 <20190308211122.wx34kyixd64do2ep@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308211122.wx34kyixd64do2ep@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 03:11:22PM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 12:45:30PM +0100, Peter Zijlstra wrote:
> > Add PUSHF / POPF state.uaccess restore logic.
> > 
> > XXX: should possibly be merged with the previous patch such that KASAN
> > doesn't explode in between. Split for review.
> 
> Needs more description -- namely, what and why.

See patch 8. This really should be folded back in the previous patch,
but it is easier to look at without all that mixed in.
