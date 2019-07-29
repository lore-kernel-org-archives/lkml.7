Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00484C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4721655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy9FXfvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfG2PPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:15:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44084 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfG2PPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:15:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so28166766pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mr+1JXG4ep5IJnhUOv2yDvp535ds/nwPcTsl5tGZZT0=;
        b=Wy9FXfvyOWRb0I7mYJpheM/3cxuEqD5IV6/n3sZHzS3YyOgdk49cessjcTrBmHdTtw
         j2q4k+G4rTolvc/OcFMowFfAkVM/bjAnaauyRpRP5Q9h3HXBVrC+2xT2GIS6XKY+K/rj
         G9Se89aAR6cpXlWHAmytCt0QNPztwHQnwiUvmTIGJvBCdgSdTPPXtZtikiYc2+wtaqS1
         Gk0Dk2p02j6tPGWBhUyON7uQplNPZMOBVNdhMckWPneh0Gr3fznFftuBYkdVVcBb2RRV
         O1c7UY8uaKAPFqXRhnZvlunBc8JrXviKTDgHvGbuggelnAWkEHJOW+id8dkTkUwoaEsv
         fYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mr+1JXG4ep5IJnhUOv2yDvp535ds/nwPcTsl5tGZZT0=;
        b=rSe5n1JFvhoipOW9OYHAQJmqI8QlHIPjCKhZgUXUGPLe6YZ5zq0arAjPrvven9A9ka
         CFFKpbN+yMhe4kM6+FsDZXyCYrGKF+HWWsMXmDUm8BZxINNr4jnoi8/Y2rFEVDj4+t5N
         Sq9Lnf4ryMLz9tpPMVZ2CZETXQhFTDOsvivZncnhkUaOPWrQs404SilZwk+4tJgslai5
         m4LejDLz4sW206K3oda4y0bdG3g3JQlIw2onHwYw6eJaz4Ihg9KtUtCiwJHQ4tZogUlm
         y8/yexPIyWsCcZVROCwwScNmsW4StHCF8RqBiRES+iUZx2tOjG8etLMgS5ikBJzsSTOM
         HSKQ==
X-Gm-Message-State: APjAAAWp+SAMc5Eg9+Cd4YceGGLYbjXthyNOPiXbAhbNHrej2i1Jp7K4
        gJlyxUiB3mFjZC2tJzoGvWXglUC1RZE=
X-Google-Smtp-Source: APXvYqywhwpLee8FxvUW0fbzzAme+O6yrfuhKy+2b8cUiF5RwNSprZcAvEKADum4v59hdnP1PxqE9g==
X-Received: by 2002:a63:6eca:: with SMTP id j193mr29228707pgc.74.1564413339288;
        Mon, 29 Jul 2019 08:15:39 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 125sm81441456pfg.23.2019.07.29.08.15.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:15:38 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 12/12] watchdog: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:15:34 +0800
Message-Id: <20190729151534.9876-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
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

