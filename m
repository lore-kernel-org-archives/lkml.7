Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA471C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B8A20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BjmSUlQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDIEzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:55:13 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:35556 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfDIEzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 00:55:13 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x394rZ7R004013;
        Tue, 9 Apr 2019 13:53:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x394rZ7R004013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554785615;
        bh=I8W+MlJxuYZkV0iAaLmXEewdBUE8cuF0yeIZtO9GjRc=;
        h=From:To:Cc:Subject:Date:From;
        b=BjmSUlQ9NPP3MBhFboUUGmsWWwy+tRdTNOFO6oXJHzfZs0n25IMZBn6RMJ+teCq26
         Tk4tr4g123wvcpjIlw9Y3IiAObLazt2Gj90fKALG7jTTZLtoZPNYZn5bdqL7kDU++h
         /9ne133HKo8X+wsgl5QsVtfeXucCQCfRZ2T83NntV8nkrQ3JJ6SO5Y5c3dZ0Bysc6p
         Sp5+IdzSdCpVRfXBv4VDm2wonqR7u26ndBIAVw9ExCCbDzJMICD++UUej58G+sPNxJ
         j05JXBN2m/C1WBjnR6AyNwMNpz6NmTuXa1zh3Fr43m3xy9O/ZL4N7M2oX3GqaSGJHZ
         eRkYwTZLGUyxg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] mtd: rawnand: constify elements of NAND_OP_PARSER(_PATTERN)
Date:   Tue,  9 Apr 2019 13:53:32 +0900
Message-Id: <20190409045332.5452-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, drivers are able to constify a nand_op_parser array,
but not nand_op_parser_pattern and nand_op_parser_pattern_elem
since they are instantiated by using the NAND_OP_PARSER(_PATTERN).

Add 'const' to them in order to move more driver data from .data to
.rodata section.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/mtd/rawnand.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index b7445a44a814..ebde52088e4d 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -805,7 +805,7 @@ struct nand_op_parser_pattern {
 #define NAND_OP_PARSER_PATTERN(_exec, ...)							\
 	{											\
 		.exec = _exec,									\
-		.elems = (struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ },		\
+		.elems = (const struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ },		\
 		.nelems = sizeof((struct nand_op_parser_pattern_elem[]) { __VA_ARGS__ }) /	\
 			  sizeof(struct nand_op_parser_pattern_elem),				\
 	}
@@ -831,7 +831,7 @@ struct nand_op_parser {
 
 #define NAND_OP_PARSER(...)									\
 	{											\
-		.patterns = (struct nand_op_parser_pattern[]) { __VA_ARGS__ },			\
+		.patterns = (const struct nand_op_parser_pattern[]) { __VA_ARGS__ },		\
 		.npatterns = sizeof((struct nand_op_parser_pattern[]) { __VA_ARGS__ }) /	\
 			     sizeof(struct nand_op_parser_pattern),				\
 	}
-- 
2.17.1

