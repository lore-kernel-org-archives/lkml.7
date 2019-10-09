Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D68C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C20206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfJIJWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:22:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47407 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbfJIJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:22:01 -0400
Received: by mail-io1-f70.google.com with SMTP id k14so3592664iot.14
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HPZvvZ/9gjJip4a0YxXlSMk8fxyxykOWKERE6MG24B8=;
        b=CBB9+aDQ8srF4OnWUQBhJAvaXA0mIzlQ2HHSrmG22sbVl/8sjseyY6Sa0RtncWjT+/
         gCmCJ8pkNupykNTSzkdImfjBt8K57Zie9tsDAa6cH17Saw67pzSYZhfivfyDQQcnUYIq
         vVUcgQUN/rp66polt9isiIKyVIgSDFVjzIrBMske+q5+dOfhuZ/Xw9CEugLHfh6+BH0m
         W9S1uryJ0+bQYb/R0vBQbPabyan4LI6z9F1ATrk0jODdlL6Ka5uHcKpJQzDobcKnv/6x
         6MAHQvVMMKSp8TeaIiKPgahCqi3Xo5mlESHehgowrOktxQMC3I1wfNruQrZZgp5CD551
         jJPA==
X-Gm-Message-State: APjAAAVAlIq1bSE5g8kKWyLZreYB7YvGW7zAkjHSkkwq3U6rWlzd1lxa
        FXWZKnZIKeYx1zAY7vheUpZzjMgTyi0X/CqBiEIkAp3Q9RdY
X-Google-Smtp-Source: APXvYqzusl152j/JV35SyZSwQmWMSoEboM9LDlzkJhrF5z5FXK489gY6noXCILJxl+gcSeoJuYNvC0rsereWl09pW8rCFBXW5FsW
MIME-Version: 1.0
X-Received: by 2002:a6b:6018:: with SMTP id r24mr2427870iog.25.1570612920964;
 Wed, 09 Oct 2019 02:22:00 -0700 (PDT)
Date:   Wed, 09 Oct 2019 02:22:00 -0700
In-Reply-To: <0000000000003dc9ba059475614f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bdc5f059476d153@google.com>
Subject: Re: KASAN: use-after-free Read in tipc_nl_node_dump_monitor_peer
From:   syzbot <syzbot+d2a8670576fa63d18623@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jiri@mellanox.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 057af70713445fad2459aa348c9c2c4ecf7db938
Author: Jiri Pirko <jiri@mellanox.com>
Date:   Sat Oct 5 18:04:39 2019 +0000

     net: tipc: have genetlink code to parse the attrs during dumpit

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ac08e7600000
start commit:   f9867b51 netdevsim: fix spelling mistake "forbidded" -> "f..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ac08e7600000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ac08e7600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9be300620399522
dashboard link: https://syzkaller.appspot.com/bug?extid=d2a8670576fa63d18623
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d3e04f600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a76593600000

Reported-by: syzbot+d2a8670576fa63d18623@syzkaller.appspotmail.com
Fixes: 057af7071344 ("net: tipc: have genetlink code to parse the attrs  
during dumpit")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
