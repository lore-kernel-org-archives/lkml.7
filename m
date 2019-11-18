Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB37C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB8D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 06:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKRG7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 01:59:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:54456 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfKRG7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 01:59:01 -0500
Received: by mail-il1-f199.google.com with SMTP id t67so15502856ill.21
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 22:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aF2hkb+uDPuWocQ0k+VDFxZ3uHqIeoh49sdaxIzLqYY=;
        b=T9chuOthCehPQZsWmIz8FLC+M5ykW7b3d5rCID9JnbdL66cv+P/IVwflbX2mBoYwln
         AN8ZEvSinRqwFCKgg+0JRrM71GF7yYH6fbC+hp5iWssQkwfWTe2RZZGb+nSt6sTjEN7C
         QrfRwDdCMvOvculiqZJKCsjPzOziq3cpE7zoY6lpQI+VGsL8Jyfnvb9edDNCf4wrZZeo
         frFgWHe9WsjNe18LRc9skny7F4B8CBJo99vMY34GfzbzuLTcpMkZWxD8sE6PI5je8OS9
         CEgXgOTOoqQjKHi4gfXjKWnyBQjoDDHKjHJgjKMvv3QspCw3OZ0xuqn6msgblHqi5k5O
         dwyg==
X-Gm-Message-State: APjAAAUo9BL7KQu0IYWuBRUEDfm7v6CCjcMyChegKI0KuILK44r10z41
        yQJ8kH3dyQ3YttEZcRbl6z3zF0lCVWcbJrpOOTJFxDkN4AGH
X-Google-Smtp-Source: APXvYqysoNyeEKRWypMnt+cdrFAOn38eJTXWLtV2lRmkpvPHZzOvepD6Or4PJwYns/Nexla5W6HU5q/UkUKWl9GBcKEhVFpMQAml
MIME-Version: 1.0
X-Received: by 2002:a5d:8854:: with SMTP id t20mr12183485ios.301.1574060340893;
 Sun, 17 Nov 2019 22:59:00 -0800 (PST)
Date:   Sun, 17 Nov 2019 22:59:00 -0800
In-Reply-To: <0000000000002e4a260576c1589d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000795dd20597997b1c@google.com>
Subject: Re: KASAN: use-after-free Read in relay_switch_subbuf
From:   syzbot <syzbot+29093015c21333d1c46d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bunk@kernel.org, ebiggers@google.com,
        gregkh@linuxfoundation.org, jannh@google.com, jrdr.linux@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, mawilcox@microsoft.com,
        mojha@codeaurora.org, rientjes@google.com,
        sudipm.mukherjee@gmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 21c75ad65f8e5213ec542d99c259ffe3e3671e81
Author: YueHaibing <yuehaibing@huawei.com>
Date:   Thu Mar 21 08:26:28 2019 +0000

     parport_cs: Fix memory leak in parport_config

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11480c6ae00000
start commit:   26bc6721 Merge tag 'for-linus-2019-11-05' of git://git.ker..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13480c6ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15480c6ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=29093015c21333d1c46d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132afbcce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179a1f8ae00000

Reported-by: syzbot+29093015c21333d1c46d@syzkaller.appspotmail.com
Fixes: 21c75ad65f8e ("parport_cs: Fix memory leak in parport_config")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
