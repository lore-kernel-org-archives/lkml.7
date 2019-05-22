Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA41C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30BB2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 08:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FQpPrYca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfEVIMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 04:12:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35111 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbfEVIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 04:12:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id c17so986541lfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NinRxNHyDYbCj8IbjH00ChDPuWJUmzxEB5UBBCZfvuk=;
        b=FQpPrYcaQxCAFGTYiUsPu0qLO+TyOcW7gshxdKkzEdBEoeF7zfGLnQVrcgcr4gKCeX
         LJ4YXrL36Z8UOIkkUcBOLv8jo3+1wy2Zrr1Gv+mEl7u90rBwnDVcVlXzHgwabis+F7I/
         dlJlteIhWCGDFh11b+aiyTTGML6DsZQmYr7FjOpjo+237NiSY/93FSEYu5SmcuC+kMHi
         w+QbDlfq/QnsLdgPfA6Jf+xdMdism6B4eELfwRuNPZvO4gmtKOqxk/k31Xt7g6ek0i6A
         6O4E/le0sudnktBxl+9AFEIeQt8N5n9ZAVs90K2h9eXQLV3Rz/8qfSLtahw9cvbBcJ3h
         1JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NinRxNHyDYbCj8IbjH00ChDPuWJUmzxEB5UBBCZfvuk=;
        b=ft9YheLDdUKpLZNNnqPS4LtOefQofQTVY5WDgpzG5aaz+ab9ghwIgNZ3HcgVZybqte
         kyHqby0i9VrPyfrd6mDA6ooCkLKGASmzqi9zqnh6f7Cv3DWW2v/mEY6bfJdHZI81PX7a
         08Y24wb5pH5i/Ps/t9seQTCs1XHPggB+u70Hix7fLFrSCWN3coDRnD0TsJLCYXEloxLc
         NR2zLBAqp5TxVzx8l8lF7kGrbVREv0PX8ZdEgkKiPb9G7CmSsB9IVycZQ0nk7gLOMI/Z
         6ry9j9c1FjkF6MVkn/vZM/hAXhNS+1OkXQexCqrBndwE5X85ukcZdg90f+2V+1hb8KGF
         luEA==
X-Gm-Message-State: APjAAAWgXzwy0bZvtUQPA0pRiX6pX7C05okVVI381nTY1X9OI92EOLSF
        e/CS4RXIHRCQi1QEe0cKBCkZJ1xzArgRQxE9Gb3Qsg==
X-Google-Smtp-Source: APXvYqx7pLLI28SrC6KCXMaRxdNQfwff8OtpKLPW6FHDJY0UodmrushWU4y7kAd+10dOgbbxHnK3LHfXY1UCm8GAhHE=
X-Received: by 2002:a05:6512:1c1:: with SMTP id f1mr4469627lfp.125.1558512742198;
 Wed, 22 May 2019 01:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190521150006.GJ17978@ZenIV.linux.org.uk> <20190521113448.20654-1-christian@brauner.io>
 <28114.1558456227@warthog.procyon.org.uk> <20190521164141.rbehqnghiej3gfua@brauner.io>
 <CAHk-=wgtHm4t71oKbykE=awiVv2H2wCy8yH0L_FsyhHQ5OSO+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgtHm4t71oKbykE=awiVv2H2wCy8yH0L_FsyhHQ5OSO+Q@mail.gmail.com>
From:   Christian Brauner <christian@brauner.io>
Date:   Wed, 22 May 2019 10:12:11 +0200
Message-ID: <CAHrFyr4NV_5Z7TRSXTaurd4KCTLiHqKb47dN=bdY46HiL9ZY3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] open: add close_range()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Todd Kjos <tkjos@android.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, May 21, 2019 at 9:41 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > Yeah, you mentioned this before. I do like being able to specify an
> > upper bound to have the ability to place fds strategically after said
> > upper bound.
>
> I suspect that's the case.
>
> And if somebody really wants to just close everything and uses a large
> upper bound, we can - if we really want to - just compare the upper
> bound to the file table size, and do an optimized case for that. We do
> that upper bound comparison anyway to limit the size of the walk, so
> *if* it's a big deal, that case could then do the whole "shrink
> fdtable" case too.

Makes sense.

>
> But I don't believe it's worth optimizing for unless somebody really
> has a load where that is shown to be a big deal.   Just do the silly
> and simple loop, and add a cond_resched() in the loop, like
> close_files() does for the "we have a _lot_ of files open" case.

Ok. I will resend a v1 later with the cond_resched() logic you and Al
suggested added.

Thanks!
Christian
