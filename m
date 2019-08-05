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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C45C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFB721743
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 12:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvqYbWIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfHEMXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 08:23:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33431 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHEMXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 08:23:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so4526526pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQHK9bxJCsNN8z/u4+8HH2PVzX7tOliDTN1dWwstt/w=;
        b=UvqYbWIzIdxTGctcAH9OWcDrGZ3nGG+JAaY1OXc+Hh6qVuSaLefdsDwufR1VFeL546
         V7Glpvqqlw3OT3NTf9ySVk7X69hOHFX5xv6ckqXmZJ+0oJsx6uTlH0TnEK79hXTWZazg
         M28723sWxA3JcJUnfY+if/XbMUcZ3/ADrZ47PpvXhDBxdrS76FPz5Oz3Qv9WxRRBrmoT
         PZslDBhiwIWm44afQJ6j2ETkQVE3S9xYfOEeL7Jb1lAxuktCWVG+K3tKxbEKaklfwWB+
         +MUecmSfpyYCY09HzF0ctW0zDjUSRPFgWEIq3icL1mdTdJ4xUnVDgDr2vXb2rJpLOdrd
         hkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQHK9bxJCsNN8z/u4+8HH2PVzX7tOliDTN1dWwstt/w=;
        b=Rhq8L+0/8+zJVOin/6U5CAeJq/bUTVSgKEUxDC3MLNDn/3RXiWKfFjt+nJofd1ZlnV
         W0b2qiKuRDqTt8Lhoz2/DaQy6GS4ts+qW2igKycqc+FGrSqLimfO9Iu1+VDoGwwBujTu
         QfWNuLG0vlJgKIKvzCpM5lv8VNZoMHdPUTMsG96rxgADgVKAyhtyM5DVVz2YvCtjRqw4
         ylIJX7hMidK4CmmAb5ObxfZ4lKCkrjFtqNCLe+uv/O2ZTt3BgweWg9OTxdEC5WHAxSA4
         nUnFFoj9h37lDjKc8ozEX5BqxjV3/bl/qYuUoI0v4KQ5+wJ3ugeOVneZFt8IMjAPAg2U
         Vczg==
X-Gm-Message-State: APjAAAVFztKfe3XXcLs4vtXKoy2TR0jjA8ZJT169Ks3cDPNSarM/YTNN
        W5aH943+3s/al8pJ50U2DT37V97fetw+FA==
X-Google-Smtp-Source: APXvYqzsMCeCbavmpbzWF0mKHEjUWqXHgcMRMlQ1lkhQOV4cZvLcdSJx+eUp85y3J+rCmJ8/Qf/GPQ==
X-Received: by 2002:a63:e948:: with SMTP id q8mr131962527pgj.93.1565007794686;
        Mon, 05 Aug 2019 05:23:14 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x24sm81599515pgl.84.2019.08.05.05.23.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 05:23:14 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 5/8] reboot: Replace strncmp with str_has_prefix
Date:   Mon,  5 Aug 2019 20:23:07 +0800
Message-Id: <20190805122307.13095-1-hslester96@gmail.com>
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

 kernel/reboot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b4..addb52391177 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -520,6 +520,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
 
 static int __init reboot_setup(char *str)
 {
+	size_t len;
+
 	for (;;) {
 		enum reboot_mode *mode;
 
@@ -530,9 +532,9 @@ static int __init reboot_setup(char *str)
 		 */
 		reboot_default = 0;
 
-		if (!strncmp(str, "panic_", 6)) {
+		if ((len = str_has_prefix(str, "panic_"))) {
 			mode = &panic_reboot_mode;
-			str += 6;
+			str += len;
 		} else {
 			mode = &reboot_mode;
 		}
-- 
2.20.1

