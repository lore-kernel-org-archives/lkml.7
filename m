Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4EBC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8CF2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FGw3wK2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfLDNM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:12:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34200 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfLDNM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2bbm5RvmhagS4gkZ7gdt+xx0o3iMzUuUj1LKHe0kk9g=; b=FGw3wK2VMrFNcXqp7UEmVw8Pn
        Ig43YaY41uN1NOG2/TMwGy14rFoGDYjNXQghdCjexyWrPZx5O+8n54vjtrQTgt0O2OdOisfkc5aZJ
        L3Azt2S8JsIQm5+de4hcDFnrH+RvSwDFpvTY46R/kUjKy5aOa++e3hs7jgZQreQWUugo8fPalJYon
        amnRLyfS98yeJqieCwuxsTAF6G1PP6h9xXZpKqjD/EEsU0QW4idTxvBNcl1sgpKE73Eb824QAI71c
        RE9U/ZDmWb9ebrktBp8hdtDIq9vRZQoig9bg85HjOHqmbWjw1KvdpW1pqUmnfKXunfXC/vhqkACxP
        HBxqzA0wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icUS2-0000aw-R5; Wed, 04 Dec 2019 13:12:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB3DC303150;
        Wed,  4 Dec 2019 14:10:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88C962019A887; Wed,  4 Dec 2019 14:12:16 +0100 (CET)
Date:   Wed, 4 Dec 2019 14:12:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com
Subject: Re: [RFC PATCH 3/8] perf: Init/fini PMU specific data
Message-ID: <20191204131216.GV2844@hirez.programming.kicks-ass.net>
References: <1574954071-6321-1-git-send-email-kan.liang@linux.intel.com>
 <1574954071-6321-3-git-send-email-kan.liang@linux.intel.com>
 <20191202124055.GC2827@hirez.programming.kicks-ass.net>
 <20191202145957.GM84886@tassilo.jf.intel.com>
 <20191202162152.GG2827@hirez.programming.kicks-ass.net>
 <20191202191519.GN84886@tassilo.jf.intel.com>
 <8612523d-f035-b2aa-28f5-e4122ef59901@linux.intel.com>
 <20191202202535.GO84886@tassilo.jf.intel.com>
 <3d981134-24b0-c079-3b4a-7ffe434324d5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d981134-24b0-c079-3b4a-7ffe434324d5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 03:44:34PM -0500, Liang, Kan wrote:

> It's not in context switch. I will use the normal spinlock to instead.

Mutex would make even more sense. And we already have a per-task
perf_event_mutex.

Also, I don't think you need tasklist_lock here, if you set the state
before the iteration, any new clone()s will observe the state and
allocate the storage themselves. Then all you need is RCU iteration of
the tasklist.



