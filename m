Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE41C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362FD214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QUkrH4jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKKOrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:47:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48646 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKKOrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fJOseHK2e9wvnXUZP4G+x76V2qS6ADvRL+c18xf30j4=; b=QUkrH4jIwoVjQhdt7ebErDzr+
        NOrCup9q2h3ewFeIu0qpyojgk9ez2+pTQe6VMtxuqdzJH+mX7DDPpdCvksKtsYFlhYvwHP4aOvTmv
        lH/4n5lMZSunk3gluJs0kHvEDiE68FT63N2cnFk/Kna2Y7VWPJ3GLArMZDIDkGDmFAgqna5PnY5ZX
        4ryoMuP7qzWJvwUUt7BQusb1p7bvX0zS1IZYs9tuYc386u4er8L4tMio/3xrP/pYke78IqbZ7kZS4
        Tyvj0u69Nm13O4m434yqC/qxACI5QYRj2l5cmWsqS9FfGc8VY9DURa202rsmrde/JyPrv9m6Suq/s
        OW4f7utvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUAy9-0006Zg-T1; Mon, 11 Nov 2019 14:47:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5DD303060C2;
        Mon, 11 Nov 2019 15:45:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6B8CD29980EF9; Mon, 11 Nov 2019 15:47:03 +0100 (CET)
Message-Id: <20191111131252.921588318@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 14:12:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and more)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace is one of the last W^X violators (after this only KLP is left). These
patches move it over to the generic text_poke() interface and thereby get rid
of this oddity.

The first 14 patches are the same as in the -v4 posting. The last 3 patches are
new.

Will, patch 13, arm/ftrace, is unchanged. This is because this way it preserves
behaviour, but if you can provide me a tested-by for the simpler variant I can
drop that in.

Patch 15 reworks ftrace's event_create_dir(), which ran module code before the
module was finished loading (before we even applied jump_labels and all that).

Patch 16 and 17 address minor review feedback.

Ingo, Alexei wants patch #1 for some BPF stuff, can he get that in a topic branch?

