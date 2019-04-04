Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD87DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F7217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367957;
	bh=hwM4/DBT/s0MwM714VrkbFtT8U3R/679Bfp7AHa/bZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O46wyrf0Rt7IwIVp8VSexftZoA9GrFC6nwLTwxpJ9X8dZ8H58pJmuRHXLXF7CyExu
	 Q344HPuLJL0NmTEF9W3qtxDRXSGGkBogs+C+N4WaFrezad4Y2PKyCopcL9DKDSI5/o
	 8YvK4ALO3bW8eSmg57+DDgeT45T1DR0iLivYzssY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfDDIwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729614AbfDDIwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA932147C;
        Thu,  4 Apr 2019 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367952;
        bh=hwM4/DBT/s0MwM714VrkbFtT8U3R/679Bfp7AHa/bZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEMvygHi/wygvgFw/VCEfnGHmycfiMIYLMP62ZKxD0cEDtt8oO18uvnYpK10KXxA5
         IqZhZ3k4+EckTUzhobUiTShRi5wipiiQZ6iHevB8XyWpRq4KpdULhqq81FAbc439h0
         wjNdt7s3cVhwx4hsMv09Dy2jd5j5LyKwhKRKFKo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 58/91] bcache: fix input overflow to cache set sysfs file io_error_halflife
Date:   Thu,  4 Apr 2019 10:47:42 +0200
Message-Id: <20190404084538.798863229@linuxfoundation.org>
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

[ Upstream commit a91fbda49f746119828f7e8ad0f0aa2ab0578f65 ]

Cache set sysfs entry io_error_halflife is used to set c->error_decay.
c->error_decay is in type unsigned int, and it is converted by
strtoul_or_return(), therefore overflow to c->error_decay is possible
for a large input value.

This patch fixes the overflow by using strtoul_safe_clamp() to convert
input string to an unsigned long value in range [0, UINT_MAX], then
divides by 88 and set it to c->error_decay.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 5a5c1f1bd8a5..87daccbbc61b 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -645,8 +645,17 @@ STORE(__bch_cache_set)
 		c->error_limit = strtoul_or_return(buf) << IO_ERROR_SHIFT;
 
 	/* See count_io_errors() for why 88 */
-	if (attr == &sysfs_io_error_halflife)
-		c->error_decay = strtoul_or_return(buf) / 88;
+	if (attr == &sysfs_io_error_halflife) {
+		unsigned long v = 0;
+		ssize_t ret;
+
+		ret = strtoul_safe_clamp(buf, v, 0, UINT_MAX);
+		if (!ret) {
+			c->error_decay = v / 88;
+			return size;
+		}
+		return ret;
+	}
 
 	sysfs_strtoul(journal_delay_ms,		c->journal_delay_ms);
 	sysfs_strtoul(verify,			c->verify);
-- 
2.19.1



