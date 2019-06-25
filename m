Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C735C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F40204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="B0qKM/U4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfFYTm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:42:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36287 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbfFYTmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so18027345wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vuh+TLhBB0eIRHe2g95nOHI1s4ciRO5HgoaZCB54tSE=;
        b=B0qKM/U49PvsnjrR3PuiBZn8E2OIHXhNqRCZUOwb8Z2Dw+2MBibLdwsqij3E7iQWKn
         mLrzp6xa4uKLImcuISPwM8X0ADKpvNRhy4D7rqRXNZ4+rpFZG0hp7CW48EljQEWjI/39
         kKyv5DufztuCxwacO5OD8Pre1Y7vXeXuIFkLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vuh+TLhBB0eIRHe2g95nOHI1s4ciRO5HgoaZCB54tSE=;
        b=GKVnid00CA3+ZTYt50sAMjsm9HmnzW933Dxk64A6fwW0EmeD6SGWe80KeJT1LxY1Cr
         BjOrF5+K9ZVi5L76FLbi+ocwnIt2dO7iPIIJqOK6mSq9IeyIGX1Bnlm2zfUg9rLIF8w0
         hZAaX5lTA1/OnUJj+88h0uNnROHyGv44rEfwQQe2/8+cBDuOvdGDxdI6tHcl7f0jISGL
         D53lIEHevhh8jR0x2zifjv5o2b5RydPTFt1eOQ9JvcQ1JZNgdQiPcAb0qI0InPdXHI+5
         L37WwypuMB2Avg5rnsfGB3yZ8q0KT0AHrGAbUFEZJNh/KS8yxS6fdu9Q7tYdJfn9cVs+
         K+5g==
X-Gm-Message-State: APjAAAVCEb1oDOep/7CIb8GpMlAUJXnSAlk06lCDqlnXmDVlf4m5C8X1
        XdKH0qfvCdCa7D6S/ZZ+P3ZZYQ==
X-Google-Smtp-Source: APXvYqxqGo9JlAmM8HyzzX1Md5s/iJmfNbMuxbfMOH18JHLunAkywkrJAM1P6MugGJF3HhOxB1xxYw==
X-Received: by 2002:a05:6000:c9:: with SMTP id q9mr9743783wrx.208.1561491769960;
        Tue, 25 Jun 2019 12:42:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedb6.dynamic.kabel-deutschland.de. [95.90.237.182])
        by smtp.gmail.com with ESMTPSA id q193sm84991wme.8.2019.06.25.12.42.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 12:42:49 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     netdev@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v2 05/10] selftests/bpf: Allow passing more information to BPF prog test run
Date:   Tue, 25 Jun 2019 21:42:10 +0200
Message-Id: <20190625194215.14927-6-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625194215.14927-1-krzesimir@kinvolk.io>
References: <20190625194215.14927-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test case can specify a custom length of the data member, context
data and its length, which will be passed to
bpf_prog_test_run_xattr. For backward compatilibity, if the data
length is 0 (which is what will happen when the field is left
unspecified in the designated initializer of a struct), then the
length passed to the bpf_prog_test_run_xattr is TEST_DATA_LEN.

Also for backward compatilibity, if context data length is 0, NULL is
passed as a context to bpf_prog_test_run_xattr. This is to avoid
breaking other tests, where context data being NULL and context data
length being 0 is handled differently from the case where context data
is not NULL and context data length is 0.

Custom lengths still can't be greater than hardcoded 64 bytes for data
and 192 for context data.

192 for context data was picked to allow passing struct
bpf_perf_event_data as a context for perf event programs. The struct
is quite large, because it contains struct pt_regs.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 68 +++++++++++++++++++--
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index db1f0f758f81..05bad54f481f 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -54,6 +54,7 @@
 #define MAX_TEST_RUNS	8
 #define POINTER_VALUE	0xcafe4all
 #define TEST_DATA_LEN	64
+#define TEST_CTX_LEN	192
 
 #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
 #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
@@ -96,6 +97,9 @@ struct bpf_test {
 	enum bpf_prog_type prog_type;
 	uint8_t flags;
 	__u8 data[TEST_DATA_LEN];
+	__u32 data_len;
+	__u8 ctx[TEST_CTX_LEN];
+	__u32 ctx_len;
 	void (*fill_helper)(struct bpf_test *self);
 	uint8_t runs;
 	struct {
@@ -104,6 +108,9 @@ struct bpf_test {
 			__u8 data[TEST_DATA_LEN];
 			__u64 data64[TEST_DATA_LEN / 8];
 		};
+		__u32 data_len;
+		__u8 ctx[TEST_CTX_LEN];
+		__u32 ctx_len;
 	} retvals[MAX_TEST_RUNS];
 };
 
@@ -818,7 +825,7 @@ static int set_admin(bool admin)
 }
 
 static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
-			    void *data, size_t size_data)
+			    void *data, size_t size_data, void *ctx, size_t size_ctx)
 {
 	__u8 tmp[TEST_DATA_LEN << 2];
 	__u32 size_tmp = sizeof(tmp);
@@ -831,6 +838,8 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 		.data_size_in = size_data,
 		.data_out = tmp,
 		.data_size_out = size_tmp,
+		.ctx_in = ctx,
+		.ctx_size_in = size_ctx,
 	};
 
 	if (unpriv)
@@ -956,13 +965,39 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (!alignment_prevented_execution && fd_prog >= 0) {
 		uint32_t expected_val;
 		int i;
+		__u32 size_data;
+		__u32 size_ctx;
+		bool bad_size;
+		void *ctx;
 
 		if (!test->runs) {
+			if (test->data_len > 0)
+				size_data = test->data_len;
+			else
+				size_data = sizeof(test->data);
+			size_ctx = test->ctx_len;
+			bad_size = false;
 			expected_val = unpriv && test->retval_unpriv ?
 				test->retval_unpriv : test->retval;
 
-			err = do_prog_test_run(fd_prog, unpriv, expected_val,
-					       test->data, sizeof(test->data));
+			if (size_data > sizeof(test->data)) {
+				printf("FAIL: data size (%u) greater than TEST_DATA_LEN (%lu) ", size_data, sizeof(test->data));
+				bad_size = true;
+			}
+			if (size_ctx > sizeof(test->ctx)) {
+				printf("FAIL: ctx size (%u) greater than TEST_CTX_LEN (%lu) ", size_ctx, sizeof(test->ctx));
+				bad_size = true;
+			}
+			if (size_ctx)
+				ctx = test->ctx;
+			else
+				ctx = NULL;
+			if (bad_size)
+				err = 1;
+			else
+				err = do_prog_test_run(fd_prog, unpriv, expected_val,
+						       test->data, size_data,
+						       ctx, size_ctx);
 			if (err)
 				run_errs++;
 			else
@@ -970,14 +1005,35 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		}
 
 		for (i = 0; i < test->runs; i++) {
+			if (test->retvals[i].data_len > 0)
+				size_data = test->retvals[i].data_len;
+			else
+				size_data = sizeof(test->retvals[i].data);
+			size_ctx = test->retvals[i].ctx_len;
+			bad_size = false;
 			if (unpriv && test->retvals[i].retval_unpriv)
 				expected_val = test->retvals[i].retval_unpriv;
 			else
 				expected_val = test->retvals[i].retval;
 
-			err = do_prog_test_run(fd_prog, unpriv, expected_val,
-					       test->retvals[i].data,
-					       sizeof(test->retvals[i].data));
+			if (size_data > sizeof(test->retvals[i].data)) {
+				printf("FAIL: data size (%u) at run %i greater than TEST_DATA_LEN (%lu) ", size_data, i + 1, sizeof(test->retvals[i].data));
+				bad_size = true;
+			}
+			if (size_ctx > sizeof(test->retvals[i].ctx)) {
+				printf("FAIL: ctx size (%u) at run %i greater than TEST_CTX_LEN (%lu) ", size_ctx, i + 1, sizeof(test->retvals[i].ctx));
+				bad_size = true;
+			}
+			if (size_ctx)
+				ctx = test->retvals[i].ctx;
+			else
+				ctx = NULL;
+			if (bad_size)
+				err = 1;
+			else
+				err = do_prog_test_run(fd_prog, unpriv, expected_val,
+						       test->retvals[i].data, size_data,
+						       ctx, size_ctx);
 			if (err) {
 				printf("(run %d/%d) ", i + 1, test->runs);
 				run_errs++;
-- 
2.20.1

