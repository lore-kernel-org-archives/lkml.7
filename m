Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6188AC43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4219920833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 07:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLAH6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 02:58:01 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:53068 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfLAH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 02:58:01 -0500
Received: by mail-il1-f198.google.com with SMTP id d28so20763274ill.19
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 23:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VnR9yosaS+lY39eJX0ls3om/qYEVU2oks9FYgzUS5Rc=;
        b=LMnKBRqST2vSPhE9sVYOhPgW/uCu75a/uHHReTn3JqQl3FOEDY/AojYmCOlSrXvHQ9
         zDpkXptZFc3RH8QMj7qXWZgKrCpBaywd//9VmDK+HCgOHQua6dawfSlLWgyP/AKp4czE
         PaGiKUyo1mzpUVdwqEoVwzAGxpihWj6FQwMquF2zLNG6peEU4MNw1eQn8dPIPRAubX13
         aim4y5BU66G3zpXNGtHgC7KzFGs7IbiFL6fuoJuAg3DTp/vJ33LjB8g6Hpo8x+QtJET8
         EwKwUuPweTdllZua/Zb89zhohcD5WVwdDO9JZ5Roo+SqnXNT2ellunqvrjQ4+RN/HGfo
         VPDg==
X-Gm-Message-State: APjAAAWEDJNJAS18iItwGMuQnXAaEANYtcgA6GvXKjxZ0k3iFAEPrj/O
        DuGLO6r/MDseKAxLLm4bwgYBnX+B0eYds+A2U+L46/2jCc+L
X-Google-Smtp-Source: APXvYqywuenkguXBw8KNCZzGDJV9kQVYNSCYJOwcG7e6qPfDdYpHrz7xWKQHu6QoaKIitUWg/b7Z/dHbzYjBRqdKiNJ/tpnHCeBh
MIME-Version: 1.0
X-Received: by 2002:a92:d901:: with SMTP id s1mr23813418iln.86.1575187080666;
 Sat, 30 Nov 2019 23:58:00 -0800 (PST)
Date:   Sat, 30 Nov 2019 23:58:00 -0800
In-Reply-To: <001a1140b8307b0439055ffc7872@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065e61505989fd2c3@google.com>
Subject: Re: INFO: task hung in aead_recvmsg
From:   syzbot 
        <syzbot+56c7151cad94eec37c521f0e47d2eee53f9361c4@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, ebiggers3@gmail.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, smueller@chronox.de,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0c1e16cd1ec41987cc6671a2bff46ac958c41eb5
Author: Stephan Mueller <smueller@chronox.de>
Date:   Mon Dec 5 14:26:19 2016 +0000

     crypto: algif_aead - fix AEAD tag memory handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d6d0a6e00000
start commit:   618d919c Merge tag 'libnvdimm-fixes-5.1-rc6' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11d6d0a6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d6d0a6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link:  
https://syzkaller.appspot.com/bug?extid=56c7151cad94eec37c521f0e47d2eee53f9361c4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ef592d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b865fd200000

Reported-by:  
syzbot+56c7151cad94eec37c521f0e47d2eee53f9361c4@syzkaller.appspotmail.com
Fixes: 0c1e16cd1ec4 ("crypto: algif_aead - fix AEAD tag memory handling")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
