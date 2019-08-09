Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3074AC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C73208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 07:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjebkB+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405779AbfHIHKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 03:10:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405612AbfHIHKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 03:10:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so44646653plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psT6ET5n53e8RWXSwxZ0SnD139vmrDzv09XLpcqNcnQ=;
        b=pjebkB+WzqjE25Hd/bEFmIqp+kxp6y1XWoDCJLV70ePRPKfYQflgh3R2/ZosY+woep
         1RyphNqrG27xa2dWIUCKhaMzfrZhWKWtjT/NXDhkJog5YObgs5ffBcLpIC23OzBk1gI9
         uEvveaQJFp3Z9tpGIuBRI4CXhgg45MrzJKnYZq3dlJROqFxxUpwUxZuB5VgO6m6LXAE3
         vFIdvTUP593CIKKKzyYlYl2VtLcxYysUsBovjXNOetfBGrDbUQRj7TcBjPTzu7KLwnWN
         qNAMN0HK51n558r7MCutVeucUWx3LcSR2PLkRuq3l9F9Z5hGA1GWSyLSTcflPJ0WJ+O1
         5bTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psT6ET5n53e8RWXSwxZ0SnD139vmrDzv09XLpcqNcnQ=;
        b=s8ES5OK+jqhQh+UZuk1SDlvkA9lejfL+ycMfL1t0XwWHKUXgiKVnEIseQjpdxcZzlD
         mvXiLhiN+n46chm13iKpkeik1bKVCDRtndd1ZIDXUb2Kw+jcfSKwNU2cWWghIX5cWrcO
         J9NpL/Y9hgYLa95YeBMxoF1kzFxv5Rsrjk1zna5iWELOxxm9O7ypC5iid/KVe8lFrh/W
         Ch8Hdp9um3zxSbtslBghw5WxtorCB5kuQmzYj0S721zoYXdrpEHLqzw2n2PagT05jpFw
         p2Hs1wlAsliFZP+Uohdlvhbgm+1uTr0DGoiK+w9lWWhGYxkL5XLpxNDfnE71pC37+rYa
         igvQ==
X-Gm-Message-State: APjAAAW7Ehhfyda47v4xnmEPPoW1KtHk9xKsr2xdYdICaBEBMnBoFjh1
        Qdl12JZRZL6bxI00JQ266qO08FQcBMxLlQ==
X-Google-Smtp-Source: APXvYqykuGA1VV06c9nlUG2DUSHE5SeCVkb74qiTdK/x3XoXhHa5GsDLpA9I4sEjKvAn34pI+w9jnQ==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr17686104pll.133.1565334646229;
        Fri, 09 Aug 2019 00:10:46 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id l17sm21794208pgj.44.2019.08.09.00.10.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:10:45 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 5/8] reboot: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:10:42 +0800
Message-Id: <20190809071042.17333-1-hslester96@gmail.com>
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
Changes in v4:
  - Eliminate assignments in if conditions.

 kernel/reboot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index c4d472b7f1b4..c79aaac43785 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -520,6 +520,8 @@ EXPORT_SYMBOL_GPL(orderly_reboot);
 
 static int __init reboot_setup(char *str)
 {
+	size_t len;
+
 	for (;;) {
 		enum reboot_mode *mode;
 
@@ -530,9 +532,10 @@ static int __init reboot_setup(char *str)
 		 */
 		reboot_default = 0;
 
-		if (!strncmp(str, "panic_", 6)) {
+		len = str_has_prefix(str, "panic_");
+		if (len) {
 			mode = &panic_reboot_mode;
-			str += 6;
+			str += len;
 		} else {
 			mode = &reboot_mode;
 		}
-- 
2.20.1

