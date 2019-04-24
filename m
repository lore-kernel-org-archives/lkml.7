Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE63FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429B218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127187;
	bh=D8GwtsOkgfhmNDuUdQRdDMQKXlqUGS9YRVsWpKj2guA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ukuqnGwfzfM3kYS372A/PRu7lHoIpdqGAwiZfiEwxvPVv60Xl2NdORVdKKHkfYVFx
	 2HPFFR4a5DZGmFHNS+2JXQdcmLgro6NPaK5hddzWF0eKQEcaHgoKqhwf60J+runhIl
	 RCv/pqZfv1I1codeyO7ATo5bXlBnYNZqZjBq4gw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391248AbfDXRdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388062AbfDXRdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:03 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4823621907;
        Wed, 24 Apr 2019 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127182;
        bh=D8GwtsOkgfhmNDuUdQRdDMQKXlqUGS9YRVsWpKj2guA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMNEGmiRSQKBkYThMx9VNtBTMpf06E2zwc9HWPKvV69AnTZmsr5PbUu5ohdAH2cvk
         ISrlFqMsRV0T3hKBSS/Z3fQbaiFeK5czvWHjqc4Fstferr6uIbJZ7ushWaU5gEkgY4
         bQX/KUyh4rO4jA+4WZcO/U8y6PmhjKbRVgVoE0Ao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 91/96] mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n
Date:   Wed, 24 Apr 2019 19:10:36 +0200
Message-Id: <20190424170925.976475295@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit e8277b3b52240ec1caad8e6df278863e4bf42eac upstream.

Commit 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
depends on skipping vmstat entries with empty name introduced in
7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in
/proc/vmstat") but reverted in b29940c1abd7 ("mm: rename and change
semantics of nr_indirectly_reclaimable_bytes").

So skipping no longer works and /proc/vmstat has misformatted lines " 0".

This patch simply shows debug counters "nr_tlb_remote_*" for UP.

Link: http://lkml.kernel.org/r/155481488468.467.4295519102880913454.stgit@buzz
Fixes: 58bc4c34d249 ("mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <guro@fb.com>
Cc: Jann Horn <jannh@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmstat.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1272,13 +1272,8 @@ const char * const vmstat_text[] = {
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


