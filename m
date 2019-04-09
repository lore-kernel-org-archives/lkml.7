Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FD2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44732084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="c3RBLKxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfDINJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 09:09:25 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:53370 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbfDINJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 09:09:24 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 09:09:23 EDT
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C891E2E14F9;
        Tue,  9 Apr 2019 16:01:25 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7a8Rsk49OT-1PeORcnc;
        Tue, 09 Apr 2019 16:01:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1554814885; bh=QNJxg5ExNJ6bFzaVN3amxQmlqui1fp3QtzeKauuH4OE=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=c3RBLKxgg6odcBewDveWr9wGVAyT5Go0jzwAmnYQ/OYLui+I7j3QN4kxE4m3hwfk2
         mjmXxCWFbnoRe6MOBCRZvwwhs3xf5G7FZpNvW7jCxr5GFH1zS7RwhPURJvzRUnrSCN
         0sIOkHKsr9odKr5P1o7FYMdp9tYMJbG31hQLqgMw=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:0:3711::1:6d])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Z1ZqwzxHC4-1P0mS5oG;
        Tue, 09 Apr 2019 16:01:25 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] mm/vmstat: fix /proc/vmstat format for
 CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>
Date:   Tue, 09 Apr 2019 16:01:24 +0300
Message-ID: <155481488468.467.4295519102880913454.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
depends on skipping vmstat entries with empty name introduced in commit
7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
but reverted in commit b29940c1abd7 ("mm: rename and change semantics of
nr_indirectly_reclaimable_bytes").

So, skipping no longer works and /proc/vmstat has misformatted lines " 0".
This patch simply shows debug counters "nr_tlb_remote_*" for UP.

Fixes: 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/vmstat.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 36b56f858f0f..a7d493366a65 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1274,13 +1274,8 @@ const char * const vmstat_text[] = {
 #endif
 #endif /* CONFIG_MEMORY_BALLOON */
 #ifdef CONFIG_DEBUG_TLBFLUSH
-#ifdef CONFIG_SMP
 	"nr_tlb_remote_flush",
 	"nr_tlb_remote_flush_received",
-#else
-	"", /* nr_tlb_remote_flush */
-	"", /* nr_tlb_remote_flush_received */
-#endif /* CONFIG_SMP */
 	"nr_tlb_local_flush_all",
 	"nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */

