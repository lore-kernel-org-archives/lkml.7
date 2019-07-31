Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172B92089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cjOwxm2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfGaMkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:40:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46313 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfGaMkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:40:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so69484257wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2d9mGASGzMpInrSoJK0V8OGQfPk83dPTb4eOOdfv+U=;
        b=cjOwxm2J/7H51Ue5ov5AkJjESWQHWHlWqPj80RJZF+rAsemKIeCRLVrCvsmYRZRPyx
         ai1kqq28s01F6DZZolLYzlyEsG0DPguOTNU1Y5snSDKYQsxwWZzi2GzHnwu48YaYCs8I
         SajOodxGJ+wZLA1Tb8Dx/dX2zeAdmKVOZhe2itPGxpUeCD2SBDHIeF6RD6vEgD3F3/dY
         it8PdVRoc6LTQ/uRDlOoRR5PHEqOc5vYZesekudOefn9Y/emCeO4lhtU2o0pd721sn6M
         RL6kJiM94e4CCRY0xqygSdK42upKAtOf9JkA/bBx4aBAci/a8ZuwEsGK2MGpYWcMFXeG
         2ZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2d9mGASGzMpInrSoJK0V8OGQfPk83dPTb4eOOdfv+U=;
        b=sbJpp9qfrYRe/+tpl/XdJeOr6BqXckmKx+/yUudu4gpjjZQso6AI8eth3x1qkFSxDE
         rvKtZWBW0DvzMSTdahhba90z0avC0GwkDCYhekMKIAQc/8n4exk+A2U85IkjjYcKJl33
         Q1bwm7Y+kYx1rc6yqiK9V029Q8GcZFoUd3xzDUglTJU4aLk2hfIExuzMXgutCFEZDE3x
         /fktbtIiKTjE7VMU0Vn35hwJPihB1E9fxesEd3jJQ8Sfv3KO0iAo2S3f0qBT5fqKdHIO
         ke2meR7fGyYQuo+Hc1agP140ErP2rBSbbuXY5ZtpihqZvnowbPx3f2MDdWvYiQ234kSb
         YWPw==
X-Gm-Message-State: APjAAAV8Ob1f4962s4GJ/8C4bEMmJLFvOgDTEmyWWuZZx1bvwMNCAGww
        IwrD4s+PJjpgIAPFuTEpOTo/vQ==
X-Google-Smtp-Source: APXvYqwykNgEFzibUKyYi02YlbDi0YMTvNF6eGkL7v//QXPpj15O1pF8qsk6YQ8aZWO8v8MUMTsJEw==
X-Received: by 2002:adf:db50:: with SMTP id f16mr125512065wrj.214.1564576804558;
        Wed, 31 Jul 2019 05:40:04 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm62504271wmg.46.2019.07.31.05.40.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:40:04 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/6] soc: amlogic: meson-gx-socinfo: add A311D id
Date:   Wed, 31 Jul 2019 14:39:55 +0200
Message-Id: <20190731124000.22072-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124000.22072-1-narmstrong@baylibre.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

Add the SoC ID for the A311D Amlogic SoC.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index bca34954518e..ff86a75939e8 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -65,6 +65,7 @@ static const struct meson_gx_package_id {
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905X2", 0x28, 0x40, 0xf0 },
 	{ "S922X", 0x29, 0x40, 0xf0 },
+	{ "A311D", 0x29, 0x10, 0xf0 },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.22.0

