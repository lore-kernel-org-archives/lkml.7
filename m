Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854A7C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DDA2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="csn54bR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfFYTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:43:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37286 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfFYTmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so19233981wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 12:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gF+TApHT5g/voE3vYeHrjhE0fjt+hIapyPZdSdt5oAQ=;
        b=csn54bR/un7yHoLCBsM3gUToVx0AmYE5K7Oy2aGEZPtqU0mq7XujTVNDzqowgyHVSG
         FdUGlOSmw9CAUCznG54Ck4vg54uHBUVPthrSIjqSlIT6GJyCz0B9DsnGMBxNd5Y6ZuZi
         BLr+I6RmTPkWGUMyzCJsjx+r6WN1t7VsTCIJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF+TApHT5g/voE3vYeHrjhE0fjt+hIapyPZdSdt5oAQ=;
        b=AmZ8CgM9UnaJkYiyhk+/SauAGh4M19GOpzW22qBHQshH9LB6jyoWde96On8uYtNfCm
         Nm6PDFg95z9kmfY53dxWcUgit4MazvUF4ZVUL6f75uRwM3MvjvwdJt4i+TgJDu+glcZr
         D2wAI4klw3zruOyIQFlun1S3+94hjnxknvAkg72pkms9hWwpglx7G614PY5ZsgqSIcFq
         vNUtx9oD+j3Yy4xa6u/ngscph0glDS8sUBWs8KZ5s8VyH3UOvdY0SORyQjbtQBf8fZab
         jYmM8sWI+4hrMF2qInTnwPSQnhjcrlwe0mJ5DsJdX3QhtMPh5VgdPGiNkERiDfSk6pbg
         j6cg==
X-Gm-Message-State: APjAAAVPi4QONHfllyK00L8UE8SB3Dt+SMjqi3hko2rcjprLk9jkcbuH
        0qwx7UzF06+InWhk6xNSf4FzCg==
X-Google-Smtp-Source: APXvYqyMKk5+9ncOIiVNAxk2PS3ILRPAWR8jAYomxKM4xSozvjpXH49pjU3/smRzRY7CmKGevTcuqw==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr58429326wrv.104.1561491767958;
        Tue, 25 Jun 2019 12:42:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedb6.dynamic.kabel-deutschland.de. [95.90.237.182])
        by smtp.gmail.com with ESMTPSA id q193sm84991wme.8.2019.06.25.12.42.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 12:42:47 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     netdev@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Stanislav Fomichev <sdf@google.com>
Subject: [bpf-next v2 03/10] selftests/bpf: Avoid another case of errno clobbering
Date:   Tue, 25 Jun 2019 21:42:08 +0200
Message-Id: <20190625194215.14927-4-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625194215.14927-1-krzesimir@kinvolk.io>
References: <20190625194215.14927-1-krzesimir@kinvolk.io>
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

Fixes: 8184d44c9a57 ("selftests/bpf: skip verifier tests for unsupported program types")
Cc: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 12589da13487..779e30b96ded 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -867,6 +867,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 	int fixup_skips;
 	__u32 pflags;
 	int i, err;
+	int saved_errno;
 
 	for (i = 0; i < MAX_NR_MAPS; i++)
 		map_fds[i] = -1;
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

