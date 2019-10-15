Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C8ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9375C217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfJODtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:49:31 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35513 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727092AbfJODta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:49:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tf5lel1_1571111361;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0Tf5lel1_1571111361)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Oct 2019 11:49:27 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     konrad.wilk@oracle.com, sjenning@redhat.com, ddstreet@ieee.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH 1/2] mm, frontswap: Fix frontswap_map issue with THP
Date:   Tue, 15 Oct 2019 11:49:08 +0800
Message-Id: <1571111349-5041-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shrink will try to use frontswap interface store the THP as a normal
page in __frontswap_store:
	if (ret == 0) {
		__frontswap_set(sis, offset);
		inc_frontswap_succ_stores();
	} else {
It should set all bits with THP.

This commit set all bits with THP.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 mm/frontswap.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/frontswap.c b/mm/frontswap.c
index 60bb20e..f07ea63 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -274,8 +274,12 @@ int __frontswap_store(struct page *page)
 			break;
 	}
 	if (ret == 0) {
-		__frontswap_set(sis, offset);
-		inc_frontswap_succ_stores();
+		int i, nr = hpage_nr_pages(page);
+
+		for (i = 0; i < nr; i++) {
+			__frontswap_set(sis, offset + i);
+			inc_frontswap_succ_stores();
+		}
 	} else {
 		inc_frontswap_failed_stores();
 	}
-- 
2.7.4

