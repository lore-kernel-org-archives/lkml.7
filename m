Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23A5C5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759F120663
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCoPh9Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfF3P1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 11:27:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44085 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3P1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 11:27:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so11914981qtk.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eq2HukLiuzFzKASlbDJ2Cm/tBYYzarf/IV9FWDHC4+k=;
        b=LCoPh9WdvLxOamjgGnaksBaExNO9y2okQn3Byp2aMNjJTk+00rPGWli+R+5e0ClVT0
         nGC1hobErUz1XQK+95CPL5N0FUZZv6B9aGpIWMRhu4RH2rCmxcM/8HIPyF9VRtIcLPZw
         qge8lWPJeahjV8gU69Ho+BZk+jYwZW62/70VAwk/hp8t/T8JqIiKHkhKKOT/spTe904r
         sjIHpXqALcE7G8X8lTsyJIz/z+HyYQjn8XqZpD2UaZjgBReyAxvw7sR0Zo/uTqR70ftL
         wLnTRqFaKW1zMJlpLVhImodLJnwVkznhgcjejYfzNKFHV1FlM/52TeYHjfjsLx234PcY
         74DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eq2HukLiuzFzKASlbDJ2Cm/tBYYzarf/IV9FWDHC4+k=;
        b=WUFW9pIFtF/vPtt67KuP24fikDIb88ZWtBG14mLpoexHxLHSEy+fYyDI2W5Yaabfmx
         9nrpY2izkQUJS0BdcMcjo3ikLvygBdjqjSZTEgj4itDI6Gh3eq84ULePQJbfXo58px1F
         UIqH0C+fDNt9Wt0szK/9VNonY5qMYLMAwQvPaBoqG2si7hLtCSSC86T+WxBFEFyUKMYQ
         AkamV/Gx6ijRwWKVXq/GrIOUGNMErPFB2ieyTTNa4h1/UY73kZh2AyFukENbds2r6o0N
         2lzugfiZ91brT1sv6KZJV3E9HHKdMmFBGURiie858FdsZFb7KXbOkn8Y09f1/VEgALmM
         UDyA==
X-Gm-Message-State: APjAAAVB7hAEp0FXs18Z0cvCQphJMRPUELUwTy1fChdgCGdvpyB7n3Jo
        EnuJBNdkgVdDTRnuDqS2wDs=
X-Google-Smtp-Source: APXvYqw+lugXdizRx7WEqmvH2EBqSTj9jTiIdRBtsYzArslAuyuqt9RY3tdcwaj4F0EzrFFgemmNmQ==
X-Received: by 2002:a0c:aa0f:: with SMTP id d15mr12141717qvb.229.1561908469379;
        Sun, 30 Jun 2019 08:27:49 -0700 (PDT)
Received: from localhost.localdomain ([45.58.106.199])
        by smtp.gmail.com with ESMTPSA id j184sm3648364qkc.65.2019.06.30.08.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 08:27:48 -0700 (PDT)
From:   Gabriel Beauchamp <beauchampgabriel@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        colin.king@canonical.com, gustavo@embeddedor.com, joe@perches.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Gabriel Beauchamp <beauchampgabriel@gmail.com>
Subject: [PATCH v2] Staging: most: fix coding style issues
Date:   Sun, 30 Jun 2019 08:27:26 -0700
Message-Id: <20190630152726.21092-1-beauchampgabriel@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <dbe411be6aa32a32aafc5a5b77f08e8507b45da3.camel@perches.com>
References: <dbe411be6aa32a32aafc5a5b77f08e8507b45da3.camel@perches.com>
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
Changes in v2:
- use a single snprintf
---
 drivers/staging/most/core.c | 7 +++++--
 drivers/staging/most/core.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 86a8545c8d97..852f8788ce2e 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -299,13 +299,15 @@ static ssize_t set_datatype_show(struct device *dev,
 				 char *buf)
 {
 	int i;
+	char *type = "unconfigured\n";
+
 	struct most_channel *c = to_channel(dev);
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);
+			type = ch_data_type[i].name;
 	}
-	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
+	return snprintf(buf, PAGE_SIZE, "%s", type);
 }
 
 static ssize_t set_subbuffer_size_show(struct device *dev,
@@ -728,6 +730,7 @@ int most_add_link(char *mdev, char *mdev_ch, char *comp_name, char *link_name,
 
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

