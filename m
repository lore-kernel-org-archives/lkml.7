Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F11C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCE72184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DEK3e7jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfCNNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:50:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36600 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCNNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:50:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so1383180wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 06:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LopwxDimRT8UjyEYLKdAqKMp3HyHxeVVB6mLtEYK2Pg=;
        b=DEK3e7jXnx99b+eK6vj424kE8CI5tN/CLiNyjBVJ18/VABvP911FtXthdLqTHmqsKX
         z+rE5vXM55cY9r4xuv205zn6gwUONqfphvFtket9SqkAVLCKK04iW9MfE2zCRYl8wyZ6
         shz7MU1wR74gXNfXPsexZLOgMXvjYOp0WMfee1ruxEUGo7PiYE9Dzwg449BcmEhyyWQ1
         QOcQDJtvA9o6dWef3TfopSC05US2cbVmkW5Rl0nCLKXyWq8VGvzegNpTTww5f1d8M0jF
         LZ44RKAkfxq3QtG5rPc6cwVyp+wMb1+iR+gsRpXPwt0NBu02xOvGqLu64uJVQxsW2n3m
         ETlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LopwxDimRT8UjyEYLKdAqKMp3HyHxeVVB6mLtEYK2Pg=;
        b=owqGEY9s5vzkb1178Qj6u14Bot2mYEw+l49F3WO43g2kHE2lNx/UarAy2BhmjewSbW
         I1IILOuy2wlhenCwmgxS4LfhckC/hY9l3Yuc2ol2bGFbJPv2nihnITtxSr2QT7ilTwXn
         NxGwNYgruSgq2dyoUZMSFRkTURb0aZEB9DPWqqQnU7SEh7O6oRfDjll4UNJB/sjrqZTi
         kX8kfVDyfUSSuOvLtiXIqjFYP4EFFV6UQZ0iJQ4I8QwnuVH6AccKV91uacemKRMvbo29
         BO9wkzd2eFmUOhHqKlPTWSzyMamEf69kKIHhz+lxBVecsXtBHJyrmZgr0aYoS5Qq0w8l
         q9Bg==
X-Gm-Message-State: APjAAAWmptUblkAXgk5fSU0swFynIOCk3db27yLxQwIolM4fecYKX6kp
        jq/yrWJ8tlvXX4t2czrsbwyD/Q==
X-Google-Smtp-Source: APXvYqx/kBNzg0o902tB4RLR8XzW5YSFoBpOwlFon0LDhyLKRvqEPlgLXja/PTNtp+PohvLWIvWXsQ==
X-Received: by 2002:a5d:6643:: with SMTP id f3mr11213036wrw.120.1552571399328;
        Thu, 14 Mar 2019 06:49:59 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y8sm12079963wrm.8.2019.03.14.06.49.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 06:49:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: meson-gxl: fix interrupt support
Date:   Thu, 14 Mar 2019 14:49:45 +0100
Message-Id: <20190314134945.17300-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an interrupt is already pending when the interrupt is enabled on the
GXL phy, no IRQ will ever be triggered.

The fix is simply to make sure pending IRQs are cleared before setting
up the irq mask.

Fixes: cf127ff20af1 ("net: phy: meson-gxl: add interrupt support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index a238388eb1a5..0eec2913c289 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -201,6 +201,7 @@ static int meson_gxl_ack_interrupt(struct phy_device *phydev)
 static int meson_gxl_config_intr(struct phy_device *phydev)
 {
 	u16 val;
+	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		val = INTSRC_ANEG_PR
@@ -213,6 +214,11 @@ static int meson_gxl_config_intr(struct phy_device *phydev)
 		val = 0;
 	}
 
+	/* Ack any pending IRQ */
+	ret = meson_gxl_ack_interrupt(phydev);
+	if (ret)
+		return ret;
+
 	return phy_write(phydev, INTSRC_MASK, val);
 }
 
-- 
2.20.1

