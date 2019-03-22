Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A4A21939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256031;
	bh=FWaPtH9+v5541JsmLcW80Kt2u5fTgKvK18z9dkRDox8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U7eNgmAolDT1sZGRApIwEPBz1kR7AFkRCv8ycX+hwsJqucMtxHDc7Cx/97gdgRBEN
	 djlVNCcc2bKZWKB4qwL/N+V7GI4Z2z5I1tVK1VY4qjC3QEMVYhgCHJkTFGFymfMztu
	 T1bSA/2ChBRvWBwefVWDwJxmU5Em1b6IW5KH2jF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbfCVMAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388078AbfCVMAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFAD204FD;
        Fri, 22 Mar 2019 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256025;
        bh=FWaPtH9+v5541JsmLcW80Kt2u5fTgKvK18z9dkRDox8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXJvNyhXpg6NfnBG7ngAWBQ7rqFWpwwbs2zTxf8Wqzhd9Eod+RjHRAV1FSx3em7i3
         1iQ7IlmlD99Dm4kLOB6gTs+64/XykzhkEglcrnE7qVKE29ru0zMa59rlyIq5Nboh9l
         Yi+IMv+M2HKkFbNfVgy8uf9750BngfnCr9fWY25A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Loh <eugene.loh@oracle.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/280] kallsyms: Handle too long symbols in kallsyms.c
Date:   Fri, 22 Mar 2019 12:13:41 +0100
Message-Id: <20190322111310.117043948@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a9186a98a37d..0c9c54b57515 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -120,8 +120,8 @@ static int read_symbol(FILE *in, struct sym_entry *s)
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



