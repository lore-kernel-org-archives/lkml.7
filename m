Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C45C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDAF2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 11:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fodpkxYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfENLBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 07:01:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42358 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfENLBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 07:01:16 -0400
Received: by mail-io1-f66.google.com with SMTP id g16so12644345iom.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2Zuv8CKh3wPvxluNj428+EEqYUTWg7a1Kriib7f/xU=;
        b=fodpkxYMLnwiILy2IEMEeBWNfvFSddYprl+ERPMf5/ikNS7aDUAodH6EUKBdLeGYL+
         8oP9SZJGySwxYTwipx66czNchCG0ftPMpDnXDffHm0gBmIuXF+mUcQSCJ96P53vQWeaX
         yo+nH6Qv/6hLH1DUKBOBAM6bqm8SKK4f5Ywn5Qt9by/ZtQsamYW65C1H+BzEEoHFI5cc
         KaSI9ff8mUOZRjt6bXarXxAy7Mx7bJH6gnkWrZXTxQ1giu1A5pp/2BUjDakVpFpP9QHn
         hoRh9OAh7xZWm3Sr2R9vAd6M0P6DedrMG7zhXAJbDzGm7gkJHZ0IiHie6CFUu5sk2htC
         rA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a2Zuv8CKh3wPvxluNj428+EEqYUTWg7a1Kriib7f/xU=;
        b=NhCwnL89FwmcKlCBdtCKa0WyjCVTgAkDprYhUGYbkrbzJkeUNBwVuh8oIy/kOyIVGu
         z5B0cT1z6nHrW3FBUzRzywd4VtheU2Jx8ZUto4jsxX8IyREW5+kKUUi6NG3sLzDz1zV0
         PdHrO4feLMj344smtMWYD1koNgURLagOyHBwHiOeh31+7vjKcqbAUxGrMYIqtzR1cVOY
         fD78hpiXjd+F6KN52+J4yAF07bm6GNf0GJiqy+dd5A25i7bC66UxCQ/49qacXTxlUxcS
         0Nc9cz0f4z1rwW6C2ulSi12Ug55bDbMhb+tsQnlV69oieNs2SfewOVkfw6/oLHr0jgyW
         83TQ==
X-Gm-Message-State: APjAAAWpbOnCQu4LU26IIBAyc8eVx/SbF96DO3erGonXxFF79bLzQ/oE
        Xvwpl3AMjUdcNy90IlUJQL/HI8TGRebq6g==
X-Google-Smtp-Source: APXvYqzBxQxDZq/DOZfrDQ8lF6ybkBqcX+N1b48Z/8zqlQthSK2n14L3t0nmGAD+X809fQ9nLIrA8A==
X-Received: by 2002:a5d:9c0d:: with SMTP id 13mr2556258ioe.160.1557831675694;
        Tue, 14 May 2019 04:01:15 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:7a60:20d:6f1c:3788:87f4:7fe7])
        by smtp.gmail.com with ESMTPSA id k201sm982609itb.10.2019.05.14.04.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 04:01:14 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, Donald Yandt <donald.yandt@gmail.com>
Subject: [PATCH v2] tools/perf/util: null-terminate version char array upon error
Date:   Tue, 14 May 2019 07:01:00 -0400
Message-Id: <20190514110100.22019-1-donald.yandt@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fgets fails due to any other error besides end-of-file, the version char array may not even be null-terminated.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3c520baa1..28a9541c4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1234,8 +1234,9 @@ static char *get_kernel_version(const char *root_dir)
 	if (!file)
 		return NULL;

-	version[0] = '\0';
 	tmp = fgets(version, sizeof(version), file);
+	if (!tmp)
+		*version = '\0';
 	fclose(file);

 	name = strstr(version, prefix);
--
2.20.1

