Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05535C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D007B207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXyNFWdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfFLIMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:12:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45980 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729382AbfFLIMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:12:15 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so11328879lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONQAntTAACJE0IJDBpBlglBaprB61LRkMC27jTtksx0=;
        b=AXyNFWdIUMFiS8tUU/hhAXav92vQH5sxz/gb/odm7JFXZrvG/WYmyxxmOq6lSDjfSb
         4+NZB0p4M9//5KX9rIwkAzsUMtyfgkGFwvrrxIMG1PD5SyzjenrkqgNRqo1P8mEhdIat
         w9XEeD0oKOB/mTTrVNtgCbZURXDz2pPO3T9iBsyYxJzaPFeiydSCT6BKkmp+SQjuVn6d
         qHgk+Oedx1x+9VrrO1GF0uiU+/2BoTWvFv6BtNXJLsbXto0AecieV51hGrRHApc0W0oK
         AKDd5ccES9nCqkyb3sEOo9gGkt8t/JIUlhufDmDiKj42q3VSQgkOKio0j0D+QOvESTvR
         vWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONQAntTAACJE0IJDBpBlglBaprB61LRkMC27jTtksx0=;
        b=QhqKnRzMasbU3dKDb4VN7n8d+C6UlN4ALzQQ+DP+uH3zir2ymCzB55tvnVm824KmOO
         glrfQRmHr7Pdl3OKq9aziRiwd5q3kfXz7a3H1+Db0Lc39iRQCrDVbThqMBb823lkjhjZ
         ZonahqEqYfDr4j4tfnP5Im8bpPD7fy+/Uu5RL2hS7qxPBk2P5RCK6L72f86eszjw3Df3
         oRfyNVsG25DTvJZ2R87snCuL6pv0SUGW66IHKnLsDch5a9IJGhIDqc+rh0gnveNI4gyZ
         GRQU3J4pzwBCRlOJ05Lym+qA04im8o1lI5nswG9z1cbFIX0D0ocHvuZzbV/jGs3yxeXZ
         WyuA==
X-Gm-Message-State: APjAAAXJeZkh4DCMMS4TO4mFYbkhZGztvSfv8l8ANTRF0ifgxj+mBedh
        v6PvNOR7jnbS1jHZb83iRgRaKBkz+RuNqA==
X-Google-Smtp-Source: APXvYqx7vlN0mt8dTaicMB4mPcru21xjCNakkthzCjeuNniouoxjWhyZuDTtm34L5t03+GaZ9w1NKA==
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr39832028lfm.120.1560327132871;
        Wed, 12 Jun 2019 01:12:12 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id z6sm3605218lfa.45.2019.06.12.01.12.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:12:12 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 1/3] drivers: media: i2c: fix warning same module names
Date:   Wed, 12 Jun 2019 10:12:08 +0200
Message-Id: <20190612081208.1550-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_VIDEO_ADV7511 and CONFIG_DRM_I2C_ADV7511
enabled as loadable modules, we see the following warning:

warning: same module names found:
  drivers/gpu/drm/bridge/adv7511/adv7511.ko
  drivers/media/i2c/adv7511.ko

Rework so the names matches the config fragment.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/media/i2c/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
index d8ad9dad495d..b71a427a89fd 100644
--- a/drivers/media/i2c/Makefile
+++ b/drivers/media/i2c/Makefile
@@ -35,7 +35,8 @@ obj-$(CONFIG_VIDEO_ADV748X) += adv748x/
 obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
 obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
 obj-$(CONFIG_VIDEO_AD9389B) += ad9389b.o
-obj-$(CONFIG_VIDEO_ADV7511) += adv7511.o
+obj-$(CONFIG_VIDEO_ADV7511) += video-adv7511.o
+video-adv7511-objs          := adv7511.o
 obj-$(CONFIG_VIDEO_VPX3220) += vpx3220.o
 obj-$(CONFIG_VIDEO_VS6624)  += vs6624.o
 obj-$(CONFIG_VIDEO_BT819) += bt819.o
-- 
2.20.1

