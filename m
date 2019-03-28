Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A56C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC3621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfC1NDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:03:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42352 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1NDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:03:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so19307691wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 06:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxSLTenBfnmz724y4L8PsmflSaCsaPmD4w20OUV9oBQ=;
        b=luCeC2FgguqfeVYvPrWbQlCN7imh3o1ivz1ut5O+z1dVo06XZPIdKEBLQ9lJK8yXmL
         OvHRuuZatkPIlNf6o8dIOQ7qOJTsmtqp6mt2yB2F1mHUsHreW8SwbBD2mR0BJ4B2tviD
         m3d3kExbniq22Z5mkxwgccS/03xVFOdWhPbQs57T3YDfJQsuZFSonSWl4GkkyYSZwseZ
         Y/Aiwb5ij9QobUXFQdWfHbU3fGwQzKzGNNqno36zzWjSGAA3RelqCVrfZMFEmeFY5E2x
         FpVHKCL68Z4yXglo4/R0JI4XYscXF/0pZl6p9Ajdq/z1KhvIpCBwK6d2TKIsgf2GJS5a
         C7Dg==
X-Gm-Message-State: APjAAAVWPYufiU2lEVhdWEPuLLRD12ri56W8AZyNy2EjJXEUihoPv+Gi
        hHLd/hdAqTz9n52mLbtf52pnlg==
X-Google-Smtp-Source: APXvYqyCbkCrDJviJGwRn0vQmGhPpIDygsYHFC4Cnxeid5LCqs1qAXYFGp60wqWMlu5qLazNchuwHA==
X-Received: by 2002:adf:edca:: with SMTP id v10mr25908161wro.157.1553778187933;
        Thu, 28 Mar 2019 06:03:07 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id z7sm3071512wml.40.2019.03.28.06.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:03:07 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
Date:   Thu, 28 Mar 2019 14:03:06 +0100
Message-Id: <20190328130306.25384-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs.file-max sysctl uses proc_doulongvec_minmax() as proc handler, which
accesses *extra1 and *extra2 as unsigned long, but commit 32a5ad9c2285
("sysctl: handle overflow for file-max") assigns &zero, which is an int,
to extra1, generating the following KASAN report.
Fix this by changing 'zero' to long, which does not need to be duplicated
like 'one' and 'one_ul' for two data types.

==================================================================
BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x2f9/0x600
Read of size 8 at addr ffffffff8233dc20 by task systemd/1

CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc2-kvm+ #22
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
Call Trace:
 print_address_description+0x67/0x23d
 kasan_report.cold.3+0x1c/0x36
 __do_proc_doulongvec_minmax+0x2f9/0x600
 proc_doulongvec_minmax+0x3a/0x50
 proc_sys_call_handler+0x11d/0x170
 vfs_write+0xd7/0x200
 ksys_write+0x93/0x110
 do_syscall_64+0x57/0x140
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f67d33e8804
Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 5e 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
RSP: 002b:00007fffd9992ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f67d33e8804
RDX: 0000000000000015 RSI: 00005586ce2607b0 RDI: 0000000000000004
RBP: 00007fffd9992f30 R08: 000000000000c0c0 R09: ffffffffffff0000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000015 R14: 00005586ce2607c4 R15: 00007fffd9992f70

The buggy address belongs to the variable:
 0xffffffff8233dc20

Memory state around the buggy address:
 ffffffff8233db00: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
 ffffffff8233db80: fa fa fa fa 04 fa fa fa fa fa fa fa 04 fa fa fa
>ffffffff8233dc00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
                               ^
 ffffffff8233dc80: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
 ffffffff8233dd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

Fixes: 32a5ad9c2285 ("sysctl: handle overflow for file-max")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e5da394d1ca3..3e959d67d619 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -124,7 +124,7 @@ static int sixty = 60;
 
 static int __maybe_unused neg_one = -1;
 
-static int zero;
+static long zero;
 static int __maybe_unused one = 1;
 static int __maybe_unused two = 2;
 static int __maybe_unused four = 4;
-- 
2.20.1

