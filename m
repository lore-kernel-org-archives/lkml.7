Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF72C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC10F20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfD3WSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:18:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfD3WSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 511F930642AA;
        Tue, 30 Apr 2019 22:18:23 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C793A7D903;
        Tue, 30 Apr 2019 22:18:22 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2] kernel/module: Reschedule while waiting for modules to finish loading
Date:   Tue, 30 Apr 2019 18:18:07 -0400
Message-Id: <20190430221807.2418-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 30 Apr 2019 22:18:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
loading the s390_trng.ko module.

Add a reschedule point to the loop that waits for modules to complete
loading.

v2: cleanup Fixes line.

Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Fixes: commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
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

