Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3924C2D0D1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983FA24650
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613837;
	bh=M1c/O0iDEk6T8Gfqt4f5ZxzFfCgxZMruJbN2xwoze1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RKqG3Euan4BHLq5A2Rodtxuvf+fZlyT0xfa6d20b1w5nhqlK/FeOg+2ubfNyYrupd
	 WDDPf7zqDsOobR+OFj+MFR6ENaE/ncskMSRWfMonkuiUSoF8JjHp/6/GsBidcQTmt0
	 TxxN5N8ApNSuiXK3I/FNGccB2ODMJ+/gLC7a4zj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfLQURQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:17:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36471 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfLQURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:17:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so7909630lfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XAjeERk50YhDeYT1JOW5M/FgClTa6Imxci6PQByuhDw=;
        b=BpI4Cx3VyDVOZ4EPyO3hjdxg3/2CzYOdLTwYIUHWWCcq73CwUM4wszAAN+ldrL0+bB
         8R+3ipV3FaxJu6uIhbljBiAFWXXU7/pTjyoWd7Ae/vpY9V90ICMAADQnOReqmRb24gtP
         cxBovGWS7tf3AdnmbqcJp9hkDnBrrMHrEiOh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XAjeERk50YhDeYT1JOW5M/FgClTa6Imxci6PQByuhDw=;
        b=JdIEirkOjO/ZcLBcHz5jmNXZjPqhwrDCluG+AXI3+NHCxKDAjsUCc8JYwnQOnGBJHG
         9MypAi7ZLz3wWnvCo9Z1PuNQQO+qZu6M+z4w2YsgoMx76vU6h/A1m/0SwSZqd2Z2u19s
         4XjJ+f76Z5qFvoqPoZfWLsYGMwlEA8f1TFSas9g3G4cyDmscqT2UoJz7NL/o1k1hzXGk
         K/XexScaTYm8GSZK+gfgudWIa636hb0h3ZF9nEUdMk/y2n3H8v5wi9l8ue9dH+XrUsgL
         hIc/aaaZoBPiHTUnL5C1IdJqNjoR0usq+DuMmYfle+8Y2GrN+lKvkQ/TauMZp0OTA8Ay
         enXA==
X-Gm-Message-State: APjAAAXUxdm7wSgYCgG+dgnxpx1aj9k/bb26KaARPbkeDplSj/6kNYZ6
        DXmwFbH8KHSxXvesNcG/YR5lmEEPQkk=
X-Google-Smtp-Source: APXvYqxnwDS0O41sCJ5xZUI3g+3lBkZ1oaBI/xz2/dHVAfxRMXXFRrFjAfVyjEq51oizvfLdFf3pPw==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr3851949lfc.92.1576613829904;
        Tue, 17 Dec 2019 12:17:09 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m13sm11173505lfo.40.2019.12.17.12.17.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 12:17:09 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 15so7918564lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 12:17:08 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr4008826lfo.134.1576613828695;
 Tue, 17 Dec 2019 12:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20191217115547.GA68104@gmail.com> <CAHk-=wiVZMU69qB7nmkkyvjtDenQ+89V94V=3mmdY88uWYrZiQ@mail.gmail.com>
 <20191217193039.GF2844@hirez.programming.kicks-ass.net>
In-Reply-To: <20191217193039.GF2844@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 12:16:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgH8bSsgxnUAjuoUyDwHPKZwdVirH__=mJQu7RCFfCwZA@mail.gmail.com>
Message-ID: <CAHk-=wgH8bSsgxnUAjuoUyDwHPKZwdVirH__=mJQu7RCFfCwZA@mail.gmail.com>
Subject: Re: [GIT PULL] timer fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> What alternatives are there? That is, we normally only use HPET to
> double check nobody messed up the TSC.

The thing is HPET seems to be _less_ reliable than the TSC we're
checking these days.

If that's the only use-case for HPET, we should just stop doing it.

> We can't just blindly trust TSC across everything x86.

No, but we can trust it when it's a modern CPU.

The HPET seems to get disabled on all the modern platforms, why do we
even have it enabled by default?

We should do the HPET cross-check only when we know the TSC might be
unreliable, I suspect.

           Linus
