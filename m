Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A1CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2640217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367918;
	bh=5lZF+uO9rRnEBv6fz0DtkM2qyWHJsvWSEInxdyHXKpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DDcEclZ6Aoog+z4mehZ3jv7uzlKsDEzEjkqCGLBCVTF5r6flC5znd4s5SsMAEh7hJ
	 Tdc7KzXRMd6U0wg+50b7DeN5NbwxP7A2w7WIM38GrWk+acLAzyIScddjmrsm51QI3v
	 51+gihM68UjJgFvPC2MUdOrxVFZe9uFCYvgkFCvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfDDIv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfDDIvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:51:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DF0217D4;
        Thu,  4 Apr 2019 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367913;
        bh=5lZF+uO9rRnEBv6fz0DtkM2qyWHJsvWSEInxdyHXKpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HkbOPX0hsUXa5wWSulcyiI7oblEMt7HmuJMWQyyBsCpRShl6PjmyHAgX7VrbhwwmL
         oB4ohou0304/PJJuXBEG+/FhAoHZrNngyG5/r6VqnmaECWJc6Va6WRzan6bE8aUjY/
         wNJ6bs9ZjLvkPpFU5oQMq8Az5BFF66ZxcZ3xSaIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 60/91] bcache: improve sysfs_strtoul_clamp()
Date:   Thu,  4 Apr 2019 10:47:44 +0200
Message-Id: <20190404084538.909408027@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



