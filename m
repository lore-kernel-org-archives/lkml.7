Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427AB2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697863;
	bh=/PVC3G9/SX/K3Pj3kLvFzj8Bv5bJt9sVHAuZdAS7PY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pe5EiMBV7Vom4FA2211n5w0iT4kP8HB1WqSwAlUMTQazzIpy2d273ylVoh3nL2qQk
	 JTGfLibAMhBkPmRhOcUHDwPvneatyuWTMp7diAQ3HQbjnrDpjUkmLfYM6KwbLPf7l+
	 Gqu62/vXOh8niEBrkcdqh1tkcmyFNpNkqq6gIo58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389494AbfJJI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:52198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388642AbfJJIqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772C22064A;
        Thu, 10 Oct 2019 08:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697185;
        bh=/PVC3G9/SX/K3Pj3kLvFzj8Bv5bJt9sVHAuZdAS7PY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O8QZPhCISnnSv7idzkXqeDDbs3dCIXKiT/EUHctLtPgEI/2vIve/2kGGmrwQPU9Yr
         mUYk2J55mcdVLzH/5UTWn7QzQkjPPc5Lwgs8g3QgAt05oQwJohHQzXXkzG2GwbvDfv
         n++wCDPamEjkC+mwyM2Nla4+K16oCEVlFXZtE8Ck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 050/114] ima: fix freeing ongoing ahash_request
Date:   Thu, 10 Oct 2019 10:35:57 +0200
Message-Id: <20191010083608.110575459@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



