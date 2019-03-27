Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C026C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346CE2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfC0UKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:10:04 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46880 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfC0UKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:10:02 -0400
Received: by mail-io1-f71.google.com with SMTP id k5so14045108ioh.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M9LZ+bMimI4PbDOfuBNIBaRlNMQDprLBDf38mjJfhKc=;
        b=evWRrkRt/f6LQYZkXTuZqQWNnDJ9dC2d2qVXrkfjIzTR95Kg4nWv4bu8sPXiY8Ngne
         cQmk7XFbH+46Ny3mKe76WvCJZF4AnrgjiEHtsXMLRLZQZwqdfUC065TNCi4s7hPvs6jK
         z4ENnqdYQSPAMZHFoBR8eGUPiaQA25gLTNYCZt2G0SmUBfT74po+lmwVdQhz5CHLDsb3
         EOOo1qmYxTQ88JVVSwNji2vFpTdO87mkMIvsxbIBRA3uIZG11YGWkTHk7jxLHzqOdxVa
         JD2GyxPobn1DNu3GYSqPfEV8v+zvbp85fQYgdk5ZGyNhu7IQp66PRjIOjFRVfJdCSBlY
         X7gw==
X-Gm-Message-State: APjAAAUFlNIsz9sL44MQhTCm08Mqb0NOatMqIWYkZIjHhhbqMlOqJh45
        Y+OXk2I1ROCLD26Y1Pw9B9OStcu6NxOdUiZb3m89zotFlIy/
X-Google-Smtp-Source: APXvYqyDAf4ploxQXeYfC+CFYQgbOcopu+jJ1sXdRok24pSP1DcDyVjvzKS+bGYT+67jK4ftl65L/WTLJk3QASrrZ0jfVnqyzKD5
MIME-Version: 1.0
X-Received: by 2002:a24:2704:: with SMTP id g4mr1307352ita.36.1553717401059;
 Wed, 27 Mar 2019 13:10:01 -0700 (PDT)
Date:   Wed, 27 Mar 2019 13:10:01 -0700
In-Reply-To: <00000000000051ee78057cc4d98f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c58fcf058519059e@google.com>
Subject: Re: general protection fault in put_pid
From:   syzbot <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, clm@fb.com, dan.carpenter@oracle.com,
        dave@stgolabs.net, dhowells@redhat.com, dsterba@suse.com,
        dvyukov@google.com, ebiederm@xmission.com, jbacik@fb.com,
        ktkhai@virtuozzo.com, ktsanaktsidis@zendesk.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, manfred@colorfullife.com, mhocko@suse.com,
        nborisov@suse.com, penguin-kernel@I-love.SAKURA.ne.jp,
        penguin-kernel@i-love.sakura.ne.jp, rppt@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit b9b8a41adeff5666b402996020b698504c927353
Author: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon Aug 20 08:25:33 2018 +0000

     btrfs: use after free in btrfs_quota_enable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14155a1f200000
start commit:   f5d58277 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16155a1f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=12155a1f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000

Reported-by: syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com
Fixes: b9b8a41adeff ("btrfs: use after free in btrfs_quota_enable")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
