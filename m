Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D92C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE1120679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 23:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2RSo9cQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfFXXy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 19:54:29 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:32853 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfFXXy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:54:26 -0400
Received: by mail-pg1-f201.google.com with SMTP id k19so9984081pgl.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AvvLLB8A0iI06VA1j5j+vTzVvGJk1Op1AW1IdCduR9s=;
        b=d2RSo9cQKKRl25dOdBfsnDGGnscSwocpRAZHDyvnt1bBP7dwHv42asBe/d+0Ds6i81
         ZWymcTFiQfAKuNWZbOn1OUNGduNzPn68gzYy+U35A9g+9sYIVrtM71mfNksILgO1KG83
         VoF1M16yTp/ru9dF9p/W+8/NV3uHjULkK4mPrEI47cfj0Xa+g2+g6APL6cWkkwXMf5P+
         bNxH0aMivTI0wnlnxx30oc4HKpAeC9KQNlzFvnIORzVefzR7uLGiq1OTs7m2OsHI+q7Z
         eeNvy2hLpZA9vlj6X54rklzqoRd29M+ryKil+epJ/peGGwSVLQNVIQRaJHJBtWuX17L0
         bpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AvvLLB8A0iI06VA1j5j+vTzVvGJk1Op1AW1IdCduR9s=;
        b=tHYGBFbg9ys6t8kmMf4vCy5RtOFfCVc+77HQ81gBsDeFH2gSmlX9VBbHA2Mt4UiU6u
         nHOwqGp86k4QSckHRyIdLuAXuOFXauTlneAM3V9s0CWuvAonyAkfz6BRzZku+iAs9VLW
         FdYIwhul25A6ZEov8HZ2UCKeiqTY69SXHkXkEJEAXazvHefw5kzPylT+GGSydOtpXPmz
         rwrRzQ9cwlKA5LFwnhh/Ntyn+31rSUQLNjiWQLVQnvPqS00tqUwP+y5qlfmhsTycBxEM
         KabNB/xVQJYZonPSoeB0uX4VoGPGFnrA/yWJ1yFny9j8L6YvDz8cab9lT461jb9wmBq5
         SRGQ==
X-Gm-Message-State: APjAAAVtkAScNxy6aKDiTijLdV7+fxfmeoP8gway2IN+4TGiRJ1sDrRQ
        +a4RQYSnBsbO4Rs5rXIGTkRYEkLMee2875C8
X-Google-Smtp-Source: APXvYqy3tf2tgcg+3AbUDyuSDF3KqZ35zHB9n5kMNHN0ZX8wDh39dhhjehDYDTlvGLyiC0ihFN0DsdtBmevDdu95
X-Received: by 2002:a63:e53:: with SMTP id 19mr35160885pgo.137.1561420465274;
 Mon, 24 Jun 2019 16:54:25 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:53:34 -0700
In-Reply-To: <20190624235334.163625-1-allanzhang@google.com>
Message-Id: <20190624235334.163625-3-allanzhang@google.com>
Mime-Version: 1.0
References: <20190624235334.163625-1-allanzhang@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v2 2/2] bpf: Add selftests for bpf_perf_event_output
From:   allanzhang <allanzhang@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     allanzhang <allanzhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software event output is only enabled by a few prog types.
This test is to ensure that all supported types are enbled for
bpf_perf_event_output sucessfully.

Signed-off-by: allanzhang <allanzhang@google.com>
---
 tools/testing/selftests/bpf/test_verifier.c   | 33 ++++++-
 .../selftests/bpf/verifier/event_output.c     | 94 +++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/event_output.c

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c5514daf8865..901a188e1eea 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -50,7 +50,7 @@
 #define MAX_INSNS	BPF_MAXINSNS
 #define MAX_TEST_INSNS	1000000
 #define MAX_FIXUPS	8
-#define MAX_NR_MAPS	18
+#define MAX_NR_MAPS	19
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
@@ -84,6 +84,7 @@ struct bpf_test {
 	int fixup_map_array_wo[MAX_FIXUPS];
 	int fixup_map_array_small[MAX_FIXUPS];
 	int fixup_sk_storage_map[MAX_FIXUPS];
+	int fixup_map_event_output[MAX_FIXUPS];
 	const char *errstr;
 	const char *errstr_unpriv;
 	uint32_t retval, retval_unpriv, insn_processed;
@@ -604,6 +605,28 @@ static int create_sk_storage_map(void)
 	return fd;
 }
 
+static int create_event_output_map(void)
+{
+	struct bpf_create_map_attr attr = {
+		.name = "test_map",
+		.map_type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+		.key_size = 4,
+		.value_size = 4,
+		.max_entries = 1,
+	};
+	int fd, btf_fd;
+
+	btf_fd = load_btf();
+	if (btf_fd < 0)
+		return -1;
+	attr.btf_fd = btf_fd;
+	fd = bpf_create_map_xattr(&attr);
+	close(attr.btf_fd);
+	if (fd < 0)
+		printf("Failed to create event_output\n");
+	return fd;
+}
+
 static char bpf_vlog[UINT_MAX >> 8];
 
 static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
@@ -627,6 +650,7 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	int *fixup_map_array_wo = test->fixup_map_array_wo;
 	int *fixup_map_array_small = test->fixup_map_array_small;
 	int *fixup_sk_storage_map = test->fixup_sk_storage_map;
+	int *fixup_map_event_output = test->fixup_map_event_output;
 
 	if (test->fill_helper) {
 		test->fill_insns = calloc(MAX_TEST_INSNS, sizeof(struct bpf_insn));
@@ -788,6 +812,13 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 			fixup_sk_storage_map++;
 		} while (*fixup_sk_storage_map);
 	}
+	if (*fixup_map_event_output) {
+		map_fds[18] = create_event_output_map();
+		do {
+			prog[*fixup_map_event_output].imm = map_fds[18];
+			fixup_map_event_output++;
+		} while (*fixup_map_event_output);
+	}
 }
 
 static int set_admin(bool admin)
diff --git a/tools/testing/selftests/bpf/verifier/event_output.c b/tools/testing/selftests/bpf/verifier/event_output.c
new file mode 100644
index 000000000000..b25eabcfaa56
--- /dev/null
+++ b/tools/testing/selftests/bpf/verifier/event_output.c
@@ -0,0 +1,94 @@
+/* instructions used to output a skb based software event, produced
+ * from code snippet:
+struct TMP {
+  uint64_t tmp;
+} tt;
+tt.tmp = 5;
+bpf_perf_event_output(skb, &connection_tracking_event_map, 0,
+		      &tt, sizeof(tt));
+return 1;
+
+the bpf assembly from llvm is:
+       0:       b7 02 00 00 05 00 00 00         r2 = 5
+       1:       7b 2a f8 ff 00 00 00 00         *(u64 *)(r10 - 8) = r2
+       2:       bf a4 00 00 00 00 00 00         r4 = r10
+       3:       07 04 00 00 f8 ff ff ff         r4 += -8
+       4:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00    r2 = 0ll
+       6:       b7 03 00 00 00 00 00 00         r3 = 0
+       7:       b7 05 00 00 08 00 00 00         r5 = 8
+       8:       85 00 00 00 19 00 00 00         call 25
+       9:       b7 00 00 00 01 00 00 00         r0 = 1
+      10:       95 00 00 00 00 00 00 00         exit
+
+    The reason I put the code here instead of fill_helpers is that map fixup is
+    against the insns, instead of filled prog.
+*/
+
+#define __PERF_EVENT_INSNS__					\
+	BPF_MOV64_IMM(BPF_REG_2, 5),				\
+	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -8),		\
+	BPF_MOV64_REG(BPF_REG_4, BPF_REG_10),			\
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, -8),			\
+	BPF_LD_MAP_FD(BPF_REG_2, 0),				\
+	BPF_MOV64_IMM(BPF_REG_3, 0),				\
+	BPF_MOV64_IMM(BPF_REG_5, 8),				\
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,		\
+		     BPF_FUNC_perf_event_output),		\
+	BPF_MOV64_IMM(BPF_REG_0, 1),				\
+	BPF_EXIT_INSN(),
+{
+	"perfevent for sockops",
+	.insns = { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for tc",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for lwt out",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_LWT_OUT,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for xdp",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_XDP,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for socket filter",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for sk_skb",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_SK_SKB,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
+{
+	"perfevent for cgroup skb",
+	.insns =  { __PERF_EVENT_INSNS__ },
+	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
+	.fixup_map_event_output = { 4 },
+	.result = ACCEPT,
+	.retval = 1,
+},
-- 
2.22.0.410.gd8fdbe21b5-goog

