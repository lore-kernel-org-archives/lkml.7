Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4441DC32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2002E222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 15:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgACPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 10:55:16 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:59624 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727539AbgACPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 10:55:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TmkFDOs_1578066907;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TmkFDOs_1578066907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 23:55:13 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     rjw@rjwysocki.net, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/power/snapshot.c: improve arithmetic divisions
Date:   Fri,  3 Jan 2020 23:54:58 +0800
Message-Id: <20200103155458.21707-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_div() does a 64-by-32 division. Use div64_u64() instead of
do_div() if the divisor is u64, to avoid truncation to 32-bit.
This change also cleans up code a tad.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 kernel/power/snapshot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168..8a6eaf7 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1566,9 +1566,7 @@ static unsigned long preallocate_image_highmem(unsigned long nr_pages)
  */
 static unsigned long __fraction(u64 x, u64 multiplier, u64 base)
 {
-	x *= multiplier;
-	do_div(x, base);
-	return (unsigned long)x;
+	return div64_u64(x * multiplier, base);
 }
 
 static unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
-- 
1.8.3.1

