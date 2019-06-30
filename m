Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5531CC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15FCB206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 16:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="us+8FD6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfF3Q4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 12:56:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36595 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF3Q4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 12:56:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so12112567qtl.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJDgP97eShcdmvJ/LnUBsrdxn29SNS9vsStoVXzeXJo=;
        b=us+8FD6ty3wOB+rDydNxaCdnuDWtaUUghJhSAUhP2jw7zmLMY6PvX1sL9zdDZFuAg3
         jyUarc1r1rYVBA/Qh2aqK3VaUdSmfjcYTJ2g6deXfsNe9zBopKLl8x8cc3jISrHC+drw
         U1Cd5YGSoDrTeC9X5BCtvvmfOIwUu1nXQSuuNTu3MVUW8p1jrbYKyCwXTzEu7ZBeZi8/
         yFB/RCmOhMaWFs0Y7ln0Cgtzm0sjp8qllyvAe4KgtbrMaq+dOqzPHgn0bu7GTZyWpXoa
         z5/J2A2BcP2JeA1lTSYq5BL2puag5NdELb9iO43hlGKPFL5LoXvPMNAuV23ivzlbv+5p
         A1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJDgP97eShcdmvJ/LnUBsrdxn29SNS9vsStoVXzeXJo=;
        b=G5qrL+4W/BDZu/HwKyLN8AVmkF38ED5Ha7/neEViZjxGeGG/r/LanN2RttUa5GMznX
         48PtTUcga6XhelEqm2wrXbrPvJiploN5Cr32+LRBiR3aWZHT9MocbQxzq4JRTzNlaMUu
         YYxLN8rjqvlggzr2iEkZjtyOV+J2tBJdBvdDecHcp5tQRfpggMeKP8wDl80UfJPhyawR
         oGac2/k83IEnDwTkh3pocCgQ/NmVIx8qKrGRQxjYgImLy+5BPFdD/1J8hwW/aEhl/nCy
         IGHElqTgOqHqMlHyAhe7Bc+rSDW38nglEfSZCMjEbEpW8LojJtuWe9gPqH0pmQ3uc1Sw
         V3sg==
X-Gm-Message-State: APjAAAU0JmNYDDYg8UcHBQFaSk3e5b4TGcT1ceLxFCrke8P7NK8mhhkr
        lkMsLQEICea0GiMNZPoCUkodBQFnqAU=
X-Google-Smtp-Source: APXvYqwg/oXBjsbchSxxuvIyzrcSxgfEoJn2s0sK/tXzD4IGLOqCq5RHfs5pF3HXviUmmewCwoZQ6w==
X-Received: by 2002:ac8:1a8d:: with SMTP id x13mr17184376qtj.114.1561913772285;
        Sun, 30 Jun 2019 09:56:12 -0700 (PDT)
Received: from localhost.localdomain ([45.58.106.199])
        by smtp.gmail.com with ESMTPSA id g3sm3557810qkk.125.2019.06.30.09.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 09:56:11 -0700 (PDT)
From:   Gabriel Beauchamp <beauchampgabriel@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        colin.king@canonical.com, gustavo@embeddedor.com, joe@perches.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Gabriel Beauchamp <beauchampgabriel@gmail.com>
Subject: [PATCH v3] Staging: most: fix coding style issues
Date:   Sun, 30 Jun 2019 09:56:04 -0700
Message-Id: <20190630165604.2452-1-beauchampgabriel@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630152726.21092-1-beauchampgabriel@gmail.com>
References: <20190630152726.21092-1-beauchampgabriel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch for the core.[ch] files that fixes up warnings
found with the checkpatch.pl tool.

Signed-off-by: Gabriel Beauchamp <beauchampgabriel@gmail.com>
---
Changes in v3:
- add a break statement to preserve the control flow
Changes in v2:
- use a single snprintf
---
 drivers/staging/most/core.c | 11 ++++++++---
 drivers/staging/most/core.h |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 86a8545c8d97..eb18d4df8ad1 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -299,13 +299,17 @@ static ssize_t set_datatype_show(struct device *dev,
 				 char *buf)
 {
 	int i;
+	char *type = "unconfigured\n";
+
 	struct most_channel *c = to_channel(dev);
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
-		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);
+		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type) {
+			type = ch_data_type[i].name;
+			break;
+		}
 	}
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+	return snprintf(buf, PAGE_SIZE, "%s", type);
 }
 
 static ssize_t set_subbuffer_size_show(struct device *dev,
@@ -728,6 +732,7 @@ int most_add_link(char *mdev, char *mdev_ch, char *comp_name, char *link_name,
 
 	return link_channel_to_component(c, comp, link_name, comp_param);
 }
+
 /**
  * remove_link_store - store function for remove_link attribute
  * @drv: device driver
diff --git a/drivers/staging/most/core.h b/drivers/staging/most/core.h
index 652aaa771029..6ba7c2b34c1c 100644
--- a/drivers/staging/most/core.h
+++ b/drivers/staging/most/core.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * most.h - API for component and adapter drivers
  *
-- 
2.21.0

