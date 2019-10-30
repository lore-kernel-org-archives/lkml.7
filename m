Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF3CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9360520856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 01:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKtWSJu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfJ3BFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 21:05:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34729 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJ3BFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 21:05:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so431820wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YdPunCo8P9dDqlKpWYJvgG38WQaPvb66w7p+wQZiDZ0=;
        b=HKtWSJu/j3RiRaKQXF3g2ZwH8oXWiftHra1acJiyKrBG2tdY6nlZYspWLKwCfGGWRs
         ys6h6/UJPfKR/fbhQK4VN7NJg1y1nTsXDv8ol6p9mGkum7DW2t9CVmTp2J0twVeRiFBl
         L4xgulrpaQ7OWz0WsdIusG3J2PZYba/ipiayoK2OLoAPM6BFXRAkGXT4fP+KzQ6zjMQr
         Y/TybfNzZKcflG3fc3WGe5IqxISrteE+7nbPx0VUB3LGlrtpA9Q/aenZEwCGRvXDdbGr
         /pU9YzOfdw7RVnkf6Kzu5Qy8zcTYMq7c1U3rvH5EPHQEKB9q+WWSg0aLzp8f2oKztHcn
         I3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YdPunCo8P9dDqlKpWYJvgG38WQaPvb66w7p+wQZiDZ0=;
        b=FC1JMB+0tTgPpoTjt/b2hBNWMBA3R7RNW4C8Xwp0fbn8KczRRupZ3fAiv+gBHp7dxo
         DKJdfx3jjCBjZ8fH4vlkqXpTVhbgFGfWlupa6/TM34IEZBLl7ls1oIE/YaRZDzcAIIEi
         1PghP+8tr21K8ITD3O4bXa0IY9WBLtVEQDkAiHljSBsMrPJtX55UpT5/1VgmZ7ZoKA25
         e/GoQntCHLfIFyRSEb62BFBeasmYADP873jVTuaEX37xIu/D5uSjgQ+99ka1YnM8Kshd
         +2CwuZOdeFbNDiBYDjmX3AhvgIuTOPciKl0+BuuqP9uE7poP6Bhu6yqMrNW1ilPqaXns
         UOrw==
X-Gm-Message-State: APjAAAV/7SVje6Ku0tHfbEtmdAc17vC/jCK62pnorx7+0S5u72cET/GV
        MUNZ8SYRF67v3txQCWRCHUs=
X-Google-Smtp-Source: APXvYqwXH9iLdXlKcxfC+BGKA2PPO5PjKM2WO6xN57cDBgsfAsyhGoA7yQG1vELdL3sKPasMJADUHQ==
X-Received: by 2002:adf:a497:: with SMTP id g23mr21376484wrb.135.1572397509103;
        Tue, 29 Oct 2019 18:05:09 -0700 (PDT)
Received: from localhost ([92.177.95.83])
        by smtp.gmail.com with ESMTPSA id f20sm372699wmb.6.2019.10.29.18.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 18:05:08 -0700 (PDT)
From:   Roi Martin <jroi.martin@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Roi Martin <jroi.martin@gmail.com>
Subject: [PATCH 6/6] staging: exfat: replace kmalloc with kmalloc_array
Date:   Wed, 30 Oct 2019 02:03:28 +0100
Message-Id: <20191030010328.10203-7-jroi.martin@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191030010328.10203-1-jroi.martin@gmail.com>
References: <20191030010328.10203-1-jroi.martin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace expressions of the form:
	kmalloc(count * size, GFP_KERNEL);
With:
	kmalloc_array(count, size, GFP_KERNEL);

Signed-off-by: Roi Martin <jroi.martin@gmail.com>
---
 drivers/staging/exfat/exfat_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index f446e6e6c4ee..a9391f0b8141 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -713,8 +713,8 @@ static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
 
 	u32 checksum = 0;
 
-	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
-						GFP_KERNEL);
+	upcase_table = kmalloc_array(UTBL_COL_COUNT, sizeof(u16 *), GFP_KERNEL);
+	p_fs->vol_utbl = upcase_table;
 	if (!upcase_table)
 		return FFS_MEMORYERR;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
@@ -793,8 +793,8 @@ static s32 __load_default_upcase_table(struct super_block *sb)
 	u16	uni = 0;
 	u16 **upcase_table;
 
-	upcase_table = p_fs->vol_utbl = kmalloc(UTBL_COL_COUNT * sizeof(u16 *),
-						GFP_KERNEL);
+	upcase_table = kmalloc_array(UTBL_COL_COUNT, sizeof(u16 *), GFP_KERNEL);
+	p_fs->vol_utbl = upcase_table;
 	if (!upcase_table)
 		return FFS_MEMORYERR;
 	memset(upcase_table, 0, UTBL_COL_COUNT * sizeof(u16 *));
-- 
2.20.1

