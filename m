Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A982DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D030920828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IbOnWEIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391628AbfIEUck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:32:40 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43274 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732067AbfIEUci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:32:38 -0400
Received: by mail-pf1-f180.google.com with SMTP id d15so2640644pfo.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 13:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9Qg9Nx9cB8xbkR8DKdOAVsSOg4Sv7dm0VDOXeMKcPY0=;
        b=IbOnWEIBTTnLr6Qjzx8Q/qiwu1YjeDw/fAU8Wi+CLeKz6PLqIYno0eLNOXvHeqII0L
         mR7ZDkT4BkZqUWnQ19YpqPwPX8/3ISYlGhE4T+7jqHNjOd5ZFYZT99pfspwNI9LmgV+f
         BQBeWKRzTtYdG1bLx5gAMkxg8Z8JqUhar5QWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Qg9Nx9cB8xbkR8DKdOAVsSOg4Sv7dm0VDOXeMKcPY0=;
        b=bfnuG32c0N/M1fFsHgjf0fbW0FzAwM2gXoxyGjib0Ge1y5FGYv9LjumPXTjYP0GYbQ
         CefDo70ErtmAZiauqU0+lM01gYiXQSw+P354P/O3P234vRkjURsxhkBy68ogtcizC9bj
         qmbz1R5RyQhf1KszbNZKGe1K9kLyeJ3hqllaqvMVCL1Q1pIUwg2jN/uMj7zbQs+ArWCu
         W8ghdEFCHKI8fm1AaqOhDLqenu+fiHdB6hXjDo8GDUyBKySeU8t1J7E/QqL9bQmJ6lXq
         ZWjeECs4HWIpYpfD99GG0VqXk/RminD9IMhYc5dgrauLSjsmeKaYajOchl3sxFnwrlJb
         ySsg==
X-Gm-Message-State: APjAAAXlAmbF/vcBiDOFjfWTm4bMs94CVilSuI1ZNsDwOIXLTHEUK/ik
        fzr6UkGxwu+hxqyMz3xaWN2zmR+0uUA=
X-Google-Smtp-Source: APXvYqyxyG2EMP43A7GhAfSk50z92dCDPc7fGQjDpr3deWAvBvUb/4Tj6uICFqn1E/I9o24JfVA7BQ==
X-Received: by 2002:a62:e910:: with SMTP id j16mr6390586pfh.123.1567715557465;
        Thu, 05 Sep 2019 13:32:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w13sm3517603pfi.30.2019.09.05.13.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 13:32:36 -0700 (PDT)
Date:   Thu, 5 Sep 2019 13:32:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [patch 0/6] posix-cpu-timers: Fallout fixes and permission
 tightening
Message-ID: <201909051329.A630E97F@keescook>
References: <20190905120339.561100423@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905120339.561100423@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:03:39PM +0200, Thomas Gleixner wrote:
> Sysbot triggered an issue in the posix timer rework which was trivial to
> fix, but after running another test case I discovered that the rework broke
> the permission checks subtly. That's also a straightforward fix.
> 
> Though when staring at it I discovered that the permission checks for
> process clocks and process timers are completely bonkers. The only
> requirement is that the target PID is a group leader. Which means that any
> process can read the clocks and attach timers to any other process without
> priviledge restrictions.
> 
> That's just wrong because the clocks and timers can be used to observe
> behaviour and both reading the clocks and arming timers adds overhead and
> influences runtime performance of the target process.
> 
> The last 4 patches deal with that and introduce ptrace based permission
> checks and also make the behaviour consistent between thread and process
> timers/clocks.

I like these changes! Thanks for working on it. :)

Since this is a subtle bit of checking and there are concerns about ABI
breaks, can you also write some selftests for this area just to nail
down what should work and what should be blocked, etc?

-- 
Kees Cook
