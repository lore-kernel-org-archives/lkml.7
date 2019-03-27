Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1C02082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712564;
	bh=3DgkFPmNHY7KhHw+MPatUjIUf/I0icEz0+8TClSwq7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I+jcdll4zgwJcAbu3P+1uWNwTSxRSUG6PvCyjKkFR7qRWblebHPn3o1bqMastOt+Y
	 Mx9rrvEDAx6FAzV1K+dKJpv5RIhixMi5/Ng9RITMxSi9E4PSBpwNiqUTunCdZqYdsK
	 igfPhOFEP6KdvyyZ6NCB0Kkhh4msudFUHPArgWbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391202AbfC0StX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390592AbfC0SSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:18:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053192177E;
        Wed, 27 Mar 2019 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710728;
        bh=3DgkFPmNHY7KhHw+MPatUjIUf/I0icEz0+8TClSwq7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFI2MGxqcKlKSUJnr93rPxAhd892nTi8B+c5lKagR3oebpXnZBwT8KSJouHXsWf5z
         H4E3P3/+S0nJhAPdJAN5UC6oU4OoLxUT/WihKvu4znOpb39Wkf58+PI4v73sQ7Dau+
         RxdV7tE6kopDezj3pMtchTdn5niTE/eSsJg7tS0I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 075/123] bcache: fix input overflow to cache set sysfs file io_error_halflife
Date:   Wed, 27 Mar 2019 14:15:39 -0400
Message-Id: <20190327181628.15899-75-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

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
index 5d81cd06af00..43ff7fbcbc7c 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -660,8 +660,17 @@ STORE(__bch_cache_set)
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

