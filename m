Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04973C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBFC520409
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 19:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkahppR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfL3Tce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 14:32:34 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44776 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Tce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 14:32:34 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so11368142oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 11:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6mnPArXVUk5NY3MI/fMB8A3scIm3goC7mWuXENXONpo=;
        b=XkahppR7fiPelU38s2oc6VHlUkE19zDKWP3W+dxmOoKAlnggLFV/znh9+hnxZBrWZH
         /2cK9lgyDBUqb9XwDQky7jRkkBcjIH5hl8M4S/ABxhfkRSuOE/3ZFQkTtjsVlrZfqiKi
         31pYC4F0pphDH4o3KamEwnD0Tk3UQM0qloFD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6mnPArXVUk5NY3MI/fMB8A3scIm3goC7mWuXENXONpo=;
        b=C6eNeSCpv3CxVg8waXXE0K2HU7BEHmXdjhfslZ3xTOmYDr8Gv9IoX892+l+KSGr9UI
         WTgjCiZtkFe85lNQw0eYAsLQj6nz6KOTo4l3+8CURfvNvwIyvS83zKh31eOIqDvsSs4z
         4G9ijPZ61h5R5AmoJL77TqIgnOzgnGQOGb4q8mSunWM6LIdfOwfjRfx44VYMN2Fs6VV1
         aHaOyfNPKGhZIOYFgtuSmTVd0/LX9DnLNPJhcT/viIZRbbpso8eOeqZ7xo4rtaW+Jzli
         dolerQGjF7xwv3yLSDYkDfa7Sr2ahAkp7dfoie0onEWWhsOw+VKmL6CquxHlH6wUYv8N
         rgRQ==
X-Gm-Message-State: APjAAAUeZ86mEtXWFQOmIz3G3QRb70b0Oj77F7iyn/8R0rCWHD+hwPzt
        WS8cAsIKqFvrkg7RtVssAu+tckdpQzI=
X-Google-Smtp-Source: APXvYqxIDhoXbMpWVw7/T6spGcnSRDIY/Nh0Ftwjv/suu8fnq/ZLmVpP5GF1Y3dRdXjRYF/9VGF56A==
X-Received: by 2002:aca:889:: with SMTP id 131mr289832oii.3.1577734353418;
        Mon, 30 Dec 2019 11:32:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w6sm11220589oih.19.2019.12.30.11.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 11:32:32 -0800 (PST)
Date:   Mon, 30 Dec 2019 11:32:31 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <201912301131.2C7C51E8C6@keescook>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
 <201912301042.FB806E1133@keescook>
 <20191230191547.GA1501@zzz.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230191547.GA1501@zzz.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 01:15:47PM -0600, Eric Biggers wrote:
> On Mon, Dec 30, 2019 at 10:43:20AM -0800, Kees Cook wrote:
> > On Sat, Dec 28, 2019 at 12:49:18PM +0100, Peter Zijlstra wrote:
> > > On Thu, Dec 26, 2019 at 09:29:22AM -0600, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Wrap refcount_dec_and_lock() and refcount_dec_and_lock_irqsave() with
> > > > macros using __cond_lock() so that 'sparse' doesn't report warnings
> > > > about unbalanced locking when using them.
> > > > 
> > > > This is the same thing that's done for their atomic_t equivalents.
> > > > 
> > > > Don't annotate refcount_dec_and_mutex_lock(), because mutexes don't
> > > > currently have sparse annotations.
> > > 
> > > I so f'ing hate that __cond_lock() crap. Previously I've suggested
> > > fixing sparse instead of making such an atrocious trainwreck of the
> > > code.
> > 
> > Ew, I never noticed these before. That is pretty ugly. Can't __acquire()
> > be used directly in the functions instead of building the nasty
> > wrappers?
> 
> The annotation needs to go in the .h file, not the .c file, because sparse only
> analyzes individual translation units.
> 
> It needs to be a wrapper macro because it needs to tie the acquisition of the
> lock to the return value being true.  I.e. there's no annotation you can apply
> directly to the function prototype that means "if this function returns true, it
> acquires the lock that was passed in parameter N".

Gotcha. Well, I guess I leave it to Will and Peter to hash out...

Is there a meaningful proposal anywhere for sparse to DTRT here? If
not, it seems best to use what you've proposed until sparse reaches the
point of being able to do this on its own.

-- 
Kees Cook
