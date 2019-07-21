Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F98C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CE12085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qH23uZ9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfGUO7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 10:59:19 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45235 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfGUO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:59:19 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6LEx85K013173;
        Sun, 21 Jul 2019 23:59:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6LEx85K013173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563721149;
        bh=SZy+uLkon38CCDje8/zm1tdJCwUC5JlMFjWrOj6eS5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qH23uZ9jYoKZFGSa4P+aIP/0pKT4Oc/bJ3c6w7GaRDLnPIyqK8dpvnySzrhcyYSpt
         7WrsQa/gKDQdckPN6IRx83j2Qnpm7fC9QsdEmNcIbNKXQutqHTWv56c+JVKkeHAV5A
         re4O/J+4puCJbnYeo9JHGNsyII4Pim3aNo2+4M+x6X7Z6xMcNx1o8xz3xCjGaw3KTd
         qx6TLL3BUk+ag20qdZUCUbC0m5vQQ8Md2v9vJ2/VYwx9+dTvM6PH+ld/gXjwEjxOBW
         pe4TTQ/Yncixe6peHxsMxKL8q++3++lfzfsglYB8ZXMGeKra6pKVVm3c1ug6Rvo9fy
         3jTApb+Ltna+g==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id s4so14357737uad.7;
        Sun, 21 Jul 2019 07:59:09 -0700 (PDT)
X-Gm-Message-State: APjAAAWvXhplfvq5w3bk9JF0lwWs8qlD9G7/ZvqKUZPSAgDQXbrkuuKH
        44DL8EUOPbhPRR+7FVpOWK8eeODNmx6Cj3iW3FM=
X-Google-Smtp-Source: APXvYqyAwiV3KBWoWjJD3+zk2rUIgIMU+WIFrZMBsQ9GCkP5Uzkh9pM+r0dx3Z0Jr8l4K6v3qcrgBR3JjPF41u+Am6A=
X-Received: by 2002:a9f:2265:: with SMTP id 92mr25580331uad.121.1563721148042;
 Sun, 21 Jul 2019 07:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASyzmYjjBkFxRc06rqf36-en-bvJvrKcg6iiRfjoPCxhQ@mail.gmail.com>
 <CAK8P3a2AeUpmNfFLJSvHT=AJ0kFRT2B=TWDm0HsTwoHt2jQ0gQ@mail.gmail.com>
 <CAK7LNATPbCjwzVnAigsQ8tQRXjC31uxgPg3jgi7pwp+N1RPgWw@mail.gmail.com>
 <CAK8P3a3cURmbGZc-6ESLjrF465VLnBroD4QENyfsSsCrNenRrA@mail.gmail.com>
 <CAK7LNARN=iNmresDJ2=J1wOb2QYoZ7yw4O0Q9sYVPo0jRKDf=w@mail.gmail.com> <CAK8P3a133ekPqkLWfC2ee0mT3iLbFzSjJ9FDokSyaX+hMVigKA@mail.gmail.com>
In-Reply-To: <CAK8P3a133ekPqkLWfC2ee0mT3iLbFzSjJ9FDokSyaX+hMVigKA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 21 Jul 2019 23:58:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAhhmeKtQYJYEje3B26zy3EtdqegRL7YmbsDOJ=0HcAg@mail.gmail.com>
Message-ID: <CAK7LNATAhhmeKtQYJYEje3B26zy3EtdqegRL7YmbsDOJ=0HcAg@mail.gmail.com>
Subject: Re: [Question] orphan platform data header
To:     Arnd Bergmann <arnd@arndb.de>
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

On Sun, Jul 21, 2019 at 11:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Jul 21, 2019 at 2:13 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Sun, Jul 21, 2019 at 6:10 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sun, Jul 21, 2019 at 5:45 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > > On Sat, Jul 20, 2019 at 10:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Sat, Jul 20, 2019 at 5:26 AM Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >
> >
> > Another example that I have no idea
> > how it works:
> >
> > drivers/net/hamradio/yam.c
> >
> > yam_ioctl() reads data from user-space,
> > but the data structures for ioctl are
> > defined in include/linux/yam.h
>
> That is different: the hardware attaches to a serial port and may well
> be usable, and the user space side just contains a copy of the header,
> see https://github.com/nwdigitalradio/ax25-tools/tree/master/yamdrv

Oh, I did not know that
user-space had a copy of that.


> > If we want to fix this, we could move it
> > to include/uapi/linux/yam.h
>
> We could do that, or just leave it alone, as nobody would
> tell the difference.

When we are changing structures in uapi,
it is very likely a red alert.
On the other hand, we can change code outside of uapi
more safely.
One benefit of uapi is we can catch the compatibility level
from the directory path.


>
> > But, if nobody has reported any problem about this,
> > it might be a good proof that nobody is using this driver.
> >
> > Maybe, can we simply drop odd drivers??
>
> Both the kernel driver and the user space side have a maintainer, and
> I see no indication that it is actually broken. The driver is clearly
> a relic from old times (earlier than 2.4) and we would not merge
> this driver today.
>
> It seems more useful to keep looking for drivers with a platform_data
> header file that is no longer included by any platform for candidates
> that may be obsolete.

OK.

Thanks.




-- 
Best Regards
Masahiro Yamada
