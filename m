Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52444C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D3121655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZDISY/WL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfJGLYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:24:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58296 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfJGLXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=References:Subject:Cc:To:From:Date:
        Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=aJcXWmfeWEZlwYA4uLMAbrM0HoUYouAYfkkj++ZTsqg=; b=ZDISY/WLSZ5y
        Trtg9/P1RKGyZvVxr4aSpZmNwdPCoq2Ymzi+b77Kmo7jIiutUOj7bxY9kIxUQ74htSLJg+t/cE5l4
        f1jVJZb4rsPqR7ZnP/SVaAzaB3I+PgcApwLyur0+ucTEo8Nug6tGNnqZo0x8//8tAxV6j8+jUE4qe
        lXLnn+edqNn+Gwt77eX3MfZn4xkySFgTKZxDRaoOQK2I/p5mQ5fONLX9/YiE+AwRecYqnyeMmwqVQ
        F5NUDZDpsnl2l3+orrNoN2wnVwQqBoX2baAviG0J8aFoHGf2M4937Pv2LdNJZmVdTbgvsWwc+GxAo
        Xx4AruZFXcrhHX5ifUrUHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6w-0002BE-R8; Mon, 07 Oct 2019 11:23:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4269E3072EC;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E927A20244FAD; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007084443.79370128.1@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 0/9] Variable size jump_label support
References: <20191007090225.44108711.6@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These here patches are something I've been poking at for a while, enabling
jump_label to use 2 byte jumps/nops.

It _almost_ works :-/

That is, you can build some kernels with it (x86_64-defconfig for example works
just fine).

The problem comes when GCC generates a branch into another section, mostly
.text.unlikely. At that point GAS just gives up and throws a fit (more details
in the last patch).

Aside from anyone coming up with a really clever GAS trick, I don't see how we
can do this other than:

 - get binutils/gas 'fixed', for this there's two possible approaches:

  * add some extra operators such that something like:

      .set disp %[l_yes] ~ 1b ? (%[l_yes] - (1b + 2)) : 128

    works, where the new '~' infix operator would indicate left and right hand
    operands are from the same section, and the ?: conditional operator would be
    added to make it all work.

  * add a 'fake' mnemonic for x86 that directly generates the right NOP:

      nojmp{.d8,d32} %target

    which would completely mirror how the existing 'jmp{.d8,d32} %target'
    works, except it would emit single instruction NOP2/NOP5.

 - use 'jmp' and get objtool to rewrite the text. Steven has earlier proposed
   something like that (using recordmcount) and Linus hated that.

