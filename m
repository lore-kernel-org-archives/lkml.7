Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B097BC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CFE2668F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 10:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oqStfDIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfEaKdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 06:33:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53915 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfEaKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 06:33:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id d17so5739155wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByfPDgU22Z1U1XSrJRvjO9v2H1XpDQdjYxUHf9uqjyc=;
        b=oqStfDIlIvDhQcvg02CGqjgJ7Ao8oVncyoutW0cZjjWZ58BOJIESPVLfHcy1Z14EMG
         xEAxiq7yhKTu0YlXgoHnS5DqWjOrtmcOjkYtlo8sN85WUB5cpaLMYHaPAmVdBa1gYzl4
         3TdtYf/g2gLQfx4TkB6ZwxU5tAWDa875de3CK44we9z5lnWpAg3qLow3qvGZyw5fqByI
         anpgZCTe1MSQwrLWQN95Aut0KAj+F2NHlcWIwvI8QSqxoyAo6kt0Q7Ea7VZEK7STuA7y
         CaztDXWqWndS69y4O++k2U3ZO0XDlOC8Om/r1jB1ND2Lvb1tpftUFKO5Pgsvb2/KN+K8
         sxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ByfPDgU22Z1U1XSrJRvjO9v2H1XpDQdjYxUHf9uqjyc=;
        b=Ui6iRC0xzVmzxzxMj/B41+TLcwxZLCfjIHKpByq7zi4o2agQgL5M9/zcOeyfVqfdi5
         Npobnag+ki6U/p4lqZGxEQYldPbvNsVlWhaZPYfG+SQG3YWQlhBTNLNtjO5dh/B6jUR9
         XTlkLly7ANShuPIq9em2oHTOx3yLpLbAnyfnw6YdLnC9H2ifXBuC4rXkCD63gPkKqrPl
         Rb9ULv1c8QVU0YlJgtb04TdUMGrdhp5BahPN2HNrX3g4R2362dhZV1VEks88d9z73zCU
         PUXlEtbmDfk9UEpAouwj+w/zOf6KbfUXB8asWDA8FXg/kz6coSgos3GNpNQLNitOx0cU
         weCA==
X-Gm-Message-State: APjAAAX+y6rqVRkOGEtpLze1z8E3QyRUP+hwDy4RuMV/3WZ6djsCQOr1
        1LlNPuYmeWQOckOkgXICa4dqcg==
X-Google-Smtp-Source: APXvYqzjri4jLx4G/XNJBs9hd4fjiKEFHxhfjCQjKElQHrV/S/VVwy5aVTcTRF646Me7ACF6VyIlqA==
X-Received: by 2002:a05:600c:22cc:: with SMTP id 12mr5271222wmg.141.1559298798562;
        Fri, 31 May 2019 03:33:18 -0700 (PDT)
Received: from bender.home (amarseille-652-1-291-131.w109-208.abo.wanadoo.fr. [109.208.94.131])
        by smtp.gmail.com with ESMTPSA id h14sm4038960wro.3.2019.05.31.03.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 May 2019 03:33:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-media@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: ao-cec-g12a: disable regmap fast_io for cec bus regmap
Date:   Fri, 31 May 2019 12:33:15 +0200
Message-Id: <20190531103315.15166-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With fast_io enabled, spinlock_irq is used for read/write operations,
thus leading to :
BUG: sleeping function called from invalid context at [snip]/ao-cec-g12a.c:379
 in_atomic(): 1, irqs_disabled(): 128, pid: 1451, name: irq/14-ff800280
[snip]
Call trace:
 dump_backtrace+0x0/0x180
 show_stack+0x14/0x1c
 dump_stack+0xa8/0xe0
 ___might_sleep+0xf4/0x104
 __might_sleep+0x4c/0x80
 meson_ao_cec_g12a_read+0x7c/0x164
 regmap_read+0x16c/0x1b0
 meson_ao_cec_g12a_irq_thread+0xcc/0x200
 irq_thread_fn+0x2c/0x60
 irq_thread+0x14c/0x1fc
 kthread+0x11c/0x12c
 ret_from_fork+0x10/0x18

Simply remove fast_io to use mutexes instead.

Fixes: b7778c46683c ("media: platform: meson: Add Amlogic Meson G12A AO CEC Controller driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/media/platform/meson/ao-cec-g12a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/meson/ao-cec-g12a.c b/drivers/media/platform/meson/ao-cec-g12a.c
index 3620a1e310f5..ddfd060625da 100644
--- a/drivers/media/platform/meson/ao-cec-g12a.c
+++ b/drivers/media/platform/meson/ao-cec-g12a.c
@@ -415,7 +415,6 @@ static const struct regmap_config meson_ao_cec_g12a_cec_regmap_conf = {
 	.reg_read = meson_ao_cec_g12a_read,
 	.reg_write = meson_ao_cec_g12a_write,
 	.max_register = 0xffff,
-	.fast_io = true,
 };
 
 static inline void
-- 
2.21.0

