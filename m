Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC3CC43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D164206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfLOGwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 01:52:03 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:49526 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfLOGwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 01:52:03 -0500
Received: by mail-io1-f71.google.com with SMTP id c11so3301380iod.16
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 22:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=u5G1wrWjpZdsvluOyjyhr3hFBI3eS6YddfcUNsAZMTM=;
        b=V1LmzXD+MQo9C+SIK0zmuP0cNfKsT4wApnOKQLiFBjUuKeAcV00NQDkTqkJblOGWQ4
         2ddecug49zs8oFzZMvzptJSpz6CfhvlEjkBQJO5XbN9IMj8cao5G+2+mqHZubMtN6y3j
         W7oH4U0kDIy3lLcKQXFF8m3GJANKyiUXK9aVxfdv3uKQFMBTVr9Z89OQBsvs1We1N5LE
         zbzSquYGjVr+vfkvJJYT/TMJB3iWGVmB+XR7ziCdWRrH3wXmO7kDrtWqFaPU6IiNCcFb
         Vqj/QOvT9HjUGDx7m17Do9wzfJY1NUMbal/USfLblrg+45eh9LLuODnDpcdHc6feMMrV
         1G/A==
X-Gm-Message-State: APjAAAXs8IEQtK9IxhvTcxdStNsFilVyGunZVn0BorOJnVHGT1oFGGYg
        ELbkPSpgDI66DaacEl5JlX/iBoPeRX+78w+fLTzVgBhunCvh
X-Google-Smtp-Source: APXvYqxyLGjpjTN0mObYvpOtmBDQtr6uJ7PwrSM6L61lcM5UPHprWuZJancgeOdVtUb3P1pj0JRYbD3+nDwIa7kKTYXjQFKUuwTE
MIME-Version: 1.0
X-Received: by 2002:a92:3b98:: with SMTP id n24mr7262387ilh.189.1576392721076;
 Sat, 14 Dec 2019 22:52:01 -0800 (PST)
Date:   Sat, 14 Dec 2019 22:52:01 -0800
In-Reply-To: <20191215063020.GA11512@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a99070599b888dd@google.com>
Subject: Re: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From:   syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
To:     a@unstable.cc, adilger.kernel@dilger.ca, afd@ti.com,
        b.a.t.m.a.n@lists.open-mesh.org, chris@lapa.com.au,
        davem@davemloft.net, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com

Tested on:

commit:         dfdeeb41 Merge branch 'tt/misc' into dev
git tree:        
https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=be3b077056d26622
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b02546e00000

Note: testing is done by a robot and is best-effort only.
