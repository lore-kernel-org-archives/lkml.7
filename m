Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55B2C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CF5208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e3R8zpyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfF0Xry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:47:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0Xry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:47:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNlZsV503085
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:47:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNlZsV503085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679256;
        bh=dHC6ig0/remYSbb17ANAbzepvA3ymaeJEI2Ue7UCDc8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=e3R8zpyyl8tZZnK3tY7mIdvSaGtolUGKVr0PNKqlUtG550YGfkluyx3btLCFpNred
         axcgu/gd6oa3GjVsKfkSwZF3mNJ8AKcKwzjDiVU7V4UsKC0GaDRQ70j2JwNzPHRRlj
         U5/HILVHjvHmw4o08dN0bvsZxz8MpiG/mvQl3To8GIGxlPxi3IDDmfWcpe2f8Aq/SU
         HAjWV4eSxB/fuUFA8xxyaScKT9F1bbBknO2QZrm+UacwxXOF9O7MNxKwA4nzS558qu
         15SLq1dj+2cM36cuVXExwd6s982jqfL4qeKFhVx3ZX8JuwnfRZyoXcrZNHGbT6mnOo
         8/GCNzjKivHBA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNlZ9Z503082;
        Thu, 27 Jun 2019 16:47:35 -0700
Date:   Thu, 27 Jun 2019 16:47:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-9e16e4933e48819a259b8967e72e5765349953b1@git.kernel.org>
Cc:     ricardo.neri-calderon@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ashok.raj@intel.com, hpa@zytor.com, mingo@kernel.org,
        ravi.v.shankar@intel.com, eranian@google.com, andi.kleen@intel.com,
        tglx@linutronix.de, Suravee.Suthikulpanit@amd.com
Reply-To: peterz@infradead.org, ashok.raj@intel.com,
          linux-kernel@vger.kernel.org,
          ricardo.neri-calderon@linux.intel.com,
          Suravee.Suthikulpanit@amd.com, andi.kleen@intel.com,
          tglx@linutronix.de, eranian@google.com, ravi.v.shankar@intel.com,
          mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190623132435.911652981@linutronix.de>
References: <20190623132435.911652981@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Add mode information to struct
 hpet_channel
Git-Commit-ID: 9e16e4933e48819a259b8967e72e5765349953b1
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

Commit-ID:  9e16e4933e48819a259b8967e72e5765349953b1
Gitweb:     https://git.kernel.org/tip/9e16e4933e48819a259b8967e72e5765349953b1
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Jun 2019 15:24:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:23 +0200

x86/hpet: Add mode information to struct hpet_channel

The usage of the individual HPET channels is not tracked in a central
place. The information is scattered in different data structures. Also the
HPET reservation in the HPET character device is split out into several
places which makes the code hard to follow.

Assigning a mode to the channel allows to consolidate the reservation code
and paves the way for further simplifications.

As a first step set the mode of the legacy channels when the HPET is in
legacy mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132435.911652981@linutronix.de

---
 arch/x86/kernel/hpet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 8711f1fdef8f..3a8ec363d569 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -22,9 +22,17 @@ struct hpet_dev {
 	char				name[10];
 };
 
+enum hpet_mode {
+	HPET_MODE_UNUSED,
+	HPET_MODE_LEGACY,
+	HPET_MODE_CLOCKEVT,
+	HPET_MODE_DEVICE,
+};
+
 struct hpet_channel {
 	unsigned int			num;
 	unsigned int			irq;
+	enum hpet_mode			mode;
 	unsigned int			boot_cfg;
 };
 
@@ -947,6 +955,9 @@ int __init hpet_enable(void)
 
 	if (id & HPET_ID_LEGSUP) {
 		hpet_legacy_clockevent_register();
+		hpet_base.channels[0].mode = HPET_MODE_LEGACY;
+		if (IS_ENABLED(CONFIG_HPET_EMULATE_RTC))
+			hpet_base.channels[1].mode = HPET_MODE_LEGACY;
 		return 1;
 	}
 	return 0;
