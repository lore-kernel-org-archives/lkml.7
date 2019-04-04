Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AE3C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7C92075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370776;
	bh=IdPP1kgzsjD8Wb3v67ymoOb7gX7zlYTjymgD1SDsHo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0YbM1K9JgaPWge1ERHdu06Amuhvd18ilEoCjISJQVAQcXq9EJ8RkFqO6/YVI0ZkLk
	 cWLd0+lHoNJaWk54zAnxsgZzNSGQO5SftLCfkrMulgyHifylOkoLCFhhn3tEulGjBD
	 AyoSuSrTVBZa2mKeU9biBQnuNw5dfeLgIiNETn3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbfDDJD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731321AbfDDJD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D41782147C;
        Thu,  4 Apr 2019 09:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368606;
        bh=IdPP1kgzsjD8Wb3v67ymoOb7gX7zlYTjymgD1SDsHo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqPGNSFIGIsVjah3Y/8JvpPQKmq57azujtG34gmssKzEtA7+UP8mkFKA2rgiXuUmi
         UR6Sxwi1Pu/LPpZC+1eUZ1/hj2q3P0Qa2acrw5ZC+bW5iDUaa07/ZWfSef50hFwSQm
         o1lNKRcXIHvBxOF78IB6EH6hKdzJZrDIFaBBqFaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 101/187] selftests: skip seccomp get_metadata test if not real root
Date:   Thu,  4 Apr 2019 10:47:18 +0200
Message-Id: <20190404084607.952046935@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 83057fa9d391..14cad657bc6a 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -2920,6 +2920,12 @@ TEST(get_metadata)
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



