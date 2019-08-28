Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E58C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1D520679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfH1Ho2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:44:28 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:39536 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1Ho2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:44:28 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 244A6ABB5E9B5C8EB589;
        Wed, 28 Aug 2019 15:44:26 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x7S7glHe066154;
        Wed, 28 Aug 2019 15:42:47 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019082815430719-3232524 ;
          Wed, 28 Aug 2019 15:43:07 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     keescook@chromium.org, dan.j.williams@intel.com,
        wang.yi59@zte.com.cn, cai@lca.pw, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, osalvador@suse.de, mhocko@suse.com,
        rppt@linux.ibm.com, david@redhat.com,
        richardw.yang@linux.intel.com, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
Subject: [PATCH] mm: fix -Wmissing-prototypes warnings
Date:   Wed, 28 Aug 2019 15:42:41 +0800
Message-Id: <1566978161-7293-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-08-28 15:43:07,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-08-28 15:42:49
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl2.zte.com.cn x7S7glHe066154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get two warnings when build kernel W=1:
mm/shuffle.c:36:12: warning: no previous prototype for ‘shuffle_show’
[-Wmissing-prototypes]
mm/sparse.c:220:6: warning: no previous prototype for
‘subsection_mask_set’ [-Wmissing-prototypes]

Make the function static to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 mm/shuffle.c | 2 +-
 mm/sparse.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shuffle.c b/mm/shuffle.c
index 3ce1248..b3fe97f 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -33,7 +33,7 @@ __meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
 }
 
 static bool shuffle_param;
-extern int shuffle_show(char *buffer, const struct kernel_param *kp)
+static int shuffle_show(char *buffer, const struct kernel_param *kp)
 {
 	return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
 			? 'Y' : 'N');
diff --git a/mm/sparse.c b/mm/sparse.c
index 72f010d..49006dd 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -217,7 +217,7 @@ static inline unsigned long first_present_section_nr(void)
 	return next_present_section_nr(-1);
 }
 
-void subsection_mask_set(unsigned long *map, unsigned long pfn,
+static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 		unsigned long nr_pages)
 {
 	int idx = subsection_map_index(pfn);
-- 
1.8.3.1

