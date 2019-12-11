Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A968C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD2B2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077291;
	bh=V3W/It5zf+Qc9Qam9DLjUxFvJ61pLPbxIY3M6si2UcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1HDs1xjR8z7ZrALRG2eYmCNpy1v3YfbOwmaYfp8zMd0xUNn4txJpnX4NaCcjUb8Ce
	 lyQWiGphAZe0RcaDVmXX9MGKLhK912R8BXORtHpwT8xsUl9z4grI4X6U5vWwYeFNB0
	 x4CU/MW0mvhg2L5dRj0BgYcD58e16l+o/OEchnVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfLKPOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbfLKPNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268E624671;
        Wed, 11 Dec 2019 15:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077231;
        bh=V3W/It5zf+Qc9Qam9DLjUxFvJ61pLPbxIY3M6si2UcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0zkgNEGSpPkUVhaf70PZKATow9zLpJHeVNu63NNoaIXnZ5mL3lHym+FAzsor3dAs
         D4IDT24vlOtaLyeVi4keV8L8xmgAmnaVRUzQ84q2C+mSMNOVHCkKHekqcgndC2+IsQ
         2a8VbQo4HBG5S8n53Tchouf9LOWR/bv3q4Ek29II=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 110/134] scripts/kallsyms: fix definitely-lost memory leak
Date:   Wed, 11 Dec 2019 10:11:26 -0500
Message-Id: <20191211151150.19073-110-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
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
index ae6504d07fd61..fb15f09e0e38c 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -489,6 +489,8 @@ static void build_initial_tok_table(void)
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

