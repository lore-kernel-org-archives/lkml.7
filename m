Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FAC5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008A021D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 02:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbfKFCnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 21:43:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35270 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbfKFCnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 21:43:02 -0500
Received: by mail-il1-f199.google.com with SMTP id w69so20468977ilk.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 18:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uSWnjSO8aRmC6HOtbozEviyKgrIraDFwwf90scm40l0=;
        b=UPBuc/8nSsxZFdQAJsdFPYmKoKKQ1+uJ9Z6WO3YziCnYL4C4z/lg/MqrxZw3COBtdA
         0oqfe8ALj7uXqZwKRxTDE2lly+qI9/hmKqHe9Lt7/3hJ9oEyCe9XGqWOWAcys9/aIrhj
         sZ10bSo2y+582wyNV/+wZmOoSAZRjo33AWd0a20VhzHD+NqaQPm/QKt335YujRo0us6U
         WwxkrmoJgHhgCB+HdZFF/tf3mQOp1AaOpjpJDDQzAVMuiJ4Y+g8jiUZDWJtedgJbSTEp
         odRPZIPRYGVGCKX/chC6SZmWqFf8A4+kMT4tfrAXSruGc9TTjKC5TUdyKkiisWL6wUby
         X+iQ==
X-Gm-Message-State: APjAAAWeJQpNSo4TZH3RaGCKJ22YrLZjCPqocJxpUypLsO9ijmDf/do2
        Cr1VlqP3qBpfPBo8bJ5+qZl6lUe2cL/edpXHfv3LTFptQg8T
X-Google-Smtp-Source: APXvYqxWaexPBXY5jrl37JvvcUZAaVp3KXSs+h0t1RYE4hSK4+O06OdivMpHLxC+8f80DUzb4Mq0EMSAeFKl27IKU5J4/7z8BlIP
MIME-Version: 1.0
X-Received: by 2002:a92:ce42:: with SMTP id a2mr235457ilr.69.1573008181583;
 Tue, 05 Nov 2019 18:43:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 18:43:01 -0800
In-Reply-To: <0000000000005ed7710596937e86@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e46daf0596a48179@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_xtp_rx_abort_one
From:   syzbot <syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1157fb1ae00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1357fb1ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1557fb1ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1435c078e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139a3542e00000

Reported-by: syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
