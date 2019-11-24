Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C24C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796302068F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKXXYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:24:01 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:39110 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKXXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:24:01 -0500
Received: by mail-il1-f199.google.com with SMTP id t4so12253690iln.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 15:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lvmYFxQ4tMpUppOKxWLXexXQSrq67jjHmSMnYwsK918=;
        b=ggcl6ArpCbytyZ0TjXVDz0fhyvhVXlu/Z+gsNd59ZYuAhAfyRfsRx73PaUDJZMQWc6
         zqWbwex7B/YyM17nA7ugoVwsmzG2zDGikhzZxzTwJ4+Sdt1yrWow1TUN9gDLPux8hdhs
         Zfx0RzcIhcCQDrN5Oi7qqYynNamMTefbWbOPmjm8OawNvnM/IcOgWigHqvIY68gRoU5M
         dW0iUZj9CywCrJuZ1EcBIcCetuiyR0Yy5PA1lkEl3Y0H6WGrJhtPQ5xPL70fY/OBnh/9
         PmxKzc6A+wFDN09i04Qpyk+qkAj43BeyGQMt3bhn59SHDQlZAiXE7XY1tE5fwFQwxE3x
         SOIA==
X-Gm-Message-State: APjAAAWZGgb0X4XsOMJpL8iQq4swYDZsfWHjLKtf0R2hWFu3qiNGiXTp
        m+nvy2voWgbtLNFpTXP5+r4LJXJ3N1jxRrLzpzSuluQ74H4F
X-Google-Smtp-Source: APXvYqzybgh35xlc8OCAZI+HDDxRXvIzbywSitZ5fmZRerPy++yQAdBkreUmqiN9FAW1Gh+w6H3FG23oukUmVPMMPPcj1XreIAIA
MIME-Version: 1.0
X-Received: by 2002:a92:7405:: with SMTP id p5mr31061111ilc.261.1574637840449;
 Sun, 24 Nov 2019 15:24:00 -0800 (PST)
Date:   Sun, 24 Nov 2019 15:24:00 -0800
In-Reply-To: <Pine.LNX.4.44L0.1911241553390.4632-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000214afd05981ff1a8@google.com>
Subject: Re: possible deadlock in mon_bin_vma_fault
From:   syzbot <syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        jrdr.linux@gmail.com, keescook@chromium.org,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, zaitcev@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+56f9673bb4cdcbeb0e92@syzkaller.appspotmail.com

Tested on:

commit:         4d856f72 Linux 5.3
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.3
kernel config:  https://syzkaller.appspot.com/x/.config?x=86071634b2594991
dashboard link: https://syzkaller.appspot.com/bug?extid=56f9673bb4cdcbeb0e92
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ff3eeee00000

Note: testing is done by a robot and is best-effort only.
