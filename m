Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D4EC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4E7208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 17:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfE0Rwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 13:52:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50979 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0Rwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 13:52:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hVJnS-0001iE-Qa; Mon, 27 May 2019 17:52:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] smack: remove redundant assignment to variable m
Date:   Mon, 27 May 2019 18:52:26 +0100
Message-Id: <20190527175226.17191-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable m is assigned a value that is never read and m is later
reassigned in for-loop.  This the assignment is redundant and can
be mored.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 security/smack/smackfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 47f73a0dabb1..b66adafeb5fa 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1174,7 +1174,6 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 			rc = -EINVAL;
 			goto free_out;
 		}
-		m = BEBITS;
 		masks = 32;
 	}
 	if (masks > BEBITS) {
-- 
2.20.1

