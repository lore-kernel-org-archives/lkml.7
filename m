Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84520C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AF7204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLQGdWF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfDDKxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:53:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43723 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfDDKxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:53:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so3138438wrx.10;
        Thu, 04 Apr 2019 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pxvL35aH/7RCJzE3gEleqG2No3mstCVxiwL9/BTlxAc=;
        b=HLQGdWF0YJME6Od1MQuO0vqx36A1rl8EcMhGek3Sm0QAC6nl0/8Y3r8W0xzio9LQ4z
         /uI8SryNeBxJxdmDoXr+ZGKGpsh1Uo4H3fNH+ah7crSpkus6DplLa3hi57PPH4uP6/K1
         74I+QuIt9HmZKUkh53rbzd3ji9hbcAO0LcpEURBpb6YYW7xuJNsM82BuK3vOBgtEajMZ
         8yam7rsz/qIpMv++9yom3OY6M/XzWMUqzcs3tr8HdQAp1bG/ew388JHUqEfM9sVllNgY
         I4cmSA2G/yzhseoI0m4nLVS4Hfbu70/8UTm/v7ngeGAG8NH7o8KQqM1IMutwiq2SWNoX
         uZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pxvL35aH/7RCJzE3gEleqG2No3mstCVxiwL9/BTlxAc=;
        b=InjbYcM4XoOdyYljXI3fAkdhCtLXPwAxMh52x2jB4v6H8I3IqMdnWzRlc/JUEH2eNZ
         cUvQewKQoJNAht7/dAJ+8QeXToPXeup6xXP3ugBoQegtmd4pv9AKZjcLyLSvkRYZYphu
         PloS6O5pUwEEHKdA8vfKKIPzsq98aY1QH6/Mh/K9BILyoJXGSBx0QTJV5+4D9Q0VkoNl
         Wn488aZ88lZpFs+Rs69ZFM6u/27aq6k5Pch6n6F26ZtIvzZxsLkGN3q7tIlTJ3LKJ3at
         Sq2nFZYMhezKW+TI0Ecl+Dxy5iie4NuTCNglTIGqMANGCk2tz9lBUgWyKncvhTN1r+gk
         JkGg==
X-Gm-Message-State: APjAAAXLYkWsTCO4Wt4dG7wgd8GA/atkW5NCRN0D7VskiurWfSwvj4n4
        msFor4E5M/G6SH2or59QGchp3lmcwCo=
X-Google-Smtp-Source: APXvYqwbgeYeXk0wnbPxVpUTN6Jnm/LpFlH/JLVXcA62UOaTyMD14k6QlxTyhXWsZixx0HiWzeXP/Q==
X-Received: by 2002:adf:f050:: with SMTP id t16mr157708wro.198.1554375181628;
        Thu, 04 Apr 2019 03:53:01 -0700 (PDT)
Received: from amir-VirtualBox.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id x205sm17115285wmg.9.2019.04.04.03.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 03:53:00 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] acct: fix possible deadlock in acct_pin_kill
Date:   Thu,  4 Apr 2019 13:52:55 +0300
Message-Id: <20190404105255.12189-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like an old bug, pre-dating the "Fixes" commit, but the
"Fixes" commit did not handle it properly.

The bug recently surfaced as a lockdep possible deadlock warning
with commit d1d04ef8572b ("ovl: stack file ops").

When acct_on() replaces one acct file with another, it takes sb_writers
lock on new file sb and calls acct_pin_kill(old) before releasing the
sb_writers lock.

If new file is on the same fs as old file, acct_pin_kill(old) fail to
file_start_write_trylock() and skip writing the old file, because
sb_writers (of new) is already taken by acct_on().

If new file is not on same fs as old file, this ordering violation
creates an unneeded dependency between new sb_writers and old sb_writers,
which may later be reported as possible deadlock.

This could result in an actual deadlock if acct file is replaced from
an old file in overlayfs over "real fs" to a new file in "real fs".
acct_on() takes freeze protection on "real fs" and tries to write to
overlayfs file. overlayfs is not freeze protected so do_acct_process()
can carry on with __kernel_write() to overlayfs file, which would
try to take freeze protection on "real fs" and deadlock.

Reproducer of lockdep possible deadlock warning:

  mkdir -p mnt upper lower work
  touch upper/x upper/y
  mount -t overlay none mnt -olowerdir=lower,upperdir=upper,workdir=work
  accton mnt/x
  accton upper/y

 ======================================================
 WARNING: possible circular locking dependency detected
 4.19.0-rc1-xfstests #3424 Not tainted
 ------------------------------------------------------
 accton/1390 is trying to acquire lock:
 00000000e0585aa5 (&acct->lock#2){+.+.}, at: acct_pin_kill+0x1b/0x76

 but task is already holding lock:
 000000003692505a (sb_writers#6){.+.+}, at: mnt_want_write+0x1d/0x42

Reported-and-tested-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com
Fixes: 59eda0e07f43 ("new fs_pin killing logics")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Al,

I've pinged you several times about this patch.
Not sure if you had missed it or haven't had the time to look at
it yet. syzbot has been complaining about the bug for a while now.

Fixes label claims to fix your commit, but I believe the bug was
already there before your commit.

As you can see, I have a reproducer to demonstrate the manifestation of
the bug in the case of switching acct file from overlayfs to real fs.
This started to manifest with overlayfs stacked f_op.

I have made another claim about correctness of acct_on() when switching
files on the same fs which seems obvious from the code, but did not
bother to try to reproducer, because I doubt if anyone cares.

Thanks,
Amir.

Changes from v1:
- Add Reported-and-tested-by syzbot

 kernel/acct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index addf7732fb56..c09355a7ae46 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -251,8 +251,8 @@ static int acct_on(struct filename *pathname)
 	rcu_read_lock();
 	old = xchg(&ns->bacct, &acct->pin);
 	mutex_unlock(&acct->lock);
-	pin_kill(old);
 	mnt_drop_write(mnt);
+	pin_kill(old);
 	mntput(mnt);
 	return 0;
 }
-- 
2.17.1

