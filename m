Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71D5C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3420B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 00:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="df9ezSH6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfHSA6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 20:58:19 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42330 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfHSA6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 20:58:19 -0400
Received: by mail-lj1-f179.google.com with SMTP id l14so134823ljj.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 17:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAWLA6RndFaNzG8rdPLbOXymqdUVzWZhT6YCM9vqWCY=;
        b=df9ezSH6JtFuameOXtvnUSlJUImajdAavNOPHNXMzUM/qXtlU48707BWIBLOKeH93F
         kLbZIMi33jMeuWVUcqpfoSwjmaMWvDx9VVXg2qv0Bv6R3GdDXXME+otkbkLosPILaA6u
         GKNcwX9zGUSCDENvH8v92rMU9Ekj2PxQCRkQuQUHZ9b/45Aca4eWEG8+NuKI8BeXR0vB
         basnKSN6+IZXibOE5VNU9I5lSyI3C2Aa+TYZMNULZs46MIlbfBzfM8v/NzfL9btl2i/Y
         Y1PdcmiDD9UmgI/4Kx8mNUNChU2WNAfci3X0WDieWW3EiIy0itzkgplovT2ZCpjDfRh5
         2RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAWLA6RndFaNzG8rdPLbOXymqdUVzWZhT6YCM9vqWCY=;
        b=oMS+9HaXGTk05uUdD4NNhQdcbDB9ypVn4pkdpn2+o8qZMwKg97BZJcJjubxqHtUf/H
         GGPBseaUN8BfBhfT4MH6zaLMWqSFWspp7ubWdJmG9LSnog9aGREcIW3t+2keSUQ0UZX9
         KWc6+1R9z0njglxdwiDJ3+/0HBn7DEIeF3k+t6LsYcET6lOEMW9KEsjRXr+njRIPkqXP
         5yofaOePfDEHJmA9pHGeICihv18C56XBmZi+oGkCAjUfjKPYVSz8qyt43Y92tUiiPl6s
         ixkF7nsIaIvG74x++guX0JbCxhUHrxcvkj/574C9J/aHpIzJHxqMBKCWRvtSotinw/rY
         vJ0A==
X-Gm-Message-State: APjAAAVYnsi30UyaNPehJm8OuLah9ti3q4+xxNZF58o0KkxSB8K6hSgG
        gz29gEFk7PZZPkQOZAaaQBOdfnXDX6uLWZSEJPmQaxKlz3M=
X-Google-Smtp-Source: APXvYqx2BS0WUUTEE3Z0Uus3hGRJind//UzqEc3IEWlMUjgggQOHwAdYJHApM88G3FoZ2eW3O+JcsbvbD0NDOiZUl9A=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr11245217ljm.5.1566176296975;
 Sun, 18 Aug 2019 17:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
In-Reply-To: <CAHirt9jesMHB_sXx7PyXTxrzLR=3xw9bHERueNMVkWOUkg6XXQ@mail.gmail.com>
From:   Heiher <r@hev.cc>
Date:   Mon, 19 Aug 2019 08:58:04 +0800
Message-ID: <CAHirt9jvRPjg=PPJEso-gKhXBto3=MPu_+50D+L=6O35M0BzBw@mail.gmail.com>
Subject: Re: Why the edge-triggered mode doesn't work for epoll file descriptor?
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 12:36 AM Heiher <r@hev.cc> wrote:
>
> Hello,
>
> I've added a pipe file descriptor (fd1) to an epoll (fd3) with
> EPOLLOUT in edge-triggered mode, and then added the fd3 to another
> epoll (fd4) with EPOLLIN in edge-triggered too.
>
> Next, waiting for fd4 without timeout. When fd1 to be writable, i
> think epoll_wait(fd4, ...)  only return once, because all file
> descriptors are added in edge-triggered mode.
>
> But, the actual result is returns many and many times until do once
> eopll_wait(fd3, ...).
>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/epoll.h>
>
> int
> main (int argc, char *argv[])
> {
>     int efd[2];
>     struct epoll_event e;
>
>     efd[0] = epoll_create (1);
>     if (efd[0] < 0)
>         return -1;
>
>     efd[1] = epoll_create (1);
>     if (efd[1] < 0)
>         return -2;
>
>     e.events = EPOLLIN | EPOLLET;
>     e.data.u64 = 1;
>     if (epoll_ctl (efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
>         return -3;
>
>     e.events = EPOLLOUT | EPOLLET;
>     e.data.u64 = 2;
>     if (epoll_ctl (efd[1], EPOLL_CTL_ADD, 1, &e) < 0)
>         return -4;
>
>     for (;;) {
>         struct epoll_event events[16];
>         int nfds;
>
>         nfds = epoll_wait (efd[0], events, 16, -1);
>         printf ("nfds: %d\n", nfds);
>     }
>
>     close (efd[1]);
>     close (efd[0]);
>
>     return 0;
> }
>
> --
> Best regards!
> Hev
> https://hev.cc

Is this behavior correct? any help?

-- 
Best regards!
Hev
https://hev.cc
