Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF8EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661E620652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128804;
	bh=snUmIis4bvVhHd8W1Cn7UxYwbRGoaED9XQjaqs2tE3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OEhkjs1DdhQtTkJ6HUqKPVQhk5IU5EDlzFFwtMtKo7+a35Elh7FlYW1Vy6w/+VK5j
	 Zi38KDKMdqIdzA3f07YtzvU+PBdn+Yiw169kMG/jr+7l0kMrlYrwuoGRWnI+eAVU7v
	 o1rubEBCowHuvhM4TCfQNqRZigawsfltVU0qkcnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389718AbfDXRXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389698AbfDXRX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:23:29 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706C521907;
        Wed, 24 Apr 2019 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126608;
        bh=snUmIis4bvVhHd8W1Cn7UxYwbRGoaED9XQjaqs2tE3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVvWWoTaMc2wQfazocv3fTLIYghBA2Z8Uj1XlQB6HxEi6e250gMEzqfQPsoz+iSRJ
         sje2t49rafDQYRFtxolq3LMaWKK4akPnHucV46wg75IcT9jY9IFWYncKGDrcTf9v7B
         MWNmISBfdDijvjbqky/LsMIh4FdY4UCrxgETgySI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 167/168] mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n
Date:   Wed, 24 Apr 2019 19:10:11 +0200
Message-Id: <20190424170933.141412650@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
@@ -857,13 +857,8 @@ const char * const vmstat_text[] = {
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


