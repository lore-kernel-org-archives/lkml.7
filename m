Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFE1C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 10:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F02920637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 10:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLHKRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 05:17:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:48583 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfLHKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 05:17:02 -0500
Received: by mail-il1-f197.google.com with SMTP id 4so9215133ill.15
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 02:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=k4E/mqa4W+kq1mdY2640K8IoV0aq2OgaR3MQVU5N0qw=;
        b=clKWcm0IfK+A7Bik4e9WnOuA3097i/47Q64OnCBSrShUFCyJsgxksG49ciF5WCPN7X
         GL3f1iBJPR4mAL69XLZ+z2DedS6Abyx7r6LnYERvv7HjFz+kdvLw+ObS9dDvsc0zkyko
         L6GcHVtlkvyxEjX3Q9reH6DrCAbhVx2d/KZ0OjfwfACDC/Q15BK6RILmi/0ul/8GfZzL
         O5X4gad4I+nD89JWn5XV+pHdE8ja+SG5b7MMKCFR9gVrKbf+2TmyYdas4zQGdNFqJWDl
         BKzA8ZY1UEeAbkAXMp8E6nUQcweiakKAFXIlyZlpESbeqDNhRiVBpfAoX7cFgKRa9aqB
         vQXw==
X-Gm-Message-State: APjAAAW8zwy4PfH6lYe2YPyLgqJsj0XYsFlVL58V+1VDwWYzd33oj2W+
        sO4izFV3Igye/+kaL5w1gCEMQbJ8+TI1e7NijTxDB27u24/d
X-Google-Smtp-Source: APXvYqxTE6EZREG4LTPjlQr/Cd3zcGls/yAP2gpzh5nqfGaDzJ4084rVdEkfPj9Fp2EmOa+jCyeqD+IN0vzk7/4GuB6BqFmCa5zL
MIME-Version: 1.0
X-Received: by 2002:a5d:9593:: with SMTP id a19mr16249548ioo.36.1575800221149;
 Sun, 08 Dec 2019 02:17:01 -0800 (PST)
Date:   Sun, 08 Dec 2019 02:17:01 -0800
In-Reply-To: <0000000000001282e1057e14848e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b2f6205992e9402@google.com>
Subject: Re: WARNING in perf_group_attach
From:   syzbot <syzbot+23fe48cbe532abffa52e@syzkaller.appspotmail.com>
To:     Kernel-team@fb.com, acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, arvid.brodin@alten.se,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, jbacik@fb.com, jolsa@redhat.com, kafai@fb.com,
        kernel-team@fb.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, xiyou.wangcong@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 311633b604063a8a5d3fbc74d0565b42df721f68
Author: Cong Wang <xiyou.wangcong@gmail.com>
Date:   Wed Jul 10 06:24:54 2019 +0000

     hsr: switch ->dellink() to ->ndo_uninit()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1639a42ae00000
start commit:   6fbc7275 Linux 5.2-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6451f0da3d42d53
dashboard link: https://syzkaller.appspot.com/bug?extid=23fe48cbe532abffa52e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1758795da00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d2fa1ba00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hsr: switch ->dellink() to ->ndo_uninit()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
