Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFAEC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0522070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="D9xP2Bub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfEONsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:48:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40318 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfEONs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:48:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so93845wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4wFlx6HQLwkFDpRpijpjb+LCC4DqiZp6fdw5d4Bn0s=;
        b=D9xP2BubzEPMEBtp4A/REzzwHzsxPmnZZGeY2xY/f1+7/kcqWbosB7HhgK4rfNY63G
         rKonLvKxUHvdwCOEopEm/AVUNntJh2b6OOJzQgr4da6zbmppPX8HlkfDYipmSNtOAqWE
         3HIdf2UETubgofhYaek5zlB3hweliaucMnXKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4wFlx6HQLwkFDpRpijpjb+LCC4DqiZp6fdw5d4Bn0s=;
        b=B7cdLdTbFUZeYW81dPZEhf6n+ISLytYbt3YmhEZWHDPEuAPDMHbxYlDb0nxK2bBAXt
         8HH6hrp+JI62u9HEb5nI22FxIWbImj6AzMj7sE1EJHdEki1w0EM9fH0sCUl1AoL8Xw9P
         y1f/o1vSjxW+rojx3DVD3J+5GZfe/r3T1WcvQX5AtvWQ1DIbt7tJ9fQ9NAAGDupzBtDs
         X9i7Jw0MsMFrW0fic0ULkQNAGU4EspDvpBDqExJXK/ZpEpsJNslzuHt/Pg84c1uTejow
         lteAiXSUn8/LGqGvXnZFbxZZxPtVdc7kbbiCyWx9SSMK0ZHR3dd978fAsxGIoN0xaP2T
         8ozA==
X-Gm-Message-State: APjAAAWlQmF2wcWSzYecmOtkvePn3GHe9esitORlB2mbwipOPNxUsoO0
        N5F+HspfGZoV2xSfz4iEax+Epw==
X-Google-Smtp-Source: APXvYqwpuCIcSe7tEpjLLIyvs2sBphmsdGB5DWnT0DsJKq+gtI+0iDk2r07JPa/i5V9zFjAc1hfA9A==
X-Received: by 2002:a1c:1f0d:: with SMTP id f13mr3449718wmf.74.1557928107896;
        Wed, 15 May 2019 06:48:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea35.dynamic.kabel-deutschland.de. [95.90.234.53])
        by smtp.gmail.com with ESMTPSA id v5sm4498506wra.83.2019.05.15.06.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:48:27 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     iago@kinvolk.io, alban@kinvolk.io,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 2/3] selftests/bpf: Print a message when tester could not run a program
Date:   Wed, 15 May 2019 15:47:27 +0200
Message-Id: <20190515134731.12611-3-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515134731.12611-1-krzesimir@kinvolk.io>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prints a message when the error is about program type being not
supported by the test runner or because of permissions problem. This
is to see if the program we expected to run was actually executed.

The messages are open-coded because strerror(ENOTSUPP) returns
"Unknown error 524".

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index ccd896b98cac..bf0da03f593b 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -825,11 +825,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 				tmp, &size_tmp, &retval, NULL);
 	if (unpriv)
 		set_admin(false);
-	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
-		printf("Unexpected bpf_prog_test_run error ");
-		return err;
+	if (err) {
+		switch (errno) {
+		case 524/*ENOTSUPP*/:
+			printf("Did not run the program (not supported) ");
+			return 0;
+		case EPERM:
+			printf("Did not run the program (no permission) ");
+			return 0;
+		default:
+			printf("Unexpected bpf_prog_test_run error ");
+			return err;
+		}
 	}
-	if (!err && retval != expected_val &&
+	if (retval != expected_val &&
 	    expected_val != POINTER_VALUE) {
 		printf("FAIL retval %d != %d ", retval, expected_val);
 		return 1;
-- 
2.20.1

