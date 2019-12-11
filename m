Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B7C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A1E22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078767;
	bh=XOgid7OM46KmDNQ+MvlGlqC3GhFhG3RduDzjGCUZOMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QO0pAdeNlg5QFg9ttkJIi30QZmQvf9RzaXmnGDbM6FT/gwh0LjnAOPwReCHv3kVYe
	 OITfE4iBRKNeyi3EOCJz9MGpncMxGmpg3/gkG2qlPEfAf11JH/ZfuZ+upjUqkPYycP
	 PW9jvdTLyz+XNXVaw/FY4IGAedkgMcysV4P4WDaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfLKPjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:39:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388491AbfLKPir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:38:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82CFA222C4;
        Wed, 11 Dec 2019 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078727;
        bh=XOgid7OM46KmDNQ+MvlGlqC3GhFhG3RduDzjGCUZOMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eC819SVacXpkugNiKYM7sQq58slXtIxeAevKhm+NP3by4FYFd+NRR9ohgMZWu00aE
         ET4Ti7zYZz+waWHAjJeudMikAYEsKPHLIwYi5xDlf5s3z9ZG8Uq5pbFl9gTuEu69k7
         CAp2LawvX3ZZ/Qm9Z4bcxfMwW0g1VdJOsEYCsHM4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 31/37] scripts/kallsyms: fix definitely-lost memory leak
Date:   Wed, 11 Dec 2019 10:38:07 -0500
Message-Id: <20191211153813.24126-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153813.24126-1-sashal@kernel.org>
References: <20191211153813.24126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 21915eca088dc271c970e8351290e83d938114ac ]

build_initial_tok_table() overwrites unused sym_entry to shrink the
table size. Before the entry is overwritten, table[i].sym must be freed
since it is malloc'ed data.

This fixes the 'definitely lost' report from valgrind. I ran valgrind
against x86_64_defconfig of v5.4-rc8 kernel, and here is the summary:

[Before the fix]

  LEAK SUMMARY:
     definitely lost: 53,184 bytes in 2,874 blocks

[After the fix]

  LEAK SUMMARY:
     definitely lost: 0 bytes in 0 blocks

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kallsyms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index d117c68d1607b..b92b704e7ace3 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -455,6 +455,8 @@ static void build_initial_tok_table(void)
 				table[pos] = table[i];
 			learn_symbol(table[pos].sym, table[pos].len);
 			pos++;
+		} else {
+			free(table[i].sym);
 		}
 	}
 	table_cnt = pos;
-- 
2.20.1

