Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8619EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5846421873
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563988160;
	bh=JFMNq2ee+xriAoq6k+AUM2Q9PcGDapyRKWvWdJTeSZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gLcGar2aARLTmXBwuDOu0XlVQSsEhOXvMNRJTNj2pq9HyBzMrYNYzX+58MtVwtXxg
	 86O6mBvv07p5jIw4qz0LYaxfJUdd4Pg40p3ELnESviSUhvnxLMDl+ZRA57DjLFIB1/
	 Pe3z1PnT0Nx7q0E4oaghVD10/RjDT51+q8K4Sn9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfGXRJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:09:19 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43583 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfGXRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:09:18 -0400
Received: by mail-lj1-f193.google.com with SMTP id y17so20670693ljk.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8cl4nVt9icJqK0yFnx5TQc7gNHvGEAy+pPaBq+pmC0=;
        b=cBh9ReMV8eGmBOSMW8Zb37lV8BeNSV/1KWRwZgRg4j0iO5KN3WnhA2Qu32ZWEKD+eQ
         EXrde2G7KNiEvgfnjmcRw4+n9RJPOxSJ6KCiK+lXaNn2j190ZQQ0Dnj+r9+0owvXalW+
         XrJXduBhJmMLWWMH9L/vZIpTPzMtHlHQbeDsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8cl4nVt9icJqK0yFnx5TQc7gNHvGEAy+pPaBq+pmC0=;
        b=cDWNq5N+E+TxYsk3IYKAWoth78u9ofh8pEe6U3x+qDInmqZs/OEMlLUPLx0p77hzXW
         8+DYxPxhnbTidi276KHJiahAY0HdBg4aTFg/EyfVuKvabVukfFD2YQJXKyNUQ3CP2fKM
         YX42J8zCrco7Y2eB7dQR29aMVH3ph7FUJbtISiDPyxOKA74ShyhTEh1IXdpTEOnYgdB0
         86wwBCEvGE5wcSYOIVNN6F4nM5q4i+bn1DxUP9TFKUTVv4tWvtU338NZhx1/y7Z9/zm3
         V4BjdPk/TEqTiS1a7kS9nX10X5e2I+RKjs/e3Vkb4cLTMFwvCSZkRKIqBNLjbE/xIEg8
         TjxQ==
X-Gm-Message-State: APjAAAWejZHljTk9XarzaRisY3WoXAuHXYWqVvov0F31Oj3tbDMk9blz
        uB2rmk9tQ0aqwJySxFXjRvE5ZoBNGeo=
X-Google-Smtp-Source: APXvYqwISId4+jaVbcAonk6H2ssnpDij+cc5Il+I585lZfWe+PUVS0Eph2bDkscrlW2G6+u8CJABcg==
X-Received: by 2002:a2e:86c1:: with SMTP id n1mr43123719ljj.162.1563988156207;
        Wed, 24 Jul 2019 10:09:16 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y25sm9632853lja.45.2019.07.24.10.09.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:09:13 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id i21so45253653ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:09:13 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr44754092ljj.156.1563988153239;
 Wed, 24 Jul 2019 10:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563841972.git.joe@perches.com> <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk> <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
 <bc1ad99a420dd842ce3a17c2c38a2f94683dc91c.camel@opteya.com> <396d1eed-8edf-aa77-110b-c50ead3a5fd5@rasmusvillemoes.dk>
In-Reply-To: <396d1eed-8edf-aa77-110b-c50ead3a5fd5@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jul 2019 10:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPA-Vv-OHbUe4M5=ygTknQNOasnLAp-E3zSAaq=pue+g@mail.gmail.com>
Message-ID: <CAHk-=whPA-Vv-OHbUe4M5=ygTknQNOasnLAp-E3zSAaq=pue+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 6:09 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> The kernel's snprintf() does not behave in a non-standard way, at least
> not with respect to its return value.

Note that the kernels snprintf() *does* very much protect against the
overflow case - not by changing the return value, but simply by having

        /* Reject out-of-range values early.  Large positive sizes are
           used for unknown buffer sizes. */
        if (WARN_ON_ONCE(size > INT_MAX))
                return 0;

at the very top.

So you can't actually overflow in the kernel by using the repeated

        offset += vsnprintf( .. size - offset ..);

model.

Yes, it's the wrong thing to do, but it is still _safe_.

              Linus
