Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975E8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DA5218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfCULbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:31:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54127 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCULbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:31:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LBV9Fw107573
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:31:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LBV8No107570;
        Thu, 21 Mar 2019 04:31:08 -0700
Date:   Thu, 21 Mar 2019 04:31:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-9bd681251b7c1db1c6cfe29a72c5ea1b1c0ba022@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, bp@suse.de, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190313110022.8229-1-bp@alien8.de>
References: <20190313110022.8229-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/microcode: Announce reload operation's
 completion
Git-Commit-ID: 9bd681251b7c1db1c6cfe29a72c5ea1b1c0ba022
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

Commit-ID:  9bd681251b7c1db1c6cfe29a72c5ea1b1c0ba022
Gitweb:     https://git.kernel.org/tip/9bd681251b7c1db1c6cfe29a72c5ea1b1c0ba022
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 13 Mar 2019 12:00:22 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:24:39 +0100

x86/microcode: Announce reload operation's completion

By popular demand, issue a single line to dmesg after the reload
operation completes to let the user know that a reload has at least been
attempted.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190313110022.8229-1-bp@alien8.de

---
 arch/x86/kernel/cpu/microcode/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 97f9ada9ceda..5260185cbf7b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -608,6 +608,8 @@ static int microcode_reload_late(void)
 	if (ret > 0)
 		microcode_check();
 
+	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
+
 	return ret;
 }
 
