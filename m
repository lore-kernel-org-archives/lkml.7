Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22576C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66F7207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbfKGNnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:43:49 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44346 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbfKGNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:06 -0500
Received: by mail-io1-f71.google.com with SMTP id q13so1848630iot.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Vf6K/h0qpqQKsSoL002ZxeehhKzDYr+4ythimfWKfZ8=;
        b=a9tqGOvdZ/uDUZSIL4LzFZQN3e7qxA4ZstmAGSHy65QbFvY/BWaS1/7lnfhvfwAakJ
         QDnMMJprY4+9GcTov+KbEyybXfIwNpUUzIcvQRN0DJWp8SYohosDVxJwHWl+OvE8W/NZ
         fihCM0/8OOLhJA45zwy/gP/triqGCbic1G0LZbPknXzNHYbXM8N7Kcp1l30pdXfye31v
         b8VmNfv+zpx4P0CXCE8Hgibphdzl7Bx1sAEkM0/w3sdKTt97EHEBCw/LzqowCoa/pXV+
         ahC3gYa9gfLPhOBCrBbWQz5fnQcCeByHqMzZ2dOzFpxcCRK+OK0h0y+aU9KFUSbtBbOY
         RJOg==
X-Gm-Message-State: APjAAAVArvS+RD/B8EzSZLc7Cs08Hnomgur90ge4LXpYbe293U5kuL8r
        exl03WisR8bsQUCzYlc17h1WIIJiJOTCRedmk5wTUEOZK001
X-Google-Smtp-Source: APXvYqxtqS9jnDj10uHB/QHrMRUKjJWOjaExI73Hx2xEMNtJxQbyy5I+Msc61BdsDsl5SzjhgXSd4Tpv0SaNrrMljsv9YcDnaitG
MIME-Version: 1.0
X-Received: by 2002:a5e:aa10:: with SMTP id s16mr1261527ioe.113.1573134125893;
 Thu, 07 Nov 2019 05:42:05 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:05 -0800
In-Reply-To: <00000000000054395605708fbd13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c214300596c1d487@google.com>
Subject: Re: BUG: corrupted list in p9_conn_cancel
From:   syzbot <syzbot+ad0832746849421bba05@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dominique.martinet@cea.fr, ericvh@gmail.com,
        jiangyiwen@huwei.com, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com, tomasbortoli@gmail.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 9f476d7c540cb57556d3cc7e78704e6cd5100f5f
Author: Tomas Bortoli <tomasbortoli@gmail.com>
Date:   Mon Jul 23 18:42:53 2018 +0000

     net/9p/trans_fd.c: fix race by holding the lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11adad06600000
start commit:   c25c74b7 Merge tag 'trace-v4.18-rc3-2' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=25856fac4e580aa7
dashboard link: https://syzkaller.appspot.com/bug?extid=ad0832746849421bba05
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d8db0c400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c12a58400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: net/9p/trans_fd.c: fix race by holding the lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
