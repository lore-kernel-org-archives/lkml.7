Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AB8C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BB0222DA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 13:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfCXNiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 09:38:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40361 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfCXNiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 09:38:01 -0400
Received: by mail-io1-f70.google.com with SMTP id e72so5760283iof.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 06:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lqov6kEVYRRjkKN/N2TaC0G2XGYdnYqePYhb4GlM6+A=;
        b=i82uXYFhWtkTj7D7LZvwIKl9VGFT0YljhjCE5cVtO9bJbop6lIjrzj8aAADpd8y7yr
         SmDDUQSdj67fpY6y+zEX21Ocjbn9s+iJU6ALpSl/58SXzUOm0z9ASmob7pqSBGNYy3VL
         Nni9GVkKYupBzRij7KKIvYH5L07OWU69asvtBXOiSAG0p7Rym+eDDqDpBXc/zDVbW7g6
         /xLIHe+bV43McQSYOVE6nMklThq7hqogPLZSAkVyxlvqRDBSQpmS5gM6ecp1Vv9XhmNF
         ZFC5ND2cGwA7aLbm8TbgkyTuj5j52n+1O/IGzb5Vwc2BZSeTELY3Z1a/ILAvJ1PIhTYU
         IRjA==
X-Gm-Message-State: APjAAAWj3Mt4Cgwvjin2gFMlwiKtouLK09gnLR8l9xlOoix2U4mssSBn
        V9NBWOTiCfQoV17Tzuagf2leB56KfndoQhsmcgqxhBkyphT3
X-Google-Smtp-Source: APXvYqz1Q4nBmKPW8mDoQ8DME35u8Sq4Z1NFRCPBc5hq4d+m3HLH3xHCxAYGfU2QAsTS2wyQ5hqEOLqKfw3XPo+PpW2cPYCmw8bj
MIME-Version: 1.0
X-Received: by 2002:a24:22c5:: with SMTP id o188mr9063820ito.68.1553434681114;
 Sun, 24 Mar 2019 06:38:01 -0700 (PDT)
Date:   Sun, 24 Mar 2019 06:38:01 -0700
In-Reply-To: <0000000000000a9cca057cd141bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005986b10584d73269@google.com>
Subject: Re: inconsistent lock state in icmp_send
From:   syzbot <syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
        yoshfuji@linux-ipv6.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12619917200000
start commit:   f5d58277 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11619917200000
console output: https://syzkaller.appspot.com/x/log.txt?x=16619917200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=251ec6887ada6eac4921
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ab6ba3400000

Reported-by: syzbot+251ec6887ada6eac4921@syzkaller.appspotmail.com
Fixes: 52dfae5c85a4 ("tipc: obtain node identity from interface by default")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
