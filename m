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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D003C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C4021655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLnp/uOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfG2PPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:15:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38851 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfG2PPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:15:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so27619345plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=woIVuR6VRVNLdq7Fj1cmViScb45LHJKHE4rmpevHnO0=;
        b=YLnp/uOVa1Wbp1QzU8U044HQkPekYyZ+LBPl7SyR1wyiYZk6zP+JGAKWo5Fh/xgw+J
         l0CXkxTfVrtA11MqtsAdqKOUvQqaoNq/C21gXsoNkpwT8e3moFlPuctYoqQmJNZlhzHj
         i/KNpWc7Nv6HIiisMZB0SDPOHwLLxCG4PlBOby1uint94lTi3YLiz2lZEjdiV0atDsf8
         2jjULtn4rhODy9t3gRU38UAUDVumYScZ4B8dY0NBSPOj1oNqfCJoqcOQzTCsX1fYq7zm
         dfNVZ8vrmA6gsZXSMuTQWbqUmZj1bJn/OrlvnvUNKV8dyWB7qO16VRGke62Tj/SpfXiS
         j5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=woIVuR6VRVNLdq7Fj1cmViScb45LHJKHE4rmpevHnO0=;
        b=PcFEHP3+qxGeRaeXOXVgyE4mxxaTjTXTPBGF8XNdHp9sS0xVXDmSB60CcXO+A+9pVN
         9dSRuh3DdtXLJBBlYC8W5DvcXs/RdBgbdmki7lha1gBhKA77913robzXyEz2rwNu9uFC
         PIHVzRQJikMS+Wa2x0TVhw1jjuCemrg6sYxmaqztr0BEfScR61NdiDHLEri6ej2QShFS
         IuNULzzYE7qUt89mOT9sUK2FzTcd2vrvGD2CM+zG5XHa7YEiBpd2XzE089nkJxjmmqsR
         GZTEACWjI/bQCNyJZuM/fcln7O4iclpE8aKMHWDjwOp+U78X2vvrUvj5mLKGx1l9maTF
         TW2Q==
X-Gm-Message-State: APjAAAV2pQ35gIR6psVfMrHg0Bz+RD3uXv9afupy8LXbWc1VobQASnQq
        MZJwEVBARKvk423LnvnYSify9Yje92Y=
X-Google-Smtp-Source: APXvYqz/lW49XoxV+tIvM4nUCvYIhX9n4rdhoUAj0Z2B2SOlvi+CN94JwkfvL0xuv+6R7HPLP02ZIg==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr111588055plb.60.1564413315877;
        Mon, 29 Jul 2019 08:15:15 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a5sm53659586pjv.21.2019.07.29.08.15.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:15:15 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 09/12] reboot: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:15:11 +0800
Message-Id: <20190729151511.9714-1-hslester96@gmail.com>
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
 kernel/reboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b4..88098cf922b8 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -530,7 +530,7 @@ static int __init reboot_setup(char *str)
 		 */
 		reboot_default = 0;
 
-		if (!strncmp(str, "panic_", 6)) {
+		if (str_has_prefix(str, "panic_")) {
 			mode = &panic_reboot_mode;
 			str += 6;
 		} else {
-- 
2.20.1

