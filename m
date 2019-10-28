Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574CECA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC9720830
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572275690;
	bh=3bA1CKw5DxLrwMigXlz2YeU695BAZLgPfS9g8yw1HeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zkbdICxsEWdN9ZP8HeZAuyN3pBM0Yfhs8MGGicVDJ6sujg9ldyCABBe6Q1JOvFLY2
	 +GsUsc8Lh0KQdld7cs/8bCJiQg9uw1XIcZfXLEihU+5bib4JgVs2MsyO/KwHvGHruC
	 7qLYkfklmn0KrEC8jhDE050pF7PVKOuF4QogIiAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390635AbfJ1POs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfJ1POr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:14:47 -0400
Received: from linux-8ccs.suse.cz (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6DB5217D6;
        Mon, 28 Oct 2019 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572275686;
        bh=3bA1CKw5DxLrwMigXlz2YeU695BAZLgPfS9g8yw1HeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Un9Bf5s2T7QD4LPjOLi56wXUz5Kr+M6mwuEXzVKgkqKfvDXDbqP9x9z3diFvuGUiW
         rldUkIJmPykn5jxrUvfXNJvpcVq9Il9mwsYEOZXlucPhh3MRy6yjk9+OSIN16iW2tC
         mslOyyPZiB/3frfK5CTDm35behHbI/XyHltDRbkA=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthias Maennich <maennich@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 4/4] scripts/nsdeps: make sure to pass all module source files to spatch
Date:   Mon, 28 Oct 2019 16:14:27 +0100
Message-Id: <20191028151427.31612-4-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191028151427.31612-1-jeyu@kernel.org>
References: <20191028151427.31612-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nsdeps script passes a list of the module source files to
generate_deps_for_ns() as a space delimited string named $mod_source_files,
which then passes it to spatch. But since $mod_source_files is not encased
in quotes, each source file in that string is treated as a separate shell
function argument (as $2, $3, $4, etc.).  However, the spatch invocation
only refers to $2, so only the first file out of $mod_source_files is
processed by spatch.

This causes problems (namely, the MODULE_IMPORT_NS() statement doesn't
get inserted) when a module is composed of many source files and the
"main" module file containing the MODULE_LICENSE() statement is not the
first file listed in $mod_source_files. Fix this by encasing
$mod_source_files in quotes so that the entirety of the string is
treated as a single argument and can be referred to as $2.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 scripts/nsdeps | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsdeps b/scripts/nsdeps
index 9ddcd5cb96b1..5055b059a81b 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -36,7 +36,7 @@ generate_deps() {
 					      | sed -E "s%(^|\s)([^/][^ ]*)%\1$srctree/\2%g"`
 	for ns in `cat $ns_deps_file`; do
 		echo "Adding namespace $ns to module $mod_name (if needed)."
-		generate_deps_for_ns $ns $mod_source_files
+		generate_deps_for_ns $ns "$mod_source_files"
 		# sort the imports
 		for source_file in $mod_source_files; do
 			sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
-- 
2.16.4

