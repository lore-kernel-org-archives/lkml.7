Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B25C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B06521D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="fpgGkcR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438896AbfIYPDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:03:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33029 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfIYPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:03:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so7364782wrs.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vZ1ZsSVj18a6RvTBAEr2379v7Y7nRqSApdj4dC7ZSqE=;
        b=fpgGkcR6PeJ4SAhhpwKidK9B5w7sjAWVH2wvqRQ4LIvIpIvc3OIBuUlVqThZTJKiK7
         fVCEL1P8JI82K0B2ELC7DC0ydThjPHvhVQlLkGrU62xtPFw8gDzRqrWD8RRV5klViBv9
         /8vW5p8ua1TL+cdZLl8K+laWT7dti4mc/tn6j/3e9MxywiUFteLbSq3Ckk2XnbdqwHKa
         dlQfSFcki5lUItZs92CaKHhfu+ytsPZFLvkDf2IxR3rde0xyPySS2G6SqESIyVwegojF
         SlcLYuQXlLjm/lTUoyBUR5QtWwpnjoY2mdVeioCbo+4JPG9yrcQNVvDqkWu58MdWD7eG
         1WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vZ1ZsSVj18a6RvTBAEr2379v7Y7nRqSApdj4dC7ZSqE=;
        b=HLjNSAC9b51ln7jpVGS9Yg/p5dvto+/F1EaPlBMNc0ZYDykPNUb2ttWp3bC9OeI/FX
         pbaDI3ylu9QT9C9UXAsfe964C3yj7FvUZDd1VjUVXMKzGFLL9D0ZbQfkBk7XVZ5dxhRL
         MQacwrtSVSrHR4Rb9PX1IAJsVyE72ahTgP16fM0nurU1f8EbcUxkG9wnk7cKfNm4rz1b
         Vo7yD1Pk5xzV8+P3pDyUyufWGv81HDKIhV1hCNgWff7a2iI9prihgQJXhI/AXmp2KK6g
         YD/1kDYHvt/dZHhapuQdNJ+u+Ls/kiOhm8Von/VraAxRWw5SyOWZa3NJK7Mvzrx274g7
         Z2dA==
X-Gm-Message-State: APjAAAUohYSk6TrI/9rMWkVTkc+sC2tZl5xgUigwvnz72fVOP5+iXO2D
        tPi3LYiDrbbmeb6SyeLvrvrOycjZI7Y=
X-Google-Smtp-Source: APXvYqzLCQRLt3BbVYhAWHnsOxMRH3w0UIVd7l4KMahMn4jJj2c6Dh0Ibh/pMwPIFb/mu1qlUm9Lzw==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr10600742wrj.269.1569423831754;
        Wed, 25 Sep 2019 08:03:51 -0700 (PDT)
Received: from baileys.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id x5sm6285337wrt.75.2019.09.25.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 08:03:51 -0700 (PDT)
From:   Joel Colledge <joel.colledge@linbit.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is set
Date:   Wed, 25 Sep 2019 17:03:08 +0200
Message-Id: <20190925150308.6609-1-joel.colledge@linbit.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PRINTK_CALLER is set, struct printk_log contains an
additional member caller_id. As a result, the offset of the log text is
different.

This fixes the following error:

  (gdb) lx-dmesg
  Python Exception <class 'ValueError'> embedded null character:
  Error occurred in Python command: embedded null character

Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
---
 scripts/gdb/linux/constants.py.in | 1 +
 scripts/gdb/linux/dmesg.py        | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 2efbec6b6b8d..3c9794a0bf55 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -74,4 +74,5 @@ LX_CONFIG(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)
 LX_CONFIG(CONFIG_HIGH_RES_TIMERS)
 LX_CONFIG(CONFIG_NR_CPUS)
 LX_CONFIG(CONFIG_OF)
+LX_CONFIG(CONFIG_PRINTK_CALLER)
 LX_CONFIG(CONFIG_TICK_ONESHOT)
diff --git a/scripts/gdb/linux/dmesg.py b/scripts/gdb/linux/dmesg.py
index 6d2e09a2ad2f..1352680ef731 100644
--- a/scripts/gdb/linux/dmesg.py
+++ b/scripts/gdb/linux/dmesg.py
@@ -14,6 +14,7 @@
 import gdb
 import sys
 
+from linux import constants
 from linux import utils
 
 
@@ -53,7 +54,8 @@ class LxDmesg(gdb.Command):
                 continue
 
             text_len = utils.read_u16(log_buf[pos + 10:pos + 12])
-            text = log_buf[pos + 16:pos + 16 + text_len].decode(
+            text_start = pos + (20 if constants.LX_CONFIG_PRINTK_CALLER else 16)
+            text = log_buf[text_start:text_start + text_len].decode(
                 encoding='utf8', errors='replace')
             time_stamp = utils.read_u64(log_buf[pos:pos + 8])
 
-- 
2.17.1

