Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4B4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CBA20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367610;
	bh=aTSslCZyozdCGivbx5r76KIeY7cZHhQDX3dTCKvRL8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g98YxxQL76v1ksAMUH72w+FaM3p5/fVYZRQ0gTYzidfV9QoITTPPCHByHR+UBWzNG
	 GhKTGW3+UO9N/OQa8nhNbBs5oz1F1CARCyzYMHIlfDcnmygEjXDSptT67rkmYgBZZC
	 lMjkrlpP/XpQpclgxwQHV6JvKpQF2mJ7085WmSIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbfB1P0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388007AbfB1PLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:11:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 375D12171F;
        Thu, 28 Feb 2019 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366692;
        bh=aTSslCZyozdCGivbx5r76KIeY7cZHhQDX3dTCKvRL8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fekcJyRExmAX25ejby+u9zUzuOB1GkFpN87TUiELaa5AVi6bT8cmoH3s1iLjH4rsw
         +2Jd67MfFaNTB5blSACEOZi+yqOA6DWbO4ptMrMOMAWAGr+Q7MTtG2Z3fCfx0aJc3u
         GNm1EwyWJtb4w/6zaWL6DFf6vujbBhnEM54AG9Hk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/64] bpftool: fix percpu maps updating
Date:   Thu, 28 Feb 2019 10:10:15 -0500
Message-Id: <20190228151105.11277-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
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
index b455930a3eaf7..ec73d83d0d310 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -370,6 +370,20 @@ static char **parse_bytes(char **argv, const char *name, unsigned char *val,
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
@@ -449,6 +463,8 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 			argv = parse_bytes(argv, "value", value, value_size);
 			if (!argv)
 				return -1;
+
+			fill_per_cpu_value(info, value);
 		}
 
 		return parse_elem(argv, info, key, NULL, key_size, value_size,
-- 
2.19.1

