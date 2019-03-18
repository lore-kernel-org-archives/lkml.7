Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB11B20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfCROel convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:34:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35117 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCROek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:34:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id z13so9735837qki.2;
        Mon, 18 Mar 2019 07:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I0Ws5Ly+Mdf4A6QH49pa/XLERe2q+ZBCSRe5rPGf/pg=;
        b=t2lw6H+v9g/t99z/86ntCOndV1lRwifCXHr/U7ZUiMGIaUF3rvPuOHyJRnugEOzn8I
         TidT1CS2ur3szd23HLRkUpJBJ3X3zLrjIevZCtBV9JBMCKO2pVAg8wQ2IfCx4/9dIlIZ
         RNLmKbg+eEh8zVRdYIxRl1Jwv9t72PDP8YOwnM5EIAcZR50+UMj4B+EJzjXXpZ279aB0
         JKrSZaaQi1osYMuw42/CkmkE/pDhqj9iti5CQpBqtBjLQbiu9NtspsCBtaL77NgLSTD8
         phLYr03e6OoHDffsRriSaZYUVKnPBnCM+fQWRJD6b6KoALbZKvkTr5qJBFlGa9acqR0l
         bgOQ==
X-Gm-Message-State: APjAAAUVYACgVN2+oO73hx2VoV4mLGXnNxc+l3VWHVDuUtwqCYp4v2BA
        I98ZnW7dKSWj+5hK0RGSx7rDEqPZOONC0HycU/o=
X-Google-Smtp-Source: APXvYqzchpNIvlcBZpgL+vwWoS2dH5czUw7fEzGafZ76KL0gS+8oXYY4krH+C4S2CGUPhi/c/jAbnkRlciISDm6Qp80=
X-Received: by 2002:a05:620a:153b:: with SMTP id n27mr6045177qkk.343.1552919678198;
 Mon, 18 Mar 2019 07:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190311153857.563743-1-arnd@arndb.de> <87k1h1fgkk.fsf@mid.deneb.enyo.de>
 <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
 <87a7hvded7.fsf@mid.deneb.enyo.de> <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
 <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com>
 <87o968y1uv.fsf@mid.deneb.enyo.de> <CAK8P3a1DzRhiuNxBeQaTYSX1NhCaN6+B0Ya7aeGfxUGj35LFhw@mail.gmail.com>
 <877ecwwckm.fsf@mid.deneb.enyo.de>
In-Reply-To: <877ecwwckm.fsf@mid.deneb.enyo.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Mar 2019 15:34:17 +0100
Message-ID: <CAK8P3a3X26niT8Y8mWCNXgcRkWhT=ADK-Tt2vjYz6SLj90shCQ@mail.gmail.com>
Subject: Re: [PATCH] y2038: fix socket.h header inclusion
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Law <law@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 2:12 PM Florian Weimer <fw@deneb.enyo.de> wrote:
> > On Mon, Mar 18, 2019 at 10:25 AM Florian Weimer <fw@deneb.enyo.de> wrote:
> >>
> >> * Arnd Bergmann:
> >>
> >> > Should we just remove __kernel_fd_set from the exported headers and
> >> > define the internal fd_set directly in include/linux/types.h? (Adding the
> >> > folks from the old thread to Cc).
> >>
> >> The type is used in the sanitizers, but incorrectly.  They assume that
> >> FD_SETSIZE is always 1024.  (The existence of __kernel_fd_set is
> >> itself somewhat questionable because it leads to such bugs.)
> >> Moving around the type could cause a build failure in the sanitizers, but I'm
> >> not entirely clear how the UAPI headers are included there.
> >
> > It looks like sanitizer_platform_limits_posix.cc includes
> > linux/posix_types.h to ensure that __kernel_fd_set is the same
> > size as __sanitizer___kernel_fd_set, and then it uses the
> > latter afterwards.
> >
> > What I don't see here is what kind of operation is actually done
> > on the data, I only see a cast to void.
>
> I think it is used to assert that the select family of system calls
> writes to the 1024 bits for each of the passed pointers.

Yes, that is what I expected to see in libsanitizer, I just couldn't
find any code that actually does this check.

> Which is not actually true—the write size is controlled by the
> file descriptor count argument.

Yes, of course. In fact, I see multiple possible problems that

- kernel reading uninitialized data if 'FD_ZERO()' was
  used with a shorter size than the count argument.
- kernel writing beyond the fd_set data on stack
  when the declaration had a shorter size than the count
  argument.

Each one could happen either because __FD_SETSIZE
is smaller than 'count', or because kernel and user space
disagree on the element size (32 vs 64 bit on x32).

> > If libsanitizer actually does
> > anything interesting here, we should definitely fix it to use the
> > correct size, especially since this is actually something that
> > can trigger a buffer overflow in subtle ways when used carelessly.
> > See for example [1], which we still have not addressed
>
> The footnote is missing.

Sorry, I meant [1] https://patchwork.kernel.org/patch/10245053/

> > For this specific use (and probably others like it), renaming the
> > fds_bits member to __kernel_fds_bits or something like that
> > would keep user space still compiling. That would only break
> > if someone was using __kernel_fd_set, and actually doing
> > bit operations on it. glibc uses '__fds_bits' unless __USE_XOPEN
> > is set, so maybe we should use use that name unconditionally.
>
> Please use something that is more obviously Linux-specific.

Ok, so not '__fds_bits'.

Is '__kernel_fds_bits' ok? I would prefer to keep at least the
name __kernel_ namespace that we have for typedefs and the
occasional struct tag.

        Arnd
