Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9C5C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E454D21823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b1L4ca+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLFRhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:37:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLFRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+6LYuatW9jF4wLm7eEprIcSEiB+UNxPWaadtEB0v6Vs=; b=b1L4ca+k8z4ucutXjW6JX13Ld
        ZhbhHKosYAPZE3lcoT93IdnmVyiBex5NWwz0GzNZc2p+PRb7IfWCtHToMLvrfQrZtgXnWv0rRKUXJ
        8YLO94hpplDVhQna+AOOwI+Bf3QcM1QGxL7bxzd25mbvbKgQx/t6kz7eyS+FT8jFZXN6OddtoLAoH
        CyAfdv7iK51CSZ5uiYEFJpCbMTvmZuDyQ3iPzbj2nuIYTH7xR7R+dBBfOdLE1crZxNXCwf/OIUC22
        Q/GOhFXMoOIaVI3Ky7p31kLbu2nVE8Tnub2vOuvbJ2qoXvhgzMqWoWt4vtqMj267b1tkESW2YtqEL
        Nm2J/5y/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idHXR-000228-Dc; Fri, 06 Dec 2019 17:37:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BBC7300DB7;
        Fri,  6 Dec 2019 18:35:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CB3AE2B2763CD; Fri,  6 Dec 2019 18:37:05 +0100 (CET)
Date:   Fri, 6 Dec 2019 18:37:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Malte Skarupke <malteskarupke@web.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm
Subject: Re: [PATCH] futex: Support smaller futexes of one byte or two byte
 size.
Message-ID: <20191206173705.GE2871@hirez.programming.kicks-ass.net>
References: <20191204235238.10764-1-malteskarupke@web.de>
 <20191206153129.GI2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206153129.GI2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:31:29PM +0100, Peter Zijlstra wrote:
> > +		case FUTEX_WAKE:
> > +		case FUTEX_REQUEUE:
> > +			/*
> > +			 * these instructions work with sized mutexes, but you
> > +			 * don't need to pass the size. we could silently
> > +			 * ignore the size argument, but the code won't verify
> > +			 * that the correct size is used, so it's preferable
> > +			 * to make that clear to the caller.
> > +			 *
> > +			 * for requeue the meaning would also be ambiguous: do
> > +			 * both of them have to be the same size or not? they
> > +			 * don't, and that's clearer when you just don't pass
> > +			 * a size argument.
> > +			 */
> > +			return -EINVAL;
> 
> Took me a while to figure out this relies on FUTEX_NONE to avoid the
> alignment tests.

And thikning more on that, I really _realy_ hate this.

You're basically saying WAKE is size-less, but that means we must
consider what it means to have a u32 WAIT on @ptr, and a u8 WAKE on
@ptr+1. If the wake really is size-less that should match.

I'd be much happier with requiring strict sizing. Because conversely,
what happens if you have a u32-WAIT at @ptr paired with a u8-WAKE at
@ptr? If we demand strict size we can say that should not match. This
does however mean we should include the size in the hash-match function.

Your Changelog did not consider these implications at all.
