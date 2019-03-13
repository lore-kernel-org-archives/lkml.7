Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C373C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC1213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504232;
	bh=l5DC/oAs6OVHZGFDZfsO/axiIOd/RiHixTgJLodp/m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E/e1kTYNcDP+El6MZKhJVJuOBuz+ez52zgY+ubBf3wqrzGso9DIVyRFp9bpBN1UeA
	 iFFDkcxNdiVjPwV2AsTkvig5ObR8mwaxu9Bfl4r7sw36wN26SF3RGCZj7WniqHUYlI
	 aZ78OmLtW6pEDS1TCT7ije9AWFbFrDFy3IwS04JA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfCMTKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMTK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:10:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACD3213A2;
        Wed, 13 Mar 2019 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504228;
        bh=l5DC/oAs6OVHZGFDZfsO/axiIOd/RiHixTgJLodp/m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yoiApyh8BuKbbZZTmpCBFr7hRlvilRsmJTTQjwpV4RD6a8SJxy4AKLyVNdx8hUucv
         ys++SHpft9xjCorR66uQ3ntilicdkknrixq7k2Kmzbr/boVSMOgnJsGAj4HL8YgjYW
         jC+SpRm9bKSjdXeDqe73D8EwR+GeXqbhUUKiCrKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugene Loh <eugene.loh@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 02/60] kallsyms: Handle too long symbols in kallsyms.c
Date:   Wed, 13 Mar 2019 15:09:23 -0400
Message-Id: <20190313191021.158171-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Loh <eugene.loh@oracle.com>

[ Upstream commit 6db2983cd8064808141ccefd75218f5b4345ffae ]

When checking for symbols with excessively long names,
account for null terminating character.

Fixes: f3462aa952cf ("Kbuild: Handle longer symbols in kallsyms.c")
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 109a1af7e444..f9339da8605e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -118,8 +118,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 			fprintf(stderr, "Read error or end of file.\n");
 		return -1;
 	}
-	if (strlen(sym) > KSYM_NAME_LEN) {
-		fprintf(stderr, "Symbol %s too long for kallsyms (%zu vs %d).\n"
+	if (strlen(sym) >= KSYM_NAME_LEN) {
+		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
 				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
 			sym, strlen(sym), KSYM_NAME_LEN);
 		return -1;
-- 
2.19.1

