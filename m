Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6149ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30B92168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948849;
	bh=/PVC3G9/SX/K3Pj3kLvFzj8Bv5bJt9sVHAuZdAS7PY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LRuaJUfQ+GqsjhaVl+d6HY7GGPIwe+kdDzCgf/UNL5ojJhJ8MU0t6aant/WyMmFTH
	 +6X301yVXyzqLjjZWO29RDH7OA9PYSkifgrcQ1Tl+NdL9xEcim9FIi3eTPlKiE4aRj
	 B3G1TlDohWtgK/zU0qI9ZMlE0mKSZtdfTSylQuek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfJAQyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732503AbfJAQnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:43:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7E321855;
        Tue,  1 Oct 2019 16:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948194;
        bh=/PVC3G9/SX/K3Pj3kLvFzj8Bv5bJt9sVHAuZdAS7PY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMatnWQ6rkVVG6+O7Gc3JOnZLDdIq276+QOo/fx/Zw4a53k0aTo3hqIac3FhkkDuZ
         wYcL4hFLiIUMQglJQQ6jEqX0czGinL1F4PL+D5E0Qq7FampBcXPMID/r+ne4hGrluw
         fnLazSxSb3RNP2nBP57rkDs685BeYqQOUixKSJFE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/43] ima: fix freeing ongoing ahash_request
Date:   Tue,  1 Oct 2019 12:42:30 -0400
Message-Id: <20191001164311.15993-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164311.15993-1-sashal@kernel.org>
References: <20191001164311.15993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit 4ece3125f21b1d42b84896c5646dbf0e878464e1 ]

integrity_kernel_read() can fail in which case we forward to call
ahash_request_free() on a currently running request. We have to wait
for its completion before we can free the request.

This was observed by interrupting a "find / -type f -xdev -print0 | xargs -0
cat 1>/dev/null" with ctrl-c on an IMA enabled filesystem.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index b7822d2b79736..f63b4bd45d60e 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -274,6 +274,11 @@ static int ima_calc_file_hash_atfm(struct file *file,
 		if (rc != rbuf_len) {
 			if (rc >= 0)
 				rc = -EINVAL;
+			/*
+			 * Forward current rc, do not overwrite with return value
+			 * from ahash_wait()
+			 */
+			ahash_wait(ahash_rc, &wait);
 			goto out3;
 		}
 
-- 
2.20.1

