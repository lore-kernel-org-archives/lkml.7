Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29DFC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E9E21743
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="AwysrBJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbfGHQb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:31:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35047 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388799AbfGHQbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so186000wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfapiFsE4OmxP9vMHIQmElH3PTxTJhdK3T96JsR6xmY=;
        b=AwysrBJC39iPhW8fSEU+3huktCPgPvzlgzNdwOdQrw+V5E8uP/wIg/Q0wCJVSkrQUJ
         Y12gYUKKE5NakL3+MVgJ2Fsu1guDhor2brgYw+CkRNveotznlgGG4HBX8Dk9thPw/Y5A
         6Xk42e56KAaitNCqYeA68tZW2ACB2UxzsxWm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfapiFsE4OmxP9vMHIQmElH3PTxTJhdK3T96JsR6xmY=;
        b=fBhMsDfGzl6exE+iYimCMdSXoR40ga9PlwaMtlYhA+bZoB3GL3FIDbej3sn9YG6G6s
         U5n3Xo1Ltkylxd1eWdEyrXLIKzDp3P4Ed3vSN+hNANL6IyVf7fUXFUry1BPAifgC7jef
         t4cZg1czFqt91rOXJ0VHK4N4ee8OzlNIiYWbzCm45vOuNwb53C4YuD+kcwwj/UXHt5fS
         iPns7qYYVk0ACvOHOgYkeSgtCm+bvzS/YAyz9ByAKd1CqC61Qf1Ikl7tSxxuw9uBrk1b
         /1OXKvTOwi6fuNUsYKYwCnKhwIiHQGnvfdJr18bzc95CvVTft5lJitSzBPPKkwAa+i4p
         Q9Xw==
X-Gm-Message-State: APjAAAXpIpeg2HeHOGw/pZQ1AeBcOc25XLf9iUi7xQgaZjyUHnX4dcTk
        3w2wgt3pDqPSgUBx5jQ+u5LMiE9a9zpM7g==
X-Google-Smtp-Source: APXvYqy4tMsGFA84bjXV72y0LxdF54qkE5Rr12cM5BrQCv2eDz3tBHn7eYNxh9WEPMBYW/RPdWOQtg==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr18325919wmi.78.1562603510047;
        Mon, 08 Jul 2019 09:31:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:49 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v3 03/12] selftests/bpf: Avoid another case of errno clobbering
Date:   Mon,  8 Jul 2019 18:31:12 +0200
Message-Id: <20190708163121.18477-4-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8184d44c9a57 ("selftests/bpf: skip verifier tests for
unsupported program types") added a check for an unsupported program
type. The function doing it changes errno, so test_verifier should
save it before calling it if test_verifier wants to print a reason why
verifying a BPF program of a supported type failed.

Changes since v2:
- Move the declaration to fit the reverse christmas tree style.

Fixes: 8184d44c9a57 ("selftests/bpf: skip verifier tests for unsupported program types")
Cc: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 3fe126e0083b..c7541f572932 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -864,6 +864,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int run_errs, run_successes;
 	int map_fds[MAX_NR_MAPS];
 	const char *expected_err;
+	int saved_errno;
 	int fixup_skips;
 	__u32 pflags;
 	int i, err;
@@ -894,6 +895,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 		pflags |= BPF_F_ANY_ALIGNMENT;
 	fd_prog = bpf_verify_program(prog_type, prog, prog_len, pflags,
 				     "GPL", 0, bpf_vlog, sizeof(bpf_vlog), 4);
+	saved_errno = errno;
 	if (fd_prog < 0 && !bpf_probe_prog_type(prog_type, 0)) {
 		printf("SKIP (unsupported program type %d)\n", prog_type);
 		skips++;
@@ -910,7 +912,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	if (expected_ret == ACCEPT) {
 		if (fd_prog < 0) {
 			printf("FAIL\nFailed to load prog '%s'!\n",
-			       strerror(errno));
+			       strerror(saved_errno));
 			goto fail_log;
 		}
 #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-- 
2.20.1

