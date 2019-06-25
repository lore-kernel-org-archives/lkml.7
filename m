Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC55C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76787208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="V3ngQTsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfFYTmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:42:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41300 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfFYTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:42:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so19208167wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCISGYpVhbDUZBooq11pFuU2+JLufihV8fmI2MlKQk4=;
        b=V3ngQTsaLqIqF7TzFh6XNjh79Gh1EyL5uZaziiNjq0FLjD3fH1sqkMEytNv8O3YwPd
         DVEeJlvoUws0v0y8oOxwkz1XaTgwrRGLPTZXz47swy6hZxA2kwBzXr/0T2m6BTfs7SVd
         rSBkXge4VJk/T/eh1joDvCtlj4xufcLDnC9D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCISGYpVhbDUZBooq11pFuU2+JLufihV8fmI2MlKQk4=;
        b=Kq4CiDS8cZ0l0l+69BEtr6A27DYMdTNEI3S8fk836cxXjeQEFpfwQWAYG+ol+PvQqc
         pNVaKgksQt8uO1yE/seIc5rTDX1c31yJ46NMelGB0ZD67fduKpx/II81T5qxcjRlF5LI
         0aVWP/CW7770kzyxuGToNXnHgdKVDSp5MAt9TXeQgYLmXj51rYvXYyxoZ2gwTZ7OUuJD
         qvx7f3aFK/zF6bDzL+eUP11gNX8Ynii+Il+mhPilOaGBcjLFpDNtx2Ouk9sFO098GdQJ
         O2gGeV4ifo1kyRudOhe7JEXTF3fdjO4/9swPjtmNX3TGnUgxfJULRWBRoOKNau+coAJ5
         WGeA==
X-Gm-Message-State: APjAAAXQyfmnNc/XzQA6iKuUjJoiUWWfJKjBz+xiZFUkRnL37f5VfEvJ
        btbK1HzZIT57W8JpyFBUg8BsUA==
X-Google-Smtp-Source: APXvYqyNgXnCNILDoy8+5U5tXxar92e+BVq+owk0l4GKapvSszJjZbwR63Kdzpqqdix/AVt37AOpXg==
X-Received: by 2002:a5d:4f8a:: with SMTP id d10mr33245893wru.13.1561491766892;
        Tue, 25 Jun 2019 12:42:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedb6.dynamic.kabel-deutschland.de. [95.90.237.182])
        by smtp.gmail.com with ESMTPSA id q193sm84991wme.8.2019.06.25.12.42.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 12:42:46 -0700 (PDT)
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
Subject: [bpf-next v2 02/10] selftests/bpf: Avoid a clobbering of errno
Date:   Tue, 25 Jun 2019 21:42:07 +0200
Message-Id: <20190625194215.14927-3-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625194215.14927-1-krzesimir@kinvolk.io>
References: <20190625194215.14927-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save errno right after bpf_prog_test_run returns, so we later check
the error code actually set by bpf_prog_test_run, not by some libcap
function.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Fixes: 832c6f2c29ec ("bpf: test make sure to run unpriv test cases in test_verifier")
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 9e17bda016ef..12589da13487 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -824,15 +824,17 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 	__u32 size_tmp = sizeof(tmp);
 	uint32_t retval;
 	int err;
+	int saved_errno;
 
 	if (unpriv)
 		set_admin(true);
 	err = bpf_prog_test_run(fd_prog, 1, data, size_data,
 				tmp, &size_tmp, &retval, NULL);
+	saved_errno = errno;
 	if (unpriv)
 		set_admin(false);
 	if (err) {
-		switch (errno) {
+		switch (saved_errno) {
 		case 524/*ENOTSUPP*/:
 			printf("Did not run the program (not supported) ");
 			return 0;
-- 
2.20.1

