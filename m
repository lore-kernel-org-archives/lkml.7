Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B541C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3206620722
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfL2QTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:19:41 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:38979
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbfL2QTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:19:35 -0500
X-IronPort-AV: E=Sophos;i="5.69,372,1571695200"; 
   d="scan'208";a="334379019"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 29 Dec 2019 17:19:30 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Jonas Bonn <jonas@southpole.se>
Cc:     kernel-janitors@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] openrisc: use mmgrab
Date:   Sun, 29 Dec 2019 16:42:58 +0100
Message-Id: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
helper") and most of the kernel was updated to use it. Update a
remaining file.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ expression e; @@
- atomic_inc(&e->mm_count);
+ mmgrab(e);
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
I was not able to compile this file.

 arch/openrisc/kernel/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
index 7d518ee8bddc..7bd6e0fc7a6d 100644
--- a/arch/openrisc/kernel/smp.c
+++ b/arch/openrisc/kernel/smp.c
@@ -113,7 +113,7 @@ asmlinkage __init void secondary_start_kernel(void)
 	 * All kernel threads share the same mm context; grab a
 	 * reference and switch to it.
 	 */
-	atomic_inc(&mm->mm_count);
+	mmgrab(mm);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
 

