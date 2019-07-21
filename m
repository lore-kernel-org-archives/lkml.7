Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D55C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696520828
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfGUOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 10:15:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40101 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfGUOPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:15:24 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so35850681qtn.7;
        Sun, 21 Jul 2019 07:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fgIseiVrtAquhWDjVQHmGJTo29/NM2BiyqyCsBeT0k=;
        b=tST2D1luKjX2uB23aL0KnoOkDOYMIc5LuuVy00STnrxfARVSaE+R2l9GckhfFmULAh
         EmZxzCJoydZwPuyQUYRlqDk2khxcg0/37I6eN8MFCzWNb+8SONR4pmgoHy5kyFaezewM
         md4oXPHmdce/WJ791bHzF7R9HhLKEovc/GG1NAjVp4jqWCpQArl35Px8Uf9sH93GFb7n
         E0bHPBN5nUpMNozMExhtVwmDv4+56Twjx+XWVMwpL1dqhyt0dlHxyJeUdUl4+EqYCPb2
         WDs0HZU3QjF8ElxNYkYb9khba7opf50arpN9/a1Lw0EyGWk6l0L1TXcQ6Uq6FhdPbZIT
         a7Og==
X-Gm-Message-State: APjAAAV6Z3QWyaq20GsfDa+VxtJTYkEuZ9PD20r605s/kBp4PaJ9YVdI
        Qiw+X1wvW9a6aS2i8YdKtU/C7oVRNpO7d26ing4=
X-Google-Smtp-Source: APXvYqzmfpQVXcNsR7ZSo+5zgHmqeAV8HCP9yQSQY8uxhFJlST1Js4TTMvUvxzkovdtsU1jBTePEin3IcT5vrcf7Dc0=
X-Received: by 2002:a0c:b88e:: with SMTP id y14mr45073099qvf.93.1563718522909;
 Sun, 21 Jul 2019 07:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
 <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com>
 <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com>
 <CAK8P3a3cURmbGZc-6ESLjrF465VLnBroD4QENyfsSsCrNenRrA@mail.gmail.com> <CAK7LNARN=iNmresDJ2=J1wOb2QYoZ7yw4O0Q9sYVPo0jRKDf=w@mail.gmail.com>
In-Reply-To: <CAK7LNARN=iNmresDJ2=J1wOb2QYoZ7yw4O0Q9sYVPo0jRKDf=w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 21 Jul 2019 16:15:05 +0200
Message-ID: <CAK8P3a133ekPqkLWfC2ee0mT3iLbFzSjJ9FDokSyaX+hMVigKA@mail.gmail.com>
Subject: Re: [Question] orphan platform data header
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 2:13 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Sun, Jul 21, 2019 at 6:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sun, Jul 21, 2019 at 5:45 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > On Sat, Jul 20, 2019 at 10:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Sat, Jul 20, 2019 at 5:26 AM Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
>
> Another example that I have no idea
> how it works:
>
> drivers/net/hamradio/yam.c
>
> yam_ioctl() reads data from user-space,
> but the data structures for ioctl are
> defined in include/linux/yam.h

That is different: the hardware attaches to a serial port and may well
be usable, and the user space side just contains a copy of the header,
see https://github.com/nwdigitalradio/ax25-tools/tree/master/yamdrv

> If we want to fix this, we could move it
> to include/uapi/linux/yam.h

We could do that, or just leave it alone, as nobody would
tell the difference.

> But, if nobody has reported any problem about this,
> it might be a good proof that nobody is using this driver.
>
> Maybe, can we simply drop odd drivers??

Both the kernel driver and the user space side have a maintainer, and
I see no indication that it is actually broken. The driver is clearly
a relic from old times (earlier than 2.4) and we would not merge
this driver today.

It seems more useful to keep looking for drivers with a platform_data
header file that is no longer included by any platform for candidates
that may be obsolete.

        Arnd
