Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D2C19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A42206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tP/9nOuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbfHBBr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:47:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38042 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfHBBr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:47:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so26375403pgu.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuvGrEKDwaYDxNsylZRH3iXO6ZMXYnOP7mztNqR4E2A=;
        b=tP/9nOuQALgghPmYXazr8/2p2rD1ahGSBrjFT9OAg2J9ptUwaPuknyOCQulWk6g0Fx
         LpbdhrNAahm6NsQif5PJ76o7KNrjqKSQAREjJEmsMvroMpBTdASZ9EE/3oo0+J2LkZoi
         dq4VMKhaZTEDcXbzmXCQbtgNpvR2IvME5JZLb/M7ASsNRWeXuJfgBB9jyQ71lFeq1r4d
         elZ0elm4LEdLsUPPnNn2nE94dKhfZZuey/6sM+0JUn3BF7lhMaozB49omj5h+5FFCGCQ
         RZsaYfkp+Jv9CMvFmO4QyAlTzPP+Bh4+c3xDccxa36mU+8DJq/i25gxAOw1T/LR4cmfe
         OIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuvGrEKDwaYDxNsylZRH3iXO6ZMXYnOP7mztNqR4E2A=;
        b=khz8CJZFarqoFrgIsBgmpW2sQJXplSjONyAxBap++HAhaddcD25sRbBWsTWrVcu8Nd
         K5JDmjtNlKsvP5Yy+SmgS+M507lMfYYCmmhtp97R8oDvWU/H3izSTsaS+SgQ6Pk51mg/
         6885UjcvqzTXN4YXIGCyWvjczYpdd7fDMgeWoUxjvyOgTKfawC+6tz63Q7NFqzePKDp9
         mIk6pNPIb5S/fZwgkUtD2cenJZp2fRInt1MUE9dSZvJFFyM5ZVLSU5bO6dlKRkXwv5Lr
         /iKEDeNrj9/0Y17EQfaiWE135DEYPEniy7dCMBwIXqVkOrrLpR+z3mu8UZlMvjuSU6Mn
         80+g==
X-Gm-Message-State: APjAAAWWMFch1GrtGHeslDAMclPPe7EiKsYNW5NXD1P3n9LQLaI3ncFF
        ho8RcoT2heEc8uyYCsx2xxE=
X-Google-Smtp-Source: APXvYqwVC7IZr4lSx8p4kHbb9tbFWG45uW//usuBK49r9xH8es13XIBJGRoIlnS3CTGvmXRTH/JGrQ==
X-Received: by 2002:a62:64d4:: with SMTP id y203mr56380968pfb.91.1564710476079;
        Thu, 01 Aug 2019 18:47:56 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id p1sm78437616pff.74.2019.08.01.18.47.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:55 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 10/10] watchdog: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:47:49 +0800
Message-Id: <20190802014749.9168-1-hslester96@gmail.com>
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
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
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

