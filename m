Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42892C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 14:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD522082F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 14:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WeNFDzV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfGGOo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 10:44:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35798 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfGGOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 10:44:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so5135857pfn.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llINxd7chWMQYSAAyJoEbONP27hNSFFLJxUayxqRxU8=;
        b=WeNFDzV60cDo1nguHaheWGmnBM8pQnuimPwSW6wzwIDUeAvyLHkF0EMM1lo4ItrWMZ
         4qHfyHfCdotZ2qyxAVZDNjQYaPnwwiHT94B3k715RvttE3sJE4iUA6aUpiPYQFCosXyM
         8JWlgxbvBJLWgybUuFba14Nu7r6bxjHFRPqMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=llINxd7chWMQYSAAyJoEbONP27hNSFFLJxUayxqRxU8=;
        b=Nj/2odBIri7QaKrglrByGcn/ufHmE3PY40JwPTrdrs3uFhB5zN07ZjILyjDR8mfeCt
         vxrr7vBr5kSRRu/Jw71mcvYi6WMB3ZuS8Mar3/6w8CYw+nKD7ZTE33eMwbiOed2oFAwb
         lxyjSkQ4YJnYMFA2b/kyUOpBSe8AnYeOvzVaaDxKIX9I3ki+DzjmFG+GwvO1cnBO+48I
         I+CoyZO5YGYphdItX81MHPLBQr0Ohwpao4jvZl9sY+wTi22FUNR6YDy9TWbWeF77kmqX
         RKgVNC5+5FsLvA7PwZB3sFnfvt/zuQalF1zWT1lsv5v3ah0m06vrKiu+6qCgNGAfYmp4
         gAlw==
X-Gm-Message-State: APjAAAXxLtuxF7NLUzBsvJsK4UGrU1R3lAhq0b14wdhD0IJ8Cb19fkda
        YAxyC7UEnYWSG/SfMh/pjBuKK34uWIU=
X-Google-Smtp-Source: APXvYqxu7HRbHsOuM3+rCbDIFEiAwYtA3JiDauASBsUxhU1jkKRE20/qOxlOEycD4ziUrTwKFwGRFA==
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr6565283pgn.182.1562510665202;
        Sun, 07 Jul 2019 07:44:25 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 14sm12757014pgp.37.2019.07.07.07.44.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 07:44:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        acme@kernel.org, jolsa@redhat.com, Jiri Olsa <jolsa@kernel.org>
Subject: [RFC] Fix python feature detection
Date:   Sun,  7 Jul 2019 10:44:17 -0400
Message-Id: <20190707144417.237913-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a hard time building BPF samples by doing a make in
samples/bpf. While I am debugging that, I ran into the Python issue.
Even though the system has libpython2.7-dev:

If I just do a 'make' inside tools/build/feature/ I get:
Python.h: No such file or directory

This led me to this patch which fixes Python feature detection for me.
I am not sure if it is the right fix for Python since it is hardcoded
for Python version 2, but I thought it could be useful.

My system is a Debian buster release.

Cc: acme@kernel.org
Cc: jolsa@redhat.com
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/build/feature/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 4b8244ee65ce..cde44cb38a5e 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -83,7 +83,7 @@ __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(
 ###############################
 
 $(OUTPUT)test-all.bin:
-	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -laudit -I/usr/include/slang -lslang $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
+	$(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -laudit -I/usr/include/slang -lslang $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) $(shell $(PKG_CONFIG) --libs --cflags python2 2>/dev/null) $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma
 
 $(OUTPUT)test-hello.bin:
 	$(BUILD)
@@ -205,7 +205,7 @@ $(OUTPUT)test-libperl.bin:
 	$(BUILD) $(FLAGS_PERL_EMBED)
 
 $(OUTPUT)test-libpython.bin:
-	$(BUILD) $(FLAGS_PYTHON_EMBED)
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags python2 2>/dev/null) $(FLAGS_PYTHON_EMBED)
 
 $(OUTPUT)test-libpython-version.bin:
 	$(BUILD)
-- 
2.22.0.410.gd8fdbe21b5-goog

