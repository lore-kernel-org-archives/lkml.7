Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40098C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AB7218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258642;
	bh=hzjXXs8xbRm9nyxnKzv9zVoVgPK+PlgRVrR9cFiHgxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4pY0q/JxQU8ClPECl7Qxa5OfK1Oidy92jkJwb0hPPQR3ftwWxZq90G55y8JyQpbq
	 I/6EgGrBHqX0oGbjL6Wf1uWm+9zPt4fKx4s4nNjUqFMb8ZnhMBCi0z8yPWTVFpwK3n
	 kwbhAVgidReo5DMuV3z4Qpm0h0odWfHc99gSdZAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbfCVMCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732217AbfCVMCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:02:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9353204FD;
        Fri, 22 Mar 2019 12:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256138;
        bh=hzjXXs8xbRm9nyxnKzv9zVoVgPK+PlgRVrR9cFiHgxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GF3Wy0MMBo389Nv1dT1bphSZX91oqV6iA/J3c7eW4PeM/Yze5NJj0kw++CBJ/3BqV
         tBI+bwelG3iA2htfC7EmtYOb1h2tVZ466ficrAzuUYXsF5GIt28agiPyoC9JPHdInA
         g0yzUcv/ursq8tE9PPqpzy86O8rmOSMV818J3aLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Craig Gallek <kraig@google.com>,
        Alban Crequy <alban@kinvolk.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 102/280] bpf, lpm: fix lookup bug in map_delete_elem
Date:   Fri, 22 Mar 2019 12:14:15 +0100
Message-Id: <20190322111312.336070173@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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



