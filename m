Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BEC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCED520715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 17:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6z20UaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgAFRzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 12:55:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52518 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAFRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 12:55:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so15911903wmc.2;
        Mon, 06 Jan 2020 09:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vjAnTqnyYDsojY81CidHO5cyS8TO9xjXn3TKtmGerFk=;
        b=T6z20UaRrFmnrbUyiy+mHxDezojhLXlh7hgeFh/aF2hkWRPxHeVPthL/Ew0DWiQy/s
         IQlul1zUabH9uKrZKnUepn2r4SaHnN1Kg2G0At5fCXvhl7IHgDpvEKLl4AXT6vHfzDaq
         Yo0c+qCBLyQhSAB6dqLtlNGhJlmr7rpANLwmzDUWHKE+hgZgavVFd9BnKIt+y44qLxAb
         VdSL1VfCz3xLmcYNXnDSyXV6byjOI946tysgOrGGCQSVgfZVauTf0J+3Rq68zV+OGSU1
         8UN11wmOktzxjq15Ck1OG1f5jKAgurQX7Qa3PbM+wwDDeASN+KnbV5Iq1uV0zr9pzoz7
         q8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjAnTqnyYDsojY81CidHO5cyS8TO9xjXn3TKtmGerFk=;
        b=STkDYvABIrvKXbMAmjlPF4HqBjtStg3/hJjHYvM4u5GtOoZzMlXhWCy3nYHvbzejOX
         3hEwn1QB1ZvrKk2BxEBL13zQJHcl4aEMmuxLkSSZRMQIhiY+vEAZmGh8dKSJ19q0oSDy
         0geOCAAIdPLlGhEIZO/enn1JQF5RffYBKZ4l55++kxFL00l3g6hjy2Ou4T9fsPU+9xgs
         pt/EdThHDUR6MXfZQIrkJUZfvvctXR5vQcYkrnsLnPZYZ7MPcoFi3IbGdQ2fWlxCijOn
         dMLL9pI8vr2VIaTwYMV1mdBweJrd0fkfupxeGTV5dWLp38f9HWLjOSmpN0jlbfayE6bm
         /D+Q==
X-Gm-Message-State: APjAAAVC5zKm7acI/lpjJmS140MeaOKNKnmoiFgVIjjLcCfotqUCEgo+
        W9CvDzvSibQ5foJugWq0RPQ=
X-Google-Smtp-Source: APXvYqwPymLgT6RXmbgP+qXyLmGY4VlaPE4NBuq2WMV/hlgF3pRFMWeNI7PixFZJhLcwDsY9mSG3kw==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr34005535wma.72.1578333301903;
        Mon, 06 Jan 2020 09:55:01 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40c7:f800:685b:86a3:90af:d97])
        by smtp.gmail.com with ESMTPSA id s1sm24420828wmc.23.2020.01.06.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 09:55:01 -0800 (PST)
Date:   Mon, 6 Jan 2020 18:54:59 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <20200106175459.tjuhmdrsusax3s4z@ltop.local>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
 <201912301131.2C7C51E8C6@keescook>
 <20191230233814.2fgmsgtnhruhklnu@ltop.local>
 <20200106154119.GV2810@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106154119.GV2810@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2020 at 04:41:19PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 31, 2019 at 12:38:14AM +0100, Luc Van Oostenryck wrote:

...
 
> Not quite what we're talking about. Instead consider this:
> 
> The normal flow would be something like:
> 
> extern void spin_lock(spinlock_t *lock) __acquires(lock);
> extern void spin_unlock(spinlock_t *lock) __releases(lock);
> 
> extern bool _spin_trylock(spinlock_t *lock) __acquires(lock);
> 
> #define __cond_lock(x, c) ((c) ? ({ __acquire(x); 1; }) : 0)
> #define spin_trylock(lock) __cond_lock(lock, _spin_lock)
> 
> 
> 	if (spin_trylock(lock)) {
> 
> 		/* do crap */
> 
> 		spin_unlock();
> 	}
> 
> 
> So the proposal here:
> 
>   https://markmail.org/message/4obybcgqscznnx63
> 
> would have us write:
> 
> extern bool spin_trylock(spinlock_t *lock) __attribute__((context(lock, 0, spin_trylock(lock));

Well, allowing arbitrary conditions would be hard/impossible but you're
only asking to have the *return value* as condition, right? That looks
as reasonably feasible.

> Basically have sparse do a transform on its own expression tree and
> inject the very same crud we now do manually. This avoids cluttering the
> kernel tree with this nonsense.

So, a call of a function declared with __acquires() or releases() is
interpreted by Sparse as if the call is immediately followed by an
increase or a decrease of the context. It wouldn't be very hard to
add a new attribute (something like __cond_context) and let Sparse do
as if a call to a function with such attribute is directly followed
by a test of its return value and a corresponding change in the context.
It would boil down to:

	extern bool spin_trylock(lock) __cond_context(lock);

	if (spin_trylock(lock)) {
		/* do crap */
		spin_unlock();
	}

behaving like the following code currently would:

	extern bool spin_trylock(lock);

	if (spin_trylock(lock)) {
		__acquire(lock);
		/* do crap */
		spin_unlock();
	}


Would something like this be satisfactory?

-- Luc
