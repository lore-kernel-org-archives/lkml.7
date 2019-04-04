Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4D21734
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369282;
	bh=8mD6DfCv33e5oU0Hp6FUAiUU4b8FrtIVzz9qZ2WXA/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZXd/YmNps8r3syBE2pFjmUf0ijXTdSntHupt1CZmrcKez6NrhPOWy3XI6o7O5n/M
	 2gvN9GCvU6YTXdWFoKQEztJ7AOfET77GTno3kmCig+wEpyhc49xWmRX80YP7LeDH6S
	 BnuMCkuaJZmh7xUwlwQX0IGmy5FmDKgPP9VyPveM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbfDDJOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:14:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733094AbfDDJOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:14:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01584214AF;
        Thu,  4 Apr 2019 09:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369277;
        bh=8mD6DfCv33e5oU0Hp6FUAiUU4b8FrtIVzz9qZ2WXA/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HX6ko6JFBXkbdflv+1UoeHVSsY3h9zROExChqp191AMTowBrWmVsP9wZB4nz/nn1V
         OiAeeZWCahofcLdZ5jfjQNleffZG0ODu5qB0Anark6DNZb+gqnuI4/GVwf03B+gXDf
         //fzXukjrALak58D5seh2RLZ/DCjTi8rD2O1YiPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 140/246] selftests: skip seccomp get_metadata test if not real root
Date:   Thu,  4 Apr 2019 10:47:20 +0200
Message-Id: <20190404084624.068041539@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3aa415dd2128e478ea3225b59308766de0e94d6b ]

The get_metadata() test requires real root, so let's skip it if we're not
real root.

Note that I used XFAIL here because that's what the test does later if
CONFIG_CHEKCKPOINT_RESTORE happens to not be enabled. After looking at the
code, there doesn't seem to be a nice way to skip tests defined as TEST(),
since there's no return code (I tried exit(KSFT_SKIP), but that didn't work
either...). So let's do it this way to be consistent, and easier to fix
when someone comes along and fixes it.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7e632b465ab4..6d7a81306f8a 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2971,6 +2971,12 @@ TEST(get_metadata)
 	struct seccomp_metadata md;
 	long ret;
 
+	/* Only real root can get metadata. */
+	if (geteuid()) {
+		XFAIL(return, "get_metadata requires real root");
+		return;
+	}
+
 	ASSERT_EQ(0, pipe(pipefd));
 
 	pid = fork();
-- 
2.19.1



