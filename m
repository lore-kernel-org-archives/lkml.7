Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BABC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041E2071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLIGUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:20:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35676 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfLIGUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:20:02 -0500
Received: by mail-il1-f198.google.com with SMTP id t15so10940637ilh.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 22:20:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ib3fib3sKuBIkbtv5x2t+C/s5FzxvHK11gS8z3pdu9M=;
        b=FF/mn156cCVLwfEj1SJ68S3zr/XouVnXBBeKScsCcZnApIKNJNEcITcPhy0L+2+Lt/
         pXXMCUPQK2eLim6tj9cT7Be9onkpdN85bOcZMYoMZWCQe5Y+B5V78a8H2L5Vlm30ZcS+
         N2Asj2fSr4htjWi7vL0F1HpxdZlce5S2jofrIQzf2tz+t0iJmGlMICjOQfrHnsPdBL76
         75EU5Y+Z/WBQ7sd47O+dnEFuMwZVGrLoDN+sTSBjbW5nAeYpZzTYOY3mv8dKBU0K14gB
         TJ5lvps6cWl/KL49RJouqY9JAETddr9KAwUx9JbPAPF4BMJOzFRBwro/w8+qKcTFS1iA
         CliA==
X-Gm-Message-State: APjAAAVXDB0U6d+lE0dK6mz7mNdeloDIjxodjNqI3C0fCGd/efUd0FJa
        74o7rOb+vUZg5HUDOnKibgGZvUUEba8AU+2svD/eOeJ1kWl+
X-Google-Smtp-Source: APXvYqxt5xSP7tbAVzuFhg+Ac4ya+TgZhTpk2Zr7W851b8K8a2VkPVv4m82Tfhoq72Q7Q0DHIeS8xNIuP9bQPMwA3Lj5vvagzqgz
MIME-Version: 1.0
X-Received: by 2002:a92:3984:: with SMTP id h4mr25241387ilf.36.1575872401339;
 Sun, 08 Dec 2019 22:20:01 -0800 (PST)
Date:   Sun, 08 Dec 2019 22:20:01 -0800
In-Reply-To: <000000000000bcd434057f4eb905@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b17fae05993f628b@google.com>
Subject: Re: WARNING in tty_set_termios
From:   syzbot <syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, gustavo@padovan.org,
        johan.hedberg@gmail.com, jslaby@suse.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@intel.com, marcel@holtmann.org, mhjungk@gmail.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        vdronov@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit b36a1552d7319bbfd5cf7f08726c23c5c66d4f73
Author: Vladis Dronov <vdronov@redhat.com>
Date:   Tue Jul 30 09:33:45 2019 +0000

     Bluetooth: hci_uart: check for missing tty operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b20aeae00000
start commit:   66c56cfa Merge tag 'remove-dma_zalloc_coherent-5.0' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b05cfdb4ee8ab9b2
dashboard link: https://syzkaller.appspot.com/bug?extid=a950165cbb86bdd023a4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121cee07400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fdaed8c00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: Bluetooth: hci_uart: check for missing tty operations

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
