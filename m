Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F9ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032922086A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R43ESF1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfJARh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:37:58 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:35680 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbfJARh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:37:56 -0400
Received: by mail-pg1-f201.google.com with SMTP id r35so11669983pgb.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wk/kSRiVr2+hsdRYwtEFf1vJ/Djbn8eKotL+Cap8me8=;
        b=R43ESF1qMXL4EzulkwPKBST9Dj9BWXUYzOA79YIBN3gl1tGYXc1vwhGctIq6E00cZs
         0/UjG2x1/oKDfi/3K/19NhvRkp+8lpVt4QD0EcW517r04E6T7md9G8OFfYeCb54cqRWW
         hFzCDuhmXbM62ySyLJzRaOr8xImhDdNMYqte9P8E99uDPTcvk6k5/o8SMaET/DQYIhiC
         XBqvzzqPoNyK4Qj5QBDw8DtSrRxTw1H6QgF/Iotstr3P/bwVSwEGLYWQC1svmAanmuSl
         Q08tr61T61IwMcGoYYyaD9N3u7i2s7GkmserM6YQ7yqFmj1awCGslVtUNUWbgxD3gDC2
         hRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wk/kSRiVr2+hsdRYwtEFf1vJ/Djbn8eKotL+Cap8me8=;
        b=sWDF3sjt/JZgPijyqm/umVDcHOZE3Fbx7EDhZn7OhJvupwTVoDxiisBD/Wvz16DsJ7
         pV+riVgz++x9/IRgV6zanlzhZObkrQ0A5ONM7uS0sTCPrVkf6pCj87+E35OIddjjwiMY
         cTRbWSHm8H2NtfXTTvBV+vgIQ4pzm2cNBw9WyGpPbqNF2m0EQSSpLkc2BQT10ajVxPFb
         5q1N5OUeZKTb4RZeK4Rz3QWRsXhJVFLOS6VLo5aiIGr483aik1nSZeVfQB2Zpv00vtwp
         keivBrS0wH8u8p+JGRs5sExWc3t/c7nhfhCZNPr6oF3UV7layEzSP4uls/FCeunSTGiL
         ErMw==
X-Gm-Message-State: APjAAAXjLimRtliR3nF0syIFm8djfTxtTdLj3IgecrRYJCP29tiKjr1l
        4dRLlnj32dQ0gM777nyMIFBAk1RbkdLP
X-Google-Smtp-Source: APXvYqypaHVZ+jWEwbZaptMaWnugEpNBCtzVp1uSABDkv7TEphW8RK4IYnhKiUDvh2qs9s1LSN74jWoUUaM1
X-Received: by 2002:a65:6252:: with SMTP id q18mr32002268pgv.111.1569951475681;
 Tue, 01 Oct 2019 10:37:55 -0700 (PDT)
Date:   Tue,  1 Oct 2019 10:37:28 -0700
In-Reply-To: <20191001173728.149786-1-brianvv@google.com>
Message-Id: <20191001173728.149786-3-brianvv@google.com>
Mime-Version: 1.0
References: <20191001173728.149786-1-brianvv@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf 2/2] selftests/bpf: test_progs: don't leak server_fd in test_sockopt_inherit
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

server_fd needs to be close if pthread can't be created.

Fixes: e3e02e1d9c24 ("selftests/bpf: test_progs: convert test_sockopt_inherit")
Cc: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
index 6cbeea7b4bf16..8547ecbdc61ff 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
@@ -195,7 +195,7 @@ static void run_test(int cgroup_fd)
 
 	if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
 				      (void *)&server_fd)))
-		goto close_bpf_object;
+		goto close_server_fd;
 
 	pthread_mutex_lock(&server_started_mtx);
 	pthread_cond_wait(&server_started, &server_started_mtx);
-- 
2.23.0.444.g18eeb5a265-goog

