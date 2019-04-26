Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5788EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7B42064A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDZWWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:22:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54552 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfDZWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:22:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hK9Es-0002bw-2W; Fri, 26 Apr 2019 22:22:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] unicode: fix dereference of a potentially null pointer
Date:   Fri, 26 Apr 2019 23:22:37 +0100
Message-Id: <20190426222237.13209-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer 'tree' is deferenced when assigning pointer 'trie', however
trie is being null checked a few lines later, so it could potentially
be null. Fix the potential null pointer dereference by only dereferencing
it after it has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: b08fcacaaaf4 ("unicode: introduce UTF-8 character database")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/mkutf8data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/mkutf8data.c b/scripts/mkutf8data.c
index 12ce94b43be6..0563ba679bbb 100644
--- a/scripts/mkutf8data.c
+++ b/scripts/mkutf8data.c
@@ -2706,7 +2706,7 @@ static utf8leaf_t *utf8hangul(const char *str, unsigned char *hangul)
 static utf8leaf_t *utf8nlookup(struct tree *tree, unsigned char *hangul,
 			       const char *s, size_t len)
 {
-	utf8trie_t	*trie = utf8data + tree->index;
+	utf8trie_t	*trie;
 	int		offlen;
 	int		offset;
 	int		mask;
@@ -2716,6 +2716,7 @@ static utf8leaf_t *utf8nlookup(struct tree *tree, unsigned char *hangul,
 		return NULL;
 	if (len == 0)
 		return NULL;
+	trie = utf8data + tree->index;
 	node = 1;
 	while (node) {
 		offlen = (*trie & OFFLEN) >> OFFLEN_SHIFT;
-- 
2.20.1

