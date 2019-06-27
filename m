Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CABC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6C42084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oBkAdZLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfF0Hh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:37:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0Hh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:37:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5R7bAJg177138
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 00:37:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5R7bAJg177138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561621031;
        bh=4LQhO5iKOeqHsEwFapxOyCS0pfnKvdjPzTYio4diccA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=oBkAdZLATCASnJM0AXQjrrvlC7qmQMNjs4A5HdZ9+SVOj6sHqoL2qRh0hmTS3wVd0
         5Rtpb3/S/2XLMrA8H1ksZw2T/BBbb+YDdzHAnSkG0aaHAI71tjNFSB52/dyiwnWob7
         I/SR1r5+ET0s46WcZjnxC5qNMKLI0Bs9qeOvD/onDZ6l/Qmso2/xydODkrV3UjgxXl
         O8oLqjOXaP6HHL2R+0o8grV4F2tdocfeeWRcW3dQmM54fojzPglPctNqqVPj7ZCzlu
         b1inHcI0KMKUah9+u2iuPIT27ZdSXTvTrP5GuDxBKz8H/IAIvO7mha4dQuyNIsQHby
         TKhvvKChnIIMw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5R7bATa177135;
        Thu, 27 Jun 2019 00:37:10 -0700
Date:   Thu, 27 Jun 2019 00:37:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eiichi Tsukata <tipbot@zytor.com>
Message-ID: <tip-33d4a5a7a5b4d02915d765064b2319e90a11cbde@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        devel@etsukata.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          devel@etsukata.com, tglx@linutronix.de
In-Reply-To: <20190627024732.31672-1-devel@etsukata.com>
References: <20190627024732.31672-1-devel@etsukata.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:smp/urgent] cpu/hotplug: Fix out-of-bounds read when setting
 fail state
Git-Commit-ID: 33d4a5a7a5b4d02915d765064b2319e90a11cbde
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  33d4a5a7a5b4d02915d765064b2319e90a11cbde
Gitweb:     https://git.kernel.org/tip/33d4a5a7a5b4d02915d765064b2319e90a11cbde
Author:     Eiichi Tsukata <devel@etsukata.com>
AuthorDate: Thu, 27 Jun 2019 11:47:32 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Jun 2019 09:34:04 +0200

cpu/hotplug: Fix out-of-bounds read when setting fail state

Setting invalid value to /sys/devices/system/cpu/cpuX/hotplug/fail
can control `struct cpuhp_step *sp` address, results in the following
global-out-of-bounds read.

Reproducer:

  # echo -2 > /sys/devices/system/cpu/cpu0/hotplug/fail

KASAN report:

  BUG: KASAN: global-out-of-bounds in write_cpuhp_fail+0x2cd/0x2e0
  Read of size 8 at addr ffffffff89734438 by task bash/1941

  CPU: 0 PID: 1941 Comm: bash Not tainted 5.2.0-rc6+ #31
  Call Trace:
   write_cpuhp_fail+0x2cd/0x2e0
   dev_attr_store+0x58/0x80
   sysfs_kf_write+0x13d/0x1a0
   kernfs_fop_write+0x2bc/0x460
   vfs_write+0x1e1/0x560
   ksys_write+0x126/0x250
   do_syscall_64+0xc1/0x390
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x7f05e4f4c970

  The buggy address belongs to the variable:
   cpu_hotplug_lock+0x98/0xa0

  Memory state around the buggy address:
   ffffffff89734300: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
   ffffffff89734380: fa fa fa fa 00 00 00 00 00 00 00 00 00 00 00 00
  >ffffffff89734400: 00 00 00 00 fa fa fa fa 00 00 00 00 fa fa fa fa
                                          ^
   ffffffff89734480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffffffff89734500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Add a sanity check for the value written from user space.

Fixes: 1db49484f21ed ("smp/hotplug: Hotplug state fail injection")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Link: https://lkml.kernel.org/r/20190627024732.31672-1-devel@etsukata.com

---
 kernel/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 551db494f153..ef1c565edc5d 100644
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
