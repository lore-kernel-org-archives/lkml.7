Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A502082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfCSSJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:09:35 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58818 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfCSSJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:09:35 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h6JB7-0002qC-K2; Tue, 19 Mar 2019 12:09:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1h6JB6-00029T-Ib; Tue, 19 Mar 2019 12:09:32 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Date:   Tue, 19 Mar 2019 12:09:30 -0600
Message-Id: <20190319180930.8231-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, rppt@linux.ibm.com, mhocko@suse.com, logang@deltatee.com, hch@lst.de, ysato@users.sourceforge.jp, dalias@libc.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] sh: mm: make use of new memblocks_present() helper
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the open coded for_each_memblock() loop that is equivalent
to the new memblocks_present() helper.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
---
 arch/sh/mm/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

This is just a resend

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a8e5c0e00fca..dc0ff41d602d 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -234,12 +234,7 @@ static void __init do_init_bootmem(void)

 	plat_mem_setup();

-	for_each_memblock(memory, reg) {
-		int nid = memblock_get_region_node(reg);
-
-		memory_present(nid, memblock_region_memory_base_pfn(reg),
-			memblock_region_memory_end_pfn(reg));
-	}
+	memblocks_present();
 	sparse_init();
 }

--
2.19.0
