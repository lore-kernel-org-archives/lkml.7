Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9148C004E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968E320665
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 20:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKyqjXW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfF0UYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 16:24:51 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:45651 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF0UYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:46 -0400
Received: by mail-qt1-f201.google.com with SMTP id k8so3644628qtb.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rj82FQVe1sxehS1oKg3PuFxZ1lm7MWUrxe2hdxNBH9E=;
        b=wKyqjXW+i8bJU7mw8YLb9CipelcwkZ19jDfD8mhZg6zX8WN7guD9x4twWyioOsfUr5
         B8Catk+137ZQ7uAvobbbPYWcGnPjhZQVvEhjSxL5YMiRhzw43C3kQEcdh4Y/fAvahwQK
         YmwmH2G6+6sOi+6VRubL8X/3UYMrcUvESFFkh+FJ6ZkZVrePX+V7sYg2175Rqs7N6+GT
         3D1d57hURzUbUDHOHRBQaXuBjMUZazLLoSV2zoMqsPqCYiHwMYCNe+fA51dDwgE5XYlI
         rxM0/YCNJRGtfDdyW1VYd8nC80yvPJn2awyYjbqsrRtiuMrYLzuonr7bk+51Rd+YZhMH
         2qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rj82FQVe1sxehS1oKg3PuFxZ1lm7MWUrxe2hdxNBH9E=;
        b=hDZTxQ1fRLmvdIRs+UQUBB/GL4KCRZA4S6JScKQaTRpZR3W52x5L7w5kEXywvJ9lkr
         DUVIMZNu3AAhruKac6kZHbaZzCUbgbaqx+uBigzJPoMW5r8W4D1uTj9h1wkS14aG/vJQ
         k7+pmXJJMNTQI4ZStse6YwXbNpmOZdYRbRkxW1ITVwwUYBYb7MPWRx+VbpdjZHR6lZMV
         yWUbT2L3R3PwXmPOF1IOXQU+BUs4jrt1vZ/Z05nQrBAcKWKSGs644leg+p1Z9J6cm3W4
         /MqJH1SmWhft3dclJcY5cAnBJY46armkG+2urKx3rJODEkp+TjTO4X0SU9C/R1G8lvhz
         lmCA==
X-Gm-Message-State: APjAAAWQTbZzyj70YC84UENeqQA62LDfZ5EAVd8T3MMG37ObsSlvJmnc
        lLj638b67WXbDm0ksRTeXyTUszfQ05T7
X-Google-Smtp-Source: APXvYqyEx2JvpFtb0XDaNb/UJuj+ePHHrHd1stzhIltAxRVHyo6iTgdwWNGv/o4Ckyvhgx9frP6Wu+rgGz35
X-Received: by 2002:ac8:3f55:: with SMTP id w21mr4914843qtk.217.1561667085274;
 Thu, 27 Jun 2019 13:24:45 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:16 -0700
In-Reply-To: <20190627202417.33370-1-brianvv@google.com>
Message-Id: <20190627202417.33370-6-brianvv@google.com>
Mime-Version: 1.0
References: <20190627202417.33370-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH bpf-next v2 5/6] selftests/bpf: test BPF_MAP_DUMP command
 on a bpf hashmap
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tests exercise the new command on a bpf hashmap and make sure it
works as expected.

Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/testing/selftests/bpf/test_maps.c | 70 ++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index a3fbc571280a9..3df72b46fd1d9 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -309,6 +309,73 @@ static void test_hashmap_walk(unsigned int task, void *data)
 	close(fd);
 }
 
+static void test_hashmap_dump(void)
+{
+	int fd, i, max_entries = 3;
+	uint64_t keys[max_entries], values[max_entries];
+	uint64_t key, value, next_key;
+	bool next_key_valid = true;
+	void *buf, *elem, *prev_key;
+	u32 buf_len;
+	const int elem_size = sizeof(key) + sizeof(value);
+
+	fd = helper_fill_hashmap(max_entries);
+
+	// Get the elements in the hashmap, and store them in that order
+	assert(bpf_map_get_next_key(fd, NULL, &key) == 0);
+	i = 0;
+	keys[i] = key;
+	for (i = 1; next_key_valid; i++) {
+		next_key_valid = bpf_map_get_next_key(fd, &key, &next_key) == 0;
+		assert(bpf_map_lookup_elem(fd, &key, &values[i - 1]) == 0);
+		keys[i-1] = key;
+		key = next_key;
+	}
+
+	// Alloc memory for the whole table
+	buf = malloc(elem_size * max_entries);
+	assert(buf != NULL);
+
+	// Check that buf_len < elem_size returns EINVAL
+	buf_len = elem_size-1;
+	errno = 0;
+	assert(bpf_map_dump(fd, NULL, buf, &buf_len) == -1 && errno == EINVAL);
+
+	// Check that it returns the first two elements
+	errno = 0;
+	buf_len = elem_size * 2;
+	prev_key = NULL;
+	i = 0;
+	assert(bpf_map_dump(fd, prev_key, buf, &buf_len) == 0 &&
+	       buf_len == 2*elem_size);
+	elem = buf;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+	elem = buf + elem_size;
+	i++;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+	i++;
+
+	/* Continue reading from map and verify buf_len only contains 1 element
+	 * even though buf_len is 2 elem_size.
+	 */
+	prev_key = elem;
+	assert(bpf_map_dump(fd, prev_key, buf, &buf_len) == 0 &&
+	       buf_len == elem_size);
+	elem = buf;
+	assert((*(uint64_t *)elem) == keys[i] &&
+	       (*(uint64_t *)(elem + sizeof(key))) == values[i]);
+
+	// Check that there are no more entries after last_key
+	prev_key = &keys[i];
+	assert(bpf_map_dump(fd, prev_key, buf, &buf_len) == -1 &&
+	       errno == ENOENT);
+
+	free(buf);
+	close(fd);
+}
+
 static void test_hashmap_zero_seed(void)
 {
 	int i, first, second, old_flags;
@@ -1668,6 +1735,7 @@ static void run_all_tests(void)
 	test_hashmap_percpu(0, NULL);
 	test_hashmap_walk(0, NULL);
 	test_hashmap_zero_seed();
+	test_hashmap_dump();
 
 	test_arraymap(0, NULL);
 	test_arraymap_percpu(0, NULL);
@@ -1705,11 +1773,9 @@ int main(void)
 
 	map_flags = BPF_F_NO_PREALLOC;
 	run_all_tests();
-
 #define CALL
 #include <map_tests/tests.h>
 #undef CALL
-
 	printf("test_maps: OK, %d SKIPPED\n", skips);
 	return 0;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

