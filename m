Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE00C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF19C20652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r5fmDJPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfCHVeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:34:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfCHVea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CxB8s96WjghhiesOt5ydVNCuiwaAMnUIxwjNAKFzIeQ=; b=r5fmDJPb2lVy/CXQoQTgE8OdX
        rsD8rfaVhOJXNDqQxsWQv7aN95BTuUTrAFRCrVTKif+pfd8HMmDKFqf8pXei/116oLGklmoRHptLf
        Ds/RlzO8MViDL3tzGVmQp0c1qxXI/i+Q2kL8KW2PB9IGkArKQpLCWsWWufnxlw+ND/NIQji6pOjo8
        sddRitabkt0R2J5W/Tk6RaktvEc40upTuXSwjahZuxqtgVcrpomHPnkow79jUhhGimYyFOXQRXrCs
        fYU8qPjCgjGmEoq3VYwiGkzuK58waJMbenl6R2PA9PtHZFbX8277e36bCQbtDp9nwpFvglNwm42e0
        N5wXo4QEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h2N8H-00027H-0R; Fri, 08 Mar 2019 21:34:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4112981BBE; Fri,  8 Mar 2019 22:34:18 +0100 (CET)
Date:   Fri, 8 Mar 2019 22:34:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        julien.thierry@arm.com, will.deacon@arm.com, luto@amacapital.net,
        mingo@kernel.org, catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, luto@kernel.org,
        bp@alien8.de, dvlasenk@redhat.com, linux-kernel@vger.kernel.org,
        dvyukov@google.com, rostedt@goodmis.org
Subject: Re: [PATCH 16/20] objtool: Rewrite alt->skip_orig
Message-ID: <20190308213418.GF2482@worktop.programming.kicks-ass.net>
References: <20190307114511.870090179@infradead.org>
 <20190307115200.515578829@infradead.org>
 <20190308201510.4luzked52x3sdezg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308201510.4luzked52x3sdezg@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 02:15:56PM -0600, Josh Poimboeuf wrote:
> On Thu, Mar 07, 2019 at 12:45:27PM +0100, Peter Zijlstra wrote:
> > Really skip the original instruction flow, instead of letting it
> > continue with NOPs.
> > 
> > Since the alternative code flow already continues after the original
> > instructions, only the alt-original is skipped.
> 
> I like this approach.  I wonder if we can do something similar to get
> rid of the nasty fake jumps.

This actually hard relies on those fake jumps. Or am I missing the
point?
