Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3D8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B2C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JVgAaFcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388164AbfGXXpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:45:17 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42520 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbfGXXpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:45:13 -0400
Received: by mail-qk1-f202.google.com with SMTP id 199so40874958qkj.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VQaWcfe07h7xkPV4srIxPAegZrqwtOuxXwp48xMCRFw=;
        b=JVgAaFcP4BXC+4Nk6aWkGbBNbormFNb7B2J2uLoqHwsOLu0+A9xD2RsQs7Jj7XcDz0
         GWagGjRxlDZK3/Ovx7o5c7c8ffOh8AdWIj6eumKSiSYIy4AXuQDI2YB3HJ6SsJ6Esxgq
         sGam93Bf/ar1WP2KpXBe4WS8c0gusArStRpbSLDQ3xanZdaFy0k+VBUfhl/nir8kPlDs
         LB0sWJyIZ3Fh9hqJOkO6/7YzmpjvR52IOA6CzztS5Bl+zY1BcUT+pzJUYJnkWIlanmcl
         O0C3Xkh6Ema6NvFIGt8IVZuLkrLZ4sO3r3WprP4U6/0qKEQ4qRNRTUd7Q1seDttF8BBI
         cbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VQaWcfe07h7xkPV4srIxPAegZrqwtOuxXwp48xMCRFw=;
        b=iYrDXYiVNn1NhywQk1DrMm65PoLcNu9ogkU2q1cbmeqTuBO/E0HdGO99DkU+AX4/yJ
         I3aHQVcRS6MlbDuxrhJuskxGetMFEMHN9QCo+siEs9EcBGl0U4deQzFNaRxXg4Ev5S/N
         ChzkAl/Wjz6lgd06BYuRhKQ2u0bXYkv65YeRyhfyfBSNN+maleGOOVcrZPNGn5DAKJT5
         VaB82OWpo72RlRH5CdTWsHHk8zGd+eXZX+1kB4GTHEOOazd6crUiXImVlt9TXUB38Mz+
         3T2tOqTgVZ0DFUguIjm5BLL4b2hlQciiWKLxhfgdQO5wyzMrkd8GJkQTroE71zW8NLny
         Mi3g==
X-Gm-Message-State: APjAAAXGXLc3bAo0wMzBeA5yDUHqTdy2tOAEdr/iazhgl5THTOtdP5se
        YKhCrdxfRW5GIU4KUZlRjnnwYEgP
X-Google-Smtp-Source: APXvYqyaU8l40Dg9ugxvYn7JyOeLkVyu0WKdTJ6MCa5Vbl46pXV5IDHVJ5swXoEwQp2v7+3MuJSuNppK
X-Received: by 2002:a37:b0c6:: with SMTP id z189mr56205530qke.208.1564011911372;
 Wed, 24 Jul 2019 16:45:11 -0700 (PDT)
Date:   Wed, 24 Jul 2019 16:45:00 -0700
In-Reply-To: <20190724234500.253358-1-nums@google.com>
Message-Id: <20190724234500.253358-4-nums@google.com>
Mime-Version: 1.0
References: <20190724234500.253358-1-nums@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH 3/3] Fix sched-messaging.c use of uninitialized value errors
From:   Numfor Mbiziwo-Tiapo <nums@google.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, songliubraving@fb.com, mbd@fb.com
Cc:     linux-kernel@vger.kernel.org, irogers@google.com,
        eranian@google.com, Numfor Mbiziwo-Tiapo <nums@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our local MSAN (Memory Sanitizer) build of perf throws use of
uninitialized value warnings in "tools/perf/bench/sched-messaging.c"
when running perf bench.

The first warning comes from the "ready" function where the "dummy" char
is declared and then passed into "write" without being initialized.
Initializing "dummy" to any character silences the warning.

The second warning comes from the "sender" function where a "write" call
is made to write the contents from the "data" char array when it has not
yet been initialized. Calling memset on "data" silences the warning.

To reproduce this warning, build perf by running:
make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-fsanitize=memory\
 -fsanitize-memory-track-origins"

(Additionally, llvm might have to be installed and clang might have to
be specified as the compiler - export CC=/usr/bin/clang)

then running: tools/perf/perf bench sched all

Please see the cover letter for why false positive warnings may be
generated.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
---
 tools/perf/bench/sched-messaging.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index f9d7641ae833..d22d7b7b591d 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -69,7 +69,7 @@ static void fdpair(int fds[2])
 /* Block until we're ready to go */
 static void ready(int ready_out, int wakefd)
 {
-	char dummy;
+	char dummy = 'N';
 	struct pollfd pollfd = { .fd = wakefd, .events = POLLIN };
 
 	/* Tell them we're ready. */
@@ -87,6 +87,7 @@ static void *sender(struct sender_context *ctx)
 	char data[DATASIZE];
 	unsigned int i, j;
 
+	memset(data, 'N', DATASIZE);
 	ready(ctx->ready_out, ctx->wakefd);
 
 	/* Now pump to every receiver. */
-- 
2.22.0.657.g960e92d24f-goog

