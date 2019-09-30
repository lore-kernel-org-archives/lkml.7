Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CD4C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F29C2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knqv4i8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbfI3NFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:05:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42215 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbfI3NFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:05:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so3888720pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 06:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bK6MZWr6w6FAJdtYkaWJFSK0yuqaC12S3EefYxnzoEs=;
        b=Knqv4i8+ZXR2OCiNHFHexifplYe5hJkj0cZoff3qmNP1hBi9gO9mkM3O/JC0xCaAWl
         xgDLFFzkS+hn20TfrAdwktWc64NrJq7P9xOK/9k4cwLKJXO/T5ae59MhcUjuAU1PK9mm
         B4wU4Ztuhl3SctfdBEE21H9bTqvPA9rCYsjlnA9zrcMSVRZyCaq6oA/opLB5tBOZ09eD
         cemM7vFg9fPasjRKf8q/j5J/j6q+ckmTP5tIjiTDUQfU/hh7ihbDOGjwPRbfgZf3/hDm
         sCjB5QTNzaGT1k7ToDrQG0Fk38fg+F9Q38gYCy1Dw2W6WpkjP3DMlVJmYqv4miOLmfh4
         RyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bK6MZWr6w6FAJdtYkaWJFSK0yuqaC12S3EefYxnzoEs=;
        b=nTdjuofHjdwClJEq9/YHJ1UxoldT91rcYmXpjW8uNoLqOP9nX0ns0+Hne9Al4Tqh19
         7D14By4VHZ/68MTDJ4Mr175U8O3uuj9vnPDmBrNs+6G+G4sr/sFIFX8TXCYVk87zTBLO
         qeqKWfdTPovojsKCqT97SWz5tx1V05EEiAOhn52E4JznwCD2NpjP8Udp/6zelJ9LAOBZ
         tb/SI+o5N4737kYs8s75uC2Er4Xf+ARqQ+TCzQh2X6isDt3chWXp+zYuIcv4LoXo2Id7
         mWLMbise70cwOAaZUfQvOMEtEHKp3Rwa3Rx1GTuNLhpXieJJEk3Ci3ABeBssiQqAueim
         wv7Q==
X-Gm-Message-State: APjAAAVhL4J4jlytZ19qCVqOE/JJmgv5f2oLr0uqFvCV6qYdBZ0kw28S
        cFbSylSMxmYEJJNs5Kv4Pzo=
X-Google-Smtp-Source: APXvYqzFrheD9iRIOM5AGnrOqazLAlu0eRDin8o2r2cvC5uhiD4ntPY1J0weH2MFxRKW4uaScLjgGA==
X-Received: by 2002:a17:902:201:: with SMTP id 1mr18757795plc.276.1569848709401;
        Mon, 30 Sep 2019 06:05:09 -0700 (PDT)
Received: from masabert ([210.161.134.36])
        by smtp.gmail.com with ESMTPSA id q14sm26181571pgf.74.2019.09.30.06.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 06:05:08 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id B118F20119E; Mon, 30 Sep 2019 22:05:05 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] staging: exfat: Fix a typo in Kconfig
Date:   Mon, 30 Sep 2019 22:05:04 +0900
Message-Id: <20190930130504.21994-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.23.0.256.g4c86140027f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/staging/exfat/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 290dbfc7ace1..12f7af346c9b 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -6,7 +6,7 @@ config EXFAT_FS
 	  This adds support for the exFAT file system.
 
 config EXFAT_DONT_MOUNT_VFAT
-	bool "Prohibit mounting of fat/vfat filesysems by exFAT"
+	bool "Prohibit mounting of fat/vfat filesystems by exFAT"
 	depends on EXFAT_FS
 	default y
 	help
-- 
2.23.0.256.g4c86140027f4

