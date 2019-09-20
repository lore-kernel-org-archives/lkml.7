Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9FEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226012073F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 13:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfITNb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 09:31:27 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:44580 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfITNb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:31:27 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 9E1197BD9EF; Fri, 20 Sep 2019 15:31:25 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] dimlib: make DIMLIB a hidden symbol
Date:   Fri, 20 Sep 2019 15:31:15 +0200
Message-Id: <20190920133115.12802-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Tal Gilboa the only benefit from DIM comes from a driver
that uses it. So it doesn't make sense to make this symbol user visible,
instead all drivers that use it should select it (as is already the case
AFAICT).

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 lib/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index cc04124ed8f7..9fe8a21fd183 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -555,8 +555,7 @@ config SIGNATURE
 	  Implementation is done using GnuPG MPI library
 
 config DIMLIB
-	bool "DIM library"
-	default y
+	bool
 	help
 	  Dynamic Interrupt Moderation library.
 	  Implements an algorithm for dynamically change CQ moderation values
-- 
2.23.0

