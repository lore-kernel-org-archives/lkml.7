Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A65C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7906824656
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UhpSPxPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLKWfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:35:04 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54048 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfLKWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:53 -0500
Received: by mail-pf1-f202.google.com with SMTP id x26so16332pfa.20
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R6dm7VkIBCoESXL6sSnd11Wq7sihsZ1CHqqH3rADAoc=;
        b=UhpSPxPSDsCYUCJsQgh/i6mD6Bv+fWxlFhFp0nolX5H4NDTAH6NygKnXx93hIl/kpv
         OLhohgHYIa/FNk9CvD/gwJk3Wj3826a4vgorh0FV7R18/bvqynqZSEojai1262uxZtB5
         uoX+LSVgVHplxRqXV+8HVpo6i8JdfTvifgUMX2qbYYHNAJnk0SrV7X0Qz24irarQx/ns
         BbmVZxNfHmbHojBz5UjbJLuMp+0ZafUR/JQzEs4M79hmGtvPQDvD7O+Vu13j4lUL7Z7T
         w6gh/amokEQXmgNx3O8Xr0WIj3/AFl+ryVz6fAJiAve4Z2DXpWvWnLngQfX5Ld9S3fI2
         Asag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R6dm7VkIBCoESXL6sSnd11Wq7sihsZ1CHqqH3rADAoc=;
        b=UbBnw3kzxzGF3XVKvaHlY2LMZIXKCb1oaIRBete+Pnrbqy1ooUTsj7xoFGl5W+xt8J
         LZ1RWS8pV16h/qnGcbR1CQb7kfhwaw2cLQEHejEkUU0Myi9FFFD6AMxDiWcfyL1VS7bp
         +WXIpRPvsTxDH5BW8tUgyk4672M+V0UQkgYC+cq5ce6IeVoOJ679kd4RIpfn8kBXdKo6
         aJrl1JoDE+v4o6QgFDesipWSUnZpUslYHVaQVG8k7HldR7z2Ui0m7FpEh1fGJXdVQ0s0
         B7HnNW4U6SMsXDTAR4hSBzQj5Y/JddTawBKo89OWVnczDGyAtsi3f5k7Zv26ppN3Sl85
         h76A==
X-Gm-Message-State: APjAAAU9FBTIwlGfNBfGTa68CxjXNshujf+6ztikxFdaueIoffNoJyLi
        2BdgWQw0tPa0RezsnsC2Vg2YdyQoU1qa
X-Google-Smtp-Source: APXvYqwxWIkn8Frtxa8ioW8GPQJd2PBBqJKiPcPRPrtk7v8h+HP5UNtZE7qIDmZzINK6j3mYmR6xfvhoecCU
X-Received: by 2002:a63:214e:: with SMTP id s14mr6779867pgm.428.1576103692028;
 Wed, 11 Dec 2019 14:34:52 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:43 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-11-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 10/11] selftests/bpf: add batch ops testing to
 array bpf map
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested bpf_map_lookup_batch() and bpf_map_update_batch()
functionality.

  $ ./test_maps
      ...
        test_array_map_batch_ops:PASS
      ...

Signed-off-by: Brian Vazquez <brianvv@google.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../bpf/map_tests/array_map_batch_ops.c       | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c

diff --git a/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
new file mode 100644
index 0000000000000..ed90bfd03d762
--- /dev/null
+++ b/tools/testing/selftests/bpf/map_tests/array_map_batch_ops.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include <test_maps.h>
+
+static void map_batch_update(int map_fd, __u32 max_entries, int *keys,
+			     int *values)
+{
+	int i, err;
+
+	for (i = 0; i < max_entries; i++) {
+		keys[i] = i;
+		values[i] = i + 1;
+	}
+
+	err = bpf_map_update_batch(map_fd, keys, values, &max_entries, 0, 0);
+	CHECK(err, "bpf_map_update_batch()", "error:%s\n", strerror(errno));
+}
+
+static void map_batch_verify(int *visited, __u32 max_entries,
+			     int *keys, int *values)
+{
+	int i;
+
+	memset(visited, 0, max_entries * sizeof(*visited));
+	for (i = 0; i < max_entries; i++) {
+		CHECK(keys[i] + 1 != values[i], "key/value checking",
+		      "error: i %d key %d value %d\n", i, keys[i], values[i]);
+		visited[i] = 1;
+	}
+	for (i = 0; i < max_entries; i++) {
+		CHECK(visited[i] != 1, "visited checking",
+		      "error: keys array at index %d missing\n", i);
+	}
+}
+
+void test_array_map_batch_ops(void)
+{
+	struct bpf_create_map_attr xattr = {
+		.name = "array_map",
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = sizeof(int),
+		.value_size = sizeof(int),
+	};
+	int map_fd, *keys, *values, *visited;
+	__u32 count, total, total_success;
+	const __u32 max_entries = 10;
+	int err, i, step;
+	bool nospace_err;
+	__u64 batch = 0;
+
+	xattr.max_entries = max_entries;
+	map_fd = bpf_create_map_xattr(&xattr);
+	CHECK(map_fd == -1,
+	      "bpf_create_map_xattr()", "error:%s\n", strerror(errno));
+
+	keys = malloc(max_entries * sizeof(int));
+	values = malloc(max_entries * sizeof(int));
+	visited = malloc(max_entries * sizeof(int));
+	CHECK(!keys || !values || !visited, "malloc()", "error:%s\n",
+	      strerror(errno));
+
+	/* populate elements to the map */
+	map_batch_update(map_fd, max_entries, keys, values);
+
+	/* test 1: lookup in a loop with various steps. */
+	total_success = 0;
+	for (step = 1; step < max_entries; step++) {
+		map_batch_update(map_fd, max_entries, keys, values);
+		memset(keys, 0, max_entries * sizeof(*keys));
+		memset(values, 0, max_entries * sizeof(*values));
+		batch = 0;
+		total = 0;
+		i = 0;
+		/* iteratively lookup/delete elements with 'step'
+		 * elements each.
+		 */
+		count = step;
+		nospace_err = false;
+		while (true) {
+			err = bpf_map_lookup_batch(map_fd,
+						total ? &batch : NULL, &batch,
+						keys + total,
+						values + total,
+						&count, 0, 0);
+
+			CHECK((err && errno != ENOENT), "lookup with steps",
+			      "error: %s\n", strerror(errno));
+
+			total += count;
+
+			if (err)
+				break;
+
+			i++;
+		}
+
+		if (nospace_err == true)
+			continue;
+
+		CHECK(total != max_entries, "lookup with steps",
+		      "total = %u, max_entries = %u\n", total, max_entries);
+
+		map_batch_verify(visited, max_entries, keys, values);
+
+		total_success++;
+	}
+
+	CHECK(total_success == 0, "check total_success",
+	      "unexpected failure\n");
+
+	printf("%s:PASS\n", __func__);
+}
-- 
2.24.1.735.g03f4e72817-goog

