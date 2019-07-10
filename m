Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59D0C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A762086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvPQbZEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfGJPqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:46:08 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:44922 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfGJPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:46:07 -0400
Received: by mail-wr1-f49.google.com with SMTP id p17so2976092wrf.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KxY4HdGn+JBikXMjPRoVFYwUizM9J6xdE3k9w37RmQ=;
        b=TvPQbZEFfZRU3q8st2eKFVhA8cTKUj1CNmsgxkDTtPLo8XhZyPlvewn1WrDXQjq5nB
         jMMKtEOFQao6RtTegCYbn8xZZmyUhs91OeGCqqMRIixmsr1p2dMHZhGSYMOOGxPHWTf+
         4PIbrthpitm3IYTnZiKd36JUSmukie/YE+pF0g/I26KfK+JESCAaCclIdc4hlR3In82k
         S+hUB8zuWEkJM2UhuiexJrMH8/vlnAvqNLwDAq7G75JuZwIunt4oJbtzlqUeLvUN94Bb
         m0u3qkAqUMxDun9N+V7Gu65gN6ocZGnr3bqooozLKKiRLaFjZmUFAZnU9FI7gcgADr85
         s3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KxY4HdGn+JBikXMjPRoVFYwUizM9J6xdE3k9w37RmQ=;
        b=QQWZygj/q2dxWtHu8Hu5FGtrbb9ccl6OoG1W4O+iKhCyY4tbUt0O0EUTjwAi4s3waL
         rADIOXiWUoTIPUkRkY1ErNfGRgTdzwQw4Kam+l85ksxPzTYuNnRREZXCzifthSjT2w5s
         qx6VoG2Z+jV2xngz7c0jLAcNG1BAFBfs39Hr808VDXcfZOuPIWub5QkSSX6VjGqqA/S4
         1J/fUejwj5j5qEFbNHefFmeBsmOJBXVX3H1FKnImtx2aFKoXK5PyYq6bgFmugBpgHAth
         siXXCIWmoVfUqmLhx0WsURq6BaAkZ8CG83l0vi3mZNaUdM+a5kczwmuUKIl+ZD8LeJc8
         Lt9w==
X-Gm-Message-State: APjAAAUK9BQswIEO7JF71SMHiw2QPeH8MVA1naWWHKqASWB1PaDmTgIy
        +GFWuix/qC5pdCyVJqT00ioabbnQmEVSkFHH1HX38Q==
X-Google-Smtp-Source: APXvYqxnnSDTACHlYuPmxTfLY3bbaScFXMa+P+OX8aWMleEDD5IR1Uyu3tshmJYF74rvN5I8DePvvxVcEM6oCFO0fN8=
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr12476265wro.284.1562773565701;
 Wed, 10 Jul 2019 08:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190708115349.GA14779@gmail.com> <CANcMJZAYhqdO5sGbwW7GszL9NtNgMy0+uMe+bVSQHqyewQcy_g@mail.gmail.com>
 <20190710105736.GK3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190710105736.GK3402@hirez.programming.kicks-ass.net>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 10 Jul 2019 08:45:54 -0700
Message-ID: <CALAqxLXKVsCsUq3HHs0LuPFd6_aA4S0bBR4vp-xDiRKgEDnoAw@mail.gmail.com>
Subject: Re: [GIT PULL] scheduler changes for v5.3
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 3:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Urgh.. however didn't we find that before :/ stupid stats.
>
> Something like the below ought to fix, but let me see if I can come up
> with something saner...

Yep. This works for me, but let me know if you have anything else you
want me to test as well.

thanks again!
-john
