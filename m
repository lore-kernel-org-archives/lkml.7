Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E0C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A9121852
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595798;
	bh=EbTIThiEgoOgzcI/ptTmjnV2ipsmlnv0w7dVq0qzRZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+O6I4Ri7jHXNI/Vzznl0fcCL7pkI1EyEHzLcx35HqFm8rb4smG1kNjKYRdJoUEyd
	 3dJ+gzty/b4tZuo+eMJvD9uo/7V9iGLtTpkCfeYyWomAzLYgPC46pwrmyuGxbFEW5o
	 LBwAtg4MkmkXM53iyGvtQ5wlxXs/VYa68/HL47VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfF0Agh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbfF0Age (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:36:34 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7EF217F9;
        Thu, 27 Jun 2019 00:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595793;
        bh=EbTIThiEgoOgzcI/ptTmjnV2ipsmlnv0w7dVq0qzRZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqF7eYn0lKvNtGBhtEaND/pl/N/Hp6iz7xY/CfW1ltMwvOkpLdfXAYPlsaT5iVElL
         o2SZQYCgLEbp3o7RD+l+Bqt91yseHM+SQfsB8caX2CcvD479yOWpBGJL0rhiT28aMx
         iPDNBnSS2Wn2XremmBpV1LXtVwu6GPrzxI5JOsJU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 05/60] samples, bpf: suppress compiler warning
Date:   Wed, 26 Jun 2019 20:35:20 -0400
Message-Id: <20190627003616.20767-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit a195cefff49f60054998333e81ee95170ce8bf92 ]

GCC 9 fails to calculate the size of local constant strings and produces a
false positive:

samples/bpf/task_fd_query_user.c: In function ‘test_debug_fs_uprobe’:
samples/bpf/task_fd_query_user.c:242:67: warning: ‘%s’ directive output may be truncated writing up to 255 bytes into a region of size 215 [-Wformat-truncation=]
  242 |  snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/events/%ss/%s/id",
      |                                                                   ^~
  243 |    event_type, event_alias);
      |                ~~~~~~~~~~~
samples/bpf/task_fd_query_user.c:242:2: note: ‘snprintf’ output between 45 and 300 bytes into a destination of size 256
  242 |  snprintf(buf, sizeof(buf), "/sys/kernel/debug/tracing/events/%ss/%s/id",
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  243 |    event_type, event_alias);
      |    ~~~~~~~~~~~~~~~~~~~~~~~~

Workaround this by lowering the buffer size to a reasonable value.
Related GCC Bugzilla: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83431

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/task_fd_query_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index 8381d792f138..06957f0fbe83 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -216,7 +216,7 @@ static int test_debug_fs_uprobe(char *binary_path, long offset, bool is_return)
 {
 	const char *event_type = "uprobe";
 	struct perf_event_attr attr = {};
-	char buf[256], event_alias[256];
+	char buf[256], event_alias[sizeof("test_1234567890")];
 	__u64 probe_offset, probe_addr;
 	__u32 len, prog_id, fd_type;
 	int err, res, kfd, efd;
-- 
2.20.1

