Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341ACC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C25320675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfD2PSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:18:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4179 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfD2PSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:18:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61FEE3082B69;
        Mon, 29 Apr 2019 15:18:18 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA4101001DCE;
        Mon, 29 Apr 2019 15:18:17 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] kernel/module: Reschedule while waiting for modules to finish loading
Date:   Mon, 29 Apr 2019 11:17:51 -0400
Message-Id: <20190429151751.15424-1-prarit@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 29 Apr 2019 15:18:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko, do you want a Signed-off-by or a Reported-by?  Either one works
for me.

P.

----8<----

On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
loading the s390_trng.ko module.

Add a reschedule point to the loop that waits for modules to complete
loading.

Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module.c b/kernel/module.c
index 410eeb7e4f1d..48748cfec991 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3585,6 +3585,7 @@ static int add_unformed_module(struct module *mod)
 					       finished_loading(mod->name));
 			if (err)
 				goto out_unlocked;
+			cond_resched();
 			goto again;
 		}
 		err = -EEXIST;
-- 
2.18.1

