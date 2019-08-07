Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAFCC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936462086D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 19:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAbyL2kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfHGTXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:23:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52892 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfHGTXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 15:23:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so11956wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 12:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKsoxc607/oVG4FUuBA6pIcOKMffd677oTtTK5nzkwQ=;
        b=hAbyL2kbAFr/v1igXbo/LxpM6rdjv8gVdpmorEKD5FUrB1ZYcimF1qaQyLZMb6TYhW
         QzjkRAErG1RegaWbCDdgGVUKwymrAJ/l+pGyRNvoPbXDKXge8tgQSb/geI+cOWjnRCmF
         7S+MdI3tJIe3MxAgCLb1JPFwc7Iw0cXhq+bepW2li//lnMzfGH0Xze2qLht+6u85znTJ
         b9RL7RNC9Ed/4MNuYeQ6PkUu8BWDc32Q97oGYvVmVAdzCrr6ofUU9a39FOw7h1OGyn1n
         +sByh2bvE5LGEsst6gBAnGXTGpX7uyB2s6FVWLRXQJYOabz+3oz+SyUV5D9QlPrf8+2j
         A9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKsoxc607/oVG4FUuBA6pIcOKMffd677oTtTK5nzkwQ=;
        b=BBtk6gS0DDmlkaxP86wYfRGBpQ8ZZuM5nCJaoyjgx04lnNWXQiCm0P8yXxwWyKjpyU
         cJAMODmxwzwepglG+zRkmeLtmBdLKS6zIPYyBTWY3iVkaC5tCgh3CtmB+JlBQK90PyqE
         IAsbUKj1GpOHaDPuD607fg6y9GwpSVczGuQHsx0rr6PUS68M2Brgyq/WoSNiTsPfj64p
         cSneP0SAMDTAwTp0Q4ZDV9ruU4uTIIkcgug93Mj6syd844wAoMLNg/bdtW6JQq8S9c2q
         q604HQCNbgJ4apZ8b3eNfA2/mAB7w1cDN4bCNlp6gpSOJBz+D8fXo09FvuDy45IiUT82
         cVkQ==
X-Gm-Message-State: APjAAAXcx/viJhwcN+HJRn8UMh9TRF7yLgyUDThiY7RrjD/y8nzsz3XV
        mmHFIXbyPaVpNDU95viIJYw=
X-Google-Smtp-Source: APXvYqzrB/Ac6gK6PxwJ5f0X0aWnErXK6rJNnENn30REBvhx246EotYXNh2vR//dxdH43icmi3BPGw==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr21203wma.34.1565205821315;
        Wed, 07 Aug 2019 12:23:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id t13sm109820555wrr.0.2019.08.07.12.23.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 12:23:40 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "kernelci . org bot" <bot@kernelci.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] phy-rockchip-inno-hdmi: Fix RK3328_TERM_RESISTOR_CALIB_SPEED_7_0's third value
Date:   Wed,  7 Aug 2019 12:23:05 -0700
Message-Id: <20190807192305.6604-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit "linux/bits.h: Add compile time sanity check of GENMASK
inputs" [1], arm64 defconfig builds started failing:

In file included from ../include/linux/bits.h:22,
                 from ../include/linux/bitops.h:5,
                 from ../include/linux/kernel.h:12,
                 from ../include/linux/clk.h:13,
                 from ../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:9:
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c: In function 'inno_hdmi_phy_rk3328_power_on':
../include/linux/build_bug.h:16:45: error: negative width in bit-field '<anonymous>'
   16 | #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
      |                                             ^
../include/linux/bits.h:24:18: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
   24 |  ((unsigned long)BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |                  ^~~~~~~~~~~~~~~~~
../include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   39 |  (GENMASK_INPUT_CHECK(high, low) + __GENMASK(high, low))
      |   ^~~~~~~~~~~~~~~~~~~
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:24:42: note: in expansion of macro 'GENMASK'
   24 | #define UPDATE(x, h, l)  (((x) << (l)) & GENMASK((h), (l)))
      |                                          ^~~~~~~
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:201:50: note: in expansion of macro 'UPDATE'
  201 | #define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)  UPDATE(x, 7, 9)
      |                                                  ^~~~~~
../drivers/phy/rockchip/phy-rockchip-inno-hdmi.c:1046:26: note: in expansion of macro 'RK3328_TERM_RESISTOR_CALIB_SPEED_7_0'
 1046 |   inno_write(inno, 0xc6, RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(v));
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As pointed out by Robin and Guenter, inno_write's val argument is an
8-bit value so having a mask larger than that doesn't make sense. This
also matches the rest of the *_7_0 macros in this driver.

[1]: https://lore.kernel.org/lkml/20190801230358.4193-2-rikard.falkeborn@gmail.com/

Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index b10a84cab4a7..2b97fb1185a0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -198,7 +198,7 @@
 #define RK3328_BYPASS_TERM_RESISTOR_CALIB		BIT(7)
 #define RK3328_TERM_RESISTOR_CALIB_SPEED_14_8(x)	UPDATE((x) >> 8, 6, 0)
 /* REG:0xc6 */
-#define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)		UPDATE(x, 7, 9)
+#define RK3328_TERM_RESISTOR_CALIB_SPEED_7_0(x)		UPDATE(x, 7, 0)
 /* REG:0xc7 */
 #define RK3328_TERM_RESISTOR_50				UPDATE(0, 2, 1)
 #define RK3328_TERM_RESISTOR_62_5			UPDATE(1, 2, 1)
-- 
2.23.0.rc1

