Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE49C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36F821850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfGELsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:48:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64112 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726505AbfGELsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:48:35 -0400
X-UUID: 592531b021a04da2953bf1183a89fd02-20190705
X-UUID: 592531b021a04da2953bf1183a89fd02-20190705
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1473552831; Fri, 05 Jul 2019 19:48:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 5 Jul 2019 19:48:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 5 Jul 2019 19:48:29 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-mm@kvack.org>
CC:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/sparse: fix ALIGN() without power of 2 in sparse_buffer_alloc()
Date:   Fri, 5 Jul 2019 19:48:26 +0800
Message-ID: <20190705114826.28586-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size argumnet passed into sparse_buffer_alloc() has already
aligned with PAGE_SIZE or PMD_SIZE.

If the size after aligned is not power of 2 (e.g. 0x480000), the
PTR_ALIGN() will return wrong value.
Use roundup to round sparsemap_buf up to next multiple of size.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>
Cc: YJ Chiang <yj.chiang@mediatek.com>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 2b3b5be85120..dafd130f9a55 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -459,7 +459,7 @@ void * __meminit sparse_buffer_alloc(unsigned long size)
 	void *ptr = NULL;
 
 	if (sparsemap_buf) {
-		ptr = PTR_ALIGN(sparsemap_buf, size);
+		ptr = (void *) roundup((unsigned long)sparsemap_buf, size);
 		if (ptr + size > sparsemap_buf_end)
 			ptr = NULL;
 		else {
-- 
2.18.0

