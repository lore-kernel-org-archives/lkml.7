Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C292C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F76B20836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575915875;
	bh=z8iBtd29hsyUP199DabjZc4nFqNLyFccsm7VB2Mg/jQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oIR3p2uB1czl+JQnYyi+/BPyS6OD4WD6w7nKbU0yh6T1qE6ipj5bNZZX9MY3WCmWY
	 WUOdL4KLsBKw2IZUm3VFPZl2ZPfidbCOg1klhn8Jog4bgOndKm6hpY5aeZeY8iLxbB
	 3HwuXpKWGnvSnNgq8ypytPUNl5wV49pgdEJ7F06Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLISYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:24:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37504 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLISYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:24:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so16784618lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIXWZyTd39+6esYPe9MmFdMJXzmcp5bMpJnRkNThpb4=;
        b=I5z0RVLWrUPKkPPuZeqHORejsaLh5EEfaCmf/IUxy3Oow1k8FTCGy60JJ0TNIV3r4f
         2P/+8pOUDPgMSUgGxWyl95suJenzD1M7wzFBDWuG6/N9n3g6tJq7RZ0gNcKqdsCA0lQI
         CgpVgkKslfC4ZiS36sJHLjqnWvQ8F/RhgZL3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIXWZyTd39+6esYPe9MmFdMJXzmcp5bMpJnRkNThpb4=;
        b=mvky1QB+Mdq7KlqKAtgpPoN+CV8QoCn5tIb8zWJdB0YhpmuWb61eNkpKurAdgPNjF4
         FZ39lwzKRy+1IqovreNl+xs23fVRQDlP8KSyh1gUJgxZF7R8d/ve+GVH2NAl/a5gLJsI
         7jyhR6rZsYKsF7tGDL402zKJSNwk7xBbrULiQOwOOBV4OH22A2FdUDo0PAr1ByDJDv9D
         ve+NHWWs+gcAl4d2SzFN6Ui58qmYX3XiJXOhBK1kX9rUROy3kPcceUnCJi6sE+J+364N
         uX22VKGtAbQ1ZyLA7Vrba8WvLpH2jTV+ReaBUiaBmugn5CGGrQW7ADuq91jgoL+E8Zx0
         DbCQ==
X-Gm-Message-State: APjAAAWKyw4lpBSQOh3bfUQo3JTIglcGH8p5d4J6Xto3ZVueUjba1mPS
        uz3O7J9fO5QJA33kZFGiT5pBvmzfijQ=
X-Google-Smtp-Source: APXvYqwXcYJJuajPdF+Mdz6f97MU7/NA/8txg5YhKqEoAdm1aBH+NkKDXawSeZTgInzPkAXdTGZCEw==
X-Received: by 2002:a2e:6a03:: with SMTP id f3mr16909924ljc.232.1575915871216;
        Mon, 09 Dec 2019 10:24:31 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m24sm106607lfl.34.2019.12.09.10.24.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:24:29 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id d20so16732046ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:24:28 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr15574881ljn.48.1575915868556;
 Mon, 09 Dec 2019 10:24:28 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
 <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com>
 <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com> <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:24:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizyzWdjkpm_Zm9DY9TzDCB2cbyhf5HUKoWnfJoqSNtuQ@mail.gmail.com>
Message-ID: <CAHk-=wizyzWdjkpm_Zm9DY9TzDCB2cbyhf5HUKoWnfJoqSNtuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Akemi Yagi <toracat@elrepo.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        DJ Delorie <dj@redhat.com>, David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looks like opensuse and ubuntu are also on 4.2.1 according to
>
>    https://software.opensuse.org/package/make
>    https://packages.ubuntu.com/cosmic/make
>
> so apparently the bug is almost universal with the big three sharing
> this buggy version.

And the reason seems to be is that it's considered the latest "release" version.

In the git tree, I see 4.2.92, but looking at

    https://ftp.gnu.org/gnu/make/

it looks like 4.2.1 is the latest actual "release".

Oh well. I can't find a workaround for the bug, other than perhaps
using "make -LX" instead of "make -jX". Which is not the same thing at
all, of course.

                Linus
