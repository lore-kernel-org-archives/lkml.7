Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70AE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCRM46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:56:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45858 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCRM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:56:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id z76so9500592qkb.12;
        Mon, 18 Mar 2019 05:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbznIPzM2BgncPvp1B//in4xD6d5diVRzoE2nT7OyNo=;
        b=L0s3JQ9qT7pOOMnyBB5tN230IvgnvzpPqivMMUrqY5TjEJkTNCvXukRq5EmVhzLaJY
         6HidHWpGWkeY4U2ITKTZbqgptK0eM9nnFci7CL1eCPvOeKNMvEaSSx03F0Ysf0NFVPUu
         knx5d8X3vEaoIbEBts/RQUGVLEhJNnZjTGHzyR22JsQh6DhRnBNMdOylQKfL7HwxoquO
         d2FOoW1PEDKp7m5ZSfv7U0z3w5HIyj9euH89hvC43CBs59EjmeC9+ZtgT38Ne++OAK6L
         JZKAfL8r1dyyzLZJ/tizWVs6MnuUY5/LeFB4s/M2e2rvhFs/EX1YRZSuCSpPJmTz5gFy
         NHbw==
X-Gm-Message-State: APjAAAW2vTa33cyC4q5APCf+CnM1Nn2ianPrSUt7IMiZupVOXZdx5iBp
        zt7yiXHZ/DooASexeqa9apios5ovcaryIJxV8Vk=
X-Google-Smtp-Source: APXvYqwo1IOLoOSgK6A7+Oy7GycMQfbaeGLUR4WKJyErb7+OewKwgqrieSWH8nM/HC37Zf96n2Jcefsrz2Y2n1+rIeg=
X-Received: by 2002:a37:b386:: with SMTP id c128mr1450085qkf.330.1552913816352;
 Mon, 18 Mar 2019 05:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190311153857.563743-1-arnd@arndb.de> <87k1h1fgkk.fsf@mid.deneb.enyo.de>
 <CAK8P3a1r8GRC7GTHHqWY-PUn=9rWB-7+Qo=7txanbEjGZ-wppw@mail.gmail.com>
 <87a7hvded7.fsf@mid.deneb.enyo.de> <CABeXuvrEecSAkBuN-SmAbGwhLWNCC+bA1=X78fm8xMyw8=hm6Q@mail.gmail.com>
 <CAK8P3a22n5L45Gknqd=2zinVGqRovkk0OABmGLJbGcmg8xXd+A@mail.gmail.com> <87o968y1uv.fsf@mid.deneb.enyo.de>
In-Reply-To: <87o968y1uv.fsf@mid.deneb.enyo.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Mar 2019 13:56:37 +0100
Message-ID: <CAK8P3a1DzRhiuNxBeQaTYSX1NhCaN6+B0Ya7aeGfxUGj35LFhw@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 10:25 AM Florian Weimer <fw@deneb.enyo.de> wrote:
>
> * Arnd Bergmann:
>
> > Should we just remove __kernel_fd_set from the exported headers and
> > define the internal fd_set directly in include/linux/types.h? (Adding the
> > folks from the old thread to Cc).
>
> The type is used in the sanitizers, but incorrectly.  They assume that
> FD_SETSIZE is always 1024.  (The existence of __kernel_fd_set is
> itself somewhat questionable because it leads to such bugs.)
> Moving around the type could cause a build failure in the sanitizers, but I'm
> not entirely clear how the UAPI headers are included there.

It looks like sanitizer_platform_limits_posix.cc includes
linux/posix_types.h to ensure that __kernel_fd_set is the same
size as __sanitizer___kernel_fd_set, and then it uses the
latter afterwards.

What I don't see here is what kind of operation is actually done
on the data, I only see a cast to void. If libsanitizer actually does
anything interesting here, we should definitely fix it to use the
correct size, especially since this is actually something that
can trigger a buffer overflow in subtle ways when used carelessly.
See for example [1], which we still have not addressed
(I suspect we actually need to have glibc use __kernel_long_t
instead of 'long int' here, but that is a separate issue, and
not overly important given how few users there are on x32).

For this specific use (and probably others like it), renaming the
fds_bits member to __kernel_fds_bits or something like that
would keep user space still compiling. That would only break
if someone was using __kernel_fd_set, and actually doing
bit operations on it. glibc uses '__fds_bits' unless __USE_XOPEN
is set, so maybe we should use use that name unconditionally.




> Otherwise, I couldn't find any uses.
