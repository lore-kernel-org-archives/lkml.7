Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E23C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C0026508
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="mcpXksvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfEaH2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:28:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42883 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaH2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:28:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so5751743wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 00:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=349bO3eKWo36+YLW2izUvQ+NabomJ8/oiHBTBWo5iAw=;
        b=mcpXksvNecWmEad6A9O9z6z4TbMSb38IaPy5U9xh/ChgB21Cn7Ccj8gUOXoFOHUIVr
         8mNjkfFvOSL0xKKy7NQH8LCQa2sP7PeOiupRiyM38ynt6Y0bt4awXv+yW1K7Pj0ySX8C
         cfSPhYYQ8mjrwUcIVOraaVm5DNxJdZjn+gsP9OkOJXYwVd1D+iAX+kvUz8bDglVqrIFb
         ZFNBy0lMWFCbgNTyED0DxqosqhZy8WCPY5Yv1R0wL+H3IwC0W4w8cFhfcHUCtOQdcq9b
         Vjx//oFgvMqrM1ziw3xjhK6qyHexSr1jfpbkVl/VkVhlR+gJ9eL1h8SZ19Hbns2KLNjK
         ljQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=349bO3eKWo36+YLW2izUvQ+NabomJ8/oiHBTBWo5iAw=;
        b=kXAbvBlFnFJHD96uct92BlzPkycmP8233VaQGBz49hQs3Ycu8TFVadfB8VBVJcDmtn
         H/sWgX8UpUMJfIsAdtlPXW+S6rBvwgIy9BwLkFg0YtvVyR7EQ7gztC6oy03nbSM50ubi
         fVmZKL2iEFpH8XKxSCgn/c9CZHikyZf1QQWiOew8QBgX+0m735MQ5lhHIk7k6Q0zv+Ad
         bkmfH1XiduX8vmm2EkbVvUMrLHnWuwDBJ15fm2JLCjA17C1S8hIrfVe7zHpF8prf9nE7
         IucJVHfPjQsoYnJsg7wqfPSjwxu3nwqrjAkjqh/5XVp8D3XjidhbBlG/6CIHyLWv+p5h
         b79Q==
X-Gm-Message-State: APjAAAUtGj3S8eJ4EN/blwX4Ng8vOmm3gJDiY+Vn0sDmlPrfHc0pokaz
        bV/hD3P2hOpARGghcGhsyzdkTN57IUU=
X-Google-Smtp-Source: APXvYqzRSlmRgkwS8ktZa2OrrW3pe+Ou5C7Zfpqnk9FCgMzvRD6oVAi63eIdPX6etNJnqABbaTVj5w==
X-Received: by 2002:adf:e584:: with SMTP id l4mr5319382wrm.54.1559287693057;
        Fri, 31 May 2019 00:28:13 -0700 (PDT)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id u9sm11324302wme.48.2019.05.31.00.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 00:28:12 -0700 (PDT)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] net: dsa: mv88e6xxx: avoid error message on remove from VLAN 0
Date:   Fri, 31 May 2019 10:27:07 +0300
Message-Id: <20190531072707.1755-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When non-bridged, non-vlan'ed mv88e6xxx port is moving down, error
message is logged:

failed to kill vid 0081/0 for device eth_cu_1000_4

This is caused by call from __vlan_vid_del() with vin set to zero, over
call chain this results into _mv88e6xxx_port_vlan_del() called with
vid=0, and mv88e6xxx_vtu_get() called from there returns -EINVAL.

On symmetric path moving port up, call goes through
mv88e6xxx_port_vlan_prepare() that calls mv88e6xxx_port_check_hw_vlan()
that returns -EOPNOTSUPP for zero vid.

This patch changes mv88e6xxx_vtu_get() to also return -EOPNOTSUPP for
zero vid, then this error code is explicitly cleared in
dsa_slave_vlan_rx_kill_vid() and error message is no longer logged.
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 28414db979b0..6b77fde5f0e4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1392,7 +1392,7 @@ static int mv88e6xxx_vtu_get(struct mv88e6xxx_chip *chip, u16 vid,
 	int err;
 
 	if (!vid)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	entry->vid = vid - 1;
 	entry->valid = false;
-- 
2.11.0

