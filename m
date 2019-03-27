Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDF5206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713958;
	bh=RwDSvDrJpi9ErNnsHMtIec3eG0IaEYGWG1YrxeSsccQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=riwWwD6lyWrHlwOGlD6vEJrijWWV1VW49Su+t44bfcMfQeefyVX5UyJHfG7nY7+0b
	 G0/baJbrFU4SwicQIEhGrDTIwVjD5Xtst91qsutOooQpFbKflpTJPuQg2lpbZsQCH8
	 yklixoYawvFol2Vie8Zvvd2eY885VtBXpUI8mQbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbfC0TMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:12:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388334AbfC0SKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D724B2147C;
        Wed, 27 Mar 2019 18:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710223;
        bh=RwDSvDrJpi9ErNnsHMtIec3eG0IaEYGWG1YrxeSsccQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQp1jDS7enOstCIGTm+Bq0LrVAjOT9xRXGy0BI0+pbjAlt9NQ6ZPDuS3UIpJpjFUI
         pVYj2aj2Cfa2Gfa6nmHWA0JdtKkmssht5j7Py9XO0j8ojVBo20ggobz67KbRoXwrtq
         eyshN7b4iTBCASCBKZi3t4VQC23FII19F+tmBfIc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 262/262] bcache: fix potential div-zero error of writeback_rate_p_term_inverse
Date:   Wed, 27 Mar 2019 14:01:57 -0400
Message-Id: <20190327180158.10245-262-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit 5b5fd3c94eef69dcfaa8648198e54c92e5687d6d ]

Current code already uses d_strtoul_nonzero() to convert input string
to an unsigned integer, to make sure writeback_rate_p_term_inverse
won't be zero value. But overflow may happen when converting input
string to an unsigned integer value by d_strtoul_nonzero(), then
dc->writeback_rate_p_term_inverse can still be set to 0 even if the
sysfs file input value is not zero, e.g. 4294967296 (a.k.a UINT_MAX+1).

If dc->writeback_rate_p_term_inverse is set to 0, it might cause a
dev-zero error in following code from __update_writeback_rate(),
	int64_t proportional_scaled =
		div_s64(error, dc->writeback_rate_p_term_inverse);

This patch replaces d_strtoul_nonzero() by sysfs_strtoul_clamp() and
limit the value range in [1, UINT_MAX]. Then the unsigned integer
overflow and dev-zero error can be avoided.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 28e0d5a5e25b..e5daf91310f6 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -290,7 +290,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_i_term_inverse,
 			    dc->writeback_rate_i_term_inverse,
 			    1, UINT_MAX);
-	d_strtoul_nonzero(writeback_rate_p_term_inverse);
+	sysfs_strtoul_clamp(writeback_rate_p_term_inverse,
+			    dc->writeback_rate_p_term_inverse,
+			    1, UINT_MAX);
 	d_strtoul_nonzero(writeback_rate_minimum);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
-- 
2.19.1

