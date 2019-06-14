Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB083C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB0621841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544216;
	bh=71CBmJBELF6Up+VwLkK6W7S5mNrL7k+xdUVn+a4juUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KPjRwq+0M9pXyZu9FQcOluyx0oma6cED/16GBHqP/JyvdeTc8dHF6duEjOJjpsDs0
	 MslmpXL/1fRQJ8lAFhZY5ifrpfTTQ+87XAm2HEtRGEWCsx2TF8EghbpW6peRuATqVd
	 1ZR2eIezHuizgeYitAw4rU/9I6J0oCnGE65Bkw6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfFNUaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbfFNUaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:05 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CCF12184C;
        Fri, 14 Jun 2019 20:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544205;
        bh=71CBmJBELF6Up+VwLkK6W7S5mNrL7k+xdUVn+a4juUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjmJm1VBdsMg5zQ+y8KaiWZZkM8kmVS2pK3qQtWIw+n1KT491oXskYoxLTzXk5QPR
         iKI9ePJTydAkmo9bxKDkMQ2duTQZpEElX+03MeeeBu1JjgAyxGYsiT0ShnfQryPESC
         gwLgMknouTSANPyLyT94txsaRPyQdZNTBo8P7y6Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Claudio Zumbo <claudioz@fb.com>,
        Claudio <claudiozumbo@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 18/39] kselftest/cgroup: fix unexpected testing failure on test_core
Date:   Fri, 14 Jun 2019 16:29:23 -0400
Message-Id: <20190614202946.27385-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614202946.27385-1-sashal@kernel.org>
References: <20190614202946.27385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

[ Upstream commit 00e38a5d753d7788852f81703db804a60a84c26e ]

The cgroup testing relys on the root cgroup's subtree_control setting,
If the 'memory' controller isn't set, some test cases will be failed
as following:

$sudo  ./test_core
not ok 1 test_cgcore_internal_process_constraint
ok 2 test_cgcore_top_down_constraint_enable
not ok 3 test_cgcore_top_down_constraint_disable
...

To correct this unexpected failure, this patch write the 'memory' to
subtree_control of root to get a right result.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Claudio Zumbo <claudioz@fb.com>
Cc: Claudio <claudiozumbo@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cgroup/test_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index be59f9c34ea2..d78f1c5366d3 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -376,6 +376,11 @@ int main(int argc, char *argv[])
 
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
-- 
2.20.1

