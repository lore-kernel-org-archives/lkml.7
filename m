Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D247C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32F020706
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 13:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YlRnKr4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfKWN2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 08:28:01 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:39550 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfKWN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:27:59 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xANDRbkb000733;
        Sat, 23 Nov 2019 22:27:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xANDRbkb000733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1574515659;
        bh=JLQ/nMugg5YVM+foR8VQqNloJc4DhmgRZ+4CrOZuEX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlRnKr4Tk7d0Czt/xTJcgSf5lnYUu2xV02JwJ71fH12BaC/fHaPJDlCF0pG/sYmQx
         aXtYH7PnNvV2VLk89VcXdKbTXRAaNs0tu4j5UVmtMU0ovsHmf7U7xTDEdBNoAclqP8
         korgTc4lM/6/z9UgWSuQsPMdCQoBM/DL3+MD1v/JqwU9XpKWR5w8uVTaqimecsThdM
         P0hfUMzntuaYspaOTxbSd/eGO6IHVmf5CNzd7qdftSZ1c+2+NKIZt0RMOeHQz3JKYR
         D8hRO9bnbrXUKZPVa2eS/D9NcT/DOoGoaeJTO7C4j8+RcetSo/hdum6V0q36G5u65z
         WGMpgJ6Z/JcVA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] scripts/kallsyms: fix definitely-lost memory leak
Date:   Sat, 23 Nov 2019 22:27:13 +0900
Message-Id: <20191123132727.30151-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191123132727.30151-1-yamada.masahiro@socionext.com>
References: <20191123132727.30151-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

 scripts/kallsyms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 918c2ba071b5..79641874d860 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -487,6 +487,8 @@ static void build_initial_tok_table(void)
 				table[pos] = table[i];
 			learn_symbol(table[pos].sym, table[pos].len);
 			pos++;
+		} else {
+			free(table[i].sym);
 		}
 	}
 	table_cnt = pos;
-- 
2.17.1

