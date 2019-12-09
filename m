Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 01:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5D12070A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 01:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLIBiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 20:38:01 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51863 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfLIBiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 20:38:01 -0500
Received: by mail-il1-f198.google.com with SMTP id x2so10430873ilk.18
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 17:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NBRTp1Zx2xI7oM56oPmPu5F5+f3m5zadk7OaCVsc/GU=;
        b=MZrrbPQ7fyxDMWBEui76qi3mYSvmpQk9npi+/471F8gejOQcmnJKdzHebLn9/pdFyk
         wh2VYbyTFY3WsiYvbZhaX7v3Vuxt769EUNOcx+HPUsm0kbFKk8FNyo0Q4ymAJ1Poo+vp
         YV6B263yTVtqk5NmbUpYpsbV0qEmJp25Tf/In0Y7gFED79IvoJUAAZTRev1Wf+yAtpK2
         Ea7UFBO9OQd8sTzJdh7VX4Pz8rGttEfnQLDJM6R3kZAcm3D2Km6WiuisU+7cTJtm5AZG
         72MlVpaS9Pi53vevvCIE5yoQhJ0NLCADLuVtecS6VGbNVoJMP+bJPaa/mIAx14ZUo5kz
         6DXg==
X-Gm-Message-State: APjAAAVdwE2S/osysQvtj6shQ7GCdZ0RU4fZqcB6dTwGgcCTpheMcp4o
        mls672fkwUm8CRq0v+0OFbaYE2O65ey45PAxuudcind8HJ6L
X-Google-Smtp-Source: APXvYqyu9tb/aYS5ijtRbPRdV2KRezH9PuVrldZ+EPRXMCfDvdTQ1hMdClCkEtkgy6GwmBLL9Qkg2mc6RVf3iZrkqoDoe9eYRFiC
MIME-Version: 1.0
X-Received: by 2002:a92:d38e:: with SMTP id o14mr26733266ilo.238.1575855480469;
 Sun, 08 Dec 2019 17:38:00 -0800 (PST)
Date:   Sun, 08 Dec 2019 17:38:00 -0800
In-Reply-To: <000000000000f6e29f056a2edff8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000217e8d05993b7298@google.com>
Subject: Re: BUG: Bad rss-counter state (3)
From:   syzbot <syzbot+f2a1633f249cece865fe@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, hughd@google.com,
        jglisse@redhat.com, khlebnikov@yandex-team.ru,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 173d9d9fd3ddae84c110fea8aedf1f26af6be9ec
Author: Hugh Dickins <hughd@google.com>
Date:   Fri Nov 30 22:10:16 2018 +0000

     mm/huge_memory: splitting set mapping+index before unfreeze

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14202b7ae00000
start commit:   a27fc142 Merge branch 'parisc-4.17-3' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=adeb81fdb5db9d72
dashboard link: https://syzkaller.appspot.com/bug?extid=f2a1633f249cece865fe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1257325b800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163bb567800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: mm/huge_memory: splitting set mapping+index before unfreeze

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
