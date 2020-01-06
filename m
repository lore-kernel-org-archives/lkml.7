Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2AC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEA2207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jd2iIRuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAFP0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:26:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FasDblTVRzo6rSHY9siQrWkIk7A08Z0SsxWwX4908tk=; b=Jd2iIRukT2gpL+bEHVbwcYxtW
        8s2OSMrjJzx3WE/yFOTRZoWLSLNZXciYHY5q7QJkisLP4rmnVOyVzIduop2LPuk8HXVyljnkkeOEJ
        26RLsR2xZIfmU9VSqUsT0OqIqPhh358sLzHaBGqXEhSaN4Ze4bA8v8bJ/vBzf+fq7EF+uSF2k4IIb
        rq3LmMw3kl3FHytWhsAx06X7t51Neq6fwkF9eaN6tmjv+xqkk6YEP3rc/A/L5yS3JMb5sIuuOzHZu
        3lL+g5wT2p8vSWPENmB9Pos/Dpns9a5Mc6PBfSeEPJMYq2Us/y6lcellgxZ7GWO951JmY2J7Jj5xp
        4UTIsOArg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioUH0-0003Fa-Mc; Mon, 06 Jan 2020 15:26:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 047963012DC;
        Mon,  6 Jan 2020 16:24:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FF772B28450D; Mon,  6 Jan 2020 16:26:29 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:26:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20200106152629.GU2810@hirez.programming.kicks-ass.net>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912301131.2C7C51E8C6@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 11:32:31AM -0800, Kees Cook wrote:

> Is there a meaningful proposal anywhere for sparse to DTRT here?

These are what I found going through my Sent folder and Google'ing the
resulting subjects:

  https://markmail.org/message/4obybcgqscznnx63
  https://markmail.org/message/pp4ofksgactvgjbd?q=inverted_lock

> If
> not, it seems best to use what you've proposed until sparse reaches the
> point of being able to do this on its own.

Or just leave the silly sparse warning, they're easy to ignore.
