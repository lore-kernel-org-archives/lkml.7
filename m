Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A418C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7BD205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 11:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUSmaBFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfHNLcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 07:32:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42976 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfHNLce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:32:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so2638985pgb.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MF7jMNepz1wdVPgQ1SCooo7k7btOrltx/wKQg+y/GsA=;
        b=cUSmaBFdYOwqXrkSpi2SHCWiWNzTtlXihjcmXOVqkDl+X3n5d6peoCGvuYwgX64MqL
         3w2UzzDyfZu0hfAU0lFABuw+Jx2QQySxZ8wFRwIlGIY7OxsvXkuM24aClrgd5BDVkt3S
         WZWQjzicuFTY2WaLJVE4TowEXGrnoyST9NVe8UpN5Hq+5g9Y7NTDxGNJ9pj82Xev2xou
         ImULti9r2uMXMeGwdPlBd119/jITjOHMHvdG6iACS1VVifw2mwiInWCMfp4BhMf/hxoH
         fysDbWyizAW+Mp9h1asFijLvf66MdVAAiwQXyIBRQB6ViWm+rix8TlfWqFOBiu6f24pG
         vriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MF7jMNepz1wdVPgQ1SCooo7k7btOrltx/wKQg+y/GsA=;
        b=afuZ4kzJdOx2+40HlyVRTVHXa6RnEcuQEwcfve+s/kh9g3pr0w8dVZZ1t3fb9Aq8fp
         ++igqtOzaLUukAzZFi8oQI6csj2ojxjibg/CbsODdSLLcqhSJm3mTIxbnPmPnpeeQ6Er
         iZG+HmPGfp8ZJlH6xtzJcmNtXBj/ZSpIEbBHWG6zm/xtTAEsKgFZoPmchso1eLD+2jXi
         PSNJPehNxP6m14ankr350hMKK3KYb1nTN4qZmaU4Y3YSd5jcyZTnAWh+ZT11Yz+lMi79
         vqvnbBfLJsx8+n5Smoia4U+d9WVT6fra3VpD3VMN31tA3ntL6K3xUIuTopPlNWrb/sVa
         Kv5A==
X-Gm-Message-State: APjAAAU1AxVJ9hrIlxc+NRa1Wrvci4bvVfv7ku9bHrc+HkXt8IA0XGwu
        8o6jZaGVJhEPjG9ipyHL0Hd68w2Vxeg0Pnc1C1A2Lw==
X-Google-Smtp-Source: APXvYqxa1i+/yJ7X44W26il0CSBQveyXOF7jDDdUxdID5l1/hjOMDzF9/5eHbAzZ0E9FEdefJrW5A8OnVzmLhKHHRo4=
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr6772187pjn.129.1565782353721;
 Wed, 14 Aug 2019 04:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAAeHK+zPDgvDr_Bao9dz_7hGEg+Ud6-tj7pZaihKeYHJ8M386Q@mail.gmail.com>
 <00000000000054f8bd058ddfa341@google.com> <CAAeHK+xZRH9-ue0QyEdiWmbFJF6P3RXMud+tE6t3x6Orcxnbkg@mail.gmail.com>
 <20190813205104.pnyan3kafz26wsse@gofer.mess.org>
In-Reply-To: <20190813205104.pnyan3kafz26wsse@gofer.mess.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 14 Aug 2019 13:32:22 +0200
Message-ID: <CAAeHK+y3MHoeAgOtAW0pTaTBFeVzXmNpCnazsYT0wJMqhmzd0w@mail.gmail.com>
Subject: Re: KASAN: global-out-of-bounds Read in dvb_pll_attach
To:     Sean Young <sean@mess.org>
Cc:     syzbot <syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com>,
        bnvandana@gmail.com, allison@lohutok.net, hverkuil-cisco@xs4all.nl,
        LKML <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        rfontana@redhat.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, tskd08@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:51 PM Sean Young <sean@mess.org> wrote:
>
> On Tue, Aug 13, 2019 at 03:22:49PM +0200, Andrey Konovalov wrote:
> > On Wed, Jul 17, 2019 at 2:29 PM syzbot
> > <syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch and the reproducer did not trigger
> > > crash:
> > >
> > > Reported-and-tested-by:
> > > syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com
> > >
> > > Tested on:
> > >
> > > commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d90745bdf884fc0a
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=1454f4d0600000
> > >
> > > Note: testing is done by a robot and is best-effort only.
> >
> > Hi bnvandana,
> >
> > Could you submit this patch? Syzbot testing shows that is fixes the issue.
>
> The patch had issues (see discussion in the thread). I created this patch
> but I see now I did not include the correct Reported-by: tag.
>
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg148889.html

No problem, we can mark the fix manually:

#syz fix: media: dvb-frontends: use ida for pll number

Thanks!
