Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90A4ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96462207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264331;
	bh=8RDZahehh86mUaLsL8w6c3B6FC/eAknSP6AsN0Pn2IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qu3H9WKA0L1dzcsvRd8Pw0oGtwgPibwvOPbGxtQeosb9jiZedneqUNzrL29fkJm4Z
	 xPMIpK9zgPm/bR1yEASnDHm5w7TJVJhC4XV+7Oh9gVM1f8zCC31faq8izKPjEa4vQt
	 qXEoIx4RCXoQt/+/4zQ3MM/z2sTN2hDoa6P+MZy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393755AbfJPWSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:44064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437707AbfJPVyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:20 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F1F20872;
        Wed, 16 Oct 2019 21:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262859;
        bh=8RDZahehh86mUaLsL8w6c3B6FC/eAknSP6AsN0Pn2IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+0cpdLWXtP0anK6BMUQRM3bq05Q4P2jwnaitgyB04VJslmerBDOV1EhvUHxcvznI
         ARs4CfUeUNIqopPrzH1b8UaYbRgBqA3haucsb2hFPHRPcJdT0WVCFERgJRCO4RuSjq
         Bb1Wq7tJs9UPoN8RMBSbNTmE8vljP6K2J+n6RDFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 25/92] kernel/elfcore.c: include proper prototypes
Date:   Wed, 16 Oct 2019 14:49:58 -0700
Message-Id: <20191016214820.207374320@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis Kletnieks <valdis.kletnieks@vt.edu>

[ Upstream commit 0f74914071ab7e7b78731ed62bf350e3a344e0a5 ]

When building with W=1, gcc properly complains that there's no prototypes:

  CC      kernel/elfcore.o
kernel/elfcore.c:7:17: warning: no previous prototype for 'elf_core_extra_phdrs' [-Wmissing-prototypes]
    7 | Elf_Half __weak elf_core_extra_phdrs(void)
      |                 ^~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:12:12: warning: no previous prototype for 'elf_core_write_extra_phdrs' [-Wmissing-prototypes]
   12 | int __weak elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:17:12: warning: no previous prototype for 'elf_core_write_extra_data' [-Wmissing-prototypes]
   17 | int __weak elf_core_write_extra_data(struct coredump_params *cprm)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~
kernel/elfcore.c:22:15: warning: no previous prototype for 'elf_core_extra_data_size' [-Wmissing-prototypes]
   22 | size_t __weak elf_core_extra_data_size(void)
      |               ^~~~~~~~~~~~~~~~~~~~~~~~

Provide the include file so gcc is happy, and we don't have potential code drift

Link: http://lkml.kernel.org/r/29875.1565224705@turing-police
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/elfcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/elfcore.c b/kernel/elfcore.c
index e556751d15d94..a2b29b9bdfcb2 100644
--- a/kernel/elfcore.c
+++ b/kernel/elfcore.c
@@ -2,6 +2,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/binfmts.h>
+#include <linux/elfcore.h>
 
 Elf_Half __weak elf_core_extra_phdrs(void)
 {
-- 
2.20.1



