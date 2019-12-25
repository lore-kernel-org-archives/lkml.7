Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEEAC2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1851D2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 08:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLYIei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 03:34:38 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54412 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbfLYIeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 03:34:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TltSXMn_1577262870;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TltSXMn_1577262870)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 16:34:35 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     fengguang.wu@intel.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH for vm-scalability] usemem: Fix the build warning
Date:   Wed, 25 Dec 2019 16:34:25 +0800
Message-Id: <1577262865-10253-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got:
gcc -O -c -Wall -g  usemem.c -o usemem.o
usemem.c: In function ‘output_statistics’:
usemem.c:638:2: warning: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Wunused-result]
  write(1, buf, len);

This commit fixes this warning.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 usemem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/usemem.c b/usemem.c
index 85dbdc5..9158304 100644
--- a/usemem.c
+++ b/usemem.c
@@ -635,7 +635,8 @@ static void output_statistics(unsigned long unit_bytes, const char *intro)
 			"%s%lu bytes / %lu usecs = %lu KB/s\n",
 			intro, unit_bytes, delta_us, throughput);
 	fflush(stdout);
-	write(1, buf, len);
+	if (write(1, buf, len) != len)
+		printf("Output buf \"%s\" fail\n", buf);
 }
 
 static void timing_free(void *ptrs[], unsigned int nptr,
-- 
2.7.4

