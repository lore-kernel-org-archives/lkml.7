Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0567FC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE8721726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXHR6ABY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391454AbfHBON1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:13:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43007 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbfHBON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:13:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so36133963pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5treBjW4ojfofZKzbstHsda4v5OqUABJGRx6t6ZH9CA=;
        b=DXHR6ABYqH0h3ErX1CGCyj9oFdGOkuWQz5xaeVmLGPxQHExg2mLZ8afYJcvtHmuXqE
         L20AgP7+xUJ4V7qAQs5B/BJ11bjm8pSt9u+EnbShqDMGU0uhL+rRktj+PNPGxttUDcUO
         IHhV4g3O+mQnpNSZgujQMBw0vY29Y5UlWzexdAaWhAtBOlJ7D06vuhabLGuonB0TomkS
         5SlnmCjTIB5CDwJrozyi7Go3G8ThnoANR0iexUYoHhIr0PjXnnJdp3HWMh0wexSPboUD
         +C8GOmO09pobgglUY/dTY1X3abZWEATbRdfmlraPBN2dxmD5GKuMW7DdLI3cpjayxpml
         TVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5treBjW4ojfofZKzbstHsda4v5OqUABJGRx6t6ZH9CA=;
        b=VtpdPCeZWUN5TEOL+tuE1DKdbspcgB6lEvRdk82o035obm9GtnC8KY6Kq/m16TLxic
         9YefNqnivgzvdAm34sAH2OhFEKT9XvLGU+NZeQfwgULf0vVdqGBJfEn4kan/yrlpWvi7
         uJ8bWxytmqYB1ObWJRRerGv4wUvHjpzDu2zvsN0VCCmq3RVO6KOmM7riEWMXv6xqeEfb
         VE2kW2qc89WYG+eXGlZd5X6BlRXO/CBAJSpzTpJ3Tr17Uj1TBukAuimcuroJmveIc12O
         3ZIkKOz25q+HMwXHr7F0vhFo/CGaCD2PqYL7w/FtaoRbPG4wihlZa++2Swf37tRrLG4i
         pPUQ==
X-Gm-Message-State: APjAAAXQqVxAcCJTZ/Hc6rVXuEYZCaM88bN7SA3Dlzk0t5B+x2HZDp4M
        RPyuZIfC7p2f60+SxTSV/eEGMrImoN5um0BmO8gTXg==
X-Google-Smtp-Source: APXvYqzJzMIq2BOAXKkfk2ONCggXPJ354hGozdppgPTsk/gVMr7/MXdnjVkdh4xqKYqTMjZSIuwIvWZwZ8GOnQ6Cmbo=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr123928876pgq.130.1564755206144;
 Fri, 02 Aug 2019 07:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cd0435058f21e8c3@google.com> <20190802133317.GA5538@amd>
In-Reply-To: <20190802133317.GA5538@amd>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 2 Aug 2019 16:13:15 +0200
Message-ID: <CAAeHK+ziKCz=SZss7mnWZWQXWBGyXkw5dcPfjdH-6MJLUJqO8Q@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in __pm_runtime_resume
To:     Pavel Machek <pavel@denx.de>
Cc:     syzbot <syzbot+b156665cf4d1b5e00c76@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        rjw@rjwysocki.net, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 3:33 PM Pavel Machek <pavel@denx.de> wrote:
>
> On Fri 2019-08-02 05:58:05, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=146071b4600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b156665cf4d1b5e00c76
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
>
> I asked a question, noone bothered to reply, yet you spam me again?
>
> You are a bad bot. Go away. Come back when your human master is
> willing to communicate.

Hi Pavel,

What was the question that you've asked and where did you send it? I
can't find anything in my inbox.

Thanks!

>
>                                                                 Pavel
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
