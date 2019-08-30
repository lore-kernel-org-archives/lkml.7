Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C775C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F5621897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 10:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfH3KtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 06:49:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49749 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfH3KtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:49:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i3eSv-0008Tr-6K; Fri, 30 Aug 2019 10:49:13 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] afs: use BIT_ULL for shifting to fix integer overflow
Date:   Fri, 30 Aug 2019 11:49:12 +0100
Message-Id: <20190830104912.1090-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The expression 1 << nr_slots is evaluated with 32 bit integer arithmetic
and can overflow before it is widened. Instead, use BIT_ULL to avoid
overflow.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: 63a4681ff39c ("afs: Locally edit directory data for mkdir/create/unlink/...")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/afs/dir_edit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index d4fbe5f85f1b..f360119923aa 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -36,7 +36,7 @@ static int afs_find_contig_bits(union afs_xdr_dir_block *block, unsigned int nr_
 	bitmap |= (u64)block->hdr.bitmap[7] << 7 * 8;
 	bitmap >>= 1; /* The first entry is metadata */
 	bit = 1;
-	mask = (1 << nr_slots) - 1;
+	mask = BIT_ULL(nr_slots) - 1;
 
 	do {
 		if (sizeof(unsigned long) == 8)
@@ -70,7 +70,7 @@ static void afs_set_contig_bits(union afs_xdr_dir_block *block,
 {
 	u64 mask, before, after;
 
-	mask = (1 << nr_slots) - 1;
+	mask = BIT_ULL(nr_slots) - 1;
 	mask <<= bit;
 
 	before = *(u64 *)block->hdr.bitmap;
@@ -95,7 +95,7 @@ static void afs_clear_contig_bits(union afs_xdr_dir_block *block,
 {
 	u64 mask, before, after;
 
-	mask = (1 << nr_slots) - 1;
+	mask = BIT_ULL(nr_slots) - 1;
 	mask <<= bit;
 
 	before = *(u64 *)block->hdr.bitmap;
-- 
2.20.1

