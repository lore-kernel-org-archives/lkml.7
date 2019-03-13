Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7EBC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A399020693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504352;
	bh=TY+zVZ/4klUEczISMX9gft6iMeeZS9G6MXrHEdH5kSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mldckDA4/dIHnt8BGulRk6JgsGJdDDatmuwGiko0vNss1pRShIxSQDDc5xLxDdN2C
	 Aor/OgRy5vWg4Hw36reVm0M3VSZWzfvBk3QTMLw9cZhXmMNAdjf4MUdHdYkq8HjlCR
	 gBxnokPiV4W/0B3hTi2ELmFZpoEV3dsd6GdRSFGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfCMTMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfCMTM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99DF217F5;
        Wed, 13 Mar 2019 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504347;
        bh=TY+zVZ/4klUEczISMX9gft6iMeeZS9G6MXrHEdH5kSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfQBuXU2s0v4bkYhLta0hEVWQTyEdUdkGmzFEow47GtofnpcNYYeYSB+X+6uhyzkA
         TINWA9I2Cq336D46wqeoPgSFloKGEkSYORYs90FOFaWLRCuKmxz1To5AUNfMNKSGp6
         kEjOh+/ksEHkiH1oVD42bI81bZDLyCYkZBoSUrxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>, Craig Gallek <kraig@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 51/60] bpf, lpm: fix lookup bug in map_delete_elem
Date:   Wed, 13 Mar 2019 15:10:12 -0400
Message-Id: <20190313191021.158171-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

[ Upstream commit 7c0cdf0b3940f63d9777c3fcf250a2f83859ca54 ]

trie_delete_elem() was deleting an entry even though it was not matching
if the prefixlen was correct. This patch adds a check on matchlen.

Reproducer:

$ sudo bpftool map create /sys/fs/bpf/mylpm type lpm_trie key 8 value 1 entries 128 name mylpm flags 1
$ sudo bpftool map update pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 aa bb cc dd value hex 01
$ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
key: 10 00 00 00 aa bb cc dd  value: 01
Found 1 element
$ sudo bpftool map delete pinned /sys/fs/bpf/mylpm key hex 10 00 00 00 ff ff ff ff
$ echo $?
0
$ sudo bpftool map dump pinned /sys/fs/bpf/mylpm
Found 0 elements

A similar reproducer is added in the selftests.

Without the patch:

$ sudo ./tools/testing/selftests/bpf/test_lpm_map
test_lpm_map: test_lpm_map.c:485: test_lpm_delete: Assertion `bpf_map_delete_elem(map_fd, key) == -1 && errno == ENOENT' failed.
Aborted

With the patch: test_lpm_map runs without errors.

Fixes: e454cf595853 ("bpf: Implement map_delete_elem for BPF_MAP_TYPE_LPM_TRIE")
Cc: Craig Gallek <kraig@google.com>
Signed-off-by: Alban Crequy <alban@kinvolk.io>
Acked-by: Craig Gallek <kraig@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/lpm_trie.c                      |  1 +
 tools/testing/selftests/bpf/test_lpm_map.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 9058317ba9de..4f3138e6ecb2 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -432,6 +432,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 	}
 
 	if (!node || node->prefixlen != key->prefixlen ||
+	    node->prefixlen != matchlen ||
 	    (node->flags & LPM_TREE_NODE_FLAG_IM)) {
 		ret = -ENOENT;
 		goto out;
diff --git a/tools/testing/selftests/bpf/test_lpm_map.c b/tools/testing/selftests/bpf/test_lpm_map.c
index 147e34cfceb7..02d7c871862a 100644
--- a/tools/testing/selftests/bpf/test_lpm_map.c
+++ b/tools/testing/selftests/bpf/test_lpm_map.c
@@ -474,6 +474,16 @@ static void test_lpm_delete(void)
 	assert(bpf_map_lookup_elem(map_fd, key, &value) == -1 &&
 		errno == ENOENT);
 
+	key->prefixlen = 30; // unused prefix so far
+	inet_pton(AF_INET, "192.255.0.0", key->data);
+	assert(bpf_map_delete_elem(map_fd, key) == -1 &&
+		errno == ENOENT);
+
+	key->prefixlen = 16; // same prefix as the root node
+	inet_pton(AF_INET, "192.255.0.0", key->data);
+	assert(bpf_map_delete_elem(map_fd, key) == -1 &&
+		errno == ENOENT);
+
 	/* assert initial lookup */
 	key->prefixlen = 32;
 	inet_pton(AF_INET, "192.168.0.1", key->data);
-- 
2.19.1

