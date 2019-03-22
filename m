Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5098F218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbfCVMoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:44:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47781 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388354AbfCVMoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:44:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MChxnY579241
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 05:43:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MChw5i579238;
        Fri, 22 Mar 2019 05:43:58 -0700
Date:   Fri, 22 Mar 2019 05:43:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valdis Kletnieks <tipbot@zytor.com>
Message-ID: <tip-48084abf212052ca1d39fae064c581b1ce5b1fdf@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, valdis.kletnieks@vt.edu
Reply-To: linux-kernel@vger.kernel.org, valdis.kletnieks@vt.edu,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <7855.1552383228@turing-police>
References: <7855.1552383228@turing-police>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] watchdog/core: Make variables static
Git-Commit-ID: 48084abf212052ca1d39fae064c581b1ce5b1fdf
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

Commit-ID:  48084abf212052ca1d39fae064c581b1ce5b1fdf
Gitweb:     https://git.kernel.org/tip/48084abf212052ca1d39fae064c581b1ce5b1fdf
Author:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
AuthorDate: Tue, 12 Mar 2019 05:33:48 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 13:40:17 +0100

watchdog/core: Make variables static

sparse complains:
  CHECK   kernel/watchdog.c
kernel/watchdog.c:45:19: warning: symbol 'nmi_watchdog_available'
			 	  was not declared. Should it be static?
kernel/watchdog.c:47:16: warning: symbol 'watchdog_allowed_mask'
			 	  was not declared. Should it be static?

They're not referenced by name from anyplace else, make them static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/7855.1552383228@turing-police


---
 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8fbfda94a67b..403c9bd90413 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -42,9 +42,9 @@ int __read_mostly watchdog_user_enabled = 1;
 int __read_mostly nmi_watchdog_user_enabled = NMI_WATCHDOG_DEFAULT;
 int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
-int __read_mostly nmi_watchdog_available;
+static int __read_mostly nmi_watchdog_available;
 
-struct cpumask watchdog_allowed_mask __read_mostly;
+static struct cpumask watchdog_allowed_mask __read_mostly;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
