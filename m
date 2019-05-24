Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4124FC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F8921874
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558718848;
	bh=7lOWChVxREIQYWm+4ctdfW7a/QuYaHP746/1aJHMsrc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eDDoSloV9N7DFTTLKv0r438WAvX3hoC+lAk28sUKN1J4Dkf8+j9ftwAybCkkG/K6r
	 wKi5jRKEfWIBEAz6Xb0uLzGFWTyyXm8Tdb/2taWKz3C/MV3PCGAELk2fL5e+jJrrL0
	 obSxVXfKCRJjD/ZrpDbpOuO3ZnSrKle2F1419edk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfEXR11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:27:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44881 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEXR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:27:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id n134so7699746lfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVbYfBRHpnXnuZnhe+2+ac0OMNvjOmYpbXsicIs9pLQ=;
        b=fZGovy5ICIPj2aTx3nROHLOtIcKT9sS4s6Sn1H4OYj0TOF2nY+XH68z+VGIfPwKY3W
         Q/GaNi2eagm/paKz1dcVaXJGg6NwQAHxy77juANp4RUTExlXhiRo0ZtzYKFzNLoWCS/M
         W2XhIvfJKg6KBKdZnjdIqJyROtdat1scDiogQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVbYfBRHpnXnuZnhe+2+ac0OMNvjOmYpbXsicIs9pLQ=;
        b=BfDKTP+cBawqHHon3wGG+dL2UDmVE9O71GXUK5lcAMEKAvF9/rtytciVkIxCMBYxth
         M6BgId2DSP6Zln+yTiNwJA+U6Hb0mLc5JD4Qdn6sRWZMj2Gru9NweEo6dSZlHVGhXO34
         fUVphd+J0gEkfjazeGR6GIXshVV/Xqw3zKPVWY/QzZs5Je9GMGVb0etCcto9WYGeL110
         51tB9vi3Z08HRFeSWyYhscaPNwJYT6bWNZbVmwKo0JFmSwTdjgRwvelRZGBWy5vWuaaL
         BO5HAibChsR5LduUQ3TWQ80j3oY7xVAJXVs24ReL4ODNGADBt0oGxDIsHuGLme65lcRI
         Ui5g==
X-Gm-Message-State: APjAAAVSG1lAG0OEyTOYd70h9mBzobtx1KB42fgvDeOa455f98avUe7f
        8GIIO6wrVpJ6iBuO1MgdED4sUZ3kEJc=
X-Google-Smtp-Source: APXvYqyWn1UHGUwQryHphwHel8bXDnO1v5NchDNcO9WawMqmULzJz6KOy70s84bAGX1fW95C9eHwAQ==
X-Received: by 2002:ac2:5935:: with SMTP id v21mr10157201lfi.117.1558718843153;
        Fri, 24 May 2019 10:27:23 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y8sm602595ljk.79.2019.05.24.10.27.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:27:22 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id u27so7710612lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 10:27:21 -0700 (PDT)
X-Received: by 2002:a19:9150:: with SMTP id y16mr5084871lfj.106.1558718841613;
 Fri, 24 May 2019 10:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190524165346.26373-1-longman@redhat.com> <20190524171939.GA9120@fuggles.cambridge.arm.com>
In-Reply-To: <20190524171939.GA9120@fuggles.cambridge.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 10:27:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQ3kbk1G40ofSMu7qGhrX4PgngN64jGnttOcNCvKy6EA@mail.gmail.com>
Message-ID: <CAHk-=wiQ3kbk1G40ofSMu7qGhrX4PgngN64jGnttOcNCvKy6EA@mail.gmail.com>
Subject: Re: [PATCH v2] locking/lock_events: Use this_cpu_add() when necessary
To:     Will Deacon <will.deacon@arm.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:19 AM Will Deacon <will.deacon@arm.com> wrote:
>
> Are you sure this works wrt IRQs? For example, if I take an interrupt when
> trying to update the counter, and then the irq handler takes a qspinlock
> which in turn tries to update the counter. Would I lose an update in that
> scenario?

Sounds about right.

We might decide that the lock event counters are not necessarily
precise, but just rough guide-line statistics ("close enough in
practice")

But that would imply that it shouldn't be dependent on CONFIG_PREEMPT
at all, and we should always use the double-underscore version, except
without the debug checking.

Maybe the #ifdef should just be CONFIG_PREEMPT_DEBUG, with a comment
saying "we're not exact, but debugging complains, so if you enable
debugging it will be slower and precise". Because I don't think we
have a "do this unsafely and without any debugging" option.

And the whole "not precise" thing should be documented, of course.

I can't imagine that people would rely on _exact_ lock statistics, but
hey, there are a lot of things people do that I can't fathom, so
that's not necessarily a strong argument.

Comments?

                  Linus
