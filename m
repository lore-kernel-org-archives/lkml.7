Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47494C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111DB20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551368020;
	bh=ijbjMLRe+w4UWOtXWDVFVeE0V7LUSD9GaXfUEK+wurg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z7hJsYXpbuM8JvH3CnsEGZwA+wfbCJerUKlMpOk3f+ExuwGq/JO27ATlnr3lpVNNo
	 oWYu5m63EfKQhaUg0aaWnu3N45BUiDf6YywF/ueRVybRVc49nKoJVc0BfGwIYF+ztC
	 Y/seefZ0mO2fo0UFyfjwzy4IuwO5u6cw53tkNw5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbfB1Pdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733008AbfB1PIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DF7218C3;
        Thu, 28 Feb 2019 15:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366520;
        bh=ijbjMLRe+w4UWOtXWDVFVeE0V7LUSD9GaXfUEK+wurg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGl5C5kegwyHtC06+sVvJ+ghFQF9UMznk/RIh8vjz9nsJx2xzgef+boXjpII8Ox9P
         W/YZ80gwbNRume0n7J6eg+QKR7VNOaTDvQvD978KdlZEINYsssF4OwUirsen9wOWeV
         TYYfe4FpJTPnffIlyG5YXnHl5AbwhAUXvCxSYk7s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 16/81] bpftool: fix percpu maps updating
Date:   Thu, 28 Feb 2019 10:07:08 -0500
Message-Id: <20190228150813.10256-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit b0ca5ecb8e2279d706261f525f1bd0ba9e3fe800 ]

When updating a percpu map, bpftool currently copies the provided
value only into the first per CPU copy of the specified value,
all others instances are left zeroed.

This change explicitly copies the user-provided bytes to all the
per CPU instances, keeping the sub-command syntax unchanged.

v2 -> v3:
 - drop unused argument, as per Quentin's suggestion
v1 -> v2:
 - rename the helper as per Quentin's suggestion

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/map.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9988d5c126b62..94094168c4a61 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -439,6 +439,20 @@ static char **parse_bytes(char **argv, const char *name, unsigned char *val,
 	return argv + i;
 }
 
+/* on per cpu maps we must copy the provided value on all value instances */
+static void fill_per_cpu_value(struct bpf_map_info *info, void *value)
+{
+	unsigned int i, n, step;
+
+	if (!map_is_per_cpu(info->type))
+		return;
+
+	n = get_possible_cpus();
+	step = round_up(info->value_size, 8);
+	for (i = 1; i < n; i++)
+		memcpy(value + i * step, value, info->value_size);
+}
+
 static int parse_elem(char **argv, struct bpf_map_info *info,
 		      void *key, void *value, __u32 key_size, __u32 value_size,
 		      __u32 *flags, __u32 **value_fd)
@@ -518,6 +532,8 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 			argv = parse_bytes(argv, "value", value, value_size);
 			if (!argv)
 				return -1;
+
+			fill_per_cpu_value(info, value);
 		}
 
 		return parse_elem(argv, info, key, NULL, key_size, value_size,
-- 
2.19.1

