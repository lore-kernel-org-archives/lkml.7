Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A7EC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1890B2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gRrhkgmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfGYUDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:03:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34097 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfGYUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:03:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so23284029pfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHw7zEXiXiWuFCeMIM1DoPEM5lUo8QWt7fmyIitbzd4=;
        b=gRrhkgmXX57rpW/eOfU07DHgYIRJaSRHWUMLcqkuazmJ9eSgJ3ejVn/JebuAtKVADk
         Es6uzHuBitkmgkTqzHq1W3PJ0BRywQ0CY27gZ/QC9xT0zl4goLkz+41D93WnbaD1uMqw
         G/fn+b5k6gja9lg/U079hwILSubBD+sUO58DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHw7zEXiXiWuFCeMIM1DoPEM5lUo8QWt7fmyIitbzd4=;
        b=WC9jtQvMhw2pHOFzAiV2dQ0dzBVlCPLvnrmPH0doer43T2avmKM59ife63j8sFE03z
         yW28s738ECGJ9GX/QjTRVE/4F17HX4wW/ARZhnp6d4kwa/VrwgLKfxM08n3cqqbhDcKu
         X/nwOYPlDUVPbyLeSLmt3boxSJc2REJod+08UpA6FvSol+VWApFwrwYf0tGstz3+J1HD
         3v4kOnrQHNlLnMglBlWig4VY4TNdYNIE8GZajk+FE5ekUIGtDTLnuc8M9xzfwjkF32Hb
         ndmXPL0ndybM2p6Jl5BRh5J/cOiQ97h/XhDKcZcW7yMR08Z4mIdXU1zapThBUpP7s8Pi
         B7eg==
X-Gm-Message-State: APjAAAUQJwf3Sn/d1pde1xEtyE1Ognkb/JMa1VTp6uS1gbONLBUCbgbK
        DoZEjZaaBswW0YZTBnafMy3+Rg8Sr5c=
X-Google-Smtp-Source: APXvYqyiwJnHa4FCVMLcBfvKJWud2kqtfpMi3xvkqMN2IoBqOPCPGL/0CNp1/3L5rVvFG+E3R3tlcw==
X-Received: by 2002:a63:a302:: with SMTP id s2mr18456663pge.125.1564085012343;
        Thu, 25 Jul 2019 13:03:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p65sm50026998pfp.58.2019.07.25.13.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 13:03:31 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:03:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yann Droneaud <ydroneaud@opteya.com>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
Message-ID: <201907251301.E1E32DCCCE@keescook>
References: <cover.1563841972.git.joe@perches.com>
 <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
 <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
 <bc1ad99a420dd842ce3a17c2c38a2f94683dc91c.camel@opteya.com>
 <396d1eed-8edf-aa77-110b-c50ead3a5fd5@rasmusvillemoes.dk>
 <CAHk-=whPA-Vv-OHbUe4M5=ygTknQNOasnLAp-E3zSAaq=pue+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPA-Vv-OHbUe4M5=ygTknQNOasnLAp-E3zSAaq=pue+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:08:57AM -0700, Linus Torvalds wrote:
> On Wed, Jul 24, 2019 at 6:09 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > The kernel's snprintf() does not behave in a non-standard way, at least
> > not with respect to its return value.
> 
> Note that the kernels snprintf() *does* very much protect against the
> overflow case - not by changing the return value, but simply by having
> 
>         /* Reject out-of-range values early.  Large positive sizes are
>            used for unknown buffer sizes. */
>         if (WARN_ON_ONCE(size > INT_MAX))
>                 return 0;
> 
> at the very top.
> 
> So you can't actually overflow in the kernel by using the repeated
> 
>         offset += vsnprintf( .. size - offset ..);
> 
> model.
> 
> Yes, it's the wrong thing to do, but it is still _safe_.

Actually, perhaps we should add this test to strscpy() too?

diff --git a/lib/string.c b/lib/string.c
index 461fb620f85f..0e0d7628ddc4 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -182,7 +182,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 	size_t max = count;
 	long res = 0;
 
-	if (count == 0)
+	if (count == 0 || count > INT_MAX)
 		return -E2BIG;
 
 #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

-- 
Kees Cook
