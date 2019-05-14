Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8ECC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E9320879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsb2Vbdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfENRpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:45:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35404 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfENRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:45:40 -0400
Received: by mail-it1-f193.google.com with SMTP id u186so196477ith.0;
        Tue, 14 May 2019 10:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8P3ySfQalD2SQo532FRU/HLb6fvJ+vp5xEa0aBB+cw=;
        b=dsb2Vbdht04/hUI7Ko/hGCIHe/OINRXscnQ3RlKsTtGWkgoGH1Ro46ftF0t3EPowxn
         EKDEFzxCYIL1iLebE79IN9vgT1qdXAble+GIaKqq6oFcQj62bJnIw3APcA9GPu30jQav
         a9ZXdm4Jr8qGtTcL7LrgI7XbHJxakjPeKqlMpdtSyBRv+Xn4w7ptnbJhzr+ljuScC6y/
         RxTp7yt4+B9fxuOqeE02nBEu11mooBkvmlDbuLUTdBBLf5PsV7uToJIUGeYZ0xMrz2LV
         8QITiBQmD/g5tit/u8mdyL8EOkz3/KYiuVhejbDfsnt5F0FQswmqj7ojN4uVg02ZlRyr
         BIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m8P3ySfQalD2SQo532FRU/HLb6fvJ+vp5xEa0aBB+cw=;
        b=rrw4+3urM4sTuMsu8ms6VVvUj9HvcNVvJaRzH6fwJpglkcejjbAUCmUiGKfHVUm2pO
         X+KAbHNyA3DmWrCrUnExfihZ9+xLOdP5G58HInibecKj0CcY3BfdxDifgWqM8BmnZNaZ
         Y5Yq3lD6UFo/9XxWSVG/bRSfLd5tvWY32vJj95rTi/DzT4zu2ZCJzbtuy0crN41p4OT7
         DRpdHgJrRfhtDvhuMabAqRAjrmgI3tEiDDePaEaQhucgMyqF9ikimSVk6PNZ1LlIbszP
         DWHrzz5eFe00/9RDAkLXGo+Jc+CHqXKp8e4xLItAg32kiyLPGIetxqO7r59GssFuaaVZ
         ItZg==
X-Gm-Message-State: APjAAAW884wDa+SPx3Tk4qbg/a9fd90/+t77bWwYJtYwyLFI+yPj4VjM
        0/dPUWFYp1g64HGqnG66nN8=
X-Google-Smtp-Source: APXvYqyNjOy0Qp/27t8FJseSlkRckGp8QpSBnnYf6NnmhHkHAclV2Vnq/BC+mqdSzs3bYnB/uDFUgQ==
X-Received: by 2002:a05:660c:f94:: with SMTP id x20mr4817559itl.46.1557855939295;
        Tue, 14 May 2019 10:45:39 -0700 (PDT)
Received: from localhost.localdomain ([2607:fea8:7a60:20d:6f1c:3788:87f4:7fe7])
        by smtp.gmail.com with ESMTPSA id d195sm1456283itc.21.2019.05.14.10.45.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 10:45:38 -0700 (PDT)
From:   Donald Yandt <donald.yandt@gmail.com>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        yanmin_zhang@linux.intel.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Donald Yandt <donald.yandt@gmail.com>
Subject: [PATCH v3] tools/perf/util: null-terminate version char array upon error
Date:   Tue, 14 May 2019 13:44:42 -0400
Message-Id: <20190514174441.23135-1-donald.yandt@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If fgets fails due to any other error besides end-of-file, the version char array may not even be null-terminated.

Signed-off-by: Donald Yandt <donald.yandt@gmail.com>
Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
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

