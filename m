Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D99C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92A321D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003900;
	bh=tQMkJmGcVXYMn7aKUtS8kIoW8AssjEJpTFsjvF9lPnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kBLiPPsiHvxi9sWCRJ1z+E6rIXe3QhAGCmGDtWrLI5b03nQ4risvDyRhAqAG9mDnV
	 yZSJowwGqLMXMVGDpdqqRC+bWln5F/WU2RMscGJ/ypyiHhbJ98beeRw58YkNKEBZ5+
	 zF2H9DaR5LPhCV1Un6r4y+hqi1G+ozgkZfnO+Zjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgABWY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:24:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbgABWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:24:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA70F20866;
        Thu,  2 Jan 2020 22:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003894;
        bh=tQMkJmGcVXYMn7aKUtS8kIoW8AssjEJpTFsjvF9lPnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kI8zPofcvJvlC2Cjf6huNu5eSI95ljpRj0LL6hy6hgY1BqhECtnnlOE1joBUH4xev
         +0xA88BBwZQPYnpquDklIK7QsF0ijBKcG8LzTQxENd+uAXMPfFYI3sy67cHxs4/oMt
         kkcKNVMqm2TOy5dDptJqtqE2qHreKHfzzgVkYpSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 44/91] scripts/kallsyms: fix definitely-lost memory leak
Date:   Thu,  2 Jan 2020 23:07:26 +0100
Message-Id: <20200102220434.581406182@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220356.856162165@linuxfoundation.org>
References: <20200102220356.856162165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index b471022c8162..b43531899648 100644
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



