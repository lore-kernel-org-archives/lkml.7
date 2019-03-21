Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E47CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9DC218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asZujfjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCUGBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:01:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44466 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfCUGBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:01:07 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so4283379iop.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 23:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPtR+Mv0BsS4tjWXTg1n9CAjOobeYmYcaxR4lx6FSgA=;
        b=asZujfjXjIN3F1ki9QLI73gdqziMe/LG3PWt/jZ5dlPX7lMsCfhPo0qseY+izmEe5d
         1cKPnbxlZmc71xyLz7kch+6rsqPVHQSqMd1hYunERP52IDg/kGtDZVPbzlB9dfZM4ijk
         dI3XpW5VDOb0XpTJLrkABfHNkj4T1ww+aFSN3h4MePGi5jnlb3WiUuWBDLyHcpudxakg
         GnfYX3Soj8E1GO/J/Cl82Lvvo72Jso4KhPepQl0BvhWUAkbB8WKrNL00WIY2wMTlFfUe
         NznG1Y9orS2pfTqLCR6Ip5wEP4MSTCs6GmNiDzB9IqdKD0wKKYsHeekg67IYKhbTN7Q6
         hdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPtR+Mv0BsS4tjWXTg1n9CAjOobeYmYcaxR4lx6FSgA=;
        b=Vq4Jctwu3uflzEtnAK2wNtixSDWHcKaPcbCFhAUsM7FVRHEzrQC/blgq2BIMuqnBhL
         uS8bF3vk6VT1KR0cTeTL+shSsYXblulULRfShzbUD+2tAHVy+r0Dsm0TBCPMcEbscYFs
         /tBNREcTpnpmcjbCIyw3G47YF089B+csWp+ftIPrdHaHVfuTFKfmmxMjKFtzqkP/wP7N
         bqseT6b/AYXyamsIG8YtAlIfXQ8H4UD09M2+h5mOWSnIRY25PMEIa0LYNRwIYMtqoiCk
         qS0faoo0FDGQGrksfK309sFA/J2H8h1NW1a0qIQSToNVO8ctLDUCRasEjhBsVO+iIzao
         sqhA==
X-Gm-Message-State: APjAAAUelv6srIJQyOW/vjPJmY0XvK0ojdUml62S4JOJyxKFuzYkPISy
        yfFeiRkh7IZx/nO5jz9F3urrfZFGzUPnndzY6nEEgg==
X-Google-Smtp-Source: APXvYqwh3wzpKkdRJVvdfy0J9d8lyG/oA3+p9VkabiV/oQk+sgAEEXIklU3EV4EHhD4Eldm2Hk7sQX8C5fKNW6DTCOc=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr1249753ioa.282.1553148065675;
 Wed, 20 Mar 2019 23:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005b7456057a9abc57@google.com> <000000000000c6a7d005848cd56d@google.com>
In-Reply-To: <000000000000c6a7d005848cd56d@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Mar 2019 07:00:54 +0100
Message-ID: <CACT4Y+aE4Pi85OH-vDzNkSVxo6Qw3vgN94KGtF7PTWUcHwMAeA@mail.gmail.com>
Subject: Re: kernel BUG at mm/slab.c:LINE! (3)
To:     syzbot <syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 9:55 PM syzbot
<syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit b8a51b38e4d4dec3e379d52c0fe1a66827f7cf1e
> Author: Stefano Brivio <sbrivio@redhat.com>
> Date:   Thu Nov 8 11:19:23 2018 +0000
>
>      fou, fou6: ICMP error handlers for FoU and GUE
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161b63cf200000
> start commit:   b8a51b38 fou, fou6: ICMP error handlers for FoU and GUE
> git tree:       net-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=151b63cf200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=111b63cf200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a0a89f12ca9b0f5
> dashboard link: https://syzkaller.appspot.com/bug?extid=2182db487a523d86bf34
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148d46d5400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c6a225400000
>
> Reported-by: syzbot+2182db487a523d86bf34@syzkaller.appspotmail.com
> Fixes: b8a51b38 ("fou, fou6: ICMP error handlers for FoU and GUE")

That commit caused lots of crashes that look completely differently.
Now all that is fixed. The last crash for this bugs happened 2+ months
ago. So let's just do:

#syz fix:
fou: Prevent unbounded recursion in GUE error handler also with UDP-Lite
