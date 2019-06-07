Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE66EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943D7208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559932098;
	bh=Mz8ccxw2uqOMfr25Tf6EkINpbO5OFmKX3cpcg2Im6Lw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0TgSnbLqQGztHxTiZCL/8cQoz+J7oFqFcc80rRiT9c32/zivKGzGq0vqWI157HYMj
	 hatSIsD+Ts9RjLkRo+Aw8qyQ97d+F+1VVmCJE+31pSWtNJSvpKL1LTBPUV1jpLQ1uX
	 G9lusErrACHBt1wX9pe6onw8mtIu/X5Pn78iTSUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbfFGS2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:28:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37362 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbfFGS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:28:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so2581122ljf.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEMW3nbrGj3f3FeLm8Kgn7OWvgoKhy/7m5/80se1Dk0=;
        b=dxqcWtGpHywbdhRrcAXNaStWTUHq208llOuzD+TKm7VH2IqeG7+SsRF5YhrUq4AktU
         IvqSu1TZLgvJl+8nUSbjVyDprr2HKPJrom8CPywQp3mFswJGNt47FIgfsBgmTV9TunaX
         VkmqTaIBGjNL89U4Y46JVQVgz9ssjbSNKZbYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEMW3nbrGj3f3FeLm8Kgn7OWvgoKhy/7m5/80se1Dk0=;
        b=PNMGpq9CEQdyP+Ahr+dcl8VNaexHaNN49AxHMSKHqvVmLQDUOOTft0FXsScXothz3k
         /hcbcZboNj3lp0ptmS8cPYS5hHP6gaLFlVO+iLpD7DgyJpsn7QTpphSotqhagiCeFq5p
         qduUafoIV5sEUiXzO4fQhX2lm6xWq638gJMvDmWM0U8GmaA26BytriCcN4uQpH/YVrMn
         7XAZvaniWPyyuDTgi4dLGo5lTP1ovnUhJKKU98vrmv4aNYi899gxLi6vdorT7gAAFcLF
         Bi9p/aEkp6cqTFx56bNdgsf+3UN+AnI30vKzC9qW7q+F6dpneADj6eWUGXnOWIGGlVIl
         W7xg==
X-Gm-Message-State: APjAAAXJIpsW2tBpWVu5BPNMjj4OxGFZ9elrRB9RAkrJlgPgr7RcFu+9
        EgN8RMvyiiU7diKjyXXI9WkMxZ2PRww=
X-Google-Smtp-Source: APXvYqzvdi07vi9wnrOxfRo2uZBb+1IdsORtUQlPxsY7A2MrKtLF2ugUuNFjVifKrpKj5xijV+O5ig==
X-Received: by 2002:a2e:206:: with SMTP id 6mr25819656ljc.59.1559932094918;
        Fri, 07 Jun 2019 11:28:14 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h11sm544740lfm.14.2019.06.07.11.28.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:28:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id a9so2334199lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:28:13 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr27242012lfn.52.1559932093560;
 Fri, 07 Jun 2019 11:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190319165123.3967889-1-arnd@arndb.de> <alpine.DEB.2.21.1905072249570.19308@digraph.polyomino.org.uk>
 <87tvd2j9ye.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87tvd2j9ye.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 11:27:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
Message-ID: <CAHk-=wio1e4=WUUwmo-Ph55BEgH_X3oXzBpvPyLQg2TxzfGYuw@mail.gmail.com>
Subject: Re: [PATCH] uapi: avoid namespace conflict in linux/posix_types.h
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Joseph Myers <joseph@codesourcery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Paul Burton <pburton@wavecomp.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 9:28 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> This regression fix still hasn't been merged into Linus' tree.  What is
> going on here?

.. it was never sent to me.

That said, now that I see the patch, I wonder why we'd have that
#ifdef __KERNEL__ in here:

 typedef struct {
+#ifdef __KERNEL__
        int     val[2];
+#else
+       int     __kernel_val[2];
+#endif
 } __kernel_fsid_t;

and not just unconditionally do

    int   __fsid_val[2]

If we're changing kernel header files, it's easy enough to change the
kernel users. I'd be more worried about user space that *uses* that
thing, and currently accesses 'val[]' by name.

So the patch looks a bit odd to me. How are people supposed to use
fsid_t if they can't look at it?

The man-page makes it pretty clear that fsid_t is complete garbage,
but it's *documented* garbage:

   The f_fsid field
       Solaris, Irix and POSIX have a system call statvfs(2) that
returns a struct statvfs (defined in <sys/statvfs.h>) containing an
unsigned long f_fsid.  Linux, SunOS, HP-UX, 4.4BSD have a system call
statfs() that returns a  struct
       statfs (defined in <sys/vfs.h>) containing a fsid_t f_fsid,
where fsid_t is defined as struct { int val[2]; }.  The same holds for
FreeBSD, except that it uses the include file <sys/mount.h>.

so that "val[]" name does seem to be pretty much required.

In other words, I don't think the patch is acceptable. User space sees
"val[]" and _needs_ to see it. Otherwise the type is entirely
pointless.

The proper fix is presumably do make sure the fsid_t type definitions
aren't visible to user space at all in this context, and is only
visible in <sys/statvfs.h>.

So now that I _do_ see the patch, there's no way I'll apply it.

               Linus
