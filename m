Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC84C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7E9219BE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rGWFNPUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbfGVVJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:09:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfGVVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pY0LA8u0+TRN74LRfvbZ9clUI8/84sjDmmtXY1EVvV4=; b=rGWFNPUoxM9eF46CBWGZYiC4I
        12MmieSfQODgiiA2tRe5i/NGtXNT3dyP5lUxqXFQZWoCz5UAVZD9mPmrbmP+JRDnq9yl103cyoulg
        32BEnbX04xVNbYnQ/ajs6a5Y/jWPGdliZHznjbTYJYreDIKsztww+Wdy0tfhfgHyGy0gLCEj2RBu5
        CVs4UcR5OKm2Uj2/bY3xnwDsZR1wn5+fN0Z093T9FJXNoH1CaA8GzeTbqLyPIEy8Q8oCOdmCcGQo3
        aDcU4G0/AUgV5sfcsy5z46EENvsjsf3zRJV8Ko1KTRHyKGWFrmBP57TOyIwMIQ8StPmBnzBTk3G23
        RZpO0s0cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpfYf-0003OI-1a; Mon, 22 Jul 2019 21:09:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1B0B980D1F; Mon, 22 Jul 2019 23:09:18 +0200 (CEST)
Date:   Mon, 22 Jul 2019 23:09:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC 0/7] x86/percpu: Use segment qualifiers
Message-ID: <20190722210918.GM6698@worktop.programming.kicks-ass.net>
References: <20190718174110.4635-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718174110.4635-1-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 10:41:03AM -0700, Nadav Amit wrote:
> GCC 6+ supports segment qualifiers. Using them allows to implement
> several optimizations:

Overall I like this. Nice!
