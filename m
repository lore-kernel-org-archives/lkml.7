Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69889C32765
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501C020842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 18:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgAAS0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 13:26:33 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:13083
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbgAAS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 13:26:30 -0500
X-IronPort-AV: E=Sophos;i="5.69,382,1571695200"; 
   d="scan'208";a="334542279"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 01 Jan 2020 19:26:25 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     kernel-janitors@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] MIPS: use resource_size
Date:   Wed,  1 Jan 2020 18:49:48 +0100
Message-Id: <1577900990-8588-9-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
References: <1577900990-8588-1-git-send-email-Julia.Lawall@inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use resource_size rather than a verbose computation on
the end and start fields.

The semantic patch that makes these changes is as follows:
(http://coccinelle.lip6.fr/)

<smpl>
@@ struct resource ptr; @@
- (ptr.end - ptr.start + 1)
+ resource_size(&ptr)
</smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/mips/kernel/setup.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index c3d4212b5f1d..701f4bc3046f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -515,8 +515,7 @@ static void __init request_crashkernel(struct resource *res)
 	ret = request_resource(res, &crashk_res);
 	if (!ret)
 		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
-			(unsigned long)((crashk_res.end -
-					 crashk_res.start + 1) >> 20),
+			(unsigned long)(resource_size(&crashk_res) >> 20),
 			(unsigned long)(crashk_res.start  >> 20));
 }
 #else /* !defined(CONFIG_KEXEC)		*/
@@ -698,8 +697,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	mips_parse_crashkernel();
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end)
-		memblock_reserve(crashk_res.start,
-				 crashk_res.end - crashk_res.start + 1);
+		memblock_reserve(crashk_res.start, resource_size(&crashk_res));
 #endif
 	device_tree_init();
 	sparse_init();

