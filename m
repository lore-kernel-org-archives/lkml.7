Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE9C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630BE2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 07:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="KAFXgiUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfFNHlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:41:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45944 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNHlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:41:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id s21so1041986pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsiUkUiiGW2SWELwv5HDSwsA6rZPa5twFZuPhs7Mpzo=;
        b=KAFXgiUr4Nmtb7cC7a1LnzRsiOh6ApJl8HqJvKjHxEH4oWiBGUZzOYiM1nfogr5K0o
         CpHyTI/pehyr5bSMaNmg7p6iVbjXL4Tp4RcemRtVr4OmsZjyRmIqKP6gBgi2Ozvlq6jR
         E8VzuwZyjJojZ+iCvuR7GJ77JB+JR4x1/7Y+77MJ6qd9ZggWbwu0OXhsPKqjbUOg9jZC
         t7YdswMWAbrrP1Ps19NnX965G9JNB86CkY6o4Nt/dz0wyDhms24yIZB7EiYjjrR3K2vh
         biJuBYfcmHTqEYn1GrwjDs7utZpvkxhJnfbIXTbJP9/MMNfFzKo75Nck1mhZF14K0auU
         enGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsiUkUiiGW2SWELwv5HDSwsA6rZPa5twFZuPhs7Mpzo=;
        b=CDr7AXxYMb83azwU8WZ5q9XIOh0fz5leImS0H1s4iHnoUmWyqa1uPqOJV6G/w7tD52
         ubEyHYluBbySESAQLHmKDIi9+73JDdQVH++CPlQrEk86IrwQz2Vkl8IC0/auqVP19QVP
         pki8S5+XFR+iNRfSx7yxuP8+vDyWV7zrOxBMeYhqNs3rbCn66dBEpz2YKHT9Rk5HP4S2
         irMK943Ag7aRhTtca53YyOj1BV65I2ZAhjEJtdhLCg20ni5+4p39ko7t1rizAxp1VnR3
         zgV2KYCP01RB4NKyWer5hahTpsT2y+q12X4c6vWh6EBXIVq/mWD3GFbocO7RyAURszXu
         2/2A==
X-Gm-Message-State: APjAAAWh2D5trSko0oJgm64c0xtakSfgy9qXA58BE1agGEyZu0V+H+DC
        h4Y80M2Mpa26yu9Qhr8JIlGK4xbEgwA=
X-Google-Smtp-Source: APXvYqzHdAfIXfUqa9FSLycvnOdnrbH0XQxaAinfzRNbs2qvDh2Wdu/yUchN8CK1smXEv/sAZHHVVQ==
X-Received: by 2002:a65:648e:: with SMTP id e14mr9099260pgv.317.1560498059788;
        Fri, 14 Jun 2019 00:40:59 -0700 (PDT)
Received: from localhost.localdomain (p1227188-ipngn14401marunouchi.tokyo.ocn.ne.jp. [153.205.136.188])
        by smtp.gmail.com with ESMTPSA id o13sm3113636pfh.23.2019.06.14.00.40.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 00:40:59 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     rostedt@goodmis.org, mingo@redhat.com, srikar@linux.vnet.ibm.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH 1/2] tracing/uprobe: Fix NULL pointer dereference in trace_uprobe_create()
Date:   Fri, 14 Jun 2019 16:40:25 +0900
Message-Id: <20190614074026.8045-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like the case of commit 8b05a3a7503c ("tracing/kprobes: Fix NULL
pointer dereference in trace_kprobe_create()"), writing an incorrectly
formatted string to uprobe_events can trigger NULL pointer dereference.

Reporeducer:

  # echo r > /sys/kernel/debug/tracing/uprobe_events

dmesg:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 8000000079d12067 P4D 8000000079d12067 PUD 7b7ab067 PMD 0
  Oops: 0000 [#1] PREEMPT SMP PTI
  CPU: 0 PID: 1903 Comm: bash Not tainted 5.2.0-rc3+ #15
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
  RIP: 0010:strchr+0x0/0x30
  Code: c0 eb 0d 84 c9 74 18 48 83 c0 01 48 39 d0 74 0f 0f b6 0c 07 3a 0c 06 74 ea 19 c0 83 c8 01 c3 31 c0 c3 0f 1f 84 00 00 00 00 00 <0f> b6 07 89 f2 40 38 f0 75 0e eb 13 0f b6 47 01 48 83 c
  RSP: 0018:ffffb55fc0403d10 EFLAGS: 00010293

  RAX: ffff993ffb793400 RBX: 0000000000000000 RCX: ffffffffa4852625
  RDX: 0000000000000000 RSI: 000000000000002f RDI: 0000000000000000
  RBP: ffffb55fc0403dd0 R08: ffff993ffb793400 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: ffff993ff9cc1668 R14: 0000000000000001 R15: 0000000000000000
  FS:  00007f30c5147700(0000) GS:ffff993ffda00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 000000007b628000 CR4: 00000000000006f0
  Call Trace:
   trace_uprobe_create+0xe6/0xb10
   ? __kmalloc_track_caller+0xe6/0x1c0
   ? __kmalloc+0xf0/0x1d0
   ? trace_uprobe_create+0xb10/0xb10
   create_or_delete_trace_uprobe+0x35/0x90
   ? trace_uprobe_create+0xb10/0xb10
   trace_run_command+0x9c/0xb0
   trace_parse_run_command+0xf9/0x1eb
   ? probes_open+0x80/0x80
   __vfs_write+0x43/0x90
   vfs_write+0x14a/0x2a0
   ksys_write+0xa2/0x170
   do_syscall_64+0x7f/0x200
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 0597c49c69d5 ("tracing/uprobes: Use dyn_event framework for uprobe events")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 kernel/trace/trace_uprobe.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 0d60d6856de5..7dc8ee55cf84 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -443,10 +443,17 @@ static int trace_uprobe_create(int argc, const char **argv)
 	ret = 0;
 	ref_ctr_offset = 0;
 
-	/* argc must be >= 1 */
-	if (argv[0][0] == 'r')
+	switch (argv[0][0]) {
+	case 'r':
 		is_return = true;
-	else if (argv[0][0] != 'p' || argc < 2)
+		break;
+	case 'p':
+		break;
+	default:
+		return -ECANCELED;
+	}
+
+	if (argc < 2)
 		return -ECANCELED;
 
 	if (argv[0][1] == ':')
-- 
2.21.0

