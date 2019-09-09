Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F481C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E482089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="H2AxMfh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390656AbfIIKXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:23:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55833 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390615AbfIIKXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:23:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id g207so13144594wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=In6xjIv1qvZx6AHWSp+pYmS8Y+YcRx5T9VqtwgDDOao=;
        b=H2AxMfh6lZl28VuEpAig+Ks6VvS2c/2mZ96FjkKszabA6MyJP9kHbQ1KKprSKyFSmJ
         mN4OqbigiTeZ3SFvyoAWcicUp+ltfyiVQvI/5E+Fx8g5Lq1/q6CYklfhsHkBRI1QY/MU
         dETvL5Cke5dXWfEWU3vBj8E8Ij/JfReNOs3Yy/sxO8XIGlENDWstC5iB0Ttzggciw8CK
         qQ3SjJQjkpCNt+9wSAjQytMKAwbxIbfFWkxX+TPYPFag194n25iWz50I4ChcDlZEEPuv
         KMYnXYd3ae0OtxC/b7wnIClKjO4keCcC049HzFNRzUbrsnSwkpz05DTvgEmahBkZQunG
         FCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=In6xjIv1qvZx6AHWSp+pYmS8Y+YcRx5T9VqtwgDDOao=;
        b=ZBK8yMmFKPHPrF5mfo6ov59PAbxEsswYlALn4e7gGymP3mRdZDRj1MUTWf0EbQOjjr
         W9yNmNTnb3tRAglNzyssDMQGDCioITWYx4OHcTdRjuuF4k+qu+jxHZ+HjWa2Pf5U+h4v
         nqB3t43RvH0Re9NsqxhSvLTz8uhYLjFSPhiqoe/7eolVoH+snnvI45wGGzDF2XYbX3Gj
         DpE8NJVIhWEjdfjsDKrTobZTiqo7ncQLs5jgE9CFdBLmrF5XDUVQKRyIDa/WTIU5J6dR
         4n0FIT4uHZCLxWWDO+ute59GuF8a+gO1V8ZVbldPMCoE9+ZNpHBkmax+Ri6T2WzB3h4L
         PGSA==
X-Gm-Message-State: APjAAAX0ZzZi7HsKwkIiYSp5j7IkDD6JNmqyJ4vxEn9njvO94VWsftv1
        E0G8UJz5zSJiwto1mNbokC0OxjlOrENPUQ==
X-Google-Smtp-Source: APXvYqwodAb2hSbu1oBC3qnGuQjKRAYFo/bkD32ISS9HPSjmr8FMWLHhger1WxXkvavqQkINxe6skw==
X-Received: by 2002:a7b:c5ca:: with SMTP id n10mr18393828wmk.138.1568024629199;
        Mon, 09 Sep 2019 03:23:49 -0700 (PDT)
Received: from Mindolluin.localdomain ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id d14sm1800008wrj.27.2019.09.09.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 03:23:48 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] select: Micro-optimise __estimate_accuracy()
Date:   Mon,  9 Sep 2019 11:23:35 +0100
Message-Id: <20190909102340.8592-5-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909102340.8592-1-dima@arista.com>
References: <20190909102340.8592-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shift on s64 is faster than division, use it instead.

As the result of the patch there is a hardly user-visible effect:
poll(), select(), etc syscalls will be a bit more precise on ~2.3%
than before because 1000 != 1024 :)

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/select.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 12cdefd3be2d..2477c202631e 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -51,15 +51,14 @@
 
 static long __estimate_accuracy(ktime_t slack)
 {
-	int divfactor = 1000;
-
 	if (slack < 0)
 		return 0;
 
-	if (task_nice(current) > 0)
-		divfactor = divfactor / 5;
+	/* A bit more precise than 0.1% */
+	slack = slack >> 10;
 
-	slack = ktime_divns(slack, divfactor);
+	if (task_nice(current) > 0)
+		slack = slack * 5;
 
 	if (slack > MAX_SLACK)
 		return MAX_SLACK;
-- 
2.23.0

