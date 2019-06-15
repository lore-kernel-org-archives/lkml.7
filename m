Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04FBC31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A721473
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 03:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="caV2ppNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfFODTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 23:19:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38361 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfFODTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 23:19:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id a186so2506256pfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 20:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ohI27hWKlZeyTou4jxbFvisXBc6aA90HwI9dkY1QQn8=;
        b=caV2ppNbM13y8pqFENQNjkwcKGxlz6VzXDAkKGCYFOzmrUN7h3MNb4N7ij9soUBLZ4
         h3F2V9oIYdn7bdnvxgqzQcG7zGMNSd5cWqN2mZYQWYINFZ1oXjz9VcVBhn74MGKAJg5E
         qZLKURfRAYzIcbwlIhCpR6AOOOaEsmvkXdeVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ohI27hWKlZeyTou4jxbFvisXBc6aA90HwI9dkY1QQn8=;
        b=p6LR1Woh9N1cez7EZ+qti5VRv+RNaUKDe/4O8oNS7aIWgOu7B6r2AwcaiZoXVn0xH5
         Qy06VNyWBFlcr1mCH6TDT0RcaQotYtHNE0jdStl1WLUPDb8n4/61FSBfbFtpMYHua09Q
         1yIpXCWLFZGfHA14DThBNtmu4DheaKBeaJmpvgFNH8pZ+0TQQW+WccheqHrhqHL4Pyij
         Oi0DOCku5MLW0TUdp1K8KJZIeHF8B8FpqJ5mqGnRCyXgvEISYF/BBwFUQ5rckolCvXs1
         ER6oQzqa9OJZe9G+JAJneguupp5lpdqd9M6bqhp6PQMltUNrQn0vXpeWmbT3Oc/GG95K
         NIIQ==
X-Gm-Message-State: APjAAAUWpFeU7TeiTwIelRUIq9DNfMlvuQeo1zFwNYcX1kAo00i6bxSo
        yw6DJoQAt09n2MWeYQ3iJ0dDMw==
X-Google-Smtp-Source: APXvYqz5G0o0BaZhozzI35wbaBfov30fOWbDKzqc9uQKDf97DAJ6vbKBBmGIgwBVZtZm+FcpfrSBAQ==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr13639176pju.127.1560568780179;
        Fri, 14 Jun 2019 20:19:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p68sm3708744pfb.80.2019.06.14.20.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 20:19:39 -0700 (PDT)
Date:   Fri, 14 Jun 2019 20:19:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/asm: Pin sensitive CR4 bits
Message-ID: <201906142012.C18377C5@keescook>
References: <20190604234422.29391-1-keescook@chromium.org>
 <20190604234422.29391-2-keescook@chromium.org>
 <alpine.DEB.2.21.1906141646320.1722@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906141646320.1722@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:57:36PM +0200, Thomas Gleixner wrote:
> Wouldn't it make sense to catch situations where a regular caller provides
> @val with pinned bits unset? I.e. move the OR into this code path after
> storing bits_missing.

I mentioned this in the commit log, but maybe I wasn't very clear:

> > Since these bits are global state (once established by the boot CPU
> > and kernel boot parameters), they are safe to write to secondary CPUs
> > before those CPUs have finished feature detection. As such, the bits are
> > written with an "or" performed before the register write as that is both
> > easier and uses a few bytes less storage of a location we don't have:
> > read-only per-CPU data. (Note that initialization via cr4_init_shadow()
> > isn't early enough to avoid early native_write_cr4() calls.)

Basically, there are calls of native_write_cr4() made very early in
secondary CPU init that would hit the "eek missing bit" case, and using
the cr4_init_shadow() trick mentioned by Linus still wasn't early
enough. So, since feature detection for these bits is "done" (i.e.
secondary CPUs will match the boot CPU's for these bits), it's safe to
set them "early". To avoid this, we'd need a per-cpu "am I ready to set
these bits?" state, and it'd need to be read-only-after-init, which is
not a section that exists and seems wasteful to create (4095 bytes
unused) for this feature alone.

> Something like this:
> 
> 	unsigned long bits_missing = 0;
> 
> again:
> 	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> 
> 	if (static_branch_likely(&cr_pinning)) {
> 		if (unlikely((val & cr4_pinned_bits) != cr4_pinned_bits)) {
> 			bits_missing = ~val & cr4_pinned_bits;
> 			val |= cr4_pinned_bits;
> 			goto again;
> 		}
> 		/* Warn after we've set the missing bits. */
> 		WARN_ONCE(bits_missing, "CR4 bits went missing: %lx!?\n",
> 			  bits_missing);
> 	}

Yup, that's actually exactly what I had tried. Should I try to track down
the very early callers and OR in the bits at the call sites instead? (This
had occurred to me also, but it seemed operationally equivalent to ORing
at the start of native_write_cr4(), so I didn't even bother trying it).

-- 
Kees Cook
