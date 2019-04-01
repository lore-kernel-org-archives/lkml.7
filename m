Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B621FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F08B206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDALyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:54:03 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:36958 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDALyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:54:02 -0400
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id uztz1z01w3XaVaC06ztzLP; Mon, 01 Apr 2019 13:54:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hAvVn-0003fF-4W; Mon, 01 Apr 2019 13:53:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hAvVn-0007UP-1l; Mon, 01 Apr 2019 13:53:59 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fs: VALIDATE_FS_PARSER should default to n
Date:   Mon,  1 Apr 2019 13:53:57 +0200
Message-Id: <20190401115357.28734-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_VALIDATE_FS_PARSER is a debugging tool to check that the parser
tables are vaguely sane.  It was set to default to 'Y' for the moment to
catch errors in upcoming fs conversion development.

Make sure it is not enabled by default in the final release of v5.1.

Fixes: 31d921c7fb969172 ("vfs: Add configuration parser helpers")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 3e6d3101f3ff0dba..db921dc267d3b784 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -10,7 +10,6 @@ config DCACHE_WORD_ACCESS
 
 config VALIDATE_FS_PARSER
 	bool "Validate filesystem parameter description"
-	default y
 	help
 	  Enable this to perform validation of the parameter description for a
 	  filesystem when it is registered.
-- 
2.17.1

