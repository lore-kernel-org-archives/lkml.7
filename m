Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A938CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAA920872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437099;
	bh=LcmmwqOfby9yq1vOo2ElJ9bV8e0u3vySwHKazDJYZaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X4MJxqH5mQzW4EBqTsbnvdcPO09ATQBAzNsxCwrJxY7BU/VSHERjK4xe+5jausHaX
	 uBrzePywYaYWF5VBb7CkjnZGk54+tBAwhSNTgrl4UFgLbDS2uu5+LK/C61+q5My76p
	 walhrVe+KDDLCnRcAxrpAKczS+ht5SN/hJN2sLH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404133AbfJRWSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732783AbfJRWHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:07:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6FE22468;
        Fri, 18 Oct 2019 22:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436442;
        bh=LcmmwqOfby9yq1vOo2ElJ9bV8e0u3vySwHKazDJYZaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=03OWUfts0jtgENXlBSm8HjT9W+DFjj26wfLt/U8qJ61K4XGpUYxBMzpnN+Fz5nNy5
         FHRrenS/W50bIrWlHbZCbxmrTQ56oUHhWJ/19/R7J9XZ9jFNuNxy89DmaXCHNKwu+S
         wct1erkcy9QSv95fQmGoxC5vgN2xEvxyKl+aWR60=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        James Dingwall <james@dingwall.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 079/100] x86/xen: Return from panic notifier
Date:   Fri, 18 Oct 2019 18:05:04 -0400
Message-Id: <20191018220525.9042-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Ostrovsky <boris.ostrovsky@oracle.com>

[ Upstream commit c6875f3aacf2a5a913205accddabf0bfb75cac76 ]

Currently execution of panic() continues until Xen's panic notifier
(xen_panic_event()) is called at which point we make a hypercall that
never returns.

This means that any notifier that is supposed to be called later as
well as significant part of panic() code (such as pstore writes from
kmsg_dump()) is never executed.

There is no reason for xen_panic_event() to be this last point in
execution since panic()'s emergency_restart() will call into
xen_emergency_restart() from where we can perform our hypercall.

Nevertheless, we will provide xen_legacy_crash boot option that will
preserve original behavior during crash. This option could be used,
for example, if running kernel dumper (which happens after panic
notifiers) is undesirable.

Reported-by: James Dingwall <james@dingwall.me.uk>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/x86/xen/enlighten.c                      | 28 +++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 16607b178b474..a855f83defa6c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5117,6 +5117,10 @@
 				the unplug protocol
 			never -- do not unplug even if version check succeeds
 
+	xen_legacy_crash	[X86,XEN]
+			Crash from Xen panic notifier, without executing late
+			panic() code such as dumping handler.
+
 	xen_nopvspin	[X86,XEN]
 			Disables the ticketlock slowpath using Xen PV
 			optimizations.
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index c6c7c9b7b5c19..2483ff345bbcd 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -266,19 +266,41 @@ void xen_reboot(int reason)
 		BUG();
 }
 
+static int reboot_reason = SHUTDOWN_reboot;
+static bool xen_legacy_crash;
 void xen_emergency_restart(void)
 {
-	xen_reboot(SHUTDOWN_reboot);
+	xen_reboot(reboot_reason);
 }
 
 static int
 xen_panic_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
-	if (!kexec_crash_loaded())
-		xen_reboot(SHUTDOWN_crash);
+	if (!kexec_crash_loaded()) {
+		if (xen_legacy_crash)
+			xen_reboot(SHUTDOWN_crash);
+
+		reboot_reason = SHUTDOWN_crash;
+
+		/*
+		 * If panic_timeout==0 then we are supposed to wait forever.
+		 * However, to preserve original dom0 behavior we have to drop
+		 * into hypervisor. (domU behavior is controlled by its
+		 * config file)
+		 */
+		if (panic_timeout == 0)
+			panic_timeout = -1;
+	}
 	return NOTIFY_DONE;
 }
 
+static int __init parse_xen_legacy_crash(char *arg)
+{
+	xen_legacy_crash = true;
+	return 0;
+}
+early_param("xen_legacy_crash", parse_xen_legacy_crash);
+
 static struct notifier_block xen_panic_block = {
 	.notifier_call = xen_panic_event,
 	.priority = INT_MIN
-- 
2.20.1

