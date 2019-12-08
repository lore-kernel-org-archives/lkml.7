Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB72BC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F3820637
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfLHFDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 00:03:01 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:36446 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHFDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:03:01 -0500
Received: by mail-io1-f69.google.com with SMTP id 202so8187474iou.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 21:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qxR8n/MO9nUojwz4mikH1ALZdXQUJxV8vd4w04E6/Ac=;
        b=hXCFPWodiBS8iHIH2Nk+/sNuX+Evg3HKnwxjqTcTXFoYS1jeGDjrPMUYvmechKbL+F
         1NUSFAvWdI8bswjXhzR1i0yqfxkKz5PXubVouPntqHBYQC/LgJ0m7OT/8LJ4D5zo0/Ur
         i9/wAOOl61sizw/iOx77JaPIV8Nito/ceXNpBePIIFGmyjS+EQxc2B234WmU2JP0h3r5
         bS9H4oUFQgRtGCBwrrx9+qj8xTWJU4DkEdIKBzuiOLjLHQyJ4+SigKHD7WEp8hwZ+Dv3
         QY994NFJr4/bJqFJHDHcARl4LLXD8nw3HeZODHARSl6Lx8SdENsHzuAqWDHPe1deWKAY
         AOMQ==
X-Gm-Message-State: APjAAAWMxKLjhJtr4JzNie1PmNof6nHdDLrA4h6U2b3sXKm37tLI+IiK
        +qOMWbcLOOwHxUPa4FVzcJjtKViiza5Gz6691IwJJUqd/evC
X-Google-Smtp-Source: APXvYqwhYun6FRgcqHHP72qU2fze8Qfccpac/MDOfTBslHGmFtbVnfIYVfHJILMkuRSGVKPU9YNFZlZopc4zcKxXx7fBNK5x0SmW
MIME-Version: 1.0
X-Received: by 2002:a5d:9c52:: with SMTP id 18mr15554232iof.180.1575781380427;
 Sat, 07 Dec 2019 21:03:00 -0800 (PST)
Date:   Sat, 07 Dec 2019 21:03:00 -0800
In-Reply-To: <000000000000734545058bb27ebb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c96bd05992a318e@google.com>
Subject: Re: WARNING in perf_reg_value
From:   syzbot <syzbot+10189b9b0f8c4664badd@syzkaller.appspotmail.com>
To:     acme@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, arvid.brodin@alten.se,
        bp@alien8.de, davem@davemloft.net, eranian@google.com,
        hpa@zytor.com, jolsa@kernel.org, jolsa@redhat.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mingo@redhat.com, netdev@vger.kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, x86@kernel.org, xiyou.wangcong@gmail.com
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e241dae00000
start commit:   e01e060f Merge tag 'platform-drivers-x86-v5.2-3' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=10189b9b0f8c4664badd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16615caea00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a222aea00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hsr: switch ->dellink() to ->ndo_uninit()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
