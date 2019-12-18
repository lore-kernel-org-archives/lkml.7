Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28DAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E1F2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576685126;
	bh=+7tHJ6QZmfUIzfMtuMxIBcZU+naEgNPoO45RqFlSlcc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xyO5Mk4XhJMmzDgy3PhvJcoZslGxeNTDiZ6W0OpqBc04VHnRWAMXLl8Z6Wf4GhnG9
	 JJlX79WzWqS+4+ps6IN3QcFlgIolMHjawnpXPyyP8pao5o9v+IEWBfW7YALgdV0gCg
	 CKVJuIVIFeQX8gPs2+6TFDuNqTm3m/QsSXEXeQQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLRQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:05:25 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:58511 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLRQFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 11:05:25 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id xBIG5G85012778;
        Thu, 19 Dec 2019 01:05:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xBIG5G85012778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1576685117;
        bh=XrkgTceMdTMZIA8b6RjoQ0zRm2jj2UWUD7J1SCrikgA=;
        h=From:To:Cc:Subject:Date:From;
        b=zWlZwmo/tyoQg0BXA5fF/PKnJl8PDDgMOOZOyK+Wus7yaWZEX8aKK6zkfCnrVBrHR
         J92p3QowD9zzKcWmnCjKxum/ZMeMZqqFEy8LcZ+QOdldB6TjqBcLaMMCBuhW1LuWj+
         bPO2yVBgia/KZWVybAla4UL62h8/1MrDG+0eb5/PmPTt2WtxQIljXMigLDW/gt09SN
         7pumjvPix9+2qHIFkZziXxoksqg/z1tFP9X5U1o2zAWzw8Ggt4KVLZ7mLdq/uyEz4o
         CXwPJ2Wm77oX2bw5AahUAJvcaMqF9CIBizXF0VGI4LufStxJuko4CYTfIvhBIyAJHS
         EKj/2aGLEHLzA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: use pattern rule for building built-in.a in sub-directories
Date:   Thu, 19 Dec 2019 01:05:14 +0900
Message-Id: <20191218160514.28124-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The built-in.a in a sub-directory is created by descending into that
directory. It does not depend on the other sub-directories. Loosen
the dependency.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index e46b4ee9a120..a562d695f0fa 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -372,7 +372,7 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 # ---------------------------------------------------------------------------
 
 # To build objects in subdirs, we need to descend into the directories
-$(sort $(subdir-obj-y)): $(subdir-ym) ;
+$(obj)/%/built-in.a: $(obj)/% ;
 
 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
-- 
2.17.1

