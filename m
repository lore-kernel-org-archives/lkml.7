Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51291C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E372077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389677AbfKGNoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:44:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50168 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbfKGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: by mail-il1-f197.google.com with SMTP id c2so2631435ilj.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JSje/AH07oDcPbgdMNB1SmnapsrACftv+UWeFURGS+o=;
        b=PerDedrC227dCDYkW64IB6wDpF/QgG8CRFna7sZ/HnfIfvv7c7i+aKoAw1pSdhPMtG
         pkszI4JMMkwO3Ze8chOhX4sJVoW41E6tNao6E384HkFrgRk+roXy2U2ZwvUKdB1Sbn0y
         3YgvS4HS5j6N0C7kQAEEmbb/9uBfnobxZ+Jy7RkKIRpt83Kx7p5w/Xh/OieoxZJ1KK69
         UBs7S3z1loCPDVvJ+sB1GyPi2valzlnBzrNymJLtm+DN6yHLSKnmXtEzwdqP6mT1Wwb8
         GLCJNyZ0KxlfsjRb49cjBPXqohZsmvV1iPuITsr1h5FrAlSO8SbnTDyvzAAaJBNtAmLV
         K6Lg==
X-Gm-Message-State: APjAAAVDUCb4wwf7YE9PAZEZ2w+yHOZcmdseyZi0ujyu+v1HqdVASXtB
        4RiuIfFcSdj/geWMblUuepkdKFFKQQdb77DUBhvLEt/KWORB
X-Google-Smtp-Source: APXvYqxG4legBrqYPkWuqZIqpTsAoWCTwM+LFBpOJApTr736BPZhw6No/JLjYsmAogQRUvC2OoKv/gRcI5B3aQxGny7hDWkav0p7
MIME-Version: 1.0
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr3513083ioc.91.1573134125408;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <000000000000afbebb0570be9bf3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baac070596c1d4ae@google.com>
Subject: Re: KASAN: use-after-free Read in p9_fd_poll
From:   syzbot <syzbot+0442e6e2f7e1e33b1037@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net,
        dominique.martinet@cea.fr, ericvh@gmail.com, jiangyiwen@huwei.com,
        linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com,
        v9fs-developer@lists.sourceforge.net
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1646690c600000
start commit:   d72e90f3 Linux 4.18-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68af3495408deac5
dashboard link: https://syzkaller.appspot.com/bug?extid=0442e6e2f7e1e33b1037
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1569b51c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e7a978400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/9p/trans_fd.c: fix race-condition by flushing workqueue  
before the kfree()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
