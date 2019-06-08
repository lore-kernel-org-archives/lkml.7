Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889CFC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 21:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61420214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 21:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfFHVRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 17:17:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39263 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfFHVRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 17:17:01 -0400
Received: by mail-it1-f199.google.com with SMTP id a62so5117705itd.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 14:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pUXnTCGmDRM9Fiu3UMhwQKrlTPjkftTdr4gBjp4i6Ps=;
        b=Wgx++xE510y5+sbgSHQ7AkMu7ZYQYRxH9k7kJ7v4lPQPV9lObgH3A6/DZEUUYt6GU3
         9bXi2cSqf3ehpBfFeJpZeLs4KkzxakJAJ9hEPeLR6tRXAcWefsZyLOY2pQNMoZNeDzNR
         YDjaSnrNQV/YBpuiKFpmMVDVsw/MVD+J+mb1i5iTctUK6nQdQgDZ+URO5N4e/vV6fXHn
         KBMLn27EP9gx93/Gq13uQJEE5bc4EO/Az6mQS7U4yrCsCEvgQMMC6tKLeKQjxs4i4F7Q
         kSAEYVxYdgYLmHW9bh/fY8OnDcYPSrp1pm4ezDbWXoIdeojAOMRh3d8tLx0p1CKo6meQ
         9hMw==
X-Gm-Message-State: APjAAAWHUiqXeX82pHAp+cP0KhzAxQENFb4+/gMxZm/rM7q+awEw3qfd
        olvpmSdKwJ2wx2/f7OWK0QuEzpLEHLa8zk3XPHZvTH6hk51D
X-Google-Smtp-Source: APXvYqyc2nXveQl5DBuQDOiIyH/k1sTlPNyXQsmCmi+humPK9XlBkbhTw6PRCCBbfDhnuV5GcSPLM1WROKpXmdcxP8xM3qragnxh
MIME-Version: 1.0
X-Received: by 2002:a24:2b8f:: with SMTP id h137mr8306276ita.162.1560028620312;
 Sat, 08 Jun 2019 14:17:00 -0700 (PDT)
Date:   Sat, 08 Jun 2019 14:17:00 -0700
In-Reply-To: <000000000000a802e6058ad4bc53@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0d84e058ad677aa@google.com>
Subject: Re: general protection fault in mm_update_next_owner
From:   syzbot <syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        andrea.parri@amarulasolutions.com, ast@kernel.org,
        avagin@gmail.com, daniel@iogearbox.net, dbueso@suse.de,
        ebiederm@xmission.com, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        oleg@redhat.com, prsood@codeaurora.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e978e1a00000
start commit:   38e406f6 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e978e1a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e978e1a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=f625baafb9a1c4bfc3f6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1193d81ea00000

Reported-by: syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
