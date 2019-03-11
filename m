Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E82C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCKNTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:43105 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKNTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:01 -0400
Received: by mail-it1-f199.google.com with SMTP id w200so5017552itc.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CiBdsrxe7Q+BpR6/zhVW7iqKkAZ8EPTAP+vbf8QPmUo=;
        b=s5lWAnbSMwaCuRjkLeDQAwxqLPXP/gLjmgOSm1tDFLB5ouE2q2HMAYmI9P8AiaDeA9
         IYrzanpWFJpNLLCzUPzG9UeCR1lwiKc4dpEyfpCDavnfra/8HKrtZnw6Mt6r7A1Uq5gW
         YvetwOwe/ur83/bfKSn0xQLZIA7DHg0l8+Yn60Zuoi3WoZYiRUNE8fAsPeqqrp/gCrEu
         ZhMhJcy5Xh7Dn8i1rRfLgJbMc5QBCn+bMRlcAo5njOoZS/zBvgpKl3yuEWhdFIysv8xO
         bC5oqOKkR7uyTR4UpaA7mmKeLtpNh/nOCHQ6bLck6YTFDRcHK0bXDil7F5sEUou5SNFj
         po6A==
X-Gm-Message-State: APjAAAUftjhSVuImulIcliKbEmeYfyspB5kShshbs9J7OTzxbnZaDR5J
        QHDvL7Q+ZVuKpvmz07xhlFMBmvo0Uhkywl9eJhTFSpaCNclS
X-Google-Smtp-Source: APXvYqzVeOkVXhdETJlGlFcVHQSBSiNRLf4s4TFKqj4YsmczJGxLz9ph7FYqrySgvZKjftcHd3frLPh9b+f717c/UiqrLgJD5BkN
MIME-Version: 1.0
X-Received: by 2002:a24:5a04:: with SMTP id v4mr20638666ita.37.1552310340647;
 Mon, 11 Mar 2019 06:19:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 06:19:00 -0700
In-Reply-To: <000000000000cc734405836318dc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f91c90583d16a9d@google.com>
Subject: Re: general protection fault in sctp_sched_rr_dequeue
From:   syzbot <syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, lucien.xin@gmail.com,
        marcelo.leitner@gmail.com, netdev@vger.kernel.org,
        nhorman@tuxdriver.com, syzkaller-bugs@googlegroups.com,
        vyasevich@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 7efba10d6bd22030fb5931e50bf97496f932f00e
Author: Xin Long <lucien.xin@gmail.com>
Date:   Mon Jan 28 07:08:46 2019 +0000

     sctp: add SCTP_FUTURE_ASOC and SCTP_CURRENT_ASSOC for  
SCTP_STREAM_SCHEDULER sockopt

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14eec757200000
start commit:   7efba10d sctp: add SCTP_FUTURE_ASOC and SCTP_CURRENT_ASSOC..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16eec757200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12eec757200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=872be05707464aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=4c9934f20522c0efd657
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd9b03200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127de8e7200000

Reported-by: syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com
Fixes: 7efba10d ("sctp: add SCTP_FUTURE_ASOC and SCTP_CURRENT_ASSOC for  
SCTP_STREAM_SCHEDULER sockopt")
