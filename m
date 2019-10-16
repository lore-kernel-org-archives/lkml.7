Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A33DECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DBD21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194650;
	bh=aQc+9NX2jnQe4+eFFijlD/qvJyABcvYvQ+MUPaELr2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHdiEjL8Yv5QNkjjaI86wI3dNSSUajWh57kL3l4HycjdFrTwkYJVbeTIiZKGta0Ab
	 YDN99/MqD/hyWG1oiWwP/j3J4riXcX0TiQG41ImvYY6hs2ATZ8QevMKsB0DBU69C0X
	 oE+Zjy9Ov6AYd41cvDIy8dzw3hzIIw4JfzD2it/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390734AbfJPC52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390722AbfJPC5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:25 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F8B20663;
        Wed, 16 Oct 2019 02:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194644;
        bh=aQc+9NX2jnQe4+eFFijlD/qvJyABcvYvQ+MUPaELr2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCV+kyNYpEUln7/vax3bbLOiMVE3vYqfw4/dX83378c2NR4Qd1/OX6w0GM0WXYp1r
         rFbEKe+M10YgoIorJqxu/WIgPc5dMZjDeJDY458o0cgMALxblN15V+FLPjsqdStZQe
         HqyF/JxVv1LO2LvucCvkT/G788HH19DzHfKbQOwM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 06/14] context_tracking: Rename context_tracking_is_cpu_enabled() to context_tracking_enabled_this_cpu()
Date:   Wed, 16 Oct 2019 04:56:52 +0200
Message-Id: <20191016025700.31277-7-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Standardize the naming on top of the context_tracking_enabled_*() base.
Also make it clear we are checking the context tracking state of the
*current* CPU with this function. We'll need to add an API to check that
state on remote CPUs as well, so we must disambiguate the naming.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking.h       | 2 +-
 include/linux/context_tracking_state.h | 4 ++--
 include/linux/vtime.h                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index f1601bac08dc..c9065ad518a7 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -118,7 +118,7 @@ static inline void guest_enter_irqoff(void)
 	 * one time slice). Lets treat guest mode as quiescent state, just like
 	 * we do with user-mode execution.
 	 */
-	if (!context_tracking_cpu_is_enabled())
+	if (!context_tracking_enabled_this_cpu())
 		rcu_virt_note_context_switch(smp_processor_id());
 }
 
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 91250bdf2060..08f125f6b31b 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -31,7 +31,7 @@ static inline bool context_tracking_enabled(void)
 	return static_branch_unlikely(&context_tracking_key);
 }
 
-static inline bool context_tracking_cpu_is_enabled(void)
+static inline bool context_tracking_enabled_this_cpu(void)
 {
 	return __this_cpu_read(context_tracking.active);
 }
@@ -43,7 +43,7 @@ static inline bool context_tracking_in_user(void)
 #else
 static inline bool context_tracking_in_user(void) { return false; }
 static inline bool context_tracking_enabled(void) { return false; }
-static inline bool context_tracking_cpu_is_enabled(void) { return false; }
+static inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
 #endif
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 0fc7f11f7aa4..54e91511250b 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -34,7 +34,7 @@ static inline bool vtime_accounting_enabled(void)
 static inline bool vtime_accounting_cpu_enabled(void)
 {
 	if (vtime_accounting_enabled()) {
-		if (context_tracking_cpu_is_enabled())
+		if (context_tracking_enabled_this_cpu())
 			return true;
 	}
 
-- 
2.23.0

