Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50578C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF9020857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwj9ZcR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfCRI7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:59:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42847 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfCRI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:58:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id b2so10894638pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YJ4hR04oCeglYCDV44cDVhsUlXY+OAoo1KN3TEl10V4=;
        b=pwj9ZcR0DUq2lQEMmgEiodhleKRoB1tGE2GNpVVptqZmnyqp2Ya/lT27fbSm7MPj3A
         WtuaDgVba3SFX+PU3uz8Jm1ZrDxRrFKCrUO375+f0//fziWR88Lq9eZIDQosmhZjQpb0
         ku6UcROK10eDmfAkdT7uZWe2d1WJOM1osNsMBs4BoPUrmrNBTOHDIAEHtUxwCCrq9BGN
         zX481eCgvanKcYEdSoN1MrXhfxNkSiGLYspBgCyEIvhQ9qP0zOz0LiYrAjkHjUrfRzEx
         klgztcYcxmyPGHsrG42ugMoC+Rm7ogIW0FzU1eIAQUCGDBE8VTtGRsJFE02mV902LVv1
         FLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YJ4hR04oCeglYCDV44cDVhsUlXY+OAoo1KN3TEl10V4=;
        b=WtVP65Y5s7VWqPxwQac35gUZNDVsgGaMquuY40XAvFwb82H6hzZedpAWWUdArjYbCK
         87stchklryCFSzm7iIuCqU35COYLZcvBeSDoqKHtKQWR7QU4h9PLIRgcHYhJEVbOL+tm
         2a6fU+HcwtSNARGSIDwsO5rWRm+YAcD5xXi3P8Idb5LZ/vRbNyksqB4Sjts3wJ7Q/RIx
         xPE3dioDCmQ3gFBLioqrv3b4YM+o6v1NFGzg0AZLTwxbT4G1xmVTJsqJ67PN+r3yFi3i
         N5tnjmDDR0UYV/jSmNYS7AR+GW7WMF95pjFUB6231U1nXCLknAL3sDAKQ2f1kbCb1xHU
         tUhQ==
X-Gm-Message-State: APjAAAU88Dpgyu6InAXNSKoYtsRlY29TGaWPbAV3DXOCvpwLTfG0IxGB
        FgavjZcyQ4rE1yBCTpzqFzE=
X-Google-Smtp-Source: APXvYqxQOT39RJBeehv3fIijQOsmHU1iT39mZex7zCg28HtG4+zCSeQzBIJKd59egJdbeOGycduerA==
X-Received: by 2002:a17:902:26f:: with SMTP id 102mr6222145plc.175.1552899480458;
        Mon, 18 Mar 2019 01:58:00 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id k8sm11147024pgq.37.2019.03.18.01.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 01:57:59 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com,
        linux-kernel@vger.kernel.org, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 06/19] locking/lockdep: Print the right depth for chain key colission
Date:   Mon, 18 Mar 2019 16:57:20 +0800
Message-Id: <20190318085733.3143-7-duyuyang@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190318085733.3143-1-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since chains are separated by irq context, so when printing a chain the
depth should be consistent with it.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 320ab62..3df0a5e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2425,10 +2425,11 @@ static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
 	struct held_lock *hlock;
 	u64 chain_key = 0;
 	int depth = curr->lockdep_depth;
-	int i;
+	int i = get_first_held_lock(curr, hlock_next);
 
-	printk("depth: %u\n", depth + 1);
-	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
+	printk("depth: %u (irq_context %u)\n", depth - i + 1,
+		hlock_next->irq_context);
+	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
 		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
 
-- 
1.8.3.1

