Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BC6C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB682077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbfKGNmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:33 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33318 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389119AbfKGNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-io1-f70.google.com with SMTP id p19so1880379iog.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hy0IUqmtd0A4X3fC1vp+srexXjp8oWtVGisb6LFHlS8=;
        b=cozQnlxj8l/xsf7woYU0AXH5cQISSCNRmyER94Q60F3VhJyMd4dgbozDFVlwx6zC5X
         7SaafVmVyurXT5x5MrxB13Y8wwictngKvk6ucEGw5hqWLUVZX0M1/0Z6gVPjMf55nucn
         CrAPEVSMdtuUAES3TT5axyCEo9D8hGgrEVxCSnmtYia0dBJXcdiEa+OyqK0Bhg84O0Re
         bMoYyf2ImRiMluLo480E1G/ZHxM7JM43BLy20Qr1BOHSS0A1jmc2t/0g2qp2k2jQLpYH
         AqnSUyHje94KNpsxLRBQ7OuwRO1NZjLftAbyf3mBA7i7gBonz/stL1VomaD29EOY/ZTK
         r71g==
X-Gm-Message-State: APjAAAW0HcITQdNuR75ydLxRAvl/PzmXET4vGmwL0cSBAuV9NPqhnq4c
        nZ42ttR/O8vLszeMcG3lToGIvVLLAmkiopwmWAAs493cdqFw
X-Google-Smtp-Source: APXvYqy7IAQ7q+QKT0ObAmdHFO7txUCkOkWC8WZUDTvlKk/xr4Bj4B0+GFhbIElFmcxx4JMqWJqo/97ciSxzF5cqyNtl+EMM/48U
MIME-Version: 1.0
X-Received: by 2002:a02:6306:: with SMTP id j6mr4111377jac.62.1573134127936;
 Thu, 07 Nov 2019 05:42:07 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:07 -0800
In-Reply-To: <0000000000007829c8057b0b58ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e139ab0596c1d4c0@google.com>
Subject: Re: KASAN: use-after-free Read in tick_sched_handle (3)
From:   syzbot <syzbot+999bca54de2ee169c021@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, frederic@kernel.org,
        fweisbec@gmail.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        netdev@vger.kernel.org, sbrivio@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit bc6e019b6ee65ff4ebf3ca272f774cf6c67db669
Author: Stefano Brivio <sbrivio@redhat.com>
Date:   Thu Jan 3 20:43:34 2019 +0000

     fou: Prevent unbounded recursion in GUE error handler also with UDP-Lite

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119c0bc2600000
start commit:   1c7fc5cb Linux 5.0-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=817708c0a0300f84
dashboard link: https://syzkaller.appspot.com/bug?extid=999bca54de2ee169c021
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c95a30c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11df0107400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: fou: Prevent unbounded recursion in GUE error handler also with  
UDP-Lite

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
