Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69472C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E91721D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468926;
	bh=TlSEfINMZciJs0jWl7K4oZo9kl0tiFuaorqqYimDni8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o2iVTkFrIkyrWNCYBwpZUlJXe3g0sesr/RsjBXE0rE1D1NDD+PYJhadh48o6Ih93R
	 1Y3IWacEfIPtzqndA7GlitoOw5l991D8cj2+ihuj8xXaQHBCJzm7ACwNnHZM6q+ZnT
	 Gpv0cSBdNYyjwjUHWDWB5yu+/2OaeFsmvA1qF+k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfL0Rsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbfL0Roj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8984D2464B;
        Fri, 27 Dec 2019 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468679;
        bh=TlSEfINMZciJs0jWl7K4oZo9kl0tiFuaorqqYimDni8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUBWGVrlpt4l7Wss2+St6tx3AG+Who7VvnSQi6LQAtJJ2CoehRkBK/Gp8xzOZxRTf
         NVZelAZXp38FbOsToJ/ZSb5+3ev76TWYcaedl/+cdIGKuEYnE9PL/jcBCVEzFjMTrw
         USg2JTGcWjHXv0CuSUVPzqtXN7E2mSaUew1DtioQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Daniel T. Lee" <danieltimlee@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 38/84] samples: bpf: fix syscall_tp due to unused syscall
Date:   Fri, 27 Dec 2019 12:43:06 -0500
Message-Id: <20191227174352.6264-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel T. Lee" <danieltimlee@gmail.com>

[ Upstream commit fe3300897cbfd76c6cb825776e5ac0ca50a91ca4 ]

Currently, open() is called from the user program and it calls the syscall
'sys_openat', not the 'sys_open'. This leads to an error of the program
of user side, due to the fact that the counter maps are zero since no
function such 'sys_open' is called.

This commit adds the kernel bpf program which are attached to the
tracepoint 'sys_enter_openat' and 'sys_enter_openat'.

Fixes: 1da236b6be963 ("bpf: add a test case for syscalls/sys_{enter|exit}_* tracepoints")
Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/syscall_tp_kern.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/syscall_tp_kern.c b/samples/bpf/syscall_tp_kern.c
index 9149c524d279..8833aacb9c8c 100644
--- a/samples/bpf/syscall_tp_kern.c
+++ b/samples/bpf/syscall_tp_kern.c
@@ -50,13 +50,27 @@ static __always_inline void count(void *map)
 SEC("tracepoint/syscalls/sys_enter_open")
 int trace_enter_open(struct syscalls_enter_open_args *ctx)
 {
-	count((void *)&enter_open_map);
+	count(&enter_open_map);
+	return 0;
+}
+
+SEC("tracepoint/syscalls/sys_enter_openat")
+int trace_enter_open_at(struct syscalls_enter_open_args *ctx)
+{
+	count(&enter_open_map);
 	return 0;
 }
 
 SEC("tracepoint/syscalls/sys_exit_open")
 int trace_enter_exit(struct syscalls_exit_open_args *ctx)
 {
-	count((void *)&exit_open_map);
+	count(&exit_open_map);
+	return 0;
+}
+
+SEC("tracepoint/syscalls/sys_exit_openat")
+int trace_enter_exit_at(struct syscalls_exit_open_args *ctx)
+{
+	count(&exit_open_map);
 	return 0;
 }
-- 
2.20.1

