Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD6C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8856A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L9gu+vEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGJUPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:15:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50442 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGJUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=79SAeG0OCmB1YnKkVJNSfK8HErnCADxzPIPyB9Kfcws=; b=L9gu+vEIR/ZTwLzw+4D7gIwZd
        rAXLEPAWM9WDpWVEdHxMguuBVpG8TykSzE7Yg2xV5wsqw0QGQRIVt05ml7c9FZNyv//sY1pWATkdP
        VdUEkukRu9diZgwYgEPQJufsPK8boZMfWoctozpFZ+ZwzZK2h3TMRvAbUkYz0MomrNMGOrJXnAfV0
        tCeeN4/NfH8r4OqZS3UzOWTUdyEt6UlKU8cq7Os8vSlrT6BHejO9G2q6Dbn6Vel3zwdO50Cjst/RW
        AMdpN3GeuuPfzfUSsYumpYX5MhRJxNHczvZ1qF1TKDyDoA5qwCQ5P/na1oR5J+jYQk1VYSj8S9IMe
        LS5kWYing==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlIzO-0007k6-0f; Wed, 10 Jul 2019 20:14:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAA4B201247F7; Wed, 10 Jul 2019 22:14:52 +0200 (CEST)
Date:   Wed, 10 Jul 2019 22:14:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH v2 2/7] x86/entry/32: Simplify common_exception
Message-ID: <20190710201452.GK3419@hirez.programming.kicks-ass.net>
References: <20190704195555.580363209@infradead.org>
 <20190704200050.363747790@infradead.org>
 <20190710161137.026cdd47@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710161137.026cdd47@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 04:11:37PM -0400, Steven Rostedt wrote:
> On Thu, 04 Jul 2019 21:55:57 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > -	cld
> 
> The only code change of this is that cld moved from the end to the
> beginning. As this appears to match other SAVE_ALL users with respect
> to ENCODE_FRAME_POINTER, this shouldn't be an issue.

On that, getting CLD and CLAC together is somewhere on the TODO list. It
is stupid they're not.
