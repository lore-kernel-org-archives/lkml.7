Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D919C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612CA2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0Kg8Gm0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCNQQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:16:48 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38681 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfCNQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:16:47 -0400
Received: by mail-yw1-f65.google.com with SMTP id m207so4869622ywd.5;
        Thu, 14 Mar 2019 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ktaUV3fMFadix+0Z6ctybnKLcsuwszmrSG1OINS11g=;
        b=P0Kg8Gm051GGZnKv3tgLZdVWxZUALC+FgLYCwj/MOLKxU4gCM34jsuPZD0B6Fm7Szk
         jiTSz8EyCJgb7nI9YH37BouaBMOvePqXxdttxOwokuU/nFOgtucEaoyP3CbB4GlRGCY4
         NrvliTk4k2Ap7N8NQAb5wIEQwK9CMM0Lg2B+lCj18/XKtA0nqn+vW8+cpeGQrohGk/cG
         LcVGXjQsm7XoHASa9TSUcZS6eck/QzZ5xUyHTKLqb4NvMd1BMap4/+ns8iUzexvFRXxt
         NY5quK8y3O8N4DpjB6MRwXLHC8P7Vwlquovv3PCy74XJh6IFR7woMEbdXxVb8NEzYZGK
         Sljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ktaUV3fMFadix+0Z6ctybnKLcsuwszmrSG1OINS11g=;
        b=MXvi80gKmc0LmKuaM1BfQ2BoyJCrYpTEIWzalS/j7u+HfPPTeUXKa6B5tuBhC1Kk41
         cAk99A7btn6iUN1QH17+HTEohHzjhfH1BtsQi7rqkUQypPqXzEIvW3XpvR0cq5yGvO3J
         PUOSYdBkVl8V+9hobGA9EfJnR3kNkGHngpx+crTHyTr+UraTv7X/lYE8maCkXUt0haXv
         5MVjWTJ2U9M2JiVb0IpdjX2q610l9yfM1GgMrvFrFgXZ1cv2kShwbEkbuZrKh0H7IHFy
         MZ+UVoiHD5iN+UdddlRnjnK9Y9Fd+3lxSVFWmXW4h/YUcrUVZ6TOojJGMLu6VxnW5SjS
         uKyQ==
X-Gm-Message-State: APjAAAUT6uEMqAHLaOxzQggz8clE3IswsS30J7oeiH9ReLXO5BZIYElf
        lU+pnkwL9JnbOxK+RMSI2GyLq2NOPzBUTFGYeZE=
X-Google-Smtp-Source: APXvYqxF42jYjMBTZKD5Te8Y2GoxTpuu156u3a4IQ4LRlwwnn1Q5YzLcSWOxMprk34wQ4paWh4tyqwtnQyDJeQA+bqk=
X-Received: by 2002:a5b:642:: with SMTP id o2mr40888379ybq.32.1552580206382;
 Thu, 14 Mar 2019 09:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <201903140234.4FpTWdW3%lkp@intel.com> <20190314083758.GA16658@quack2.suse.cz>
 <CAOQ4uxhZH9=U63J1_bVrMbNO-Quy-8S300Qi6VmZxvKwYCogQQ@mail.gmail.com>
 <20190314123811.GH16658@quack2.suse.cz> <20190314143158.GC27249@linux-mips.org>
In-Reply-To: <20190314143158.GC27249@linux-mips.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 14 Mar 2019 18:16:35 +0200
Message-ID: <CAOQ4uxiEkczB7PNCXegFC-eYb9zAGaio_o=OgHAJHFd7eavBxA@mail.gmail.com>
Subject: Re: fs/notify/fanotify/fanotify.c:198:2: note: in expansion of macro 'pr_warn_ratelimited'
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jan Kara <jack@suse.cz>, kbuild-all@01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 4:34 PM Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Thu, Mar 14, 2019 at 01:38:11PM +0100, Jan Kara wrote:
>
> > On Thu 14-03-19 14:01:18, Amir Goldstein wrote:
> > > On Thu, Mar 14, 2019 at 10:37 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > AFAICS this is the known problem with weird mips definitions of
> > > > __kernel_fsid_t which uses long whereas all other architectures use int,
> > > > right? Seeing that mips can actually have 8-byte longs, I guess this
> > > > bogosity is just wired in the kernel API and we cannot easily fix it in
> > > > mips (mips guys, correct me if I'm wrong). So what if we just
> > > > unconditionally typed printed values to unsigned int to silence the
> > > > warning?
> > >
> > > I don't understand why. To me that sounds like papering over a bug.
> > >
> > > See this reply from mips developer Paul Burton:
> > > https://marc.info/?l=linux-fsdevel&m=154783680019904&w=2
> > > mips developers have not replied to the question why __kernel_fsid_t
> > > should use long.
> >
> > Ah, right. I've missed that mips defines __kernel_fsid_t only if
> > sizeof(long) == 4. OK, than fixing MIPS headers is definitely what we ought
> > to do. Mips guys, any reason why the patch from Ralf didn't get merged yet?
>
> Paul's patch :-)
>
> As for the reason why the definition is as it is - 32-bit MIPS was
> born using long, then in 2000 64-bit MIPS started off as arch/mips64
> using int.  Eventually the two ports were combined using:
>
> ypedef struct {
> #if (_MIPS_SZLONG == 32)
>         long    val[2];
> #endif
> #if (_MIPS_SZLONG == 64)
>         int     val[2];
> #endif
> } __kernel_fsid_t;
>
> A desparate attempt to use asm-generic where ever possible then resulted
> in the confusing definition we'e having today.
>
> Normally APIs are cast into stone not to be changed.  But fsid is used in
> struct statfs and the man page states "Nobody knows what f_fsid is supposed
> to contain (but see below)." and f_fsid is supposed to be opaque anyway so
> I'm wondering if something could break at all.  Researching that.
>

Its content is opaque, but its size must be equal to that of fsid_t
from glibc/toolchain headers. Do the mips32 glibc headers also
define fsid_t as long val[2], or do they define it as int val[2]?

Thanks,
Amir.
