Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A7FC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B432721774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1NH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:07:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43166 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1NH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:07:58 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iaJWU-0000Ep-1V; Thu, 28 Nov 2019 13:07:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: remove redundant assignment to pointer bp
Date:   Thu, 28 Nov 2019 13:07:53 +0000
Message-Id: <20191128130753.181246-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The point bp is assigned a value that is never read, it is being
re-assigned later to bp = &kdb_breakpoints[lowbp] in a for-loop.
Remove the redundant assignment.

Addresses-Coverity ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/debug/kdb/kdb_bp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index 62c301ad0773..d7ebb2c79cb8 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -412,7 +412,6 @@ static int kdb_bc(int argc, const char **argv)
 		 * assume that the breakpoint number is desired.
 		 */
 		if (addr < KDB_MAXBPT) {
-			bp = &kdb_breakpoints[addr];
 			lowbp = highbp = addr;
 			highbp++;
 		} else {
-- 
2.24.0

