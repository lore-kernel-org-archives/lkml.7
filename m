Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB0ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB07821925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407323AbfJQCmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:42:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:36581 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388198AbfJQCmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:42:01 -0400
Received: by mail-io1-f72.google.com with SMTP id g126so1246989iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 19:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7h0gQqNrYRzsWj9R4CAYCu9XOxzaPAZTOTXlm38+fvI=;
        b=fOtYvrvlmA4cuYHd9VyqCVPLLSTW3hl3qdY63NBsTwmDvj2bBNWmQhVPBjcdMVmt2i
         8ZgjQIlfVvSsH1q3ys3qOA+FZEwpGSfDhaHXpdMKcpDSwysTTQwPLlmEKQzkTec8l8DP
         WTHV51dEJMz2ykqUTc510QX/Czby3qCKEb2OOTT9+4urgOmLkrsH3oynuvV4n1ijoYD/
         40delF9Ecv4mCUIfz4rS745hZmUtBVeeh3/s+ey6UdhGlAbnl8E00PD5OoayVTTjxu3x
         uw1Egx9+wjgNhlELax7KtdtCgy4KHp8v8CS2E/uBzoYBnrT2svsmttSle1Q4czSEsmN+
         qYFQ==
X-Gm-Message-State: APjAAAXUZPkJb4Ht83iS4irkSrnXh4p4UTmhYrbhbBf9zYez2EFe5y20
        XNBPkkw63fTJ5WOaChWeZZW+WKz9ngId1uzQ58X6O57jN+Xs
X-Google-Smtp-Source: APXvYqxm/PZKRcr2VOn2bSEPROOTxJZd4s/gFYz6yxRyhamcXwHcbHmC0uB12SwLAgbX/bUP1WUzw8YXMpgkcwGIQdZ6LiO9FDXe
MIME-Version: 1.0
X-Received: by 2002:a92:3b8b:: with SMTP id n11mr1162464ilh.135.1571280120830;
 Wed, 16 Oct 2019 19:42:00 -0700 (PDT)
Date:   Wed, 16 Oct 2019 19:42:00 -0700
In-Reply-To: <000000000000830fe50595115344@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071e2fc05951229ad@google.com>
Subject: Re: WARNING: refcount bug in find_key_to_update
From:   syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>
To:     aou@eecs.berkeley.edu, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-security-module@vger.kernel.org, palmer@sifive.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 0570bc8b7c9b41deba6f61ac218922e7168ad648
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Jul 18 19:26:59 2019 +0000

     Merge tag 'riscv/for-v5.3-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b6e2bb600000
start commit:   bc88f85c kthread: make __kthread_queue_delayed_work static
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13b6e2bb600000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6e2bb600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
dashboard link: https://syzkaller.appspot.com/bug?extid=6455648abc28dbdd1e7f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8adab600000

Reported-by: syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com
Fixes: 0570bc8b7c9b ("Merge tag 'riscv/for-v5.3-rc1' of  
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
