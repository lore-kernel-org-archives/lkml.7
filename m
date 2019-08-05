Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514F1C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237F520856
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWW63Zur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfHEMXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:23:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33427 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:23:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so39573414pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlNVJGRhgAziAh7yL79j6BLAHuQYAgDj8JaIW0xteHA=;
        b=NWW63ZurGhueUM8XQrBDNSiWtLXfOiz6Mi9Q4GPGNJpL1wqX/27viVaEsBmqUIR8EC
         GYkilDyrrx1rQHS2QRsR1Z8IsLTeWpFlb1YDMFDmGcfnrvtt5cmQDMvYjBiTZ17TCUWS
         P8cst2qh/g9RWu4H/xuOSYkTT4IAn7LGt3vHT/U6usEDAMGWRf/2fKu7btfWpTi9P2Ro
         iz0/GQo+IpUahfCEqaokC0DMVUMZnDh0+7yH6oTQbeTkO3l158HEBbbzyLJSy+eA6/J1
         xwoHb0+dP4iFZKiUR2xR8jBDBGAxTD8Ca1qjBKujoox2jaJJTx8fkpTw6jmkf9U2OSp/
         N5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlNVJGRhgAziAh7yL79j6BLAHuQYAgDj8JaIW0xteHA=;
        b=gwMnCy906cgigxHoKsmWRKVG1r+XjQF1m2aq/Y/SHahLLXckrikkujReFlJ5r1ZQAc
         p0aVVApb7oPiwEtkezbX7k+4HQd7q38vZn8VKjEWlmX6MUtWsXty8+LfXNLMv2048PqP
         KjuEBkikBBR7285Ljo2ikUgD/Z98nEYRr1i8QVrLdovOvG810KHwYCH+6zESRSiS4LA3
         mHF9NPUO0JPvzN81XgiMKHQIN+/ltnAX0bOVGbhnmeGsX00ECSSeJpBrkXVJgojlrJhk
         u37x3blanDPk8gW0WfBQ+TeuHYiq0Y4Gkfd+f7wJ+ZQvlUE+6FHXH4zSCMPu50C0bjhh
         a6mA==
X-Gm-Message-State: APjAAAUoUtBevLzgWCyr5jnsCv2xg3yQ2ma6g9HJZxWRQkNBIROlYIwa
        X/Ra4COJ2glLh5bTA4sEU7DACVPAsQKqpg==
X-Google-Smtp-Source: APXvYqzZ5fX+/6jCq90JeFzTSdaNyhvmEKrGv8ZpMgNmYc3lp9VqctSVmhVbfapSDRkz0qpA8rwK8w==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr136655667pgi.445.1565007833544;
        Mon, 05 Aug 2019 05:23:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id j12sm75613114pff.4.2019.08.05.05.23.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:23:52 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 7/8] userns: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:23:46 +0800
Message-Id: <20190805122346.13203-1-hslester96@gmail.com>
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

 kernel/user_namespace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 8eadadc478f9..e231e902df8a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1138,6 +1138,7 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	char kbuf[8], *pos;
 	bool setgroups_allowed;
 	ssize_t ret;
+	size_t len;
 
 	/* Only allow a very narrow range of strings to be written */
 	ret = -EINVAL;
@@ -1153,12 +1154,11 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 
 	/* What is being requested? */
 	ret = -EINVAL;
-	if (strncmp(pos, "allow", 5) == 0) {
-		pos += 5;
+	if ((len = str_has_prefix(pos, "allow"))) {
+		pos += len;
 		setgroups_allowed = true;
-	}
-	else if (strncmp(pos, "deny", 4) == 0) {
-		pos += 4;
+	} else if ((len = str_has_prefix(pos, "deny"))) {
+		pos += len;
 		setgroups_allowed = false;
 	}
 	else
-- 
2.20.1

