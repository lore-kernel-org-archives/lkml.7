Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16837C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBFC2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="bb0wfX8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfEONsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:48:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44190 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfEONse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:48:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id c5so2739464wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8C9qQrgN+nbsH+pjHzl6tlp7Nc6h5TeMF/8muSLzN0=;
        b=bb0wfX8/WrYuGLUAmDRcNpnd3bhxH6w7/sgCZ8Drhn8KHryZFCL75wztrn3JWWAnVM
         R0QfBsa9kVPuPPY8Fl3RqZexz2P73kISAhhEJg2Zjo9RldS3sYnWT3YAgPUYR6zk1OcB
         73vtRKTT1JAauCFk9RwePECbqyDWlwQzdCSck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8C9qQrgN+nbsH+pjHzl6tlp7Nc6h5TeMF/8muSLzN0=;
        b=Ap/OmYOTuOJ1WBfajnkfACGfRQMV+0DXovvmcPHk4VqArVUc4x4iR6xC19mzr4xUEc
         wQkEX3A+yVjRCsqeAwkVopUvzhCx6jWxTuNIaobTXRQi8Ws8R0P+uAbLhSgM8LMtH0tq
         NDRtyO5e8lCHCzqlDz3/+Tpub4Ai9/U/WBXARj3UfHTYi+F4ymQfUXz34YNwOG0Gt+DY
         dEoV7JgwpyBJmGCVh51uEdTtu4hJeR4VpebW50V0+0shiEQZBMU+eCXvhbc6rmLkFT9a
         xvWDuk5FlUybvXCgc9Y0pYOjm+g03zz/ZSqufWPHCj4F7+Hrmga5YZLE/3NssabmkmkW
         1ruA==
X-Gm-Message-State: APjAAAXxtulZSPmvoMCU1RjkQiAfw3s//PXH11YgMWQPcOOphtB6ZmdM
        h9AzBDhOKgqBAzJ1YEH94r55kQ==
X-Google-Smtp-Source: APXvYqw5wECdzlZCofc+dCbXApCTq0fMDCETyET6YAJzK0hcDDptniDy4A+BRGyfphuaB3WidJzFwQ==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr13698244wrj.114.1557928112220;
        Wed, 15 May 2019 06:48:32 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea35.dynamic.kabel-deutschland.de. [95.90.234.53])
        by smtp.gmail.com with ESMTPSA id v5sm4498506wra.83.2019.05.15.06.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:48:31 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     iago@kinvolk.io, alban@kinvolk.io,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 3/3] selftests/bpf: Avoid a clobbering of errno
Date:   Wed, 15 May 2019 15:47:28 +0200
Message-Id: <20190515134731.12611-4-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515134731.12611-1-krzesimir@kinvolk.io>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save errno right after bpf_prog_test_run returns, so we later check
the error code actually set by bpf_prog_test_run, not by some libcap
function.

Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Fixes: 5a8d5209ac022 ("selftests: bpf: add trivial JSET tests")
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index bf0da03f593b..514e17246396 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -818,15 +818,17 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
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

