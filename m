Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2792C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9321218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bZA5bQx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfGDUDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:03:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfGDUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PbOw/ItJGlskEyjwYOEM+EXXsgD+rHwICf2ieYLEgx8=; b=bZA5bQx9zyjOfz8Pok8PbJh67
        LmbMCyq5NGcq3dSwgt05qeJnGzEwdeBfgv9V2COqxuL0TX/wmtRiFU+HF5R/rUh8IKlbou6+WrwWZ
        iHVIXhZuiaNCgThkMcLAaz0s+Ky/7koDNs63X9ZsM49t2n5smpqdx8fd6JyAusYrwBaA/ZEvjE73Y
        V3SP3a8bOk6j7K7MjS4XBOF2YwF//QtAg1zAazf2Y75hlDCNyiAUsGuIgIJthpEqWUrH+yXT1NK6W
        x6l7fwVQ8Qva8rRmW1hXeOgeFVQ0KdAx7vPsQEXwJqMjrQzUUqcNO/J6pV9+oTN0BQQdV8Fmks4za
        sOo2kDLKw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hj7wa-0006lB-47; Thu, 04 Jul 2019 20:03:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 398762059DEA5; Thu,  4 Jul 2019 22:02:58 +0200 (CEST)
Message-Id: <20190704195555.580363209@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 21:55:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v2 0/7] Tracing vs CR2 (and cleanups)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Eiichi-san re-discovered the bug earlier found by He Zhe which we've failed to
fix due to getting distracted by discussing how to untangle entry_64.S.

These 3 patches are basically a completion of the initial approach I suggested
in that earlier thread:

  https://lkml.kernel.org/r/20190320221534.165ab87b@oasis.local.home

Since v1:

 - idtentry_part 'cleanup'
 - extra sanity check and comment
 - read_cr2=1 for do_double_fault
 - #BP vs IST cleanup
 - IDTENTRYx() C wrapper

The thing boots on x86_64 with lockdep on, survives function-trace,
selftests/x86 and perf-test.

