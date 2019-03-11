Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA2FC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66481206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfCKRdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:33:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50671 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfCKRdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:33:01 -0400
Received: by mail-io1-f70.google.com with SMTP id d7so4604836ios.17
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 10:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=isauicIveizh2Thnf2HeFHmP4eOsW9wt5monXQQBqYA=;
        b=iTwm9hd37X5lBXjvOJahFM5WAucbUQxime2OfT1PVYu6wG6eA0B7aOgQqAimjq6LQn
         MzrwBQC/XBy9+YJi39mNJy8TBwDoruH4ZSUQBvWzzL5//vIFk4c+wb6+lYgb+stSaKYp
         VuOExt+4I5EypZTLeEx7FNuZeIw34sVEWWEtXZUEI0MUi/gQlYWaY7aldq8B5Zmc6q/x
         uwNNALO/xO1Rb+o7+SGBSTPFaRXvFRLKNmRrwR9q+JwG4Ade0sX6u0juKQgfG+UrJ2zi
         tb54H+g/qUihVRIJs6irhOWKhZ7czMGB20kWyQDjYnR0b0odDekO/26ktiLu4bUUxk45
         358Q==
X-Gm-Message-State: APjAAAVP6G/7XjR2tnZfhz+62DtmljOfOFAYe1mcyaDI5XhnkpnZT82q
        evtccXyhXUk/FUV4pnTc4dqioYZsa/qyj9RqkMYmjRGGE8QU
X-Google-Smtp-Source: APXvYqxNHGDwxMkhRMzYJUaaRw1NG+HTbRv8/Iwq88XM8tYlVM3Bik892jQNUzBmbT5xOMWwyVBKe39zxZmaWv4+1WHoIhakjx36
MIME-Version: 1.0
X-Received: by 2002:a24:6283:: with SMTP id d125mr128441itc.14.1552325580967;
 Mon, 11 Mar 2019 10:33:00 -0700 (PDT)
Date:   Mon, 11 Mar 2019 10:33:00 -0700
In-Reply-To: <0000000000004aed310583d22822@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d458540583d4f6ef@google.com>
Subject: Re: WARNING in lockdep_unregister_key
From:   syzbot <syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, bvanassche@acm.org,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        hmclauchlan@fb.com, hpa@zytor.com, joe@perches.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        marcel@holtmann.org, mhocko@suse.com, mingo@kernel.org,
        netdev@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, will.deacon@arm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 009bb421b6ceb7916ce627023d0eb7ced04c8910
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Sun Mar 3 22:00:46 2019 +0000

     workqueue, lockdep: Fix an alloc_workqueue() error path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1625a027200000
start commit:   009bb421 workqueue, lockdep: Fix an alloc_workqueue() erro..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1525a027200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1125a027200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9d91b7192a5e96e
dashboard link: https://syzkaller.appspot.com/bug?extid=be0c198232f86389c3dd
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1006dc83200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137d0027200000

Reported-by: syzbot+be0c198232f86389c3dd@syzkaller.appspotmail.com
Fixes: 009bb421 ("workqueue, lockdep: Fix an alloc_workqueue() error path")
