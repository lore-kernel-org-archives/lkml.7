Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E4FC2D0C8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47389208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078220;
	bh=GCz9esUbUwzSBgT2gpkimtUv73By8glepztBxqriKvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cLvqipHAmNQOwc9yo+bgMXJkuwtUICkDv/aJepQpbSoNj+DshSLyoB7fl2ZIWlK18
	 Oq/eAYa5qfSzLvshYT5cCGmP1LwwqhuRT5skfXWX0Hrm3rJgoh/pUUId1qbdZk7Gct
	 GALhx0L0wGF8tIbc9ikaMHjxlSKni0na7DKjwDRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbfLKP3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387866AbfLKP3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3968C222C4;
        Wed, 11 Dec 2019 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078162;
        bh=GCz9esUbUwzSBgT2gpkimtUv73By8glepztBxqriKvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvnIil53gzdIEOh6Jl4JXAfRW27BWr9ocRv4KBzKc11ZpQsmkrxOP2uwT5Dj5kK3v
         2hKp6m3dyGAiaGR/AvW80IObBHv4nR4sbYTYNxAeMeEtkXjj8EwvlJOwJ3OgeQeeJk
         xs3PunjYiOnygn7GtgTYvhrXH7PW89NExDQPU+KU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 47/58] scripts/kallsyms: fix definitely-lost memory leak
Date:   Wed, 11 Dec 2019 10:28:20 -0500
Message-Id: <20191211152831.23507-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
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
index b471022c81624..b43531899648a 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -510,6 +510,8 @@ static void build_initial_tok_table(void)
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

