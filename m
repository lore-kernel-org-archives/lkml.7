Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72658C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CE021744
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5/AW6vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409356AbfFLOx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:53:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40808 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405540AbfFLOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9XUvdxlpi+CqICMGBfiq04NZisz/VK2n9IZyYoVnnh8=; b=k5/AW6vuQFGdds2Fm59y8kxBl
        m7T50OM9EziDyTp1H813DQGqEJPPnz6NGBhe+Lk31Rs/tq6fxrj8DKIPB5iCoAyNvVN/4+BNTrMi7
        yROCztPtgvNFJ4DhkQX1Lj77kcHIDDk30wGzV2x/aO1eTrA5o+ER6o+qNrLp/rkMr03/XR5KUs+5C
        j6sGASAq2vcRP2qc0YmBZcKKNwlVyP+lCaX9v3tuaCw6gEnezd6Iz4gBxIrPwjyyEHLCXXOJ485yU
        lP+aG0ZvwYaxd+KsV4q65uW2tYDH/IyaNlxm70j5Mj/UR+NlKDEALbzaAj1Ox21Vi/OfWSadkq1UJ
        Zp5nFQdaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb4cH-0007Ot-7V; Wed, 12 Jun 2019 14:52:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88EC82029900F; Wed, 12 Jun 2019 16:52:13 +0200 (CEST)
Date:   Wed, 12 Jun 2019 16:52:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V6 4/6] x86/alternative: Batch of patch operations
Message-ID: <20190612145213.GK3436@hirez.programming.kicks-ass.net>
References: <cover.1560325897.git.bristot@redhat.com>
 <ca506ed52584c80f64de23f6f55ca288e5d079de.1560325897.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca506ed52584c80f64de23f6f55ca288e5d079de.1560325897.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 11:57:29AM +0200, Daniel Bristot de Oliveira wrote:

> When a static key has more than one entry, these steps are called once for
> each entry. The number of IPIs then is linear with regard to the number 'n' of
> entries of a key: O(n*3), which is O(n).

> Doing the update in this way, the number of IPI becomes O(3) with regard
> to the number of keys, which is O(1).

That's not quite true, what you're doing is n/X, which, in the end, is
still O(n).

It just so happens your X is 128, and so any n smaller than that ends up
being 1.
