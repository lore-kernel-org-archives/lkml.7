Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED49EC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65512206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J40faVZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfDYRFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:05:21 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38862 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDYRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:05:21 -0400
Received: by mail-ua1-f65.google.com with SMTP id t15so225065uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaoMpzdiK77dS+7ihAaKtwjGXwyLCMnaO0nG0iXi9lo=;
        b=J40faVZEC09mfj7wVYnU2FyDtrzfMkItWfXLZ91016xZo2KoiM/kYQhT1nmhWnzSHE
         iDm70EBzEgs7DRCvO0xy/jkMLHVi3TRIqZaLbX3yrE0oxzh2h4smDZ3kTUgSq6R84Sc1
         Vbq0V+cGHxswF8x/wtKbYvdClCnZnNNzOyeY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaoMpzdiK77dS+7ihAaKtwjGXwyLCMnaO0nG0iXi9lo=;
        b=GuvX8Eky+pv+8ctpHWXGuW8PaxXIUUv9hqpohAaP9Wbl/MsrXXY72YbgNRJsGrKvG2
         mBmg5vTzKbMV4SIIHKBltJDJZXhaHyXOMalcosUlHAn1vim/+HdvovZ4EFPdXTY6QUK1
         G6ZxC3NAPuHGEa9M2xVGocJ7S2Y4nTD7IHQmgI9vSdisUsIKIqmTuCC2fG889RMiwh5H
         91X2UTfJnqLlRf2zmiomvEgL+yS6bdzB9cY7ERCLGIEZL9k5h14ynln/vchCu+1rQHCA
         A0Z8Lmju9k/hFwQUMjK7C4g0Hi23CeFGNDNWLE+edR9DTkR+gTwBiLfcYg6dbi2Oj2ad
         hEKg==
X-Gm-Message-State: APjAAAU9RU5XTNoK8s6Rw9GAPkp95SqMuQsjxpI1+/p75qpjDesO01Nc
        j09zlntBP1VT1SJ4Fi4tZzWkcX3OSdI=
X-Google-Smtp-Source: APXvYqykbAHfgKqkKhjKY/EB8QLVodCOMb0IvCmmJ0fDPhSXHvvGre3Cjaat2TPYgrEJnFd7UP63Og==
X-Received: by 2002:a9f:2f1a:: with SMTP id x26mr19694160uaj.20.1556211918639;
        Thu, 25 Apr 2019 10:05:18 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id s78sm6313389vke.17.2019.04.25.10.05.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 10:05:17 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id o10so271000vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 10:05:16 -0700 (PDT)
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr21230946vsc.172.1556211916159;
 Thu, 25 Apr 2019 10:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190424231237.14776-1-keescook@chromium.org> <a3ca267e-8e1e-65da-77c8-c7010a39354b@kernel.org>
In-Reply-To: <a3ca267e-8e1e-65da-77c8-c7010a39354b@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 25 Apr 2019 10:05:04 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJChvx-_E8RMTi3ioUZGuQGViy6gcAMpmvYZzms=zc6dQ@mail.gmail.com>
Message-ID: <CAGXu5jJChvx-_E8RMTi3ioUZGuQGViy6gcAMpmvYZzms=zc6dQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] selftests: Move test output to diagnostic lines
To:     shuah <shuah@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 9:52 AM shuah <shuah@kernel.org> wrote:
>
> On 4/24/19 5:12 PM,  wrote:
> > This refactors the selftest Makefiles to extract the test running logic
> > to be reused between "run_tests" and "emit_tests", while also fixing
> > up the test output to be TAP version 13 compliant:
> > - added "plan" line
> > - fixed result line syntax
> > - moved all test output to be "# "-prefixed as TAP "diagnostic" lines
> >
> > The prefixing code includes a fallback mode for limited execution
> > environments.
> >
> > Additionally, the plan lines are fixed for all callers of kselftest.h.
> >
> > -Kees
> >
>
> Kees,
>
> Just about to apply these to a topic branch to do testing and ran into
> checkpatch errors:
>
>
> WARNING: line over 80 characters - a few

I only saw one, which is on a string which kernel coding style says to
leave unsplit:

WARNING: line over 80 characters
#55: FILE: tools/testing/selftests/kselftest/runner.sh:19:
+               echo "$TEST_HDR_MSG: Warning: file $TEST is not
executable, correct this."

> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
> #141: FILE: tools/testing/selftests/kselftest/runner.sh:2:

WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
#37: FILE: tools/testing/selftests/kselftest/runner.sh:2:
 # SPDX-License-Identifier: GPL-2.0

This is a shell script. It can't be on line 1:

$ head -n3 tools/testing/selftests/kselftest/runner.sh
#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
#

That looks like a bug in checkpatch not resetting the expected line or
something.

> Can fix them and resend - SPDX one is my main concern.

These appear to be false positives; I don't think I need to fix them?
Let me know what you think.

> The plan is to apply these to linux-kselftest ksft-tap-refactor topic
> first. I don't want to rush these until we do some testing.

Absolutely. :)

Thanks!

-- 
Kees Cook
