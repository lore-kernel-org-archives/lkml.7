Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE65C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FEF20665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="GZEiJ06O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfF0CsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:48:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38292 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfF0CsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:48:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so289467pgz.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPTmIbq5ljgDPmMGThCp/U+QvaPcVt6dpav2xNVcoSI=;
        b=GZEiJ06OA+Zl5JjF6TAZGqAJbi4Ydj70AwSdjn3r+KSHsaKlM2K9Ed7wk8dlGDX0ri
         JX3HozMe5YC8QLMhswL8Bt0726Ru1OqbBNsCBXl1U2OMgsUf8Xzk1ljM3k02LC6Gu+nu
         +QPqIc691ZfbYS/EQjhK5sTmIs2F7D1clto9/bTW0rlFvXNhY0US4pXIfB7eIolS5g8Y
         u9HWHD6h7CaU1wcL5xIcamV1fXuqh6qIvliwZcIfFXqxiIUT893s+fnTpdymFNsdMw0J
         lQDR89mPUxKa6AhYX/owSqk/cxt1fathFxjFhwwERc+s91GoZ9TUcxpJRmnkgo5/pUQE
         CHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPTmIbq5ljgDPmMGThCp/U+QvaPcVt6dpav2xNVcoSI=;
        b=sIMrq1Pw63cy7LLhz1O1m9RUcW/YFulxymHr4bo132BTngjEHuBdUADyQzGerGoNr5
         jS5/nZ+cp/5noyguxbd34IrRt4TBP2z4rkys5yn2mDhXEkDw/G8mocMshWj4hqFSptNE
         tLCq91q4eNvbdAOV1OlPtsUHn3Y3gkLjCchsXZJMh5xvi+senUk8d70Fg11X30BTXKev
         tS87gHfgkTZqYK20kFBJV1QOsmnRtYen6iNvpy5gxtm54aCGKlj7kU319upYXeTbIqLE
         aKXDOky1d9OpTtFWCDPuSCPj1sCDdI0RDVRamyG3MqoL+8R/1DH6PGOqKSgBZBG9SLBt
         gYuQ==
X-Gm-Message-State: APjAAAUOF9S8Ir3gnQviLCnSknb8p+9fUy40yHqQSB5z7DPclMAOIU+9
        bQUkH9zZNN6JOoarZvXfcPqSxw==
X-Google-Smtp-Source: APXvYqw0iDOCBWaXsVHgZpVHpFWKBBBj+hFc7H74bNxVAdLhytZhZlxm6ArHWEsCFKX12Ie+WNrw6Q==
X-Received: by 2002:a17:90a:1d8:: with SMTP id 24mr3083610pjd.70.1561603689869;
        Wed, 26 Jun 2019 19:48:09 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id f2sm420154pgs.83.2019.06.26.19.48.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 19:48:08 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] cpu/hotplug: Fix out-of-bounds read when setting fail state
Date:   Thu, 27 Jun 2019 11:47:32 +0900
Message-Id: <20190627024732.31672-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting invalid value to /sys/devices/system/cpu/cpuX/hotplug/fail
can control `struct cpuhp_step *sp` address, results in the following
global-out-of-bounds read.

Reproducer:

  # echo -2 > /sys/devices/system/cpu/cpu0/hotplug/fail

KASAN report:

  BUG: KASAN: global-out-of-bounds in write_cpuhp_fail+0x2cd/0x2e0
  Read of size 8 at addr ffffffff89734438 by task bash/1941

  CPU: 0 PID: 1941 Comm: bash Not tainted 5.2.0-rc6+ #31
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
  Call Trace:
   dump_stack+0xca/0x13e
   print_address_description.cold+0x5/0x246
   __kasan_report.cold+0x75/0x9a
   ? write_cpuhp_fail+0x2cd/0x2e0
   kasan_report+0xe/0x20
   write_cpuhp_fail+0x2cd/0x2e0
   ? takedown_cpu+0x3a0/0x3a0
   ? takedown_cpu+0x3a0/0x3a0
   dev_attr_store+0x58/0x80
   ? put_device+0x30/0x30
   sysfs_kf_write+0x13d/0x1a0
   kernfs_fop_write+0x2bc/0x460
   ? sysfs_kf_bin_read+0x270/0x270
   ? kernfs_notify+0x1f0/0x1f0
   __vfs_write+0x81/0x100
   vfs_write+0x1e1/0x560
   ksys_write+0x126/0x250
   ? __ia32_sys_read+0xb0/0xb0
   ? do_syscall_64+0x1f/0x390
   do_syscall_64+0xc1/0x390
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x7f05e4f4c970
  Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 04
  RSP: 002b:00007ffd7fa630f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f05e4f4c970
  RDX: 0000000000000003 RSI: 0000000002039c08 RDI: 0000000000000001
  RBP: 0000000002039c08 R08: 00007f05e520c760 R09: 00007f05e5858700
  R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000003
  R13: 0000000000000001 R14: 00007f05e520b600 R15: 0000000000000003

  The buggy address belongs to the variable:
   cpu_hotplug_lock+0x98/0xa0

  Memory state around the buggy address:
   ffffffff89734300: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
   ffffffff89734380: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
  >ffffffff89734400: 00 00 00 00 fa fa fa fa 00 00 00 00 fa fa fa fa
                                          ^
   ffffffff89734480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffffffff89734500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Adds sanity check for given value `fail`.

Fixes: 1db49484f21ed ("smp/hotplug: Hotplug state fail injection")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 077fde6fb953..336254a48502 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1964,6 +1964,9 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fail < CPUHP_OFFLINE || fail > CPUHP_ONLINE)
+		return -EINVAL;
+
 	/*
 	 * Cannot fail STARTING/DYING callbacks.
 	 */
-- 
2.21.0

