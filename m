Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E859CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB14F2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504014AbfJYQF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:05:28 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:42383 "EHLO
        12.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393851AbfJYQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:05:28 -0400
Received: from player718.ha.ovh.net (unknown [10.108.54.38])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id B9CE020D69F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 17:49:52 +0200 (CEST)
Received: from sk2.org (gw.sk2.org [88.186.243.14])
        (Authenticated sender: steve@sk2.org)
        by player718.ha.ovh.net (Postfix) with ESMTPSA id 14749B568AE5;
        Fri, 25 Oct 2019 15:49:48 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] Allow disabling drop_caches logging immediately
Date:   Fri, 25 Oct 2019 17:49:16 +0200
Message-Id: <20191025154916.18431-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1846475850815655406
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrleefgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, echoing 4 to drop_caches disables logging for subsequent
operations, not the current operation, even if the write is combined
(echo 7 ...). This patch takes bit 2 into account before logging, so
that logging can be disabled concurrently with other operations.

This doesn't change the behaviour for existing scenarios encountered
in the wild.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 fs/drop_caches.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d31b6c72b476..2562d6285ce4 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -65,12 +65,12 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 			drop_slab();
 			count_vm_event(DROP_SLAB);
 		}
+		stfu |= sysctl_drop_caches & 4;
 		if (!stfu) {
 			pr_info("%s (%d): drop_caches: %d\n",
 				current->comm, task_pid_nr(current),
 				sysctl_drop_caches);
 		}
-		stfu |= sysctl_drop_caches & 4;
 	}
 	return 0;
 }
-- 
2.20.1

