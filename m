Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60B6C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797A320722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="miQbznhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfL3SnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:43:23 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40943 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3SnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:43:23 -0500
Received: by mail-oi1-f195.google.com with SMTP id c77so10889590oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0adwBdSRSa0FPlcHU/hDxd1UBJTeWDvsTu8kZ2SuRTE=;
        b=miQbznhXk4hpJLs9TcBUiYHUMqvyBjkzSpnTZ/iMbNqkp3pk8S0SXEYs64hBCJ+Sr7
         sXpKy0oPmtnQD08YMpJc3AdzAGrQ8OyyBzMVjAocsuaSrzYLGLgI63lFnojCFn7PhF76
         GP6X/TpOvGbiKF8fUbGuazgouU5seKq+5aaRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0adwBdSRSa0FPlcHU/hDxd1UBJTeWDvsTu8kZ2SuRTE=;
        b=VsN8BH+N9Wz03mO2123q2E77W5aLJL4YN3lH4ePKY/57cJksL39eKHUjWghgjHNLCh
         lBXzXPT4fKuwbSJWGknPJw3meEIra1N17uTmLOZlOKY9lJPHdEHIh2XBDyeS06RkDdbK
         qxNlfzBiKvQ1/uLk3j7jLQRq/IJUdGCPvNWEapEVP1I9CjqeWsiZQ30lnc3DimNG15t0
         Z2PWAqIN63qQ7CydQijRTYeELoOgZSLb/Hdxja2iOAUXXMVk/GHfjsq7ZicMERnt2XmS
         iRhpMV5yihgmNYOOe4B2+BD3sImNDJwgwDrGGtt4uI6D2II2DXVJV920SNFelhicDg30
         S32Q==
X-Gm-Message-State: APjAAAW47h+0I9x4+kKfBsdoFmdZvSXtWtqxR1WTkGWkq7wnCP2lISFv
        xWFvirgJQOavJa5RpNzp/JcVJ3erJxA=
X-Google-Smtp-Source: APXvYqzRxZzmCKgfcf8udIzsEWn6j042rNmANRxWEQ+IbB9IZGOyjs3aXur4H2Y3DdUM9DtVY8FeVQ==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr233710oiz.120.1577731402330;
        Mon, 30 Dec 2019 10:43:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 17sm15966152oty.48.2019.12.30.10.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:43:21 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:43:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] locking/refcount: add sparse annotations to dec-and-lock
 functions
Message-ID: <201912301042.FB806E1133@keescook>
References: <20191226152922.2034-1-ebiggers@kernel.org>
 <20191228114918.GU2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228114918.GU2827@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 12:49:18PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 26, 2019 at 09:29:22AM -0600, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Wrap refcount_dec_and_lock() and refcount_dec_and_lock_irqsave() with
> > macros using __cond_lock() so that 'sparse' doesn't report warnings
> > about unbalanced locking when using them.
> > 
> > This is the same thing that's done for their atomic_t equivalents.
> > 
> > Don't annotate refcount_dec_and_mutex_lock(), because mutexes don't
> > currently have sparse annotations.
> 
> I so f'ing hate that __cond_lock() crap. Previously I've suggested
> fixing sparse instead of making such an atrocious trainwreck of the
> code.

Ew, I never noticed these before. That is pretty ugly. Can't __acquire()
be used directly in the functions instead of building the nasty
wrappers?

-- 
Kees Cook
