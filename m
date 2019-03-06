Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511BAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D29520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbfCFTqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:46:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfCFTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:46:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x26JjwUa1854540
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 11:45:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x26JjwAu1854537;
        Wed, 6 Mar 2019 11:45:58 -0800
Date:   Wed, 6 Mar 2019 11:45:58 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-041a15744a7fb4e9b2759611e44fb8847960564e@git.kernel.org>
Cc:     mingo@kernel.org, fweisbec@gmail.com, hpa@zytor.com, arnd@arndb.de,
        paulmck@linux.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, paulmck@linux.ibm.com, tglx@linutronix.de,
          fweisbec@gmail.com, hpa@zytor.com, arnd@arndb.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190304200202.1163250-1-arnd@arndb.de>
References: <20190304200202.1163250-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] time: Make VIRT_CPU_ACCOUNTING_GEN depend on
 GENERIC_CLOCKEVENTS
Git-Commit-ID: 041a15744a7fb4e9b2759611e44fb8847960564e
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

Commit-ID:  041a15744a7fb4e9b2759611e44fb8847960564e
Gitweb:     https://git.kernel.org/tip/041a15744a7fb4e9b2759611e44fb8847960564e
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 4 Mar 2019 21:01:31 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 20:43:08 +0100

time: Make VIRT_CPU_ACCOUNTING_GEN depend on GENERIC_CLOCKEVENTS

Moving the CONTEXT_TRACKING Kconfig option into kernel/time/Kconfig added
an implicit dependency on the surrounding GENERIC_CLOCKEVENTS option, but
this is not always enabled when it is possible to select
VIRT_CPU_ACCOUNTING_GEN:

WARNING: unmet direct dependencies detected for CONTEXT_TRACKING
  Depends on [n]: GENERIC_CLOCKEVENTS [=n]
  Selected by [y]:
  - VIRT_CPU_ACCOUNTING_GEN [=y] && <choice> && HAVE_CONTEXT_TRACKING [=y] && HAVE_VIRT_CPU_ACCOUNTING_GEN [=y]

Platforms without GENERIC_CLOCKEVENTS are rare enough so that corner case
can be just ignored. Make it a dependency for VIRT_CPU_ACCOUNTING_GEN to
simplify the configuration.

Fixes: a4cffdad7314 ("time: Move CONTEXT_TRACKING to kernel/time/Kconfig")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://lkml.kernel.org/r/20190304200202.1163250-1-arnd@arndb.de

---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index c9386a365eea..acbde4ef2395 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -382,6 +382,7 @@ config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
 	depends on HAVE_CONTEXT_TRACKING
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
+	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help
