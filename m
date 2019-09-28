Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7AC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D5C20815
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 09:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfI1JnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 05:43:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfI1JnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 05:43:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDA6B7E2BF0D9B13C98D;
        Sat, 28 Sep 2019 17:43:00 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 28 Sep 2019
 17:42:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <Julia.Lawall@lip6.fr>, <Gilles.Muller@lip6.fr>,
        <nicolas.palix@imag.fr>, <michal.lkml@markovi.net>,
        <maennich@google.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <cocci@systeme.lip6.fr>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [RFC PATCH] scripts: Fix coccicheck failed
Date:   Sat, 28 Sep 2019 17:42:45 +0800
Message-ID: <20190928094245.45696-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run make coccicheck, I got this:

spatch -D patch --no-show-diff --very-quiet --cocci-file
 ./scripts/coccinelle/misc/add_namespace.cocci --dir .
 -I ./arch/x86/include -I ./arch/x86/include/generated
 -I ./include -I ./arch/x86/include/uapi
 -I ./arch/x86/include/generated/uapi -I ./include/uapi
 -I ./include/generated/uapi --include ./include/linux/kconfig.h
 --jobs 192 --chunksize 1

virtual rule patch not supported
coccicheck failed

It seems add_namespace.cocci cannot be called in coccicheck.

Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 scripts/{coccinelle/misc => }/add_namespace.cocci | 0
 scripts/nsdeps                                    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename scripts/{coccinelle/misc => }/add_namespace.cocci (100%)

diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/add_namespace.cocci
similarity index 100%
rename from scripts/coccinelle/misc/add_namespace.cocci
rename to scripts/add_namespace.cocci
diff --git a/scripts/nsdeps b/scripts/nsdeps
index ac2b6031dd13..0f743b76e501 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -23,7 +23,7 @@ fi
 
 generate_deps_for_ns() {
 	$SPATCH --very-quiet --in-place --sp-file \
-		$srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
+		$srctree/scripts/add_namespace.cocci -D ns=$1 $2
 }
 
 generate_deps() {
-- 
2.20.1


