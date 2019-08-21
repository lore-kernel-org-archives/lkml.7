Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87659C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9FE22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjstqJzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfHUQuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:50:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35542 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUQuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:50:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id gn20so1639146plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dNLL8R5Ozl+yUbTTz0wtZ6BTtTLjEvK9s2CYPkCtL7o=;
        b=GjstqJzqiWim4DDuwFd0g+cGejELz5UNq4QiK/WmnN0FNkrbmqOkdW9duNhHU8gZ8K
         xVfQk91OUNALPQghxN4Aq/ItuVzKWI783T40f5LeRpverVYuRi+XzcMBCmmWaOhNE9bf
         grRYIod7QwSfSnxzRMpSn6cDVgx30+dTKt+rzVulZduUmsXf0IkVIb8Qo3v4uLXv4hW5
         38zk9tBVS7EFMKtZMdULMVMZmpqTkaV+kH0JHobeNMAUhdFPTIlVf5tmTMs8I3XEO9wz
         1d4JWpi6iRZQzAdIHWwxJkd8JaKn89mF5AUHAt38THIZwALYKRnxmvi4S0s3wZG9KvbA
         488g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dNLL8R5Ozl+yUbTTz0wtZ6BTtTLjEvK9s2CYPkCtL7o=;
        b=fSfRMMkA3jZXRZHNCfNvo/FjB+5poJHM9bLEywcrOTMSYlqNt3841HNRn2JxZTB5a3
         H/kDvz53rd4832JaXjXY2qHUNsV769wnCas9m/Pe2cnzTflz7KYaUdSeieXM9pPWBLw7
         MqW73kY0svSfPkOev+RHDF2rSa5YLfdUMSYr0tF2UFnN2r8KZ9Se+mw/1vU51y8LQiwH
         8yun7WFtEhFzbBxkUVcL94WxJmDuCgh+p1aOQKsvq9MLrSaismzjn7sSKgM8rXVeWl1J
         SyeLcd+JlmRtXAEHUG1Waafg+DrV8xMOLX439oMsHgGdf1s8V0nhY2kPd62xmTFNyfi1
         PRQw==
X-Gm-Message-State: APjAAAXwL+rLE7Txu/p6cVb2XCTi9RwBeCMYikIkfcChhP16460DacoW
        DLXI6gNmHjOuSgBMBF5k1NZgsdZuxxqbXeqXakXQ7w==
X-Google-Smtp-Source: APXvYqwBHQIFOZROdviPAJyQpfy7Sdu0wRt4psMOkU0xAa072gIO1No42ZEB2yB7154bHv1rVbQaSGSFW9+M9hc6WRg=
X-Received: by 2002:a17:902:ab96:: with SMTP id f22mr35635682plr.147.1566406238620;
 Wed, 21 Aug 2019 09:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+xQc5Ce6TwtERTmQ+6qSbuAmGikxCU5SNTdcDAynDEiig@mail.gmail.com>
 <Pine.LNX.4.44L0.1908211223070.1816-100000@iolanthe.rowland.org> <CAAeHK+z-o9naQXZoxwTXRh2WWQzFiRU9XruabNTTm31_1AbjAw@mail.gmail.com>
In-Reply-To: <CAAeHK+z-o9naQXZoxwTXRh2WWQzFiRU9XruabNTTm31_1AbjAw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 18:50:27 +0200
Message-ID: <CAAeHK+w=iNkgfBx2BCO8qSYrgVA+E6z_WjoOnCqH0dDbT0v95Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hidraw_ioctl
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 6:26 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Aug 21, 2019 at 6:24 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, 21 Aug 2019, Andrey Konovalov wrote:
> >
> > > On Wed, Aug 21, 2019 at 3:37 PM syzbot
> > > <syzbot+5a6c4ec678a0c6ee84ba@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch but the reproducer still triggered
> > > > crash:
> > > > KASAN: slab-out-of-bounds Read in hidraw_ioctl
> > >
> > > Same here, a different bug.
> >
> > It looks like I've got the fix for both these bugs.  Testing now...
>
> Great! Do you think "BUG: bad usercopy in hidraw_ioctl" can also be
> fixed by one of those fixes?

We actually have a bunch of other non reproducible bug reports that
come from HID. I think I'll dup them into these two bugs that you've
fixed, and we'll see if syzkaller triggers them again once the fixes
are upstream.

>
> >
> > > > Tested on:
> > > >
> > > > commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > > > git tree:       https://github.com/google/kasan.git
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14f14a1e600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=171cd95a600000
> >
> > Why don't these patch-test reports include the dashboard link?  It sure
> > would be handy to have a copy of it here.

Sorry, didn't notice this comment. This should be easy to implement,
I'll look into that, thanks!
