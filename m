Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A883EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701F020652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129631;
	bh=9eRShUYR5yadJs5e5s0yTcDTOdNe1UqYKYluOKNEnWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ng2kbpvIzr1iWBNmKq5qayG64q56QFdYa/omCIzVvRKYIlPgTE0o1mDp50HY6XGuE
	 zxCJNlylsPMYhtA5y1s0GQkikPBLXaRmXiNacSOVCcOjcc4AoZWIk8xZaiyemTFxvB
	 ymWRdegK1a96ij1BYT5I7+1380dcv8hG5uZrZ5Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387489AbfDXRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:11:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfDXRLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:11:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64CFC218FE;
        Wed, 24 Apr 2019 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125911;
        bh=9eRShUYR5yadJs5e5s0yTcDTOdNe1UqYKYluOKNEnWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8qqYnCWNu7XDqyJLCyL7jPNRATVVCr38xxM5zIQ/bU75NHs8E3qGjLNgDDaJVu6Q
         1iK5AIaP2N+aZ2HzSiU86L4I7Ya7FeyNttsWu0qY5XHmFtngB53DMdfAF6AmP3SxRp
         UfFnZepEr9AqhbfbzGTgqm6dqUaoIqDc5FJzADgk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 027/104] bcache: improve sysfs_strtoul_clamp()
Date:   Wed, 24 Apr 2019 19:08:44 +0200
Message-Id: <20190424170855.765519825@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



