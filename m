Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0934ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B1021479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570461072;
	bh=5UOyBnC5qla2Rd1+pYVADdaJfxPTcdJGTel4r+Yxuog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wt/xbe2PST9DioDYtXH1Cg1VVaTpFReNwBsxeq5j5NHK8thQvOHMnTeFMlmORlTYl
	 5nIV/orwWF7B3Z4EvBmttPXmJJapN0ZmquCpdRewTvE/G8t/dQgY7fGWmdDoSawuZx
	 DdcqdJrn0x9hQXk5gd+2U9pSsFmbiqvo5fZ4/AWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfJGPLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGPLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:11:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED2821479;
        Mon,  7 Oct 2019 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570461068;
        bh=5UOyBnC5qla2Rd1+pYVADdaJfxPTcdJGTel4r+Yxuog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTD2cuCGpk1mKSEc7DtF2Uz85k3iV1Qnrv/1WFvBEkzmBmkv/gaZksCFpNlx+dxfp
         x6yOXNGDQoH4VfHyKIt2r69euzMdy+V5k5nB2y4+TnDXwOYAdDGKpqGcV6fCAs7VLg
         LXt1LW9BgXzlUHOtKRYMDrOITKtD1jyAiwknmrpg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio.lopez@collabora.co.uk>
Subject: [BUGFIX PATCH 5/5] selftests: sync: Fix cast warnings on arm
Date:   Tue,  8 Oct 2019 00:11:05 +0900
Message-Id: <157046106490.20724.11239563330126529340.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157046101671.20724.9561877942986463668.stgit@devnote2>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warnings on __u64 and pointer translation on arm and
other 32bit architectures. Since the pointer is 32bits on
those archs, we should not directly cast those types.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Emilio López <emilio.lopez@collabora.co.uk>
---
 tools/testing/selftests/sync/sync.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sync/sync.c b/tools/testing/selftests/sync/sync.c
index f3d599f249b9..7741c0518d18 100644
--- a/tools/testing/selftests/sync/sync.c
+++ b/tools/testing/selftests/sync/sync.c
@@ -109,7 +109,7 @@ static struct sync_file_info *sync_file_info(int fd)
 			return NULL;
 		}
 
-		info->sync_fence_info = (uint64_t)fence_info;
+		info->sync_fence_info = (uint64_t)(unsigned long)fence_info;
 
 		err = ioctl(fd, SYNC_IOC_FILE_INFO, info);
 		if (err < 0) {
@@ -124,7 +124,7 @@ static struct sync_file_info *sync_file_info(int fd)
 
 static void sync_file_info_free(struct sync_file_info *info)
 {
-	free((void *)info->sync_fence_info);
+	free((void *)(unsigned long)info->sync_fence_info);
 	free(info);
 }
 
@@ -152,7 +152,7 @@ int sync_fence_count_with_status(int fd, int status)
 	if (!info)
 		return -1;
 
-	fence_info = (struct sync_fence_info *)info->sync_fence_info;
+	fence_info = (struct sync_fence_info *)(unsigned long)info->sync_fence_info;
 	for (i = 0 ; i < info->num_fences ; i++) {
 		if (fence_info[i].status == status)
 			count++;

