Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F4C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA857206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOoBJWqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfJJPhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:37:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34464 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfJJPhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:37:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id k7so2984207pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2rFG8brthk+yAj45DH5mKNIDigDVTcT8mTC8jWGGo0=;
        b=JOoBJWqSyjf6X8szeBRsDC6LkOh5ptq4UUCbbCWkPyb7EsSTEb3M6NXtkyyJ7TX9as
         eP3KlHAf34IAV4FEq/lpIc/5Ep+JxDRdwJBer0BnpWVIpzeDOMzNIKDQdlz/Jo2+URl1
         Wa9pOZHaNYb/mX5Kkxjo4T2vxRH6hSoQHL2kP1pg/HLJ3onEm25CKU6QsBO2GZfhJer1
         oyrys/Re0wx1hofXKtgO39DWHccjHdmvKpMeqQZ+cmDm4U3KTviLdPsFXyhSk2sDCr+8
         TSnm8V2ieaY4tjv9Xdef0frjl7K5oczyJLijEUpOcXn5eOBZnbIveAEwAajyxaMgqtgf
         SJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2rFG8brthk+yAj45DH5mKNIDigDVTcT8mTC8jWGGo0=;
        b=VkA32elT5VX4xOuuwuNWKVJgn3AQAWpOm49JIKlkuXcdbjZrWtGxVEfNo5ds6TuovE
         Uq8pHy/pbezKiqFZ+9NC5HkVU6bVG4OkUh4yEfivEY3wxxGda4Yh7uDv+y1awB/6eh59
         J96efa9WPldvSYyUYbsZ2KjXOoNF33+0rI08iEi5CM8EjFskyjwpueY2PFlfko1r9wrk
         O5DzvHpJWoWyS7nGtsr8tF0F0ranvQ0/khFopnNFFX9CAtJz8wRdAkfs8PL/S0ORVjuC
         igkBsl2k23ppTHn3P2yPT6CFmelu0dD4/kQiPg840aNkoYg0rs/4ivCwfUYST0A9MY9N
         9JZw==
X-Gm-Message-State: APjAAAU6rvx9aZQvvA87JOcHpPGprvxgeXj7wNK6O6wy33GjWh92srQH
        JkyZya4rSxYaKN1KnxWHbYuuAi264A/Zsmn7viDD1Q==
X-Google-Smtp-Source: APXvYqzeI6lIk0oZVnkyUaIveVA3axZTTzjzdyNo7JQ7knndG80eRIVovNFBN8bSwTYsZVBJ0Ey/9v1Jkvcn6z2mQOI=
X-Received: by 2002:a17:902:9696:: with SMTP id n22mr9390927plp.252.1570721826604;
 Thu, 10 Oct 2019 08:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+wE8ngx2Pa9=vD6Fw6MCbHpxfX6ss97deQUsmGD_Bw_Bw@mail.gmail.com>
 <Pine.LNX.4.44L0.1909241031550.6144-100000@netrider.rowland.org> <20190924143804.GA623902@kroah.com>
In-Reply-To: <20190924143804.GA623902@kroah.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 10 Oct 2019 17:36:55 +0200
Message-ID: <CAAeHK+yj91+aNcyrAhWr8UGjSQdWqs0ZMHe3wAaBSvf=mjaCyw@mail.gmail.com>
Subject: Re: general protection fault in open_rio
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 4:38 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 24, 2019 at 10:33:12AM -0400, Alan Stern wrote:
> > On Tue, 24 Sep 2019, Andrey Konovalov wrote:
> >
> > > On Tue, Sep 24, 2019 at 4:19 PM syzbot
> > > <syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    d9e63adc usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1602b303600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f4fa60e981ee8e6a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=dbd38fbb686a9681143a
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > >
> > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+dbd38fbb686a9681143a@syzkaller.appspotmail.com
> >
> > > Most probably the same bug:
> > >
> > > https://syzkaller.appspot.com/bug?extid=745b0dff8028f9488eba
> > >
> > > #syz dup: KASAN: invalid-free in disconnect_rio (2)
> >
> > Even more to the point, a patch was recently posted to the mailing list
> > to remove the rio500 driver entirely:
> >
> >       https://marc.info/?l=linux-usb&m=156925553004947&w=2
>
> I'll be queueing this up and just marking the driver BROKEN on older
> kernels to solve all of these issues :)

#syz fix: USB: rio500: Remove Rio 500 kernel driver
