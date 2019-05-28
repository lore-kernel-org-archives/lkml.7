Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEA6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54CA2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS6v7GXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfE1Nl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:41:56 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37814 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfE1Nly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:41:54 -0400
Received: by mail-it1-f193.google.com with SMTP id m140so3944161itg.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLDbNj8hKOhihnmanHTtFjySrA3DxxDhmX5hUAsmw+o=;
        b=lS6v7GXaZSalFWMm3WoSzuQB9Zjsw+onIMCLE6JJat+mQouJXGu2nR6VYifIFSFjHU
         WL7yLn/fqh5cHHMBiWbOyrZVR2F2qCH643m2/reJJyR78KXIoBzFB5ZgCSItTzRZhYsT
         F8qd0Jjy8o8bjV/q9TmuPrK9IKQE15lPqwE2mQhutKKiN4xhbbW+PIcjdcT/2xgCFctq
         d4xg1mnASyV9qs6xc9zLsl9AvhL/jJmm/1V9IEI9fbmxwecIufiiYOHcZwN2G/B7kH4s
         Lgdvv/oFEa4WvmyaLPLDSHq38tjMcIDzngUTDg4GasjcXupqrC+/XOz529WM0zC2u/VC
         Q0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jLDbNj8hKOhihnmanHTtFjySrA3DxxDhmX5hUAsmw+o=;
        b=rjXURw994rjTa5VU6BCX1mFtAudtdTCxIuCxU1Zl0uN4DY8eoH6/S+bOsuibA1Zr8d
         vN/WjRy7GuYVgA4UFKiXZaiJIfoBJzy++cagcaH+BpW1pYtFnHjNIuBHnoL11u1/6GwJ
         +dzVbg91ZtoEPXMqWPfGwhDsgr1YGRmbg3yksZCZTR2TlY7sKMh3Ui+gCZUbTElYQxG3
         o1jB85QAqD5W8BTvoSqhHsKt1cqz+4rQbZIMiKyNGdsPWVaDfjjf4EprtsY+plAtE4av
         dLNw3cn4roR38x/loySOqANs3nXB4FDstpw91NrlHyHhqzyN3yZeA4RQlAe2g3RD/LPP
         ovmQ==
X-Gm-Message-State: APjAAAVeP15oUGc20t7P1+5Z/+DnjwTrle2h/0WPuo7GVHFZQfBC5th9
        GeBw54fAqTImriaZc6D/uSw=
X-Google-Smtp-Source: APXvYqwm3jzumtfY56PvbYQzifT5CbLD2HPcAeXfSX9KzujmuncjrObdq8JSYqinusPnHLwQdQOb1Q==
X-Received: by 2002:a24:210f:: with SMTP id e15mr3122762ita.122.1559050913144;
        Tue, 28 May 2019 06:41:53 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:7a60:20d:6f1c:3788:87f4:7fe7])
        by smtp.gmail.com with ESMTPSA id v139sm1247007itb.25.2019.05.28.06.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 06:41:52 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        yanmin_zhang@linux.intel.com, linux-kernel@vger.kernel.org,
        Donald Yandt <donald.yandt@gmail.com>
Subject: [PATCH resend] tools/perf/util/machine: Return NULL instead of null-terminating
Date:   Tue, 28 May 2019 09:41:28 -0400
Message-Id: <20190528134128.30841-1-donald.yandt@gmail.com>
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

