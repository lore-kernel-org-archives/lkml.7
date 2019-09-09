Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE4C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D16218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 22:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568069881;
	bh=ieeg6N6SsihmRHhWQlCf1jmFz+Sgb4qasTIFr0xv6gA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L+bP4cFtA4HTr7zzFK5qtKi845JYZhQi0h1qFiUT/4hDA2r+KPMbEbbW2gGX0+L4D
	 4dZm7Rts/Lay4pV9PC0a6PrJqSru60MxuWPgwnTbIKCf4nzZDeLPTWUbYUcSpy8H0V
	 fzF5VZ4an5fASKOlhloU9jpRQLfkg9ZPBme/jc7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfIIW6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfIIW6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 18:58:00 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0040E21D6C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2019 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568069879;
        bh=ieeg6N6SsihmRHhWQlCf1jmFz+Sgb4qasTIFr0xv6gA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wOkecgI6RV5u48hhm18hrdmLwRuIBtqKQvwSlxoVggDjsyRThZrK66u2E93WU72eJ
         18g74to+p/vEDPnTM1uZ8MNegAtf84hOMyg1KFpY26vJO32kjrQeq/7ummR/JH0Acw
         A3diqOt9xrXDecZUJaH1VITNcNHmEZg4Nc7KDxjc=
Received: by mail-wr1-f48.google.com with SMTP id q17so11588809wrx.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 15:57:58 -0700 (PDT)
X-Gm-Message-State: APjAAAXAEg14awcH+k1HbmTgI3CE4AR+rYiQeE8Ne2ep/dRPtOZsRXkc
        5MiDVYlbdrGhHFeYu4E8n6myVC+UH9hieGF5RxtCqw==
X-Google-Smtp-Source: APXvYqwkK4QYU7FXrwSlH8ZO670dJg2wunQHvsqAekznrEWS6XGJSzG1Dw13PoaDb1OrneVUtTBLg8BHjXXLm7S3QWQ=
X-Received: by 2002:adf:dcc4:: with SMTP id x4mr13767482wrm.221.1568069877467;
 Mon, 09 Sep 2019 15:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567126741.git.luto@kernel.org> <20190909094230.GB27626@amd>
In-Reply-To: <20190909094230.GB27626@amd>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 9 Sep 2019 15:57:46 -0700
X-Gmail-Original-Message-ID: <CALCETrXfDSjgNieM3Q9bVH-7gAePXT=SXWxvzOsyb8xp_2ymQA@mail.gmail.com>
Message-ID: <CALCETrXfDSjgNieM3Q9bVH-7gAePXT=SXWxvzOsyb8xp_2ymQA@mail.gmail.com>
Subject: Re: [PATCH 0/7] Rework random blocking
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Lutomirski <luto@kernel.org>, Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 9, 2019 at 2:42 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-08-29 18:11:35, Andy Lutomirski wrote:
> > This makes two major semantic changes to Linux's random APIs:
> >
> > It adds getentropy(..., GRND_INSECURE).  This causes getentropy to
> > always return *something*.  There is no guarantee whatsoever that
> > the result will be cryptographically random or even unique, but the
> > kernel will give the best quality random output it can.  The name is
> > a big hint: the resulting output is INSECURE.
> >
> > The purpose of this is to allow programs that genuinely want
> > best-effort entropy to get it without resorting to /dev/urandom.
> > Plenty of programs do this because they need to do *something*
> > during boot and they can't afford to wait.  Calling it "INSECURE" is
> > probably the best we can do to discourage using this API for things
> > that need security.
> >
> > This series also removes the blocking pool and makes /dev/random
> > work just like getentropy(..., 0) and makes GRND_RANDOM a no-op.  I
> > believe that Linux's blocking pool has outlived its usefulness.
> > Linux's CRNG generates output that is good enough to use even for
> > key generation.  The blocking pool is not stronger in any material
> > way, and keeping it around requires a lot of infrastructure of
> > dubious value.
>
> Could you give some more justification? If crng is good enough for
> you, you can use /dev/urandom...

Take a look at the diffstat.  The random code is extremely security
sensitive, and it's made considerably more complicated by the need to
support the blocking semantics for /dev/random.  My primary argument
is that there is no real reason for the kernel to continue to support
it.

>
>
> are
>
> > This series should not break any existing programs.  /dev/urandom is
> > unchanged.  /dev/random will still block just after booting, but it
> > will block less than it used to.  getentropy() with existing flags
> > will return output that is, for practical purposes, just as strong
> > as before.
>
> So what is the exact semantic of /dev/random after your change?

Reads return immediately if the CRNG is initialized, i.e reads return
immediately if and only if getentropy(..., 0) would succeed.
Otherwise reads block.

--Andy
