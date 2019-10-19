Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0583CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3646021925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WhkbdhaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfJSVpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 17:45:22 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:48770 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbfJSVpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 17:45:22 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id A17602E1553;
        Sun, 20 Oct 2019 00:45:18 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 0cxZ4mrudZ-jIeWRQNh;
        Sun, 20 Oct 2019 00:45:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571521518; bh=mpv/3rNpDDzOLRHg2UtS9q80dpzHH4Vx3ZzURITMRC4=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=WhkbdhaLAe1prhIQH03uzIVboooPUeJhs710pRq6E7DaZvQmhsnT6kDdr10KRlJ3Q
         VBhzx/7Qlq0/C0xQn2W8HO+GRpHuhouljep9e9K52c9EItYjt+iiD7TmIUYKXgLgXw
         NC77uKCPOS0Nh3Pg6h+EIPY8B+0gV4RPilOhhdzA=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7010::1:5])
        by myt4-4db2488e778a.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id gDwauKkseK-jIICb97J;
        Sun, 20 Oct 2019 00:45:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/vmstat: do not use size of vmstat_text as count of
 /proc/vmstat items
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Date:   Sun, 20 Oct 2019 00:45:17 +0300
Message-ID: <157152151769.4139.15423465513138349343.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strings from vmstat_text[] will be used for printing memory cgroup
statistics which exists even if CONFIG_VM_EVENT_COUNTERS=n.

This should be applied before patch "mm/memcontrol: use vmstat names
for printing statistics".

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/linux-mm/cd1c42ae-281f-c8a8-70ac-1d01d417b2e1@infradead.org/T/#u
---
 mm/vmstat.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 590aeca27cab..13e36da70f3c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1638,25 +1638,23 @@ static const struct seq_operations zoneinfo_op = {
 	.show	= zoneinfo_show,
 };
 
+#define NR_VMSTAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + \
+			 NR_VM_NUMA_STAT_ITEMS + \
+			 NR_VM_NODE_STAT_ITEMS + \
+			 NR_VM_WRITEBACK_STAT_ITEMS + \
+			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
+			  NR_VM_EVENT_ITEMS : 0))
+
 static void *vmstat_start(struct seq_file *m, loff_t *pos)
 {
 	unsigned long *v;
-	int i, stat_items_size;
+	int i;
 
-	if (*pos >= ARRAY_SIZE(vmstat_text))
+	if (*pos >= NR_VMSTAT_ITEMS)
 		return NULL;
-	stat_items_size = NR_VM_ZONE_STAT_ITEMS * sizeof(unsigned long) +
-			  NR_VM_NUMA_STAT_ITEMS * sizeof(unsigned long) +
-			  NR_VM_NODE_STAT_ITEMS * sizeof(unsigned long) +
-			  NR_VM_WRITEBACK_STAT_ITEMS * sizeof(unsigned long);
-
-#ifdef CONFIG_VM_EVENT_COUNTERS
-	stat_items_size += sizeof(struct vm_event_state);
-#endif
 
-	BUILD_BUG_ON(stat_items_size !=
-		     ARRAY_SIZE(vmstat_text) * sizeof(unsigned long));
-	v = kmalloc(stat_items_size, GFP_KERNEL);
+	BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);
+	v = kmalloc_array(NR_VMSTAT_ITEMS, sizeof(unsigned long), GFP_KERNEL);
 	m->private = v;
 	if (!v)
 		return ERR_PTR(-ENOMEM);
@@ -1689,7 +1687,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 static void *vmstat_next(struct seq_file *m, void *arg, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos >= ARRAY_SIZE(vmstat_text))
+	if (*pos >= NR_VMSTAT_ITEMS)
 		return NULL;
 	return (unsigned long *)m->private + *pos;
 }

