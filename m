Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7DAC33C9D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0738B22313
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 01:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4wKv6vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfKSBoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 20:44:38 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:52616 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKSBof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 20:44:35 -0500
Received: by mail-vk1-f202.google.com with SMTP id x1so9164546vkc.19
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 17:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aqBvLu1rnkEBdBpvuDt45z3oeY9GzgLcLn2OH9iC7Tg=;
        b=f4wKv6vcNuAz0VzYEg9FQDrKH0mna+IfhBoW9pWHf/17VmQ6Kxzwei4DOAkgh10ye7
         B3kHwZdH+x48BqQKyB+aE1oN9cwSPt8ry2T6T9l52I75HLlmpkLlRauU6xSKTH6xQmF2
         O3qLLPvJgGaCmQJCmRMtumG8JAwimE2Ap1t/aGFknevSnYL0zzN7zqIFivUyapH5ZNwF
         sL4LAwJ4aWMstGf+jxgQ77qTR4/PajJk8oBFbSW+Dj6OVrKcD7ilFTo4sFs5ZT5/4Kgx
         REP7TChbLjV2Aga4pLdXhapF00D0Gb3YYnzyUyBGxNwo1NgzjSDNlUhrzI32n8sEUcBT
         LsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aqBvLu1rnkEBdBpvuDt45z3oeY9GzgLcLn2OH9iC7Tg=;
        b=QGQ6aUZApsDslLfKTFy9YDVLJt7gFXFgYx6n1qnSXfx/mC2El+bwTyTJY7kp1OznKt
         UfLN5niMaFvBhviNGbNxEb9DSnrnZ3Pir70qJHNkROjazFDMmTOXMt8O9ESgk26r98Bt
         UKnLejB5ezQaK0dvUd959Ny0UdtMZDtYbDPiThHVf3oovnYeipUjGr+VGGoZklCa8zDn
         V/vmx9gzR9all6xM1B9fuHkBFC0C/FtSE8C7Il26fgumHFvpFjmQuZExo0Lw6l4lq379
         M3NoocnKz1DgFpAodwGXIIfZelizi+eL5oiV2TffBg/IRh7bmDNToaYrHYgn6lLfaam2
         5SNQ==
X-Gm-Message-State: APjAAAWOOoGCwueuhH3OrFlgNsVB3YgaUUiMwrq1rUPWsocYtaSpg+1C
        shm9GWnxRubO0efzolWGXaGzvc7Q5dBa
X-Google-Smtp-Source: APXvYqzZkY2yHLOCjDQ4+90svAsK4wnP0hfk6U8NDHmQ6zMCWL7qtdF9MWRs5j/RlMB55rjWxxRp6Pv1tIkf
X-Received: by 2002:ab0:608b:: with SMTP id i11mr19896976ual.111.1574127874118;
 Mon, 18 Nov 2019 17:44:34 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:43:56 -0800
In-Reply-To: <20191119014357.98465-1-brianvv@google.com>
Message-Id: <20191119014357.98465-9-brianvv@google.com>
Mime-Version: 1.0
References: <20191119014357.98465-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH bpf-next 8/9] selftests/bpf: add batch ops testing for hmap
 and hmap_percpu
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

Tested bpf_map_lookup_and_delete_batch() and bpf_map_update_batch()
functionality.
  $ ./test_maps
    ...
      test_hmap_lookup_and_delete_batch:PASS
      test_pcpu_hmap_lookup_and_delete_batch:PASS
    ...

Co-authored-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../map_lookup_and_delete_batch_htab.c        | 257 ++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_htab.c

diff --git a/tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_htab.c b/tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_htab.c
new file mode 100644
index 0000000000000..93e024cb85c60
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/map_lookup_and_delete_batch_htab.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook  */
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <bpf_util.h>
+#include <test_maps.h>
+
+static void map_batch_update(int map_fd, __u32 max_entries, int *keys,
+			     void *values, bool is_pcpu)
+{
+	typedef BPF_DECLARE_PERCPU(int, value);
+	int i, j, err;
+	value *v;
+
+	if (is_pcpu)
+		v = (value *)values;
+
+	for (i = 0; i < max_entries; i++) {
+		keys[i] = i + 1;
+		if (is_pcpu)
+			for (j = 0; j < bpf_num_possible_cpus(); j++)
+				bpf_percpu(v[i], j) = i + 2 + j;
+		else
+			((int *)values)[i] = i + 2;
+	}
+
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, 0, 0);
+	CHECK(err, "bpf_map_update_batch()", "error:%s\n", strerror(errno));
+}
+
+static void map_batch_verify(int *visited, __u32 max_entries,
+			     int *keys, void *values, bool is_pcpu)
+{
+	typedef BPF_DECLARE_PERCPU(int, value);
+	value *v;
+	int i, j;
+
+	if (is_pcpu)
+		v = (value *)values;
+
+	memset(visited, 0, max_entries * sizeof(*visited));
+	for (i = 0; i < max_entries; i++) {
+
+		if (is_pcpu) {
+			for (j = 0; j < bpf_num_possible_cpus(); j++) {
+				CHECK(keys[i] + 1 + j != bpf_percpu(v[i], j),
+				      "key/value checking",
+				      "error: i %d j %d key %d value %d\n",
+				      i, j, keys[i], bpf_percpu(v[i],  j));
+			}
+		} else {
+			CHECK(keys[i] + 1 != ((int *)values)[i],
+			      "key/value checking",
+			      "error: i %d key %d value %d\n", i, keys[i],
+			      ((int *)values)[i]);
+		}
+
+		visited[i] = 1;
+
+	}
+	for (i = 0; i < max_entries; i++) {
+		CHECK(visited[i] != 1, "visited checking",
+		      "error: keys array at index %d missing\n", i);
+	}
+}
+
+void __test_map_lookup_and_delete_batch(bool is_pcpu)
+{
+	int map_type = is_pcpu ? BPF_MAP_TYPE_PERCPU_HASH : BPF_MAP_TYPE_HASH;
+	struct bpf_create_map_attr xattr = {
+		.name = "hash_map",
+		.map_type = map_type,
+		.key_size = sizeof(int),
+		.value_size = sizeof(int),
+	};
+	typedef BPF_DECLARE_PERCPU(int, value);
+	int map_fd, *keys, *visited, key;
+	__u32 batch = 0, count, total, total_success;
+	const __u32 max_entries = 10;
+	int err, i, step, value_size;
+	value pcpu_values[10];
+	bool nospace_err;
+	void *values;
+
+	xattr.max_entries = max_entries;
+	map_fd = bpf_create_map_xattr(&xattr);
+	CHECK(map_fd == -1,
+	      "bpf_create_map_xattr()", "error:%s\n", strerror(errno));
+
+	value_size = is_pcpu ? sizeof(value) : sizeof(int);
+	keys = malloc(max_entries * sizeof(int));
+	if (is_pcpu)
+		values = pcpu_values;
+	else
+		values = malloc(max_entries * sizeof(int));
+	visited = malloc(max_entries * sizeof(int));
+	CHECK(!keys || !values || !visited, "malloc()",
+	      "error:%s\n", strerror(errno));
+
+	/* test 1: lookup/delete an empty hash table, -ENOENT */
+	count = max_entries;
+	err = bpf_map_lookup_and_delete_batch(map_fd, NULL, &batch, keys,
+					      values, &count, 0, 0);
+	CHECK((err && errno != ENOENT), "empty map",
+	      "error: %s\n", strerror(errno));
+
+	/* populate elements to the map */
+	map_batch_update(map_fd, max_entries, keys, values, is_pcpu);
+
+	/* test 2: lookup/delete with count = 0, success */
+	batch = 0;
+	count = 0;
+	err = bpf_map_lookup_and_delete_batch(map_fd, NULL, &batch, keys,
+					      values, &count, 0, 0);
+	CHECK(err, "count = 0", "error: %s\n", strerror(errno));
+
+	/* test 3: lookup/delete with count = max_entries, success */
+	memset(keys, 0, max_entries * sizeof(*keys));
+	memset(values, 0, max_entries * value_size);
+	count = max_entries;
+	batch = 0;
+	err = bpf_map_lookup_and_delete_batch(map_fd, NULL, &batch, keys,
+					      values, &count, 0, 0);
+	CHECK((err && errno != ENOENT), "count = max_entries",
+	       "error: %s\n", strerror(errno));
+	CHECK(count != max_entries, "count = max_entries",
+	      "count = %u, max_entries = %u\n", count, max_entries);
+	map_batch_verify(visited, max_entries, keys, values, is_pcpu);
+
+	/* bpf_map_get_next_key() should return -ENOENT for an empty map. */
+	err = bpf_map_get_next_key(map_fd, NULL, &key);
+	CHECK(!err, "bpf_map_get_next_key()", "error: %s\n", strerror(errno));
+
+	/* test 4: lookup/delete in a loop with various steps. */
+	total_success = 0;
+	for (step = 1; step < max_entries; step++) {
+		map_batch_update(map_fd, max_entries, keys, values, is_pcpu);
+		memset(keys, 0, max_entries * sizeof(*keys));
+		memset(values, 0, max_entries * value_size);
+		batch = 0;
+		total = 0;
+		i = 0;
+		/* iteratively lookup/delete elements with 'step'
+		 * elements each
+		 */
+		count = step;
+		nospace_err = false;
+		while (true) {
+			err = bpf_map_lookup_batch(map_fd,
+						   total ? &batch : NULL,
+						   &batch, keys + total,
+						   values +
+						   total * value_size,
+						   &count, 0, 0);
+			/* It is possible that we are failing due to buffer size
+			 * not big enough. In such cases, let us just exit and
+			 * go with large steps. Not that a buffer size with
+			 * max_entries should always work.
+			 */
+			if (err && errno == ENOSPC) {
+				nospace_err = true;
+				break;
+			}
+
+
+			CHECK((err && errno != ENOENT), "lookup with steps",
+			      "error: %s\n", strerror(errno));
+
+			total += count;
+			if (err)
+				break;
+
+			i++;
+		}
+		if (nospace_err == true)
+			continue;
+
+		CHECK(total != max_entries, "lookup with steps",
+		      "total = %u, max_entries = %u\n", total, max_entries);
+		map_batch_verify(visited, max_entries, keys, values, is_pcpu);
+
+		memset(keys, 0, max_entries * sizeof(*keys));
+		memset(values, 0, max_entries * value_size);
+		batch = 0;
+		total = 0;
+		i = 0;
+		/* iteratively lookup/delete elements with 'step'
+		 * elements each
+		 */
+		count = step;
+		nospace_err = false;
+		while (true) {
+			err = bpf_map_lookup_and_delete_batch(map_fd,
+							total ? &batch : NULL,
+							&batch, keys + total,
+							values +
+							total * value_size,
+							&count, 0, 0);
+			/* It is possible that we are failing due to buffer size
+			 * not big enough. In such cases, let us just exit and
+			 * go with large steps. Not that a buffer size with
+			 * max_entries should always work.
+			 */
+			if (err && errno == ENOSPC) {
+				nospace_err = true;
+				break;
+			}
+
+			CHECK((err && errno != ENOENT), "lookup with steps",
+			      "error: %s\n", strerror(errno));
+
+			total += count;
+			if (err)
+				break;
+			i++;
+		}
+
+		if (nospace_err == true)
+			continue;
+
+		CHECK(total != max_entries, "lookup/delete with steps",
+		      "total = %u, max_entries = %u\n", total, max_entries);
+
+		map_batch_verify(visited, max_entries, keys, values, is_pcpu);
+		err = bpf_map_get_next_key(map_fd, NULL, &key);
+		CHECK(!err, "bpf_map_get_next_key()", "error: %s\n",
+		      strerror(errno));
+
+		total_success++;
+	}
+
+	CHECK(total_success == 0, "check total_success",
+	      "unexpected failure\n");
+}
+
+void test_hmap_lookup_and_delete_batch(void)
+{
+	__test_map_lookup_and_delete_batch(false);
+	printf("%s:PASS\n", __func__);
+}
+
+void test_pcpu_hmap_lookup_and_delete_batch(void)
+{
+	__test_map_lookup_and_delete_batch(true);
+	printf("%s:PASS\n", __func__);
+}
+
+void test_map_lookup_and_delete_batch_htab(void)
+{
+	test_hmap_lookup_and_delete_batch();
+	test_pcpu_hmap_lookup_and_delete_batch();
+}
-- 
2.24.0.432.g9d3f5f5b63-goog

