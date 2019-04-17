Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB8120674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOZV+EMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732771AbfDQPk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:40:59 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45803 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:40:58 -0400
Received: by mail-ua1-f67.google.com with SMTP id c13so8037483uao.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0rvZUI1RnDXQjMMgnSxlEoJ2tE+XZLbqLn1uf6LLs9s=;
        b=HOZV+EMzfFnSncz1jTQw/FBV+plqNQNwuvixYbamVtoye4nuNd4M7YBwvb59vaPQlK
         KVfNUfS6S2N0SMg/vxZ5Lqm2q2q8zZeBYneoKT9a9qqtqI2gKGaN/HzDaqIbVj6vYeYn
         +BnTf9GuaEtkB0WSi7rC18coldShUKOMpacY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0rvZUI1RnDXQjMMgnSxlEoJ2tE+XZLbqLn1uf6LLs9s=;
        b=FwJBBttC49O8vUkRN0YZ+xgDIBK+pDxiCDVVrf48up95mhWcAeNSMKzvOYOltZJwYw
         /5ZiG2MFEEUnWa56qhqwn+Wqw0MqaIA3V+Za4F3F94hoC+oiybVksSwCTMfd0Krg/hIq
         7DcM5pj1uF2E2YtE5ghg9wksldU79swEOQMj6OMiCCSw2Pw7YIZb2teHYLG8hlBsMvZC
         7SO6m+Ih8ZWencW3HvnkiAnCVobaNwmbSKOmglpp/E014QBI7PlglBJx6S0eG3UbrN7Q
         7kQmFTZffz0pGFRhldSmjHlBMvDdFF5gQWONAjJIdkO+EDd7oSiG5WnJ1mHjR+rbNRv4
         oKLw==
X-Gm-Message-State: APjAAAVvVWU2C7Z82HYocO5PItc/yEhWD81RWsNpHJZv8wNw+i20At7N
        d9q5OPqW+trPqJ82q35gGLzUfWmneQ4=
X-Google-Smtp-Source: APXvYqzk0JFPqiGygR175zj3b/dmvEel1XFbKZNL6d/b4uB+Iv/WOkJmfFPLXy1PHQUdEeUQnKhl2w==
X-Received: by 2002:a9f:37a1:: with SMTP id q30mr4900620uaq.114.1555515656505;
        Wed, 17 Apr 2019 08:40:56 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id p29sm10530372vsl.9.2019.04.17.08.40.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:40:54 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 195so5302934vkx.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 08:40:54 -0700 (PDT)
X-Received: by 2002:a1f:3c83:: with SMTP id j125mr295560vka.92.1555515653982;
 Wed, 17 Apr 2019 08:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com> <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net> <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu> <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com> <20190417151555.GG4686@mit.edu>
In-Reply-To: <20190417151555.GG4686@mit.edu>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Apr 2019 10:40:41 -0500
X-Gmail-Original-Message-ID: <CAGXu5jLhbBh8NjQ9wpsJ=82PXV1AnRHOFpq8Smd+Qjg+pe1TVw@mail.gmail.com>
Message-ID: <CAGXu5jLhbBh8NjQ9wpsJ=82PXV1AnRHOFpq8Smd+Qjg+pe1TVw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:17 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Apr 17, 2019 at 09:28:35AM +0000, David Laight wrote:
> >
> > If you can guarantee back to back requests on the PRNG then it is probably
> > possible to recalculate its state from 'bits of state'/5 calls.
> > Depend on the PRNG this might be computationally expensive.
> > For some PRNG it will be absolutely trivial.
> > ...
> > Stirring in a little bit of entropy doesn't help much either.
> > The entropy bits are effectively initial state bits.
> > Add 4 in with each request and 128 outputs gives 640 linear
> > equations in the (128 + 4 * 128) unknowns - still solvable.
>
> This is basically a scenario where the attacker has already taken
> control of Ring 3 execution and the question is how hard is it for
> them to perform privilege escalation attack to ring 0, right?  I'm
> sure the security folks will think I'm defeatist, but my personal rule
> of thumb is if the attacker has ring 3 control, you've already lost
> --- I figure there are so many zero days that getting ring 0 control
> is a foregone conclusion.  :-(

I think this attitude comes from Linux traditionally having had such a
weak line between ring 3 and ring 0. That's what we're trying to fix,
generally speaking. :)

> So that basically means if we want to protect against this, we're
> going to do something which involves Real Crypto (tm).  Whether that's
> RDRAND, or using Chacha20, etc., or something that has some attack
> resistance, such as "half MD5", etc., but emminently crackable by
> brute force, is essentially a overhead vs. security argument, and what
> it is we are willing to pay.

I wonder how a separate per-cpu state combined with frequent reseeding
would compare to chacha20 (or RDRAND)?

Another point to consider is that this weakness depends on a separate
bug existing, which is becoming less and less likely, given the
always-init options now available. I don't think we should try to
over-engineer this too much. Best-effort here seems fine. Using a
stack leak when the stack is randomized may also prove difficult, so
there's some chicken-and-egg problems with the proposed threat...

-- 
Kees Cook
