Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95944ECE598
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629C72067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="D32cRh/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388344AbfJJNl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:41:28 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:38042 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733228AbfJJNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:41:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1BDD93F218;
        Thu, 10 Oct 2019 15:41:19 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=D32cRh/8;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J7j8NN9xYygG; Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 7F5343F5BA;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 4E2D636105C;
        Thu, 10 Oct 2019 15:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1570714877; bh=WNkn6DKxrc1ZFUEVaoGHRMxt8C+XYlS9MSYyqtJVrQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D32cRh/8yzGyBnNXzo5kC1wRWfBHZhjN7bh56q7wTX8quGWXIWNK3PKaBKbSYpelQ
         qAyAKiotKQAruoUnITQIrRqIfNt13qlj3lsJt4dIIAFy4HgFGxt7qK8QwOUP0Ge803
         bxebV8E7Upmqi6PUwLtnl6wA3ZklU8oN4CJxDhIU=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name
Cc:     Thomas Hellstrom <thellstrom@vmware.com>
Subject: [RFC PATCH 2/4] fs: task_mmu: Have the pagewalk avoid positive callback return codes
Date:   Thu, 10 Oct 2019 15:40:56 +0200
Message-Id: <20191010134058.11949-3-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010134058.11949-1-thomas_os@shipmail.org>
References: <20191010134058.11949-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

The pagewalk code is being reworked to have positive callback return codes
mean "walk control". Avoid using positive return codes: "1" is replaced by
"-ENOBUFS".

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 9442631fd4af..ef11969d9ba1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1265,7 +1265,7 @@ struct pagemapread {
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
 
-#define PM_END_OF_BUFFER    1
+#define PM_END_OF_BUFFER    (-ENOBUFS)
 
 static inline pagemap_entry_t make_pme(u64 frame, u64 flags)
 {
-- 
2.21.0

