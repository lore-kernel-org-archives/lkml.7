Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD58C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F9E206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbgAIR2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:28:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55110 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgAIR2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipbbK-0008ON-7u; Thu, 09 Jan 2020 18:28:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 897CB1C2CED;
        Thu,  9 Jan 2020 18:28:05 +0100 (CET)
Date:   Thu, 09 Jan 2020 17:28:05 -0000
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time/posix-stubs: Provide compat itimer supoprt
 for alpha
Cc:     Guenter Roeck <linux@roeck-us.net>,
        kbuild test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191207191043.656328-1-arnd@arndb.de>
References: <20191207191043.656328-1-arnd@arndb.de>
MIME-Version: 1.0
Message-ID: <157859088532.30329.4386380919465542175.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f35deaff1b8eadb9897e4fb8b3edc7717f4ec6fa
Gitweb:        https://git.kernel.org/tip/f35deaff1b8eadb9897e4fb8b3edc7717f4ec6fa
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Sat, 07 Dec 2019 20:10:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Jan 2020 18:20:23 +01:00

time/posix-stubs: Provide compat itimer supoprt for alpha

Using compat_sys_getitimer and compat_sys_setitimer on alpha
causes a link failure in the Alpha tinyconfig and other configurations
that turn off CONFIG_POSIX_TIMERS.

Use the same #ifdef check for the stub version as well.

Fixes: 4c22ea2b9120 ("y2038: use compat_{get,set}_itimer on alpha")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20191207191043.656328-1-arnd@arndb.de
---
 kernel/time/posix-stubs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f..20c65a7 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -151,6 +151,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYS_NI(timer_create);
+#endif
+
+#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
 COMPAT_SYS_NI(getitimer);
 COMPAT_SYS_NI(setitimer);
 #endif
