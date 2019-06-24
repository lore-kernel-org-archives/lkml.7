Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E25C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFE2205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561371341;
	bh=STDA67ny//z8ON3EELw205CswwM8s+oAnWBfK72PmZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0TS+Ez5RDRVMFG54XbxxeAmImm7vK0+s9A/5uYbb8WEaKSbDgl/W5CrlPdPQffn5V
	 iDjwzs/c4J8sd5MRkcGfNKgfnbnIxNgycB5LnE0OAxDbN5VZWjeJn3qmp7/WLcpA7A
	 TKgG9DatNgZd4YGBkCwG0+UvqGuwXuLbzP4gO+5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfFXKPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbfFXKPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:15:37 -0400
Received: from localhost (f4.8f.5177.ip4.static.sl-reverse.com [119.81.143.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED80F205C9;
        Mon, 24 Jun 2019 10:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561371336;
        bh=STDA67ny//z8ON3EELw205CswwM8s+oAnWBfK72PmZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sz5FWTi//gGeX5nudyUDhjg+6Uoo/I+wulrHXrlh6eB8bxDlgIrGFZUrPMJDMa5Nk
         eET+YJRhPt3V8rE3hJzuSE2EUt+QaVHuiPhCb4l6QiPeh2E5QnQuc1OnSD2UeB355Y
         8NTnD4nGdWj5ghFQtJkUUbpjA03Yvu5NyhZ5NS3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Claudio Zumbo <claudioz@fb.com>,
        Claudio <claudiozumbo@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 058/121] kselftest/cgroup: fix unexpected testing failure on test_core
Date:   Mon, 24 Jun 2019 17:56:30 +0800
Message-Id: <20190624092323.670943186@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
References: <20190624092320.652599624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



