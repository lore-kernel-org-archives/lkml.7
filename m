Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3562EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073842077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbfKGNoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:44:17 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:42447 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfKGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: by mail-io1-f71.google.com with SMTP id w1so1863664ioj.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ri77hDWlxGadNlCgJxRYuckJ2NfPljUNUsSx9eNtzWk=;
        b=OqrigH+FnddswXKOD7l/XrvHO/T4/Y8x1AP02dIYXMOirbf7mibwaRU2CqPAjco/pf
         Sai6I1d7XlefZbLdJvpHy37Gs1iqnP6+2ThW+FO+qvolUVpKBz/t+aERxkraRzNYU2Ev
         ml5PJ3ZdE2wIxed5Y/8iNVcRy220z/S6Ki+PSKTbz9U2YHKHbnDhGEuI9AP3rqk5Z8V2
         rn8D0nPk59CgzdoiFfZ7TlMfNAj7RCm9Dirm/5+LoZ8614m5S7yH9Kinb87CicBqWjnK
         PBRJxzVUHOQETACZ7dDYyJZ4jUgB7x+NabAUdOPTX78WHJNXSy4uRM6zzeRkk9b2LlRH
         HuQw==
X-Gm-Message-State: APjAAAVZ7SqHtsxL1ni3PyA5PSip9HDK5yW3QnYfJWobi2JC9NdsMj29
        iwqG5OOnki7vco6xHbkHwH3bci/m8OEy6C9RD1L9LKfuMDQZ
X-Google-Smtp-Source: APXvYqyiaX/HBm4ThpNYBtRUCy00rdSftcGU05xFPcVkDJFu3QBgix3u6xPkEYXW5FgMlBBunB3dqautQmieoQX2FODxU5sVo2Dy
MIME-Version: 1.0
X-Received: by 2002:a5d:87c4:: with SMTP id q4mr3589286ios.136.1573134124843;
 Thu, 07 Nov 2019 05:42:04 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:04 -0800
In-Reply-To: <001a113ed49eb535d20568bb75ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b207e60596c1d413@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in find_first_zero_bit
From:   syzbot <syzbot+a88c8270030dc5d71e4f@syzkaller.appspotmail.com>
To:     aivazian.tigran@gmail.com, akpm@linux-foundation.org,
        dmitri.vorobiev@gmail.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pombredanne@nexb.com, snakebyte@gmx.de,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tigran@aivazian.fsnet.co.uk, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit d1877155891020cb26ad4fba45bfee52d8da9951
Author: Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Thu Jan 3 23:28:14 2019 +0000

     bfs: extra sanity checking and static inode bitmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16634ee8600000
start commit:   b5dbc287 Merge tag 'kbuild-fixes-v4.16-3' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9b0d91297e224bc
dashboard link: https://syzkaller.appspot.com/bug?extid=a88c8270030dc5d71e4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cf65d3800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d99ab3800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: bfs: extra sanity checking and static inode bitmap

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
