Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4EBC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFFF24659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfLFQeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:34:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:49367 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLFQeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:34:02 -0500
Received: by mail-il1-f197.google.com with SMTP id t13so5630593ilk.16
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=eN4yK+b1Bwvylv7Nm0VpeOFgnJkXHsh0eveEUiwrQH8=;
        b=iySw4DAAmH4AW5SW3HFPi8KufYsC6kbtKEJtBfu212yEJA7EkRgfbKFusXVdIsm7za
         SPUW9wEUSpwq+t0bAnvlTepTaR1wXpxDc7oqG1H2HP8gu0MZkX8XXXutrIH3d1x/PVdO
         JCdKVUGqDTnFxzOd0dJ9GJ6nVeJgkLVrs9Z8iOyUuYqQ3ylVDi+Ao4XoGmgU9E6qDcvA
         Lvjgi/hv28VZ18y3eqmxr33IV8+sKj2+Tszq52FsZC73PO/qOel2SdtPNkdNHZGDqn2x
         UZfjewyRF7NuunD2eUoz47gvoZk8BZfN2bEjKniHjPFQrKpyuT//0ekszg/wdvX+vsXu
         lvDw==
X-Gm-Message-State: APjAAAWC9oDVNXzzKwvCMPraJKyo1aYgV9vDK3BTJKpdBOHLz2p85A0C
        X/FO0O9PVlncR+6tWHFUucnMUkipMeT/lBOR9/vF35TsaicK
X-Google-Smtp-Source: APXvYqzZYpNyvisihbt8EN3KnLhQ+QrZm3JeQEpbdA8h9nBmjE1AdDXOmVmenOawWmDOfOfWECCiqsoRsetDdfRKflEyZvm4mUC+
MIME-Version: 1.0
X-Received: by 2002:a92:4891:: with SMTP id j17mr14417440ilg.33.1575650041118;
 Fri, 06 Dec 2019 08:34:01 -0800 (PST)
Date:   Fri, 06 Dec 2019 08:34:01 -0800
In-Reply-To: <000000000000e1d639059908223b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdd04105990b9c93@google.com>
Subject: Re: KASAN: use-after-free Read in soft_cursor
From:   syzbot <syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, coreteam@netfilter.org,
        davem@davemloft.net, dri-devel@lists.freedesktop.org,
        gwshan@linux.vnet.ibm.com, kaber@trash.net,
        kadlec@blackhole.kfki.hu, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, ruscur@russell.cc, stewart@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2de50e9674fc4ca3c6174b04477f69eb26b4ee31
Author: Russell Currey <ruscur@russell.cc>
Date:   Mon Feb 8 04:08:20 2016 +0000

     powerpc/powernv: Remove support for p5ioc2

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1512d1bce00000
start commit:   b0d4beaa Merge branch 'next.autofs' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1712d1bce00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1312d1bce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=cf43fb300aa142fb024b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1745a90ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361042ae00000

Reported-by: syzbot+cf43fb300aa142fb024b@syzkaller.appspotmail.com
Fixes: 2de50e9674fc ("powerpc/powernv: Remove support for p5ioc2")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
