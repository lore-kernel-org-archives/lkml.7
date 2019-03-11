Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC112087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfCKOcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:32:02 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:41271 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:32:01 -0400
Received: by mail-it1-f197.google.com with SMTP id q184so5205180itd.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ymTSxfXUiGup6ajr5LfOz0WGsXydVnYgXzDfQMDYzZQ=;
        b=hbDwvaeqAErhB0qhFRwizjfswOdqBRfPC2PoSQLEit8bRWg01vlXxs4B7iFuRQpa86
         56VKz8js1bVC2tRVLkQNP1BjcHWGvxIxVugiPZ2/7dzAqpnG/mIf7JRs6a/kU9EEguSL
         0RVvAAGp4QlZ7eIv6eG/IbEWTKDwMbF42ExFQFSWBDRikuEvi3eLaBabW60DZaA6PtIM
         2tXzY7bcrSHYX+GZ5xKTWouo2FRt3dctg24Yg8Hn4XysqJVrQoMYVrz+xe/JIRJBk/IB
         jRp15Kpy+YwnqNV4cyEEb7IJVtpwHtaydSMtDBfbug9YgB0E0FhkV9cEcHE6IB2z8zR2
         Pjrg==
X-Gm-Message-State: APjAAAWLn/utJywYu1uP71CB5hWBKBHFZEkvnlrfu1GRyK7640eOmJvX
        y4lUYFLKzp07w0M4fRWiOUhTuuGGZ+NoAzuYPFthzyBXDZs1
X-Google-Smtp-Source: APXvYqyn7vcOcmYIIFsvB+i+wzsVErW96sUHcF/WWKQANTxlsNZDdkpyhegbx71hWVq/PD/e7A/PG1H8pUdhz0FRHXQy4lXQrNU8
MIME-Version: 1.0
X-Received: by 2002:a24:1c0c:: with SMTP id c12mr20171674itc.19.1552314720883;
 Mon, 11 Mar 2019 07:32:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 07:32:00 -0700
In-Reply-To: <000000000000afcf18058364e99e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008497eb0583d26f55@google.com>
Subject: Re: WARNING: locking bug in __icmp_send
From:   syzbot <syzbot+173d67242daa7ce45f85@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 8bafb83eeee2efb8b9b4e9dfd9fb90debe4a2417
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Mar 30 16:32:00 2018 +0000

     Merge branch 'stmmac-DWMAC5'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13354d9d200000
start commit:   8bafb83e Merge branch 'stmmac-DWMAC5'
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10b54d9d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17354d9d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73d88a42238825ad
dashboard link: https://syzkaller.appspot.com/bug?extid=173d67242daa7ce45f85
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d6923200000

Reported-by: syzbot+173d67242daa7ce45f85@syzkaller.appspotmail.com
Fixes: 8bafb83e ("Merge branch 'stmmac-DWMAC5'")
