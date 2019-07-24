Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95D5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB02218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGXEN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:13:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36346 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfGXEN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:13:59 -0400
Received: from fencepost.gnu.org ([2001:470:142:3::e]:42076)
        by eggs.gnu.org with esmtp (Exim 4.71)
        (envelope-from <nikolas@gnu.org>)
        id 1hq8f7-0006cW-B9; Wed, 24 Jul 2019 00:13:57 -0400
Received: from pool-173-77-17-228.nycmny.east.verizon.net ([173.77.17.228]:39050 helo=alfalfa.home)
        by fencepost.gnu.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <nikolas@gnu.org>)
        id 1hq8f6-0002Lz-2I; Wed, 24 Jul 2019 00:13:56 -0400
From:   Nikolas Nyby <nikolas@gnu.org>
To:     tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Nikolas Nyby <nikolas@gnu.org>
Subject: [PATCH] x86/crash: remove unnecessary comparison
Date:   Wed, 24 Jul 2019 00:13:37 -0400
Message-Id: <20190724041337.8346-1-nikolas@gnu.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ret comparison and return are unnecessary as of
f296f2634920d205b93d878b48d87bb7e0a4c256

elf_header_exclude_ranges() returns ret in any case, with or
without this comparison.

Signed-off-by: Nikolas Nyby <nikolas@gnu.org>
---
 arch/x86/kernel/crash.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 2bf70a2fed90..eb651fbde92a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -225,8 +225,6 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	if (crashk_low_res.end) {
 		ret = crash_exclude_mem_range(cmem, crashk_low_res.start,
 							crashk_low_res.end);
-		if (ret)
-			return ret;
 	}
 
 	return ret;
-- 
2.20.1

