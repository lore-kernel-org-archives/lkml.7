Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3342184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388638AbfDRJ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:59:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:57013 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbfDRJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:59:01 -0400
Received: by mail-io1-f69.google.com with SMTP id s184so1522504iod.23
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VuebU8UkmIRaDiaZ1fyCf6Tqc3AJax52IMQPWDXFyYI=;
        b=XP0icQal/zFV44gdSUUKbISC4ErNLYyQIlcMq7I+EzGIhiSqBbege5e6GdJKLK3ZPu
         3O4V5HaNU/5n0xMq6flgfCsG3vkOwS6446oyalnReFL4I4OdqDacBgl0ZPAk+12dk489
         6Jco3ozHAdjFyMqgw7PYGGuvif3nNCn1GXkadp07fvI15m6mOkTVZRSCZvHYC8AF4P44
         3PVIaoaTM5p+QSdOH9C4rzXjlm42kZ8IKZIhiYFoVYIP5liiiDxML/DT+enjYN4EJzWq
         FFA7ZU+d4irPVXI4AnpKdO+FCZhHyh3/D/qMKby9W3OL8LubXYVjfmwOaglksCNEIHen
         bTsw==
X-Gm-Message-State: APjAAAXKCYhBP7+EzAr1mDz7jYHXXb358Rhhxa3veosiZadsEn84LeHW
        4xwinGabvg4bm9D8vmUjCcDACA9w8MAzuJoyQxNYgisp9Zvy
X-Google-Smtp-Source: APXvYqxuguFF8FFR1m22eGEJb+0aWhIdhdSN3LOyfQ8EbAbAyGoX9sVIQFN5fC7AqwMqDcOvQERrrrEgHjXPT6FjVwoRV42Yw1lQ
MIME-Version: 1.0
X-Received: by 2002:a6b:188:: with SMTP id 130mr2185721iob.115.1555581540713;
 Thu, 18 Apr 2019 02:59:00 -0700 (PDT)
Date:   Thu, 18 Apr 2019 02:59:00 -0700
In-Reply-To: <000000000000c770710586c6fc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000274d750586cb0d38@google.com>
Subject: Re: BUG: unable to handle kernel paging request in free_block (5)
From:   syzbot <syzbot+438a5abd4f53adb1c073@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
Author: Jon Maloy <jon.maloy@ericsson.com>
Date:   Thu Mar 22 19:42:52 2018 +0000

     tipc: obtain node identity from interface by default

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15065bdd200000
start commit:   e6986423 socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17065bdd200000
console output: https://syzkaller.appspot.com/x/log.txt?x=13065bdd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=438a5abd4f53adb1c073
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12adddbf200000

Reported-by: syzbot+438a5abd4f53adb1c073@syzkaller.appspotmail.com
Fixes: 52dfae5c85a4 ("tipc: obtain node identity from interface by default")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
