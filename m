Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4B3C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5638521537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kinvolk.io header.i=@kinvolk.io header.b="RhXNYx6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbfGHQcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:32:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32957 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389118AbfGHQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:31:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so406251wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z76b7cDfMIhdXC2S4ZNE4xkrLelxUNXMkQTCGU5+CcM=;
        b=RhXNYx6sIoPRSm80OucW4DTy7frQhaZPWJmrYQbwM4HE/3hixCW6WTJJ4w43q9LLNd
         dZJiNF+rmokzqQRRd+3NRPWItWj67xvVHDa1VDb1ML5a6iA5MqmuGGScfvd9ir26Nmr5
         0IdygbIrnx4b+g9Gfgn/r431cV34dVhbf0v+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z76b7cDfMIhdXC2S4ZNE4xkrLelxUNXMkQTCGU5+CcM=;
        b=ZCiSnXZDpxEa+I/b5gVcLuTlX2m1+QUPuExThv318mqdk5LieWUHYoeYNLCYp9gERA
         PKTE5vd0M71nDVu3qddxZ4+V6DyN93B5VG+/y/L8PaJbWbB0kKEyM2TrBuY73PGbOfH4
         YbZ4gscLzKKytX0NuY/54WLPpTIn8LUiDbb3eSHyam2dpv3exka+AANPK67xqDk2zffS
         mzvSza0lx7B+f6I6KOKPWytKLIrRSmn/wtoTxL5Dazw4vw3xcPouQ/J6P5oT+D00ZHzQ
         TT3lWIS3yf8T6CNlRCmQWj9dcLtNKtSqP/mZgup1zWCderCsCWPLocqlvMXRwzzeFVrt
         pZUg==
X-Gm-Message-State: APjAAAVp7l7b2mwXjk2Gcc6ZqNNvAmnQ870z2+Q9QkgEFpwLQu9RjPgq
        wgg7b1vkpj0jUBPgBWwXbicpyIFl/meEyg==
X-Google-Smtp-Source: APXvYqzwiQkZAgs0VAH6SVpMDzW0Obn5DcSK9LXbi4kam1MbYa2py60vd/mSlpqJk3xgKq7QBW+AKw==
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr17954233wmg.27.1562603511384;
        Mon, 08 Jul 2019 09:31:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:50 -0700 (PDT)
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
Subject: [bpf-next v3 04/12] selftests/bpf: Use bpf_prog_test_run_xattr
Date:   Mon,  8 Jul 2019 18:31:13 +0200
Message-Id: <20190708163121.18477-5-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf_prog_test_run_xattr function gives more options to set up a
test run of a BPF program than the bpf_prog_test_run function.

We will need this extra flexibility to pass ctx data later.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/test_verifier.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index c7541f572932..1640ba9f12c1 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -822,14 +822,20 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 {
 	__u8 tmp[TEST_DATA_LEN << 2];
 	__u32 size_tmp = sizeof(tmp);
-	uint32_t retval;
 	int saved_errno;
 	int err;
+	struct bpf_prog_test_run_attr attr = {
+		.prog_fd = fd_prog,
+		.repeat = 1,
+		.data_in = data,
+		.data_size_in = size_data,
+		.data_out = tmp,
+		.data_size_out = size_tmp,
+	};
 
 	if (unpriv)
 		set_admin(true);
-	err = bpf_prog_test_run(fd_prog, 1, data, size_data,
-				tmp, &size_tmp, &retval, NULL);
+	err = bpf_prog_test_run_xattr(&attr);
 	saved_errno = errno;
 	if (unpriv)
 		set_admin(false);
@@ -846,9 +852,9 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 			return err;
 		}
 	}
-	if (retval != expected_val &&
+	if (attr.retval != expected_val &&
 	    expected_val != POINTER_VALUE) {
-		printf("FAIL retval %d != %d ", retval, expected_val);
+		printf("FAIL retval %d != %d ", attr.retval, expected_val);
 		return 1;
 	}
 
-- 
2.20.1

