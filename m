Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FB12081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554601;
	bh=SXkz2rRTYygGWZhwmXK4TDRIYfU0p6emAJwWwaDRWIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rlj04Bq2ueEU+ZV5o2ymXFRn0gsk7gSqsDLYxDet7lOSYbsKB8vqY67NjOttUTZg0
	 I1AFSgz3r4RIUIasPj67bcfznKqxuluOV0MvS9u/BG0So8yPVTZelHck8gBNoEUW/g
	 sk8tQRM2BVc8ldDAvVtqL6/dbg6LpUL1w+5N1LsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbfEVT0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:26:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732110AbfEVT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:26:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02ABB21872;
        Wed, 22 May 2019 19:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553204;
        bh=SXkz2rRTYygGWZhwmXK4TDRIYfU0p6emAJwWwaDRWIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zci6+KPqSgTzPrGThRwN0E9ZbfT+3NKTDoH7+VukzCsFs52XDv/usOtSjMwNyXW+g
         jEVdpm0/EISiBTBAP4K9Dim9sPNxCg+RNhShhIE0l3ey8JRc2fWac4HTf1jtiHFYwY
         yiGvU0Bh/UxzBpopGYVTuUZ0HZxotS0MHR9Nt13o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 010/244] bpftool: exclude bash-completion/bpftool from .gitignore pattern
Date:   Wed, 22 May 2019 15:22:36 -0400
Message-Id: <20190522192630.24917-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit a7d006714724de4334c5e3548701b33f7b12ca96 ]

tools/bpf/bpftool/.gitignore has the "bpftool" pattern, which is
intended to ignore the following build artifact:

  tools/bpf/bpftool/bpftool

However, the .gitignore entry is effective not only for the current
directory, but also for any sub-directories.

So, from the point of .gitignore grammar, the following check-in file
is also considered to be ignored:

  tools/bpf/bpftool/bash-completion/bpftool

As the manual gitignore(5) says "Files already tracked by Git are not
affected", this is not a problem as far as Git is concerned.

However, Git is not the only program that parses .gitignore because
.gitignore is useful to distinguish build artifacts from source files.

For example, tar(1) supports the --exclude-vcs-ignore option. As of
writing, this option does not work perfectly, but it intends to create
a tarball excluding files specified by .gitignore.

So, I believe it is better to fix this issue.

You can fix it by prefixing the pattern with a slash; the leading slash
means the specified pattern is relative to the current directory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
index 67167e44b7266..8248b8dd89d4b 100644
--- a/tools/bpf/bpftool/.gitignore
+++ b/tools/bpf/bpftool/.gitignore
@@ -1,5 +1,5 @@
 *.d
-bpftool
+/bpftool
 bpftool*.8
 bpf-helpers.*
 FEATURE-DUMP.bpftool
-- 
2.20.1

