Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BBCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95F82087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711194;
	bh=FXdjSr8HVrfDYqWKqWAVa1HiI4r+mcXUJ3XGWwCbs4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k5GB1IvHmmCqwe/ImjCEPnwWgduaFSA+LmIsRplGu2DmcXd5CsNzC3WEdWUW+4r5f
	 HgtG4RWiekLCC2wK2nfewAH1PEFieAukUmN636OLYTNBrbCHfnF09snx6UaWYl7OIL
	 0yuY+DB2r0TQK4wQV2Oq/hEvLEytsD+O3Y63gqSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391714AbfC0S0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391671AbfC0S0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C0D2147C;
        Wed, 27 Mar 2019 18:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711169;
        bh=FXdjSr8HVrfDYqWKqWAVa1HiI4r+mcXUJ3XGWwCbs4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSutqCwQQwwMc96REyhahLzMljuy4kzdaHv5Kt1QzNpckeZc5/OVGada0DJR0siNS
         08X2xPsYi8tMOtWCkQA8s+/5kPShiOXV91+9uQcsUCgKzi6JVuLLMZDs1VIEQIFOEM
         nY4mOJwOVhMmtdb7HcR6ubVcPZELmvhXBuy/DLYY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 26/41] bcache: improve sysfs_strtoul_clamp()
Date:   Wed, 27 Mar 2019 14:25:03 -0400
Message-Id: <20190327182518.19394-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit 596b5a5dd1bc2fa019fdaaae522ef331deef927f ]

Currently sysfs_strtoul_clamp() is defined as,
 82 #define sysfs_strtoul_clamp(file, var, min, max)                   \
 83 do {                                                               \
 84         if (attr == &sysfs_ ## file)                               \
 85                 return strtoul_safe_clamp(buf, var, min, max)      \
 86                         ?: (ssize_t) size;                         \
 87 } while (0)

The problem is, if bit width of var is less then unsigned long, min and
max may not protect var from integer overflow, because overflow happens
in strtoul_safe_clamp() before checking min and max.

To fix such overflow in sysfs_strtoul_clamp(), to make min and max take
effect, this patch adds an unsigned long variable, and uses it to macro
strtoul_safe_clamp() to convert an unsigned long value in range defined
by [min, max]. Then assign this value to var. By this method, if bit
width of var is less than unsigned long, integer overflow won't happen
before min and max are checking.

Now sysfs_strtoul_clamp() can properly handle smaller data type like
unsigned int, of cause min and max should be defined in range of
unsigned int too.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/sysfs.h b/drivers/md/bcache/sysfs.h
index 0526fe92a683..e7a3c12aa66f 100644
--- a/drivers/md/bcache/sysfs.h
+++ b/drivers/md/bcache/sysfs.h
@@ -80,9 +80,16 @@ do {									\
 
 #define sysfs_strtoul_clamp(file, var, min, max)			\
 do {									\
-	if (attr == &sysfs_ ## file)					\
-		return strtoul_safe_clamp(buf, var, min, max)		\
-			?: (ssize_t) size;				\
+	if (attr == &sysfs_ ## file) {					\
+		unsigned long v = 0;					\
+		ssize_t ret;						\
+		ret = strtoul_safe_clamp(buf, v, min, max);		\
+		if (!ret) {						\
+			var = v;					\
+			return size;					\
+		}							\
+		return ret;						\
+	}								\
 } while (0)
 
 #define strtoul_or_return(cp)						\
-- 
2.19.1

