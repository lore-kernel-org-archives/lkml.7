Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A40C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A650620870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XLhVfNhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfFENXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:23:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfFENXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rzGWy/MVsBs4DNmwRKH5mWhkT+aXVKs8NMOAKIyQd/E=; b=XLhVfNhdyceJ7d7wDKrLMTo3o
        gQlCqX4HL0BnaAW0CK+l3wQHNex3dM43YX2UXBRV8nxnaOjwBtJ1C4ML3x1q42PkUNOCiSbND2aC6
        k1em+m+EUBKOa9cWRHl/NI8KgqFaWTjFITHfty+c/GUJIT+bArQDpDmrSUb1NVRHasfJcvnkRPGx3
        0YzDtoA1XaGAY9hy9ZPPWwGku1GxlWIw0qURAuPseCTYkjn5b6aD2qMjrI5pRk9EBqWeU7uQi94Qn
        Q8lZY7WycrSp+RQ2n1qJpUl1VTidYjzaSkxXM8bGgwa67SqEHc2t943libtyCz6uBxaFt2VVc3fh/
        Uv37nPJ8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYVsH-0004qL-Ca; Wed, 05 Jun 2019 13:22:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6CE4C202D0BA4; Wed,  5 Jun 2019 15:22:39 +0200 (CEST)
Message-Id: <20190605130753.327195108@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Jun 2019 15:07:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 00/15] x86 cleanups and static_call()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Now that all the x86_64 int3_emulate_call() stuff is upstream, here are the
i386 patches and all the rest of the cleanups that resulted from that
discussion.

And I figured I should have a go at making that static_call() thing working now
that we have the prerequisites sorted.  This is mostly a combination of the v2
and v3 static_call() patches done on top of an 'enhanced' text_poke_bp().

I wrote a little self-test and added Steve's ftrace convertion on top for
testing, and suspicously I've not had it explode, so I'm sure this is going to
set all your computers on fire.

Enjoy!

