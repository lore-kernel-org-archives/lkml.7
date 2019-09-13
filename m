Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE260C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D6E208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380348;
	bh=M+v2Cj/tTTedh66FI140lfs8CvMvkDan5ezh2dq2XJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BKVAkyaTO3s1JOToNUHVqP3ZeoHxeY0tKB4XUNEzrnG6fxVFSTHFRk+dm9QqeBSwX
	 e9gNrwvmeOmd59o0sNtFzgcqoK2XLbLUmuOpOyWZ+YD1JrBkW2sKevWDdUve3LTqD/
	 x7pHHPzx3WYWZFdqyR465kWD/+vrB4SqStwkbOTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbfIMNM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbfIMNMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:25 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B650206BB;
        Fri, 13 Sep 2019 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380344;
        bh=M+v2Cj/tTTedh66FI140lfs8CvMvkDan5ezh2dq2XJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfwPpAdGE/lSpDw/sB3PAueq1YVn66TsZsg1fsfLhQYb3wsp53em/0slNwVUGC/LJ
         ffsYHwGm6uEEvzV3b/9ONZrBrVJcEOyW1W4pHm9NU4Yq5nJRkdlIfinaDuDIQxc88j
         0pEOt304ES2N3H7RZle0278ArL+Wmd07YMfc2KzQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        James Morris <jmorris@namei.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/190] keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h
Date:   Fri, 13 Sep 2019 14:04:49 +0100
Message-Id: <20190913130602.388568147@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2ecefa0a15fd0ef88b9cd5d15ceb813008136431 ]

The keyctl_dh_params struct in uapi/linux/keyctl.h contains the symbol
"private" which means that the header file will cause compilation failure
if #included in to a C++ program.  Further, the patch that added the same
struct to the keyutils package named the symbol "priv", not "private".

The previous attempt to fix this (commit 8a2336e549d3) did so by simply
renaming the kernel's copy of the field to dh_private, but this then breaks
existing userspace and as such has been reverted (commit 8c0f9f5b309d).

[And note, to those who think that wrapping the struct in extern "C" {}
 will work: it won't; that only changes how symbol names are presented to
 the assembler and linker.].

Instead, insert an anonymous union around the "private" member and add a
second member in there with the name "priv" to match the one in the
keyutils package.  The "private" member is then wrapped in !__cplusplus
cpp-conditionals to hide it from C++.

Fixes: ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")
Fixes: 8a2336e549d3 ("uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Randy Dunlap <rdunlap@infradead.org>
cc: Lubomir Rintel <lkundrak@v3.sk>
cc: James Morris <jmorris@namei.org>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
cc: Stephan Mueller <smueller@chronox.de>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: stable@vger.kernel.org
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/keyctl.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 7b8c9e19bad1c..0f3cb13db8e93 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -65,7 +65,12 @@
 
 /* keyctl structures */
 struct keyctl_dh_params {
-	__s32 private;
+	union {
+#ifndef __cplusplus
+		__s32 private;
+#endif
+		__s32 priv;
+	};
 	__s32 prime;
 	__s32 base;
 };
-- 
2.20.1



