Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739AC5B57B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF87520828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 23:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpTiS9tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfF2Xoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 19:44:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45691 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfF2Xoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 19:44:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so8144830qkj.12
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 16:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Xm3J3uqRoSxwPDCNXasCxmtcHa0Ckg5BrlIZ4QZDYk=;
        b=RpTiS9tUTq/bz/Esm/3gUjoC24b3otsafuyXxvGmqpsVxHp58E3hrfnV7CeTe4NHr7
         hvqcTa9BWFQEDB3SAJh7gDx48/2zGFqcP++Vcp6ENkMV6D6dyzrf+GxPPy1cgX/HNvVf
         8ui1ARLX7VbpuZpHuLrxEr2LVHfiUKpLfy4qu4HPZ3IZcfk/v87Pq6VUIXldRVSLnitw
         nAdwUmgxEtaxyTAY/Lcaf84h+PJX3mjJE6WewFdgxzx98/hSqYS2RKJbTx+irpWjoP7F
         IYDKHy+eZEKmDDguto15V9nLDxNVLEyMBl013J6zSkxOL3ovO9oeMJ3J+gebwqpRI56U
         bZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Xm3J3uqRoSxwPDCNXasCxmtcHa0Ckg5BrlIZ4QZDYk=;
        b=bQqo5f7XDyLUq7OsNCgi+/vhREsoqGSmX3EFZ08gNpNocaNHuMDZfc4oDnFr3mQYkr
         klYoPoxWFsh+6oXv1A20trsEvMTa3BRzNhpTFlPy7XzGTH7TfBSnbKTomCvqL8TaWEZQ
         XMAa+Q0Txb9AsQhEFHEK909jJ7ScsD4PLtG2LI9f0JM9Z3DyVZLk+iMUKR0QvBJExd9K
         u+pCHOmnG9NaObASzJx1DAYcugiL22uAer9PT3gaKd/teq3gY/hlfhpXu5xiKNQJ1BE5
         rs4eoJFTA4fDHgH37j59tLUEqNgrJ0Led0Ulgy+x9wlwLjKOUP/vB9YY6U+dRTahTE3o
         9ChQ==
X-Gm-Message-State: APjAAAW+pEaf+Rcn2M6zR/y7qFlVK5ASQ9v09HuxZHVvP6flDp+vDrAW
        MPutp9yIt2CWfOf1h3LEkAE=
X-Google-Smtp-Source: APXvYqzHhsFnjFiMgZqt12GbymY/kxdtoq7iSgGuVU5Urj8xgzQYFrN3krjz4Nfa3xTu6+AI6TzwrA==
X-Received: by 2002:ae9:f20c:: with SMTP id m12mr13868766qkg.58.1561851876434;
        Sat, 29 Jun 2019 16:44:36 -0700 (PDT)
Received: from localhost.localdomain ([45.58.106.199])
        by smtp.gmail.com with ESMTPSA id c18sm2849775qkk.73.2019.06.29.16.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 16:44:35 -0700 (PDT)
From:   Gabriel Beauchamp <beauchampgabriel@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        colin.king@canonical.com, gustavo@embeddedor.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Gabriel Beauchamp <beauchampgabriel@gmail.com>
Subject: [PATCH] Staging: most: fix coding style issues
Date:   Sat, 29 Jun 2019 16:44:27 -0700
Message-Id: <20190629234427.20746-1-beauchampgabriel@gmail.com>
X-Mailer: git-send-email 2.21.0
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
 drivers/staging/most/core.c | 4 +++-
 drivers/staging/most/core.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 86a8545c8d97..f49c550ed48e 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -303,7 +303,8 @@ static ssize_t set_datatype_show(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);
+			return snprintf(buf, PAGE_SIZE,
+					"%s", ch_data_type[i].name);
 	}
 	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
 }
@@ -728,6 +729,7 @@ int most_add_link(char *mdev, char *mdev_ch, char *comp_name, char *link_name,
 
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

