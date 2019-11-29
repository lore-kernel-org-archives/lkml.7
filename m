Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FD820869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="0wOIp5DU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfK2NVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:21:54 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54416 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbfK2NVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:21:53 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1C5CE2E14B7;
        Fri, 29 Nov 2019 16:21:50 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Jn2OmG20Ag-Ln3aK9dY;
        Fri, 29 Nov 2019 16:21:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1575033710; bh=R2z27gs6Da33rqKnA4TD3aOyyj12Jol0aRE9ZSW7rhI=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=0wOIp5DUInJNy36A3asVYaNzza+EBbDHX3q3S1gZpNdscSu3VccvhTdA8m0YfYVhi
         sQn8IDQbljJkS7RE8g0ScCPGbtLrkoRQdcAG5b6nXvwfoDq3PxJ/KlelKX2pbrW+TM
         5PUAZgd+v+SIzTNfl1y/R73dcQuCrj5YKDhH5DHg=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:1009:4fae:ad87:4eae])
        by myt4-4db2488e778a.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 0j5FWt6wbj-LnWiL4t9;
        Fri, 29 Nov 2019 16:21:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/2] kernel: add sysctl kernel.nr_taints
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 29 Nov 2019 16:21:48 +0300
Message-ID: <157503370887.8187.1663761929323284758.stgit@buzz>
In-Reply-To: <157503370645.8187.6335564487789994134.stgit@buzz>
References: <157503370645.8187.6335564487789994134.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once taint flag is set it's never cleared. Following taint could be detected
only via parsing kernel log messages which are different for each occasion.
For repeatable taints like TAINT_MACHINE_CHECK, TAINT_BAD_PAGE, TAINT_DIE,
TAINT_WARN, TAINT_LOCKUP it would be good to know count to see their rate.

This patch adds sysctl with vector of counters. One for each taint flag.
Counters are non-atomic in favor of simplicity. Exact count doesn't matter.
Writing vector of zeroes resets counters.

This is useful for detecting frequent problems with automatic monitoring.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/kernel.h |    1 +
 kernel/panic.c         |    2 ++
 kernel/sysctl.c        |    9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index e8a6808e4f2f..900d02167bbd 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -604,6 +604,7 @@ struct taint_flag {
 };
 
 extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
+extern int sysctl_nr_taints[TAINT_FLAGS_COUNT];
 
 extern const char hex_asc[];
 #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
diff --git a/kernel/panic.c b/kernel/panic.c
index d7750a45ca8d..a3df00ebcba2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+int sysctl_nr_taints[TAINT_FLAGS_COUNT];
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -434,6 +435,7 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
 		pr_warn("Disabling lock debugging due to kernel taint\n");
 
 	set_bit(flag, &tainted_mask);
+	sysctl_nr_taints[flag]++;
 }
 EXPORT_SYMBOL(add_taint);
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b6f2f35d0bcf..5d9727556cef 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -553,6 +553,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_taint,
 	},
+	{
+		.procname	= "nr_taints",
+		.data		= &sysctl_nr_taints,
+		.maxlen		= sizeof(sysctl_nr_taints),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ZERO,
+	},
 	{
 		.procname	= "sysctl_writes_strict",
 		.data		= &sysctl_writes_strict,

