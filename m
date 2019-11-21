Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35CEC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8871920672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QKqJyLmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKUUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:20:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58896 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qOktCdLLVB7nTmJcxwH9iwxLQvm6tnAzKuSohvP2NxY=; b=QKqJyLmM0ryi+pVTsX9E5xBDo
        1LT0g4qnkID9F1BatrY2Fz0Kcu9yWX72F6OGoAmH2zebp/uh9sBEY4AZCOC89AB64baY+GxFV28Jn
        bELXaEPnDl0G9RI/iq8xeOVyUReRHZ4hCdqB7cZsi219jx4Qy9U+DbkZfZKlYxTjE6Xzx/QCmtMFP
        5jfbOIL4yvZUlW3q99MxBFAwm/di7EVk1AJsOz5/vbLc19jBUZnRWhrqqiiIAGeeClSa4wqJt4cth
        JWjx6oaz8wR987r13sC3BYbcJNlrP4bfCeFCDkVeyAetAPEtUyAXFIB0qIiNf8m5a0vw8E2PWEXJF
        7+PTGMpFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXsvh-0000l2-QH; Thu, 21 Nov 2019 20:19:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1EF1E300606;
        Thu, 21 Nov 2019 21:18:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D64A201F87D3; Thu, 21 Nov 2019 21:19:51 +0100 (CET)
Date:   Thu, 21 Nov 2019 21:19:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Message-ID: <20191121201951.GY4097@hirez.programming.kicks-ass.net>
References: <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <4BB1CB74-887B-4F40-B3B2-F0147B264C34@amacapital.net>
 <20191121202535.GC199273@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121202535.GC199273@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:25:35PM -0800, Fenghua Yu wrote:

> > > We are working on a separate patch set to fix all split lock issues
> > > in atomic bitops. Per Peter Anvin and Tony Luck suggestions:
> > > 1. Still keep the byte optimization if nr is constant. No split lock.
> > > 2. If type of *addr is unsigned long, do quadword atomic instruction
> > >   on addr. No split lock.
> > > 3. If type of *addr is unsigned int, do word atomic instruction
> > >   on addr. No split lock.
> > > 4. Otherwise, re-calculate addr to point the 32-bit address which contains
> > >   the bit and operate on the bit. No split lock.

> Actually we only find 8 places calling atomic bitops using type casting
> "unsigned long *". After above changes, other 8 patches remove the type
> castings and then split lock free in atomic bitops in the current kernel.

Those above changes are never going to happen.
