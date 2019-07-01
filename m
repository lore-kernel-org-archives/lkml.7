Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B06C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EE12064B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Amh80EQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfGAOsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:48:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36964 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfGAOsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:48:30 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so29436705iok.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSejyUTe512azskM/IpIonqmiTNyrrIhcYfEz7ZQPjg=;
        b=Amh80EQIE49mNx9Nt5N0ylXvUZ2MrcRTYm2KR2D157wXvQyeSLVA8VlKOo6HCYlsVv
         W23eGT61hICOIQ3bjR5NKp4fjdId/wptUd05Q033kzuhFonOb6/Yva2M/n5TYLQ6ppkN
         k9B7LaBCd48qj/mcNSE2lOgvBUgCE2zuhvJ738SARcfmBrEISS7YU+ngISeIfODKaYDQ
         9DRieGXqOYlNXVpyS/jOzNXbrDR2vC1N1DTD3jTmdtU+GaskNmiV+1ZlzdsASB+jCaIe
         7YVd29gjERVWMNSYt9DbYW5ZWibrT1S0BRbku1fpZ2VuwhEXmQRC2uHN7Ez3VYiCjf47
         aixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSejyUTe512azskM/IpIonqmiTNyrrIhcYfEz7ZQPjg=;
        b=Jk60f1bNymjD1q9mdJNii/CVttvPM/j87oD0rFhNsRMCuMy3MbPl2Qe+j5fSffrDyl
         IiXMbY1DEXa0f4e60E1NuNcEPAkHrmjWNKGn4DvJhu/SPhAD0YT8t3tU1WBLTAue0HbV
         XZcR5p9SLNIvDHJwl/dfPadUQ3WQ2O1Mnw201d0twebEWCtRrR3m9KDZ0wFlWF9JpF06
         J50BsepZyg/6Mftr2NXLuFhiZFJivFZSJ4HUV8d4DPx+yzXg+u/jQ3r6C5aU4DGx5gGf
         MRPRL1Ps7o1GaUDf2sXxYJlVaD+WdSkPyXnBJM7teQvg+9FxUgb5I8fwOmHXSZR/tXqo
         9+Cg==
X-Gm-Message-State: APjAAAUU8HBOAUSmAbOpqunTAoEiVx1MEiIAOZgKMq16iCDdlc+HPq6U
        dIAhHFR/SVR1W170ML/BPwZO7w==
X-Google-Smtp-Source: APXvYqzbfDnQnpkfPgPHbXwJBjPBvfaGSnyg+u7fbDEbY7QzQOovqTakzB10tVcti/gaNb7cYVW1lg==
X-Received: by 2002:a02:b798:: with SMTP id f24mr17183838jam.97.1561992509632;
        Mon, 01 Jul 2019 07:48:29 -0700 (PDT)
Received: from localhost.localdomain ([208.54.80.252])
        by smtp.gmail.com with ESMTPSA id x22sm9062178iob.84.2019.07.01.07.48.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 07:48:28 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com,
        viro@zeniv.linux.org.uk, jannh@google.com
Cc:     akpm@linux-foundation.org, arunks@codeaurora.org,
        ebiederm@xmission.com, elena.reshetova@intel.com,
        gregkh@linuxfoundation.org, guro@fb.com, ktsanaktsidis@zendesk.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, riel@surriel.com, rppt@linux.vnet.ibm.com,
        scuttimmy@gmail.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willy@infradead.org, yuehaibing@huawei.com,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH] fork: return proper negative error code
Date:   Mon,  1 Jul 2019 16:48:08 +0200
Message-Id: <20190701144808.6804-1-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <000000000000e0dc0d058c9e7142@google.com>
References: <000000000000e0dc0d058c9e7142@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to return a proper negative error code from copy_process()
when anon_inode_getfile() fails with CLONE_PIDFD.
Otherwise _do_fork() will not detect an error and get_task_pid() will
operator on a nonsensical pointer:

R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffc15fbb0ff R14: 00007ff07e47e9c0 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7990 Comm: syz-executor290 Not tainted 5.2.0-rc6+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:194 [inline]
RIP: 0010:get_task_pid+0xe1/0x210 kernel/pid.c:372
Code: 89 ff e8 62 27 5f 00 49 8b 07 44 89 f1 4c 8d bc c8 90 01 00 00 eb 0c
e8 0d fe 25 00 49 81 c7 38 05 00 00 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 74
08 4c 89 ff e8 31 27 5f 00 4d 8b 37 e8 f9 47 12 00
RSP: 0018:ffff88808a4a7d78 EFLAGS: 00010203
RAX: 00000000000000a7 RBX: dffffc0000000000 RCX: ffff888088180600
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88808a4a7d90 R08: ffffffff814fb3a8 R09: ffffed1015d66bf8
R10: ffffed1015d66bf8 R11: 1ffff11015d66bf7 R12: 0000000000041ffc
R13: 1ffff11011494fbc R14: 0000000000000000 R15: 000000000000053d
FS:  00007ff07e47e700(0000) GS:ffff8880aeb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004b5100 CR3: 0000000094df2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  _do_fork+0x1b9/0x5f0 kernel/fork.c:2360
  __do_sys_clone kernel/fork.c:2454 [inline]
  __se_sys_clone kernel/fork.c:2448 [inline]
  __x64_sys_clone+0xc1/0xd0 kernel/fork.c:2448
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Link: https://lore.kernel.org/lkml/000000000000e0dc0d058c9e7142@google.com
Reported-and-tested-by: syzbot+002e636502bc4b64eb5c@syzkaller.appspotmail.com
Fixes: 6fd2fe494b17 ("copy_process(): don't use ksys_close() on cleanups")
Cc: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner <christian@brauner.io>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 61667909ce83..fe83343da24b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2036,6 +2036,7 @@ static __latent_entropy struct task_struct *copy_process(
 					      O_RDWR | O_CLOEXEC);
 		if (IS_ERR(pidfile)) {
 			put_unused_fd(pidfd);
+			retval = PTR_ERR(pidfile);
 			goto bad_fork_free_pid;
 		}
 		get_pid(pid);	/* held by pidfile now */
-- 
2.22.0

