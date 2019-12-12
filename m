Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5111EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6D208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576114143;
	bh=cYxSv5bGUoIGqXO0c0d/IoNkTeKfqRsQsyJuL/YrLxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bXarzjWhC5xzFAzT2Ma8rHVyb3h34BYuW5KDuCk6inSVICWJBi5/pXzIqT924jn0n
	 RFJdoKorMEDWECNazDyDKZzB0GK7kUqH3ePgsoYtlkkiHworCPra9T7U6PnE99MV2p
	 UfxH0bYjQZKjK5Dx5N4d8C8ixTOm/E4ukXq4OMmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfLLB3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:29:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38773 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfLLB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:29:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id k8so326930ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ngCvhdELOgIQ69MigGwbslj0BoCyrEIfDMRe9lAU84c=;
        b=cwlWLXDtChisQx3BOxoqKRoI8l2aIzApJkZH0knnGXeRBkYyrjatj3Iqvq+pEYo8vz
         YB1Q6eIQ7M8Kp9xDL8IMabELBNs7kQEMnQVpm9+RvgFUWRjKay6CY/YEtmqENuN8NEJe
         SpgsA+0oAnSTBgoiasPVoSFTQm5OXTTIsNyTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ngCvhdELOgIQ69MigGwbslj0BoCyrEIfDMRe9lAU84c=;
        b=uTB4EzdKeWZ5dlAmiZQgxuBCvwAqAG6ZB5TUyJAtvNVBGeXGjAiJemq7V/2eR9F6NM
         U9EUJIPixYVbwK3rXA5e1C5EgQDd0cBFWFxrJ/TYIB0mGXj/gyBU6oCErovNCfhHnyh1
         kOSsipdc5TFuZCu1La2dCHMsPo/tE8KONxesudv3D3qkoxr0jICH1twOqq5f9Z/OWa36
         KL6QOCtuIhfNGm3V13Fw6HT/6/kmVwf1H3RJ12tN1BTbvoj626H/OFy28fMGbKSLYfMh
         T44Dw3FkOQ6AlJRpwKs2FQn7/BLT1rU/BddDEHaNKmHm0CtBb/fmjk2nEHiV8Cf5Y6w2
         /z8Q==
X-Gm-Message-State: APjAAAU+EP6aucx9AmuCBBvslGYncP4nZb0gb7j2SaTXdqZWPY27rIsO
        0Z5VTZCwx+ETu/qs4HWMQPNMr3/SMec=
X-Google-Smtp-Source: APXvYqy9R35PGK4ApW5ijXE0pZjtkt3MeCmI3lZWzaL1EZjZ2w5TTpsDeBqf8s+mpy0SPvazicR8KQ==
X-Received: by 2002:a2e:8544:: with SMTP id u4mr4060216ljj.191.1576114138416;
        Wed, 11 Dec 2019 17:28:58 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s88sm2135277lje.64.2019.12.11.17.28.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:28:57 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id e28so309997ljo.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 17:28:56 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr4218712ljn.48.1576114136551;
 Wed, 11 Dec 2019 17:28:56 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com> <9417.1576097731@warthog.procyon.org.uk>
In-Reply-To: <9417.1576097731@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 17:28:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgVpV-O4zeO+xOMcOUyKZi+1kg+6Kmi-P7SUx-ydZm5Og@mail.gmail.com>
Message-ID: <CAHk-=wgVpV-O4zeO+xOMcOUyKZi+1kg+6Kmi-P7SUx-ydZm5Og@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     David Sterba <dsterba@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 12:55 PM David Howells <dhowells@redhat.com> wrote:
>
> Is it worth reverting:
>
>         commit f94df9890e98f2090c6a8d70c795134863b70201
>         Add wake_up_interruptible_sync_poll_locked()
>
> since you changed the code that was calling that new function and so it's no
> longer called?

You are sure you won't want that for the notification queue cases? I
guess they'll never want to "sync" part..

Looking at the regular pipe read/write code, maybe we'll want to try
it again - do the wakeup while we already have the spinlock, rather
than later. But I have this suspicion that that might just then push
things into mutex contention, so who knows..

Regardless, it's not going to happen for 5.5, so I guess we could
revert it and if we ever end up trying it again we can resurrect it.

              Linus
