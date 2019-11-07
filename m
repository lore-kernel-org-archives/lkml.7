Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4668BC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F052187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388973AbfKGNmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:38071 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbfKGNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:05 -0500
Received: by mail-il1-f199.google.com with SMTP id f6so2669601ilg.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=V9C3/szOLxcs/lQrxw09yt7xBy3qLGRL88aXaqrhtNg=;
        b=U6AkBVElYN1u6mzljU5M7J9jJfEpYAAhoVqWIwImwhOJZbk6A/gqqI030YDLMe4dgu
         K78190pCWgeBNm+kmDjoCcpfnaLdorFT0vjFWHbx3I96ck+Ts8Wp0QUfBPzr1LpskaQQ
         cYHjGJSkEww08WHLl/Ti99o2L/YzPY23UwY0kQqfbuHmFD277mE8u6KZeSE257NFWNtG
         VnLL7IzRdhw8iRKmWsT3+3e8zsSdE9ZEidO+dr4Ejtu4dzti8wGcfVWb9byo5N2DaZWp
         oIAeLnl+oXMySeoEZYHvndmnlhg5FtoVrHVZlbKprqhhNR2isuPEyqY/Lci6ayPqJHHY
         HdUg==
X-Gm-Message-State: APjAAAVFnoSjTQXP2zaoO2rfd5buyhdq5aJRvDMfdUQhYrvQkJxTwO1U
        b1eKTm3aZykonmqG9In2UpNc3kmGIhJlAkHE+9MDf+hyc6qa
X-Google-Smtp-Source: APXvYqxCUbUYzo+u5rS8f2qDgRbx0mqmdassnoPfmOY5Y2vuj78n07nSmrMgM7MJp/uItBjNn+rZa528BFNhpP5yPG6wP1qdX+ZU
MIME-Version: 1.0
X-Received: by 2002:a6b:ba44:: with SMTP id k65mr3353167iof.190.1573134124463;
 Thu, 07 Nov 2019 05:42:04 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:04 -0800
In-Reply-To: <001a1140ad88c4f006055d3836d2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac3e9d0596c1d4fe@google.com>
Subject: Re: suspicious RCU usage at ./include/net/inet_sock.h:LINE
From:   syzbot 
        <syzbot+79de6f09efc55fec084b706de3c91e9457433ac5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dccp@vger.kernel.org, dvyukov@google.com,
        ebiggers3@gmail.com, gerrit@erg.abdn.ac.uk, jon.maloy@ericsson.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, parthasarathy.bhuvaragan@ericsson.com,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 3f32d0be6c16b902b687453c962d17eea5b8ea19
Author: Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>
Date:   Tue Sep 25 20:09:10 2018 +0000

     tipc: lock wakeup & inputq at tipc_link_reset()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1368cfa2600000
start commit:   464e1d5f
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=bace9f7ec244b823
dashboard link:  
https://syzkaller.appspot.com/bug?extid=79de6f09efc55fec084b706de3c91e9457433ac5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126079e1800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101499e1800000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: tipc: lock wakeup & inputq at tipc_link_reset()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
