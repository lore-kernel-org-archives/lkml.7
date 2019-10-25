Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52379CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B4821872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbfJYEUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 00:20:02 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51721 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJYEUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 00:20:02 -0400
Received: by mail-il1-f199.google.com with SMTP id d15so1092705ilc.18
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 21:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NF2elsax11pXsnm+smX3VLKpwTuafbnzKYyInM/Zfhg=;
        b=bbj55jZP3fxmRhFuOTwxSqCdF4fdtGTLg4gFmE93xRRwWTOiaMQbUS6clU1FE1BIVC
         kih6IPaLAgfOGdks4ovoveBlOAF4Hskerbvc6bA829b52B1EIwUq1qVz3NkdEMxyNBNP
         BGH05tkQQX968zkjhcjpnpJUEI93ndH8Yz3mLctEay3zlSQ2nIJ6tShtV7tbq9TqLuIL
         L3kLtRcm6zjw/sL18x1Nfi4jHtylLYUlt4jt0Ae8oqR/0XPBXCElZxKl0o3p789BZxJP
         /mt91e12RoVB1/9788p/D8cuIJXM7F3NA6RZ+2Tb0Iq/gH/uxHETztC2c7lR4foxN+3M
         HI3A==
X-Gm-Message-State: APjAAAWc9WCWLrTlamJhIppcXqgzEeUhaTSz7rxlcpSRMj0SaAPQCrdA
        Ch+EYqJJ9p3gIk4cd5TKlFT35Cb2wJrtndUzyzXAMumueRHY
X-Google-Smtp-Source: APXvYqxBLtXLb+ZNhposnuPP5R6TbEk6pDsIDIYFbKqUpk/R085DA7b4q4kzLVLphPbJ9kNcvFRhZFz7kEFExK0XH5h0eLU1wAlT
MIME-Version: 1.0
X-Received: by 2002:a92:ccd0:: with SMTP id u16mr1924578ilq.296.1571977201370;
 Thu, 24 Oct 2019 21:20:01 -0700 (PDT)
Date:   Thu, 24 Oct 2019 21:20:01 -0700
In-Reply-To: <00000000000074bc3105958042ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aecf020595b4762f@google.com>
Subject: Re: KASAN: use-after-free Read in nf_ct_deliver_cached_events
From:   syzbot <syzbot+c7aabc9fe93e7f3637ba@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net, dhowells@redhat.com,
        fw@strlen.de, kadlec@netfilter.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 2341e0775747864b684abe8627f3d45b167f2940
Author: David Howells <dhowells@redhat.com>
Date:   Thu Jun 9 22:02:51 2016 +0000

     rxrpc: Simplify connect() implementation and simplify sendmsg() op

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12f869df600000
start commit:   12d61c69 Add linux-next specific files for 20191024
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11f869df600000
console output: https://syzkaller.appspot.com/x/log.txt?x=16f869df600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb75fd8c9fd5ed8
dashboard link: https://syzkaller.appspot.com/bug?extid=c7aabc9fe93e7f3637ba
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10938e18e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147caa97600000

Reported-by: syzbot+c7aabc9fe93e7f3637ba@syzkaller.appspotmail.com
Fixes: 2341e0775747 ("rxrpc: Simplify connect() implementation and simplify  
sendmsg() op")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
