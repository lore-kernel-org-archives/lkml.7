Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B823BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89940206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412624;
	bh=aKXRrn6sj0WuqyG8GfeNQcXf+rRQREHrWtu6xVGGUOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q5/uJpm4TspJP9qQYh0Cj/ykvPiJv8yKeRph2juGi00KFjbG5hcp0GCW/ewOzz8Dn
	 lnC/+0UF60vbkSTX6RbEEBCJdZSb5lGFqr0sSXWx5rG7+RwZGJargju1tnNabEUX7f
	 hYMPMII/RFCTxlrYU+9ciCG8g7wh1wD5cLnVgZRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfCLRPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfCLRO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:56 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4D1217D8;
        Tue, 12 Mar 2019 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410895;
        bh=aKXRrn6sj0WuqyG8GfeNQcXf+rRQREHrWtu6xVGGUOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWSMTIhLwYuLguyUPECzYFAg+ZnelI52yiG931x98PUNE7QhNeLA9ekrX7l8+PYqK
         51oZMythE6cTKXKmXqN2OKvFRamJua9zWqiMVchplnDgKO+I1gygdSPGrIzuCU2DJM
         cgl92h/whyV+dZQh8SNoOBqop68nqEgxgLmF2Azk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 075/149] bpftool: fix percpu maps updating
Date:   Tue, 12 Mar 2019 10:08:13 -0700
Message-Id: <20190312170355.901029609@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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
index b455930a3eaf..ec73d83d0d31 100644
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



