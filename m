Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DBC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 08:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C332245C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 08:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="akIv4X6Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLGH6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 02:58:51 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36667 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfLGH6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 02:58:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id s25so3655800qks.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 23:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OZxrpveecc01VbvYyTvB3V1kyWxv/dSiTH96dSfU/E=;
        b=akIv4X6QceP15B8i+vSX5Mhe8GR7D0je98TUBcNOIid9R9ors1oCMMd369NO/6prIf
         ppQGz4/d0ntDc1Md+hDtq/E0hrjj3Bqj3Vy2yra2MpXtRycHfVmtlDwPP9XL6zVLwz+W
         8SwdOAA+QaVfpJOruQm2k6QZDrWlvMXkSnAauD8MnaXvY1cM19eiMbCqqTFTGSQDr722
         EJIQqUAQxZ1nBy4P9DeFORT5RnVrFg/wShHz7IjjZ3l31B1l0m4z7EJ74lUuLUqC5aQs
         RswYEzBPLJFUB9ZMVfoNA7hR8fCL6Wjxwmv7PHc92S2aaUawsRKVQ48NFvuxqMdNdzaU
         gfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OZxrpveecc01VbvYyTvB3V1kyWxv/dSiTH96dSfU/E=;
        b=ilYVV4VnPLIEFkEHA7gHeEcpNK0saoJ+W9H+tmekuf0JZyh45WmccemYxhcGinEvCE
         T957l3mCzm/rnaGADUaOVQSASnJnLT5FFyCKWO4m4KhNDXazlltBMJXVSzhcmT0EbksV
         234c6U9ClplqBnqzYuZd82ED/Tr1H1QBk2iVldn5nuBSAr/Q1eFfIzuaxDRYDC8APxim
         XpskulQzktsw3+REb848hKQOs+b5EXyM5xxwkN7Ndl//c4UUwL8/z7gVRfZDbnbqRIuw
         6DXlI/SjPwoKs8GeOZyJyvjIelWh17qMvcd/XRgl/Qzjek9YAJInro52kzTG0nTYD+27
         c9Kw==
X-Gm-Message-State: APjAAAU79+Xd4lexHerqGDdpfqDEE9ROPuceQjD5SVInzugcHRFTATcT
        rJKrg2D72TN/TF18a+eRsxhL1rrl7I0=
X-Google-Smtp-Source: APXvYqzvTxM1HQXuPba4AJRBPMMpNXtAjpTg4XAIUN0SPDIepGHTr/mLhv6SsJ1vChGTsAQgtK41QA==
X-Received: by 2002:a05:620a:1324:: with SMTP id p4mr7967858qkj.497.1575705529543;
        Fri, 06 Dec 2019 23:58:49 -0800 (PST)
Received: from ovpn-121-247.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d143sm1283497qke.123.2019.12.06.23.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 23:58:48 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tglx@linutronix.de, john.stultz@linaro.org
Cc:     sboyd@kernel.org, vikas.shivappa@linux.intel.com,
        tony.luck@intel.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] timer: fix a debugobjects warning in del_timer()
Date:   Sat,  7 Dec 2019 02:58:28 -0500
Message-Id: <20191207075828.2347-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit e33026831bdb ("x86/intel_rdt/mbm: Handle counter
overflow"), it will generate a debugobjects warning while offlining
CPUs.

ODEBUG: assert_init not available (active state 0) object type:
timer_list hint: 0x0
WARNING: CPU: 143 PID: 789 at lib/debugobjects.c:484
debug_print_object+0xfe/0x140
Hardware name: HP Synergy 680 Gen9/Synergy 680 Gen9 Compute Module, BIOS
I40 05/23/2018
RIP: 0010:debug_print_object+0xfe/0x140
Call Trace:
 debug_object_assert_init+0x1f5/0x240
 del_timer+0x6f/0xf0
 try_to_grab_pending+0x42/0x3c0
 cancel_delayed_work+0x7d/0x150
 resctrl_offline_cpu+0x3c0/0x520
 cpuhp_invoke_callback+0x197/0x1120
 cpuhp_thread_fun+0x252/0x2f0
 smpboot_thread_fn+0x255/0x440
 kthread+0x1e6/0x210
 ret_from_fork+0x3a/0x50

This is because in domain_remove_cpu() when "cpu == d->mbm_work_cpu", it
calls cancel_delayed_work(&d->mbm_over) to deactivate the timer, and
then mbm_setup_overflow_handler() calls schedule_delayed_work_on() with
0 delay which does not activiate the timer in __queue_delayed_work().

Later, when the last CPU in the same L3 cache goes offline, it calls
cancel_delayed_work(&d->mbm_over) again in domain_remove_cpu() and
trigger the warning because the timer is still inactive.

Since del_timer() could be called on both active and inactive timers,
debug_assert_init() should be called only when there is an active timer.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/time/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823515e9..90a7658dca07 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1193,9 +1193,9 @@ int del_timer(struct timer_list *timer)
 	unsigned long flags;
 	int ret = 0;
 
-	debug_assert_init(timer);
-
 	if (timer_pending(timer)) {
+		debug_assert_init(timer);
+
 		base = lock_timer_base(timer, &flags);
 		ret = detach_if_pending(timer, base, true);
 		raw_spin_unlock_irqrestore(&base->lock, flags);
-- 
2.21.0 (Apple Git-122.2)

