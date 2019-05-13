Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C77C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB5121019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SZjZHRBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfEMHj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:39:58 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50387 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfEMHj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:39:57 -0400
Received: by mail-it1-f193.google.com with SMTP id i10so14879099ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCBAgYZcl/Mx9I9kBUc9k0z+VS+2s/+/8BKjMe5L/4M=;
        b=SZjZHRBaI2LN21jyRT5EZkLIQdXHRrkgReZnW+swFod0bdKDie3+g+WGtklY0kC311
         D1KKaZ2x7uQDR0V2qnPwQzvKPDzqAA94Zpm8YHT/sOwgUG6HPRnEqu85XA+O1k0sypE5
         bbop+wUKsZ4yMehyLmsJ9459MhRGj3LYgqRz4uO/ypZ8wYUyM8rWxxtLJhVeYmIoNPzJ
         P0BGjN9KPs18zjGreU5S/Jg8qeugpnE19O6Fjj/RYomOU65m0ow3YaAVxRMZqaRgh++4
         kfjbw31MpcBw/JJVWa6iRCoFOI7x3lquY0Qvqmfqv/Cd/3KZ+WPUFvwRRIVAPicbMYQz
         mSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCBAgYZcl/Mx9I9kBUc9k0z+VS+2s/+/8BKjMe5L/4M=;
        b=AX7UvDkgkSmtmgyXodgHSYbXwRTGijMs6cwLf+G6ct76I7hQfbQAfgwZejvYNTkj0Z
         LbkATqQ6HO7TXeA1KLuuR+JKgCbbWSM4I5DoSUS8V0qut9GBnfu4X7q2HGkYd5i+XX8B
         MZ1ZdPiF4u9e4JbMMQw5Wcr5Z/AF13XJ/iwIcOFvS6rJqbryGy31aezJCuXBM1T3Y2qA
         XmuexOGHnRSccc9BgtjSAfthHoXw/SPgWT/XjTkh6CkOjPPokJ/cRQxX172/MrPV4E+X
         5/39orImB6FtzliEDAX7Xx1eQ9clGAjr3XoJVNBAxZqbLEuc5a9l/gI4ha44xZQNKTVS
         Prew==
X-Gm-Message-State: APjAAAW8d7N0fdOacf/mtwJotjFPDLAhmfekwg5uyLxyZlR9GLjxruUf
        WOYQOmch/z71PxBrfVeKXV0TcvVX0fzd9olebpSuqQ==
X-Google-Smtp-Source: APXvYqx3ThZE+Yj0kNbVwe1j3uegPjtZ90tj9AYcwjCq3pZNd6Fh+sqbqj1PKRwpmit1sNvknwuQU89gTtGOhYZrWFU=
X-Received: by 2002:a05:660c:10f:: with SMTP id w15mr11634340itj.166.1557733196690;
 Mon, 13 May 2019 00:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190412143538.11780-1-hch@lst.de> <CAK8P3a2bg9YkbNpAb9uZkXLFZ3juCmmbF7cRw+Dm9ZiLFno2OQ@mail.gmail.com>
 <fd59e6e22594f740eaf86abad76ee04d@mailhost.ics.forth.gr> <CACT4Y+aKGKm9Wbc1owBr51adkbesHP_Z81pBAoZ5HmJ+uZdsaw@mail.gmail.com>
 <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3xRBZrgv16sSigJhY0vGmb=qF9o=6dC_5DqAJtW3qPGQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 13 May 2019 09:39:45 +0200
Message-ID: <CACT4Y+ad5z6z0Dweh5hGwYcUUebPEtqsznmX9enPvYB20J16aA@mail.gmail.com>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel endianess
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, May 11, 2019 at 2:51 AM
To: Dmitry Vyukov
Cc: Nick Kossifidis, Christoph Hellwig, Linus Torvalds, Andrew Morton,
linux-arch, Linux Kernel Mailing List, linuxppc-dev

> On Fri, May 10, 2019 at 6:53 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > I think it's good to have a sanity check in-place for consistency.
> >
> >
> > Hi,
> >
> > This broke our cross-builds from x86. I am using:
> >
> > $ powerpc64le-linux-gnu-gcc --version
> > powerpc64le-linux-gnu-gcc (Debian 7.2.0-7) 7.2.0
> >
> > and it says that it's little-endian somehow:
> >
> > $ powerpc64le-linux-gnu-gcc -dM -E - < /dev/null | grep BYTE_ORDER
> > #define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
> >
> > Is it broke compiler? Or I always hold it wrong? Is there some
> > additional flag I need to add?
>
> It looks like a bug in the kernel Makefiles to me. powerpc32 is always
> big-endian,
> powerpc64 used to be big-endian but is now usually little-endian. There are
> often three separate toolchains that default to the respective user
> space targets
> (ppc32be, ppc64be, ppc64le), but generally you should be able to build
> any of the
> three kernel configurations with any of those compilers, and have the Makefile
> pass the correct -m32/-m64/-mbig-endian/-mlittle-endian command line options
> depending on the kernel configuration. It seems that this is not happening
> here. I have not checked why, but if this is the problem, it should be
> easy enough
> to figure out.


Thanks! This clears a lot.
This may be a bug in our magic as we try to build kernel files outside
of make with own flags (required to extract parts of kernel
interfaces).
So don't spend time looking for the Makefile bugs yet.
