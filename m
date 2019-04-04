Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195C2C10F0D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7F820693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369899;
	bh=3Zy4JZ+m6UCsvdfDWQlfGRFAMYKgGJRjhIADQIBPDFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IjOLCmvBq3jcCwNMmXPzJS4bk1+EmD+nJ4ZAGPKuVpeEU6nc4xt53YN5Iuh044H7Y
	 SDMFkrF5eNQ+4GjElCVBz9KRjoKnzxGjjKrU24TnuCeoa2XPtlislc93Qn+7MBEdnN
	 hmejLZNAAmJyEUTqvNeYlOTDJ27vW5gT+7FcXX8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387686AbfDDJOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbfDDJOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4D620643;
        Thu,  4 Apr 2019 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369250;
        bh=3Zy4JZ+m6UCsvdfDWQlfGRFAMYKgGJRjhIADQIBPDFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKxZGWFkPFYiKY/QRSCKaCiSVfBioiLH6Uab4pmd/V2DihL45bTyAVtDF/JQs7SSP
         3oi/VdA/4VsLP7brBuW2NEfZhg13bF1qGoKiyuDBta7K1q6IPUk4ADOsmpjDB8NS4X
         tCb9FPCU9t8LdxRmFT2cxwi7eYNbIq4XLt8hp6QM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 153/246] bcache: improve sysfs_strtoul_clamp()
Date:   Thu,  4 Apr 2019 10:47:33 +0200
Message-Id: <20190404084624.527172555@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
index 3fe82425859c..0ad2715a884e 100644
--- a/drivers/md/bcache/sysfs.h
+++ b/drivers/md/bcache/sysfs.h
@@ -81,9 +81,16 @@ do {									\
 
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



