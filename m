Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA373C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE372086D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOpVCdl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbfHEMYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:24:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41102 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:24:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so39579862pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvNIIvyr1HZdHxI3+dMG0XwOSbyqFwP/GOGTSjFs/B4=;
        b=HOpVCdl6QfscvZumVVZBmYBvn6ARHLLUFP7R98TQku3GrqyU3dAAzxvL4ijBStcoYk
         5czJxxpew3ycKWH1++HGfmppdrYO8RRb+byVydL4dmofr8CJVT757lfwXgoVto+hfL0l
         SZe5/k9NQeAfjH8H6FURerps8wvx5EA2tf/k8xWEuLFjE3+JefcVrQO+hbp9+UnK461e
         fUE44nXWttbw+6JcKJFWobaWwKw/YEzvillOo7J6I8dGs/mWPN/m4ztDWuDQ/vqqzYjw
         W7ucjpYPNrNDka+ZOGUZFtI07XhNjRBT9R9h09OgcisRSln6FCt13t9ekUrKPf/hBqpM
         XXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvNIIvyr1HZdHxI3+dMG0XwOSbyqFwP/GOGTSjFs/B4=;
        b=t9wSFKwqMZWQr9J/5z+weKAFJYa0nQboTOsdaBwYt3LnTqvDtPa6HTPgcrlKzQfz83
         QQ93dLFMnVWAju7prQMNLzxUqfDyNrtPcn66cioF3UsPcZE+D/yS5MMqdzulzvCssbLR
         N1WFC0iYSNtcYoGXiLjubgnk4enxACYUFG2ahoWX9ftVXa69rPaH2/MgELXpdp9JHpEd
         h5bx/ClFnjFy6APfZ31vWStjcBKwHAgog55LszGeul569QkbmD7MdWREG18OwcQaOou8
         SqYedMQkGpB7pphNitGxnArF3GOqaNXrM++vIV7ww2l1hJ1P8I1YOJKIKCBeMThfHvCj
         D6LQ==
X-Gm-Message-State: APjAAAWI4nl/aYDxxDmCTaiK0aHzpKjxhVCX0E/3g16Lz2cc14aIvgyU
        811ZGBsVlJoGaR06IV1fl12j4W/ImEy/WA==
X-Google-Smtp-Source: APXvYqzlm2OkMcd3gqx8xG+Nfp3IjJV48sbLSn+hdVA6VkaZsMth4vdnVIkdYU8cInV22ilwcWfC+g==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr18045000pjq.102.1565007844428;
        Mon, 05 Aug 2019 05:24:04 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id s20sm95447299pfe.169.2019.08.05.05.24.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:24:03 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 8/8] watchdog: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:23:57 +0800
Message-Id: <20190805122357.13262-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Revise the description.

 kernel/watchdog.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..ac7a4b5f856e 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -70,13 +70,13 @@ void __init hardlockup_detector_disable(void)
 
 static int __init hardlockup_panic_setup(char *str)
 {
-	if (!strncmp(str, "panic", 5))
+	if (str_has_prefix(str, "panic"))
 		hardlockup_panic = 1;
-	else if (!strncmp(str, "nopanic", 7))
+	else if (str_has_prefix(str, "nopanic"))
 		hardlockup_panic = 0;
-	else if (!strncmp(str, "0", 1))
+	else if (str_has_prefix(str, "0"))
 		nmi_watchdog_user_enabled = 0;
-	else if (!strncmp(str, "1", 1))
+	else if (str_has_prefix(str, "1"))
 		nmi_watchdog_user_enabled = 1;
 	return 1;
 }
-- 
2.20.1

