Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4524FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1035821479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOfa7hY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfJ2MpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:45:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfJ2MpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hVdr8AGoLmcLD7UHSk7r+3kLF5IAZuF+LPLrBkQW4Ew=; b=bOfa7hY7UVYL2VaHy+D78WteV
        bq/8PId8redu+5Lk8NGqrBB7E7msbmhfQ3kTAGbc92wlUJpD3GljW947j8QlWxR6FaZZ1ClhVQNUI
        Z6o9xRkl0e4Pn3260m/xo7N3X87vKuef9zkE3p3VIEPMtTN5b3sTtF0gJ14yknVDw1uUnBbuE6rKi
        6lk/3xw6N/nhWbJgxp0RNLFwyJ38w4WnXq0znO9bfAhnTR06Nf39uP1X0SNsoXQBQoWNgCIqf0Snj
        aW3TcHCAjZl/hPftFnO6tKBqHG3H11miRJWVsqv6npZGyHu5+ceBm1Id5LCscIi/OxSq5QSnIVnJN
        ifbGGI88w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPQrn-0004fR-L1; Tue, 29 Oct 2019 12:44:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A328D30025A;
        Tue, 29 Oct 2019 13:43:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FD7520D7FF19; Tue, 29 Oct 2019 13:44:53 +0100 (CET)
Date:   Tue, 29 Oct 2019 13:44:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, bigeasy@linutronix.de,
        tglx@linutronix.de, thgarnie@google.com, tytso@mit.edu,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        mingo@redhat.com, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH] sched: Avoid spurious lock dependencies
Message-ID: <20191029124453.GM4114@hirez.programming.kicks-ass.net>
References: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
 <EE57FDCF-E3CD-4A0D-B0CC-C3CBAA7EBCBD@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EE57FDCF-E3CD-4A0D-B0CC-C3CBAA7EBCBD@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 07:10:34AM -0400, Qian Cai wrote:
> 
> It looks like this patch has been forgotten forever. Do you need to
> repost, so Ingo might have a better chance to pick it up?

I've queued it now, sorry!
