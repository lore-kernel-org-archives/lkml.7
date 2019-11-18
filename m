Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5ECC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19464222DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLIHtQ5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfKRXmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:42:36 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46071 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKRXmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 18:42:35 -0500
Received: by mail-pg1-f201.google.com with SMTP id m13so3009561pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 15:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=0HR7354fwzZLoSsix3DSN5/aq9ZZkqFDIdkoEC/pg4Q=;
        b=eLIHtQ5cGODVB5oUClKGTxOm32S2L3VPlYuuJQy0HOf4Oecy2Eazi3odRqS8f+Gk1m
         PMOTqKF8xCcNqJysanPyICJC+k0lhf9Br26M+vCXz02RZBBLcMAHM0HJj4cN9vuASDks
         3IlPLeAMK8tTLiygMX5F3EwDQNu7R4MhLRreq4QJKpRWwE0JrkKcZbw4HicZOUqL33hb
         RytiyzJvaja2Nni7oyTzsXjdEASIPNRKFRfrMhviC020dLwaaG9TWA5G/dCi6I5keRZU
         v3aeMDw+rM7eo+pOhNYWXWxsZ1lYe2xkJedMTNkmwXjTD0grPvzxGCZTcdT3uZcthtFd
         GCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=0HR7354fwzZLoSsix3DSN5/aq9ZZkqFDIdkoEC/pg4Q=;
        b=ol6pce4imNmnbS0O0p4W4AxTOvd9dK4pg6oaAXlzsrY0FC2GmsI77JPtAqNV6Wmhsd
         HuIyQvGFpX92ofvMKCTzDUfBLtvAFLJYa5fPBxsPxO+M23dReN1rNgoiEP3T8hIblu4m
         QkRImI6VK0ammvh5VW+w/M7RoBafArhqNFzbxGpatDJ0Mgf2wjmjRpubR5Q/xh5rm2hG
         f42gvzvmsw4Gr4RH33htVLf6j99lSrUALzQuFpwEd6Tha+YTIs4oe2+5T1J9wYPGO0Kj
         V3CWkrGL+kz+BqkNfcDGY3Ihv7QLgZ7P9e//+FEUqX/gjHqOYqp1MfZWkkQfMh2GrEze
         swfQ==
X-Gm-Message-State: APjAAAUKe9TcqxXIQtGpVkyqd7advTQYwIdqr30lOAVsFbRQdPMr/ckn
        BrJex4D4oXYa/hfPjqiZTGdygFe8W+C3dZw=
X-Google-Smtp-Source: APXvYqzwIk4iobTLY88s1QZ96OOGkhRDC6hNTVvwik6LaqYqTQYmEX70hUoCsiX+t+O0+E9UMBnv3z1Gnc0eNUo=
X-Received: by 2002:a63:907:: with SMTP id 7mr2076044pgj.256.1574120554298;
 Mon, 18 Nov 2019 15:42:34 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:42:28 -0800
Message-Id: <20191118234229.54085-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v1] clk: Keep boot clocks on for multiple consumers
From:   Saravana Kannan <saravanak@google.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clocks can turned on (by the hardware, bootloader, etc) upon a
reset/boot of a hardware platform. These "boot clocks" could be clocking
devices that are active before the kernel starts running. For example,
clocks needed for the interconnects, UART console, display, CPUs, DDR,
etc.

When a boot clock is used by more than one consumer or multiple boot
clocks share a parent clock, the boot clock (or the common parent) can
be turned off when the first consumer probes. This can potentially crash
the device or cause poor user experience.

This patch fixes this by explicitly enabling the boot clocks during
clock registration and then disabling them at late_initcall_sync(). This
gives all the consumers until late_initcall() to put their "votes" in to
keep any of the boot clocks on past late_initcall().

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/clk/clk.c            | 62 ++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  1 +
 2 files changed, 63 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1c677d7f7f53..a1b09c9f8845 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -72,6 +72,8 @@ struct clk_core {
 	unsigned long		flags;
 	bool			orphan;
 	bool			rpm_enabled;
+	bool			state_held;
+	bool			boot_enabled;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
@@ -1300,6 +1302,36 @@ static int clk_disable_unused(void)
 }
 late_initcall_sync(clk_disable_unused);
 
+static void clk_unprepare_disable_subtree(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	lockdep_assert_held(&prepare_lock);
+
+	hlist_for_each_entry(child, &core->children, child_node)
+		clk_unprepare_disable_subtree(child);
+
+	if (!core->state_held)
+		return;
+
+	clk_core_disable_unprepare(core);
+}
+
+static int clk_release_boot_state(void)
+{
+	struct clk_core *core;
+
+	clk_prepare_lock();
+
+	hlist_for_each_entry(core, &clk_root_list, child_node)
+		clk_unprepare_disable_subtree(core);
+
+	clk_prepare_unlock();
+
+	return 0;
+}
+late_initcall_sync(clk_release_boot_state);
+
 static int clk_core_determine_round_nolock(struct clk_core *core,
 					   struct clk_rate_request *req)
 {
@@ -1674,6 +1706,30 @@ static int clk_fetch_parent_index(struct clk_core *core,
 	return i;
 }
 
+static void clk_core_hold_state(struct clk_core *core)
+{
+	if (core->state_held || !core->boot_enabled ||
+	    core->flags & CLK_DONT_HOLD_STATE)
+		return;
+
+	WARN(core->orphan, "%s: Can't hold state for orphan clk\n", core->name);
+
+	core->state_held = !clk_core_prepare_enable(core);
+}
+
+static void __clk_core_update_orphan_hold_state(struct clk_core *core)
+{
+	struct clk_core *child;
+
+	if (core->orphan)
+		return;
+
+	clk_core_hold_state(core);
+
+	hlist_for_each_entry(child, &core->children, child_node)
+		__clk_core_update_orphan_hold_state(child);
+}
+
 /*
  * Update the orphan status of @core and all its children.
  */
@@ -3374,6 +3430,8 @@ static int __clk_core_init(struct clk_core *core)
 		rate = 0;
 	core->rate = core->req_rate = rate;
 
+	core->boot_enabled = clk_core_is_enabled(core);
+
 	/*
 	 * Enable CLK_IS_CRITICAL clocks so newly added critical clocks
 	 * don't get accidentally disabled when walking the orphan tree and
@@ -3389,6 +3447,9 @@ static int __clk_core_init(struct clk_core *core)
 		clk_enable_unlock(flags);
 	}
 
+	if (!core->orphan)
+		clk_core_hold_state(core);
+
 	/*
 	 * walk the list of orphan clocks and reparent any that newly finds a
 	 * parent.
@@ -3408,6 +3469,7 @@ static int __clk_core_init(struct clk_core *core)
 			__clk_set_parent_after(orphan, parent, NULL);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, 0);
+			__clk_core_update_orphan_hold_state(orphan);
 		}
 	}
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2fdfe8061363..f0e522ea793f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -32,6 +32,7 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+#define CLK_DONT_HOLD_STATE	BIT(14) /* Don't hold state */
 
 struct clk;
 struct clk_hw;
-- 
2.24.0.432.g9d3f5f5b63-goog

