Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46ACC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83223206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 10:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="AE8bLTOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405116AbfHWKbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:31:53 -0400
Received: from vps.xff.cz ([195.181.215.36]:52664 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390779AbfHWKbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1566556307; bh=aV9HCPL2dWHEvC4yV8gUMeG+A7RjDzsVcU9TnfVEEvo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=AE8bLTOahfLkvWgkklCbF9ZCJq+vb40VaQZK+O+q5SBVGQ0jAcsXRFG9D6p6QSnaF
         LV08z3eoFXfN/sfe0GQPO2H2JD1DK8n/qK+zSGrgFASW9vH0hsIxCVOYG369B9kjDy
         WaeRclL6+8c+Gusxoeqq6TPLA7sb2TPj+r/BFR4o=
From:   megous@megous.com
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, Ondrej Jirman <megous@megous.com>
Subject: [RESEND PATCH 3/5] bluetooth: hci_bcm: Give more time to come out of reset
Date:   Fri, 23 Aug 2019 12:31:37 +0200
Message-Id: <20190823103139.17687-4-megous@megous.com>
In-Reply-To: <20190823103139.17687-1-megous@megous.com>
References: <20190823103139.17687-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Some supported devices need more time to come out of reset (eg.
BCM4345C5 in AP6256).

I don't have/found a datasheet, so the value was arrive at
experimentally with the Oprange Pi 3 board. Without increased delay,
I got intermittent failures during probe. This is a Bluetooth 5.0
device, so maybe that's why it takes longer to initialize than the
others.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 95c312ae94cf..7646636f2d18 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -260,7 +260,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	}
 
 	/* wait for device to power on and come out of reset */
-	usleep_range(10000, 20000);
+	usleep_range(100000, 120000);
 
 	dev->res_enabled = powered;
 
-- 
2.23.0

