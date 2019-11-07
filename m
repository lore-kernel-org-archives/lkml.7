Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02150207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389595AbfKGNns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:48 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:42968 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfKGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: by mail-il1-f200.google.com with SMTP id n16so2655794ilm.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3/xSqB0zH6bltKSKwelvmk7da+xMY4V8SAPC5pNZohE=;
        b=cHgnJxRukeebPIdj5klMEpB2JYVGm1jBnYVqtyN7G16neWV6sB0a2Q1jT1F3ZtGCXr
         9QgZfcT1QNUtb0c4hRzkfZW/uSGxQl6mUT8EZ/G6E/ouRV0BXtpwgbZtENoHmR4r6yy4
         AM8RRwbBo/KsPlH2hw+616ZojirsPhSf7IfFWyh64L4fBQ5QjM8TjQUpaE5EuxQcCwKN
         BkaStySgBX08qt39GhCy0D/cxE3FlbAif6RbpWoAew6WG9yd7JrhVlS3+xKc4QFUE2pu
         MhEnwevnV4+pHE+RAHYPF0bhrWtxDN28UXqYTUKYvkSv53zkgS5AHPX3A+DcRYGj6bNl
         nQbA==
X-Gm-Message-State: APjAAAUjAlWLuWnAf6b7U2OTr7ZdnZrML5eOxNPLc6Bi1jEkMTnohOAB
        YWJsLkgvDiK/lb+0UFZgUrpmx9XYejSbzXXsuxrUzqa1cR+M
X-Google-Smtp-Source: APXvYqzonUEMbV+hU0AEcPcfvumPPjz/o2sJc+Gcuj9N/CKQCOvzx0Ocr0vqAToOGHZRJPi5y9KSv7V9Lxhz3CjGGUmi6G93H8En
MIME-Version: 1.0
X-Received: by 2002:a6b:204:: with SMTP id 4mr3534207ioc.303.1573134126045;
 Thu, 07 Nov 2019 05:42:06 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:06 -0800
In-Reply-To: <00000000000075c8d70574f40fbc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c460630596c1d40d@google.com>
Subject: Re: KASAN: use-after-free Read in vhci_hub_control
From:   syzbot <syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, shuah@kernel.org,
        stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
        syzkaller-bugs@googlegroups.com, valentina.manea.m@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 81f7567c51ad97668d1c3a48e8ecc482e64d4161
Author: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Date:   Fri Oct 5 22:17:44 2018 +0000

     usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14046c2c600000
start commit:   420f51f4 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=531a917630d2a492
dashboard link: https://syzkaller.appspot.com/bug?extid=600b03e0cf1b73bb23c4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1116710a400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119be4ea400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in  
vhci_hub_control()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
