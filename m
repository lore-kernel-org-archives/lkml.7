Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C9C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC14B20821
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555779117;
	bh=ESRHhNJXyRtGQLlNKrKUwp8uM55AuWFpz7PgQVtPE6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kholuydu+angaPWRt6hblXJP9C/vSufXlWSTQprjZ2KwAMgDAFu/EXgTPbRVu7wH/
	 iJMc9IGnxKXijyw2OE9RZRehaXA/W8YQ9TjGVjFTF+/NkSbMMGYfuM8hQy+oXJyel0
	 oOMFcNH1uyZ79MbGt7s6/NBvuMkYpuT1Efh6OjW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfDTQvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:51:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41931 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfDTQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:51:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so6074191lfd.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbOhAjrB9FOS4YnH9Dm/kVOCZxGAwer85KELD/y76/c=;
        b=d2wxsVIZtwxRpsHn9/rhaYvwMfIGJak3Q+kfH1tNmJKxppYKTGkT0o04BaM0vFqhjJ
         QLMy6MaoiVry6T6Jcbf4HFxPhyTIU2IG6qUX7y7MTDe9nt6Bp8fKWzSMnlwCO139qYNE
         IqMM/UBe4o7IGO/dI5n8leYn11OwpFCl6Fe9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbOhAjrB9FOS4YnH9Dm/kVOCZxGAwer85KELD/y76/c=;
        b=AwY8hVVCNppnsen9dZGvslhZMnZ6FZL7YTYECFbwhrDcb+LGTaAxDJcB+l205jDsW+
         eK4H4+g6AuUN2NJiPiaWdJI9AXG34SD8AwNoF225u3sVZN0bzIoHnfPg+AbBUCH+ZHb4
         6wgh546qeMODgNJQe6ZJ+1Fb1nLu9gEnQ6N6+XCjtFK/mPbP14xcPhCM976sxLQ5CebF
         FlbdD1Cb3ZBjZAPqulHy1qWO4knwNMaZs/ftksKsjT+qTdb2cRwbPMv/Oi+29REjzYmk
         4uNRbV9K90ntMtHfzEzhMbt+KaWRi1xUEFVPnCY6xEJwFSkVWp1Vx0NyVvW2vUq5r2Fs
         i/ug==
X-Gm-Message-State: APjAAAWfFJlJftSNiXW/eSMzRok81nW+voORHfIpxRC0V94YySedd+jw
        keGi6TgtN1QYnmiKTzZUNYfW5+t+sro=
X-Google-Smtp-Source: APXvYqwJYE0d99uEWQKGmiFt6/bBgN7hvWXS6m+yAbr9Crz5buZ3wZRsB/iF15A+Fy2wU1q5Ht4kEQ==
X-Received: by 2002:ac2:4246:: with SMTP id m6mr5530385lfl.131.1555779107558;
        Sat, 20 Apr 2019 09:51:47 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id s67sm1783226lja.57.2019.04.20.09.51.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 09:51:45 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id o19so6098068lfl.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:51:45 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr5439324lfg.88.1555779105263;
 Sat, 20 Apr 2019 09:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190420073018.GA127076@gmail.com>
In-Reply-To: <20190420073018.GA127076@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Apr 2019 09:51:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjQg4wTQjyo_m2ZgqUc8h3H81N-XAxR+kkwRR6+3MjvQ@mail.gmail.com>
Message-ID: <CAHk-=wgjQg4wTQjyo_m2ZgqUc8h3H81N-XAxR+kkwRR6+3MjvQ@mail.gmail.com>
Subject: Re: [GIT PULL] locking fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:30 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> A lockdep warning fix and a script execution fix when atomics are
> generated.

Hmm. I've pulled this, but looking at it, I think it's worth noting something...

> diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
> index 27400b0cd732..000dc6437893 100644
> --- a/scripts/atomic/gen-atomics.sh
> +++ b/scripts/atomic/gen-atomics.sh
> -       ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
> +       /bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}

/bin/sh ?

Yes, that's what the hash-bang line says in the scripts themselves,
and thus what we used to do with the whole direct execution thing, so
it's clearly not _wrong_, but every single time when we manually do
the "run with shell" normally, we use $(CONFIG_SHELL)".

So I get the feeling that we should likely do that here too.

Of course, the gen-atomics script is (now) outside the normal build,
so maybe people just go "this is special, doesn't go through the
normal build process anyway, and thus might as well not follow the
common rules".

                        Linus
