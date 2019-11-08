Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D4020656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbfKHTYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:24:10 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:43588 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732051AbfKHSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:53:01 -0500
Received: by mail-il1-f198.google.com with SMTP id d11so7824112ild.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Sl9ZT+3VnhHk9C9hUuWzxJC0ZnzOKIM3/flYfXRQH6Y=;
        b=ndKcHQXjIYsuRcJpTPlCUgeSFOC26Du1+s23EirNwPEi/IzwaiJZLSIhWD90769yMG
         wBfzK0VVASOoUJZah1vZwAzRYFqePMIFS3z0V13ed/ZYvQDtgziG7wuNdqovfHYTxdBZ
         2ANwbMaj0JwpKZOL5sy322HoMAg004Y49sf2A8o50KyWpijInfwF3+fTRxiZU8Uub1ly
         ag58NSRvdg0y+xeGKLGNQ5ALmLY6Jj9WL6k4Y2a+cRDyIIeRkXntFpxW8WXHE1u2n6y9
         coOlUqAMr0W1vK1VJNW/UC9gpgwAYCBdU8VsFbJnR5oWR1l9jyNH1zI0giAALbH02KRJ
         rqGQ==
X-Gm-Message-State: APjAAAXwbMOYqB1lfSxQwoxO8k76SoDugeCcftTOphhClLCXaUAqD9UY
        xpAibYPSAvg2cCXLvZ0ypdszLvu5P+piSBwzgAyflHb9wVDX
X-Google-Smtp-Source: APXvYqzQP9CYRfTlLHLsV6QBEQYBhPgI8bypq0U9hHsKzSMeEB/CVu4ed4IzOfkvt3dGwLP0hHzE142Gz/VsIc1tEwnjoCJ+zd1h
MIME-Version: 1.0
X-Received: by 2002:a02:c4cf:: with SMTP id h15mr12593320jaj.112.1573239180629;
 Fri, 08 Nov 2019 10:53:00 -0800 (PST)
Date:   Fri, 08 Nov 2019 10:53:00 -0800
In-Reply-To: <0000000000005e2bf90570bbe2ab@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000821d620596da4ad0@google.com>
Subject: Re: KASAN: use-after-free Read in ep_scan_ready_list
From:   syzbot <syzbot+78b902c73c69102cb767@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net,
        dominique.martinet@cea.fr, ericvh@gmail.com, jiangyiwen@huwei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com,
        v9fs-developer@lists.sourceforge.net, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 430ac66eb4c5b5c4eb846b78ebf65747510b30f1
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Fri Jul 20 09:27:30 2018 +0000

     net/9p/trans_fd.c: fix race-condition by flushing workqueue before the  
kfree()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167fa19ae00000
start commit:   1e09177a Merge tag 'mips_fixes_4.18_3' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=78b902c73c69102cb767
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135660c8400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/9p/trans_fd.c: fix race-condition by flushing workqueue  
before the kfree()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
