Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C84C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA02A217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apCkyJVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfEURzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:55:55 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:56171 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfEURzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:55:54 -0400
Received: by mail-it1-f195.google.com with SMTP id g24so2046329iti.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLDbNj8hKOhihnmanHTtFjySrA3DxxDhmX5hUAsmw+o=;
        b=apCkyJVyJ5bFRQFpxRJZFsNxoG+/opnp07SRfcPSXgWgvUH+EGQEeldHDIWa65YICK
         qam0sZgU6YgEJX//IAbrcRfPAqxKz+dEDLUTR/VD9kXIF/Gus5tzIXn1GQPDeHvmD/7f
         CkP5Hvw0SIBfvlsqiykEEgOSNENBEXr2O0udNsrWeHl/bf0ZupafPytTFJZl0+a7DzeV
         NylV6zObP4e9bcucHNh4tqygOYd7KAVFzCvQ1s1gJMAud24KVZKPV1eBaQQg3dNz/hRP
         5SktCoMn2iKj2WN3lCQkz0GGed50BCNnRHiwHUTj9WL3B2fXJdHCB+bIdnnUp8D8V51v
         yxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLDbNj8hKOhihnmanHTtFjySrA3DxxDhmX5hUAsmw+o=;
        b=Cr8lXIDEv4LZkt/V036hWROFzE5X/FRquu5oAxU7OsbcE/cUr1thUGG9XzvdBlDEmq
         Z2iIn6RNI80m+6SsRAnfy6xATGTJFOW031UhKApiN3dORF/l2CKJ3C3clQ+SV12tOmZ2
         3qm/mmm2KC0pZjsXxGOnqdHwVQQx+ehVDoUrjPOwzim0p9vVvmLHIFq5psgouZZK/Csz
         rliNe5ch6H1Sxjax0/qyCwx1tWskxT1Cw+lOpeE0qJf/P4RoYEBWOoNxAHblk6fPbyke
         YssLLSynjYAMIxFejA72JZAMaCBGrF/QC+Pmb4hWTJTiffyhkytDkmyPanuXzkmdSX+r
         PipA==
X-Gm-Message-State: APjAAAWFERchW6um2Qi9tNt0aT89UgPJlB++yCFJC+xOgvC5gz4jRgve
        /65AuRoGnoRtXYwlS04NABk=
X-Google-Smtp-Source: APXvYqwxmOUegYH0Yg5h9NSk004Jr4zoAAdGXNe8cm4CmBsUd7SiGjkgKkrTrTcFarnzAl5Z1iBMyQ==
X-Received: by 2002:a02:a590:: with SMTP id b16mr7518436jam.143.1558461353735;
        Tue, 21 May 2019 10:55:53 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:7a60:20d:6f1c:3788:87f4:7fe7])
        by smtp.gmail.com with ESMTPSA id a2sm6718720iok.47.2019.05.21.10.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 10:55:52 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        yanmin_zhang@linux.intel.com, linux-kernel@vger.kernel.org,
        Donald Yandt <donald.yandt@gmail.com>
Subject: [PATCH perf/core] tools/perf/util/machine: Return NULL instead of null-terminating
Date:   Tue, 21 May 2019 13:54:53 -0400
Message-Id: <20190521175453.2446-1-donald.yandt@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return NULL instead of null-terminating version char array when fgets fails due to end-of-file or error.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 28a9541c4..6fd877220 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1235,9 +1235,9 @@ static char *get_kernel_version(const char *root_dir)
 		return NULL;

 	tmp = fgets(version, sizeof(version), file);
-	if (!tmp)
-		*version = '\0';
 	fclose(file);
+	if (!tmp)
+		return NULL;

 	name = strstr(version, prefix);
 	if (!name)
--
2.20.1

