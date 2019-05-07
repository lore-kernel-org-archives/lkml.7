Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEBFC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2409A20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfEGH11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:27:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36465 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfEGH11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:27:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id b18so13974024otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 00:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XByBP7XjRmOOGyhrd0e8L2R6PtcwPlhf6jPxirpwBCU=;
        b=Org/vN8ofFyt7RhfVf4tr5nRzJZei9fqx1pbXJRgo4idctdjx1fgYtQ/zTgNFADxfr
         kLIFozauuH6M9lQaJW+3jlFXaUEX16UO1E7uhpcg8ZPVF1yOXJo5sUDh2FMe2rUe9CIw
         RuUt2xSt69N1BsAU3LF2H9smz6RO9X8xwiaOoJzU3dY3KjAuAiF/Rio/HAqP2VH0Nioc
         gdruqBKt3OSKHFqwyE/3Uo3zGWROHYw4zUrp+am6A4qvCG9kz0UwHjJnbjq1pP1kLEMS
         r9yhPSE2I8nbxfGa8gwYsWotrfzg0XHKWKbflnRh/2ryQJdFQsxJevziCH8d5D1wpsXn
         8RXA==
X-Gm-Message-State: APjAAAXK9ipyRKifqSGd8hK+9NIq0FT4XAyWdm+o3Lt/aYVm1YY5VxSN
        zaCMgptUwyK1sDK0sWimdM8=
X-Google-Smtp-Source: APXvYqyG6hXWXWpi7XEBI/DlyfoNWcZlsC+PlPheQwnNUwyImO+kZSLDKaxa2x4xmrLvZ3a+smTnDA==
X-Received: by 2002:a9d:6c5a:: with SMTP id g26mr10914341otq.187.1557214046204;
        Tue, 07 May 2019 00:27:26 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id s26sm4968147otk.24.2019.05.07.00.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 00:27:25 -0700 (PDT)
Date:   Tue, 7 May 2019 00:27:21 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Daniel Colascione <dancol@google.com>,
        kernel-team <kernel-team@android.com>,
        Todd Kjos <tkjos@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Suren Baghdasaryan <surenb@google.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190507072721.GA4364@sultan-box.localdomain>
References: <20190317114238.ab6tvvovpkpozld5@brauner.io>
 <CAKOZuetZPhqQqSgZpyY0cLgy0jroLJRx-B93rkQzcOByL8ih_Q@mail.gmail.com>
 <20190318002949.mqknisgt7cmjmt7n@brauner.io>
 <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507070430.GA24150@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507070430.GA24150@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 09:04:30AM +0200, Greg Kroah-Hartman wrote:
> Um, why can't "all" Android devices take the same patches that the Pixel
> phones are using today?  They should all be in the public android-common
> kernel repositories that all Android devices should be syncing with on a
> weekly/monthly basis anyway, right?
> 
> thanks,
> 
> greg k-h

Hi Greg,

I only see PSI present in the android-common kernels for 4.9 and above. The vast
majority of Android devices do not run a 4.9+ kernel. It seems unreasonable to
expect OEMs to toil with backporting PSI themselves to get decent memory
management.

But even if they did backport PSI, it wouldn't help too much because a
PSI-enabled LMKD solution is not ready yet. It looks like a PSI-based LMKD is
still under heavy development and won't be ready for all Android devices for
quite some time.

Additionally, it looks like the supposedly-dead lowmemorykiller.c is still being
actively tweaked by Google [1], which does not instill confidence that a
definitive LMK solution a la PSI is coming any time soon.

Thanks,
Sultan

[1] https://android.googlesource.com/kernel/common/+/152bacdd85c46f0c76b00c4acc253e414513634c
