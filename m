Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F111C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2553122CE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149213;
	bh=ffW1qHV0lE3IgJXZwbzIvXiJftUw4lGsPWf3gE45yHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oe5EAa5Uv5sEk3WsxxqTsn/DyJiABl3GfXTSqxnd14RJto3Th0Y7Ec7Ydrhs3BRPL
	 qpYvkEpefG9EQ1J5Jpu+PEmtdLBilywEdyi0YvE1Tz8pG2DK9DzVT2yqwEX0h2zIp1
	 pGkWKH3YoNnPY9MRJln8Hhkl3UoE+m1BxBGOk0a4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbfGZNxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388177AbfGZNnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:43:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAA822CE5;
        Fri, 26 Jul 2019 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148602;
        bh=ffW1qHV0lE3IgJXZwbzIvXiJftUw4lGsPWf3gE45yHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ai+Psephq1KaSTmuhi46q5GGDLfExA8Sannh+VCczLgu4DymAB2B3IheMwSB17xAu
         SxEjvxdjhV8N8YGPjOOMA0GMEgBgC18ows+rss3zSIM+AHrrKnUeBDtnTF78sUd27n
         eHnTJzq8qozG92Gw2AnxC6S9aFNKPGpdO0a66Dyo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 42/47] xen: let alloc_xenballooned_pages() fail if not enough memory free
Date:   Fri, 26 Jul 2019 09:42:05 -0400
Message-Id: <20190726134210.12156-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134210.12156-1-sashal@kernel.org>
References: <20190726134210.12156-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

[ Upstream commit a1078e821b605813b63bf6bca414a85f804d5c66 ]

Instead of trying to allocate pages with GFP_USER in
add_ballooned_pages() check the available free memory via
si_mem_available(). GFP_USER is far less limiting memory exhaustion
than the test via si_mem_available().

This will avoid dom0 running out of memory due to excessive foreign
page mappings especially on ARM and on x86 in PVH mode, as those don't
have a pre-ballooned area which can be used for foreign mappings.

As the normal ballooning suffers from the same problem don't balloon
down more than si_mem_available() pages in one iteration. At the same
time limit the default maximum number of retries.

This is part of XSA-300.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/balloon.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 7ab6caef599c..d4e8b717ce2b 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -527,8 +527,15 @@ static void balloon_process(struct work_struct *work)
 				state = reserve_additional_memory();
 		}
 
-		if (credit < 0)
-			state = decrease_reservation(-credit, GFP_BALLOON);
+		if (credit < 0) {
+			long n_pages;
+
+			n_pages = min(-credit, si_mem_available());
+			state = decrease_reservation(n_pages, GFP_BALLOON);
+			if (state == BP_DONE && n_pages != -credit &&
+			    n_pages < totalreserve_pages)
+				state = BP_EAGAIN;
+		}
 
 		state = update_schedule(state);
 
@@ -567,6 +574,9 @@ static int add_ballooned_pages(int nr_pages)
 		}
 	}
 
+	if (si_mem_available() < nr_pages)
+		return -ENOMEM;
+
 	st = decrease_reservation(nr_pages, GFP_USER);
 	if (st != BP_DONE)
 		return -ENOMEM;
@@ -696,7 +706,7 @@ static int __init balloon_init(void)
 	balloon_stats.schedule_delay = 1;
 	balloon_stats.max_schedule_delay = 32;
 	balloon_stats.retry_count = 1;
-	balloon_stats.max_retry_count = RETRY_UNLIMITED;
+	balloon_stats.max_retry_count = 4;
 
 #ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
 	set_online_page_callback(&xen_online_page);
-- 
2.20.1

