Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361ECC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD6D21743
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="iGxEo3Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbfGHQbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:31:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40160 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388418AbfGHQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so11513185wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amfYeislYJ8EeT6TDcXvFdnxBjp9KM9m4SLqeYyRX4s=;
        b=iGxEo3ErstIbpnRCA6hd+jmfSU0hCfTpvTKR6lvsxesRxZHf1hoNU5JuBoXW3jQVVU
         QpC+S686rdjpn9J+WWGmQaUXctXp5v5m2wY/OlhNR+Ayr3kqJxXU3Ig9XtNGK75HceN9
         r6SBGDX9r2Mm8acAfQ74175bgJbek0xTFYta4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amfYeislYJ8EeT6TDcXvFdnxBjp9KM9m4SLqeYyRX4s=;
        b=e0/NC+ZDmRfkD77rXMGzW9ckwzZA5Lvq28AyNLmcaG9lzHZFKEXnJrlWM0OLAUZD9Q
         H7eJ5SrF1Q2DDrmL2Sj2+rDYjtL13KnsDv/3KvHGla9TCtbWvAeY3uom4WlumomTLDEv
         wWgmhqusCLhv7fMWhqImMGl96yJDKrWRsXCg2ZgNxTnTAlrOnsgdn9jPtU3V5isDXKAJ
         MO+8BtVzYMSVMFh3MK8sSWwDZ1DOgaxthKZ6J6V82lCxBKlVWSNNKcLXUj5i82AiGbtL
         ceZtcxirT338Jq2LW75UbJppjyug10FCNEfNfi0Cs4KqFUCY9XL/bgzwEo7hKZ31DqC2
         wSBw==
X-Gm-Message-State: APjAAAUSvMl3NcX93d4QdFAkD2eugDdDvOyJv7GoAa6f4gDEJ//d1mK8
        YHVLcPCKF9Y/QVQiqOttLDWMcRcxzy+lnA==
X-Google-Smtp-Source: APXvYqwxUunAJhKUnVcTSUV6gdzpyIQotbg9qXmr0mcKTSCOn3444ijLQOND9itE4kXqRoTQnQgfrw==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr19391048wrq.333.1562603507442;
        Mon, 08 Jul 2019 09:31:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:46 -0700 (PDT)
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
Subject: [bpf-next v3 01/12] selftests/bpf: Print a message when tester could not run a program
Date:   Mon,  8 Jul 2019 18:31:10 +0200
Message-Id: <20190708163121.18477-2-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
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

Changes since v2:
- Also print "FAIL" on an unexpected bpf_prog_test_run error, so there
  is a corresponding "FAIL" message for each failed test.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c5514daf8865..b8d065623ead 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -831,11 +831,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
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
+			printf("FAIL: Unexpected bpf_prog_test_run error (%s) ", strerror(saved_errno));
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

