Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DFBC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BD921655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cqDn87Bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfJGLZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58244 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JXE0dKTAZ/7/GCs33tkCyc03FqW8wVQf8nnAiBE01gQ=; b=cqDn87BkgaddKj3WAebbQbdpf
        INushnx6fW5+ARBvfq+dJQW+VDXos9edqDBCBtb20SX+C3sB3UDuhT4eaghh1GcSlgx1RdC+n2Gj/
        BAgHg1Y4c09rKKAHkiF1jwOseBJg64JTyOVQMvk3AGS+UWnGoBzEhNAODAO8vPpx5Wvr1zJGcnKNz
        RkBA5T1JkieGoU2PH7DooIaV5byvh8y12KvFF1rzMzbT+RMC3nYJ00kfmfelF3tW/Bs7ysHhDSm7P
        0+KyuSezviEWwaiXx/vmWexYGtK8+G+S0aK26rXluqL11U35G+QbddPUIBY26sztT6fUu+pXhBLUo
        8/dOCRKWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6v-0002Az-AB; Mon, 07 Oct 2019 11:23:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 911F0305FEB;
        Mon,  7 Oct 2019 13:22:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 64D8F202A1952; Mon,  7 Oct 2019 13:23:26 +0200 (CEST)
Message-Id: <20191007090225.44108711.6@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 11:02:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com
Subject: [RESEND] everything text-poke: ftrace, modules, static_call and jump_label
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Because typing on a Monday is hard, here's a resend with the LKML address
corrected.

---

Hi All,

Here are 4 series that have accumulated in my queue for a while and I
figured I'd 'finish' and send out again.

The first series is rewriting x86/ftrace to use the normal text_poke()
interfaces we have, which rids us of the last major W^X violation and a
whole second implementation of the INT3 breakpoint code patching
infrastructure.

The second series cleans up various module stuff.

The third series is a refresh of the static_call() implementation.  I've
been meaning to use that to get rid of a number of indirect calls in the
x86 pmu implementation (RETPOLINE made them so much more painful), but
also other people have been asking for it. This series has a lot of new
patches since last time, most all a result of me trying to actually use
it.

The fourth series is something that has been languishing in my queue for
a long while and I figure I'd send it out to see if anybody has any
clever ideas on how to proceed with it.

They're all related, and the 3rd and 4rd series depend on the first two.
But instead of sending a giant 30+ patch series, I figured I'd send you 4
smaller series instead ;-)

Enjoy!

