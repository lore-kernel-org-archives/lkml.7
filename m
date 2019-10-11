Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9873ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF3A206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfJKRAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:00:45 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:40669 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKRAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:00:45 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIyHQ-0002Mv-Ei; Fri, 11 Oct 2019 18:00:40 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIyHQ-0004CR-0t; Fri, 11 Oct 2019 18:00:40 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: include internal.h for missing declarations
Date:   Fri, 11 Oct 2019 18:00:39 +0100
Message-Id: <20191011170039.16100-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declarations of __block_write_begin_int and guard_bio_eod
are needed from internal.h so include it to fix the following
sparse warnings:

fs/buffer.c:1930:5: warning: symbol '__block_write_begin_int' was not declared. Should it be static?
fs/buffer.c:2994:6: warning: symbol 'guard_bio_eod' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 86a38b979323..792f22a88e67 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -48,6 +48,8 @@
 #include <linux/sched/mm.h>
 #include <trace/events/block.h>
 
+#include "internal.h"
+
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 			 enum rw_hint hint, struct writeback_control *wbc);
-- 
2.23.0

