Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D51E20449
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfDXI4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:56:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728580AbfDXI4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:56:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A78E3AECB;
        Wed, 24 Apr 2019 08:56:02 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/3] livepatch: Convert error about unsupported reliable stacktrace into a warning
Date:   Wed, 24 Apr 2019 10:55:48 +0200
Message-Id: <20190424085550.29612-2-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424085550.29612-1-pmladek@suse.com>
References: <20190424085550.29612-1-pmladek@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d0807da78e11d46f ("livepatch: Remove immediate feature") caused
that any livepatch was refused when reliable stacktraces were not supported
on the given architecture.

The limitation is too strong. User space processes are safely migrated
even when entering or leaving the kernel. Kthreads transition would
need to get forced. But it is safe when:

   + The livepatch does not change the semantic of the code.
   + Callbacks do not depend on a safely finished transition.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/livepatch/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index eb0ee10a1981..14f33ab6c583 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1003,11 +1003,10 @@ int klp_enable_patch(struct klp_patch *patch)
 		return -ENODEV;
 
 	if (!klp_have_reliable_stack()) {
-		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
-		return -EOPNOTSUPP;
+		pr_warn("This architecture doesn't have support for the livepatch consistency model.\n");
+		pr_warn("The livepatch transition may never complete.\n");
 	}
 
-
 	mutex_lock(&klp_mutex);
 
 	ret = klp_init_patch_early(patch);
-- 
2.16.4

