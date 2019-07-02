Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D745C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004CA21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9MvS5X4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfGBMY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:24:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38140 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfGBMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:24:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id n11so18172469qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3PjR78O3S5Kl2rlS/MhH2xJhjK2bFUrqsiWj/+MZnIY=;
        b=G9MvS5X4de0urYlEvuNHmuLOzcgNtdIdigNunAkxFVE4sRD0ArD6w8PWpG0jdQuELE
         QyCqCSSja8Hk3Yphpa0W7Wejb3s9Q+XS70ncCJsdPdU81sLnP8p3V9BhpXKb5ylY+8np
         tVhHZEDZGEE2tbwn0zkZ35p42deb9oTc1EXW9dS89Gwpivhlaqa/5AlUlpnP5F42jqC3
         8UsKlHIYH7wuF/JH2UVMoNbGHnGAgk+xUbzyY8kLXUzduMdu5mxtFTvoJ8TqYMCwi/lJ
         /Ub2j4QYJB5RWhQDGVlfEsYbXgrkSyeE4BvLMikJ6J93fg5AJSieEbz0b8iHD7b0YGaw
         QCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PjR78O3S5Kl2rlS/MhH2xJhjK2bFUrqsiWj/+MZnIY=;
        b=UbnIsRBCx0tu6D+qMgXWK2OriSt//at/F5tQNsQLfsyE8ElDDUrZ71opIsDjs0k4X8
         9CgNN9Lvz5PfwlJsVDzT1smd8pEhf39ffHlzj08m/mmzLMSsJFpF6+7068itStTM2JYm
         yVABgCOpieRqXTMz5vnzhVdwAtTxfZG5aAV09CxRDwiXCspsgBm99oxMJlYUlItdTwaX
         Q8ff6310REQR/9uunadl72O3mV0tScIjgrk+QGaZRhIRvjscGd/w6DZszTrObcPe287O
         6+GRW34L58wIL9CFW1N4HuBjtzOW1Pf+Oe/OYtVZ/h9alRelgBDRTjjT91DrWTTC1hLV
         vSww==
X-Gm-Message-State: APjAAAVLNkiCk8qop6HRSj2LkZ9cFqwHX7cNJn7Jw60mU7BFTQaz64Ua
        QjgGTJAU9cAhEBxmcVd5PG4=
X-Google-Smtp-Source: APXvYqyeUNYmFsM0YetlBDnh7JFe6FO6bQbsswa3WGFtws0LUGrEifK8MLPAw/JBR/fMyJg4gaHEng==
X-Received: by 2002:a0c:8a43:: with SMTP id 3mr26861400qvu.138.1562070298308;
        Tue, 02 Jul 2019 05:24:58 -0700 (PDT)
Received: from localhost.localdomain ([45.58.106.199])
        by smtp.gmail.com with ESMTPSA id j66sm6394999qkf.86.2019.07.02.05.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 05:24:57 -0700 (PDT)
From:   Gabriel Beauchamp <beauchampgabriel@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        colin.king@canonical.com, gustavo@embeddedor.com, joe@perches.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Gabriel Beauchamp <beauchampgabriel@gmail.com>
Subject: [PATCH v4] Staging: most: fix coding style issues
Date:   Tue,  2 Jul 2019 05:24:03 -0700
Message-Id: <20190702122403.4557-1-beauchampgabriel@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630165604.2452-1-beauchampgabriel@gmail.com>
References: <20190630165604.2452-1-beauchampgabriel@gmail.com>
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
Changes in v4:
- fix a warning by making '*type' const
Changes in v3:
- add a break statement to preserve the control flow
Changes in v2:
- use a single snprintf
---
 drivers/staging/most/core.c | 11 ++++++++---
 drivers/staging/most/core.h |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 86a8545c8d97..6a50e3090178 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -299,13 +299,17 @@ static ssize_t set_datatype_show(struct device *dev,
 				 char *buf)
 {
 	int i;
+	const char *type = "unconfigured\n";
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

