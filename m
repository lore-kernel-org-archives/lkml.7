Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05178C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D7222314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004713;
	bh=iiHkmAn0HtFSe8vyac2ZShkvyJ3Zx8AZ6ZfZB2ZrOSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h14uhvO1aPq8jZ+aIRSkQR3uPszf/OW7ASO5cWFVkd87fs0rxuouLFM8AXzJc1mhZ
	 M0fENoZFz+kIYX2EfGBOGVyhYVg2JslE8zmuksQCNO2DFLJ4oXYyT2RFBOZi8qCssS
	 IGpmeIU87ljC01GyIKi8qPKZJt8Cl1R/iuIjP0Ps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgABWic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:38:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731068AbgABWi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:38:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FD5E21835;
        Thu,  2 Jan 2020 22:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004707;
        bh=iiHkmAn0HtFSe8vyac2ZShkvyJ3Zx8AZ6ZfZB2ZrOSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODhYxHSYRffB8xSyYkKB06oz1qMqytRSbjW/TqZ26h7wOpLcQxlXiU1jdfpwPphz0
         gXcK2coBsaVPnU4X0I2uykcq6OwOw024iSJc7shay6NVfV0MItrX1U2iG9MBCO/4Hh
         6Bf4C51fxnJuSCU97Zb1idl0TbH5hJdRgSNfX9PI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 120/137] scripts/kallsyms: fix definitely-lost memory leak
Date:   Thu,  2 Jan 2020 23:08:13 +0100
Message-Id: <20200102220603.292723951@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
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
index d117c68d1607..b92b704e7ace 100644
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



