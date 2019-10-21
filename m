Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83530CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578672089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFaeHNsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJUGye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:54:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32968 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfJUGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:54:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id 71so7675837qkl.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 23:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ew+EeWIbh/tqMeE+5rFDb3TmVPvP26ghW75d5Js6Qtw=;
        b=dFaeHNsclipaWu2ERIrqmeUPM7sosfeU0BP3o+RR59EoFvT67V02FSKj+gA6Ig+HQi
         neYmaWsW+5c4UwwahGwcd0olDJyoJ7YK6BJGgy7BvesBTzRKGE2/TDt/ukvDG6Q4Djb6
         oAh6gbE/8bpu0NmQW/RvisFHFsv1NRbu/v0R390zJjwEa8047C8wpC59yOLz7Ss4ue0g
         wLjDKJtvKATA/L6o77A7A8y39NLlYlOIdjT+Q6QHZ5tCMmyoqy/p4UO9yeAuP1V1LNIz
         v6B4G8lEgfD+rNZdi+7o0qX0YlsCDoT5S8VULOG6rTYF8dj2G+f7DMHMmYiPRjsJXa8C
         20SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew+EeWIbh/tqMeE+5rFDb3TmVPvP26ghW75d5Js6Qtw=;
        b=Uwuej8K7+mZcx8aR1gOBZ6knT8kmzgNxG1WwYqui0Lh1S2QJwmSS9uJDW8tdXU6IbA
         QDsVleMn1949A/qAP63GP6NYV3+nIweeYYf8qIydomct24BmolhtZwmrHNgx23UBLLa9
         JOHG2O9NyZMtxvwRRYvptWtMtcU9kH144E5dvC1kuL5a83hONV98emWWm1A9kjSTH5Xf
         6bfX5DwkpJzA/Tp//M3tmWhc9rB48CxqXNB+vGtx10W9QEXGE4iGGrG/aolns8B37g+1
         NFuaEb82thmALHmaa1sAFX46cnccGlLDwGp9XmF3jjgiBCQOofQblBrQ49mYYsczccyE
         mW2g==
X-Gm-Message-State: APjAAAUBNNLi2vAQzu6L/AmcSCoOvkJjdF1bjvbUxgwp4FS/RoM9MO38
        j3NDbM1rqUj7bPStQUGnBy22etGNSOb24sjSmCYhEg==
X-Google-Smtp-Source: APXvYqwLGZMm/enYdDvmjkI2LuNStrvFJ67sk4sLbYYSRiSKeDAqgxOHCR1oZsY+eH4nd8nG/upIK48k31arWDpywLY=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr20543344qka.43.1571640872789;
 Sun, 20 Oct 2019 23:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ccde8d059564d93d@google.com> <2128256.8pjUZaGXEE@bentobox>
In-Reply-To: <2128256.8pjUZaGXEE@bentobox>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Oct 2019 08:54:21 +0200
Message-ID: <CACT4Y+b1Fkky4JZUTFpUe0jaUVpo7N59T5XTahjzkmig83Dd6A@mail.gmail.com>
Subject: Re: general protection fault in batadv_iv_ogm_queue_add
To:     Sven Eckelmann <sven@narfation.org>
Cc:     syzbot <syzbot+7dd2da51d8ae6f990403@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:33 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Monday, 21 October 2019 07:21:06 CEST syzbot wrote:
> [...]
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+7dd2da51d8ae6f990403@syzkaller.appspotmail.com
> >
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 4256 Comm: kworker/u4:0 Not tainted 5.4.0-rc3+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> > RIP: 0010:batadv_iv_ogm_queue_add+0x49/0x1120
> > net/batman-adv/bat_iv_ogm.c:605
> > Code: 48 89 75 b8 48 89 4d c0 4c 89 45 b0 44 89 4d d0 e8 fc 02 46 fa 48 8d
> > 7b 03 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48
> > 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 18 0d 00 00
> > RSP: 0018:ffff88805d2cfb80 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff888092284000
> > RDX: 0000000000000000 RSI: ffffffff872d1214 RDI: 0000000000000003
> > RBP: ffff88805d2cfc18 R08: ffff888092284000 R09: 0000000000000001
> > R10: ffffed100ba59f77 R11: 0000000000000003 R12: dffffc0000000000
> > R13: ffffed101245080e R14: ffff888092284000 R15: 0000000100051cf6
> > FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000200002c0 CR3: 00000000a421b000 CR4: 00000000001426f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   batadv_iv_ogm_schedule+0xb0b/0xe50 net/batman-adv/bat_iv_ogm.c:813
> >   batadv_iv_send_outstanding_bat_ogm_packet+0x580/0x760
> > net/batman-adv/bat_iv_ogm.c:1675
>
> I am guessing that the fix for this is queued up since a while at
>  https://git.open-mesh.org/linux-merge.git/commit/40e220b4218bb3d278e5e8cc04ccdfd1c7ff8307
>
> Kind regards,
>         Sven

Hi Sven,

It was fixed based on another syzbot report, let's tell syzbot that
this is a dup of that other report than:

#syz dup: KASAN: use-after-free Read in batadv_iv_ogm_queue_add
