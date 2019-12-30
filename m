Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D02C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 23:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E83C2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 23:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyYUCZR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfL3XiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:38:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40235 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfL3XiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 18:38:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so33972932wrn.7;
        Mon, 30 Dec 2019 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UV18QxzNw74OQEVccoyAS4yfxDD5XxdtiGTMxWiHN98=;
        b=TyYUCZR+6kQ+HW3M7eGq7s6+mRivf7dpl+FJeiN1yA+jSfyGVT8m/j5965jlyhfsCi
         f48uEv+M+ppfKoot4NPQyPbZVNtoJbTE2o2uu+Q0GucOYnkWcDiiFhEfsgWhd4i6ApQa
         xm4Yo8tExN/cOp5J8mopXd2TxItbzEeGPRFqUzL6Gd3xOLxS/52pXDEZx97pWQPL+nTU
         1dLDGJbuRXIxtm6PqBKmqNkQeg4CxWpXJPXk7BpD3C1tIgM4c5TOKi0ha6a32EqmbWYj
         i72x32SE7N7dYTraesZiixd2SFlCV1h/+2SQPPjusC1GVS6qMVqlEOClyVQv9AdBF/My
         30Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UV18QxzNw74OQEVccoyAS4yfxDD5XxdtiGTMxWiHN98=;
        b=LpR82ZNPFHq5lq5Vc4Rzxik0JpS4RUGid/LAaE9biMPNEWSrx6iy5G9aS3LG0sYs7Y
         O8JG+RTnDEQ3X2zgp8lOgtfzWvfAEZI3l5Qnmi8kGNbESxDU17uDZLlXEmHml8KGOpJb
         0t5mMCHj80FfTx3cOLI/pcKkMyuSHGAyzhVkNrOXHWEjGpqI9HJnA+YTQ4JersRYcOzp
         62d/nebfr0bfCSYo7PSZGd9V/rmnN/0ZdhjbMBN9eGcF0FAqWiP+pEb1bgNs/anHpr/x
         M5gT4Rc+FDjiJh8SPO139TrhT8XcstmPLprqVYYJ33WugNKiO4PH8qNeucS0XRT4CgqR
         DS2w==
X-Gm-Message-State: APjAAAXpgnJkOgBoAIF1BGo8Baa4Mrp45j4N7ra0pxgT6vuoS3sz5NBM
        aDP+E9FAZF2T8yKsfxIRRcaCWcR7
X-Google-Smtp-Source: APXvYqyt79dnV1jAfTe4eyYl8+9aO/tZR+atpG6aB8OYE7AhaeLTfgb5r6rvjV6ac+QJN9UGb0HI3w==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr1944547wrn.124.1577749096183;
        Mon, 30 Dec 2019 15:38:16 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40c7:f800:7c46:7fac:a1c:a5b2])
        by smtp.gmail.com with ESMTPSA id g21sm888287wmh.17.2019.12.30.15.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 15:38:15 -0800 (PST)
Date:   Tue, 31 Dec 2019 00:38:14 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20191230233814.2fgmsgtnhruhklnu@ltop.local>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912301131.2C7C51E8C6@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 11:32:31AM -0800, Kees Cook wrote:
> On Mon, Dec 30, 2019 at 01:15:47PM -0600, Eric Biggers wrote:
> > 
> > The annotation needs to go in the .h file, not the .c file, because sparse only
> > analyzes individual translation units.
> > 
> > It needs to be a wrapper macro because it needs to tie the acquisition of the
> > lock to the return value being true.  I.e. there's no annotation you can apply
> > directly to the function prototype that means "if this function returns true, it
> > acquires the lock that was passed in parameter N".
> 
> Gotcha. Well, I guess I leave it to Will and Peter to hash out...
> 
> Is there a meaningful proposal anywhere for sparse to DTRT here? If
> not, it seems best to use what you've proposed until sparse reaches the
> point of being able to do this on its own.

What "Right Thing" are you thinking about?
One of the simplest situation with these conditional locks is:

	if (test)
		lock();

	do_stuff();

	if (test)
		unlock();

No program can check that the second test gives the same result than
the first one, it's undecidable. I mean, it's undecidable even on
if single threaded and without interrupts. The best you can do is
to simulate the whole thing (and be sure your simulation will halt).

As far as I understand, it was the intention behind Sparse's design
regarding locking ("context in sparse's parlance) to discourage
such code and instead encourage to write things like:

	if (test) {
		do_stuff_unlocked();
	} else {
		lock();
		do_stuff_unlocked();
		unlock();
	}

where it is easy to check localy that the lock/unlock are balanced.

So, of course Sparse could be improved to prove that some of the
conditional locks are equivalent to unconditional ones like here
just above (it already does but only for very simple cases where
everything is inlined) but I don't thing there is a RT.

-- Luc Van Oostenryck
