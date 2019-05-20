Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50850C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252FD20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DEW9DDW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389632AbfETMty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:49:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35779 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbfETMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:21:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so7155238pfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 05:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bw14u18P9i//6PFBBpNeMD35DBcnBuJpaE6hMWzLBZ0=;
        b=DEW9DDW/wDzXrs3KiwiET14pKxALowECFZwPPv5wWj+6ZDqkA2+QErtIdqmxXurA7x
         8nR8MzsJHo17x2Nn79nFOrSPNYMZN8MfSnoiJJz7TBRQjlvqsrsKGtAfWaF/Sh6oURg3
         SN1lGIPJY69X8/HNa3mT7VZTyzNnA2gT2UFjmL7Iz4iIHqkUJbaOYpYNMguMOPyicZKL
         7x7Y68GYN4KPeBv3vRaC6o2I5RYmSqVeCIg8Lby57s/2piyKWvwTaXItSsOib9WHcoWs
         4mJjBytXKSFnmY72ltqNJUGwGE+fqUBGqVVY9lRturZUiTBxQSkOVLGb7VLXR7n20zFD
         JAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bw14u18P9i//6PFBBpNeMD35DBcnBuJpaE6hMWzLBZ0=;
        b=fIZSG2PuMN22LBcFmfPM5Q8W2RGcvfxtMHkowUlgf/ZkJBLrtymlAVwQAAS1Av3CzD
         UcxTsMglXtKP2M3xUjodeLzPaal255n7su7yTfjsIu0G6v2Xy+Xg4+1IsNb9EdSm7EWC
         LT+3lZrPZZrXJESu0eyPNFx5NISIhT3sJdWpl7a/f3+iqQ6rA9+qi4zCsxJOELe7OExI
         SDHXvYEvLjIchEc8oodS9Pwiqgu3pvVvvdMrDf903Cl4OAeQZaneEzLL2HHulJAvg4wU
         No2RL4xzHM8LRSCfczAVtzN0VK9mnG4OrEzM4Hpph/am701Q/zzbtYc8Pt1TwOpqxvwK
         fDnQ==
X-Gm-Message-State: APjAAAXY9fY93grA8JBw+/oWHUOXYRxmNchgPrhsEqtffsksujXqwXGR
        1WGdJNch7KxSkusIqCldnbRCug==
X-Google-Smtp-Source: APXvYqzKDB1HQoyZ8U0WjJ0MSo/CQPwAF839cuWrudmxHBCb6F2wVORX+7KlKaCqim0PhCgM8AAUKQ==
X-Received: by 2002:a65:5c41:: with SMTP id v1mr211402pgr.20.1558354878332;
        Mon, 20 May 2019 05:21:18 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id n27sm38137077pfb.129.2019.05.20.05.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 05:21:17 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date:   Mon, 20 May 2019 17:50:15 +0530
Message-Id: <1558354817-12034-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558354817-12034-1-git-send-email-sagar.kadam@sifive.com>
References: <1558354817-12034-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FU540-C000 specific device tree bindings to already
available i2-ocores file. This device is available on
HiFive Unleashed Rev A00 board. Move interrupt and interrupt
parents under optional property list as these can be optional.

The FU540-C000 SoC from sifive, has an Opencore's I2C block
reimplementation.

The DT compatibility string for this IP is present in HDL and available at.
https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/i2c/I2C.scala#L73

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index 17bef9a..b73960e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -2,8 +2,11 @@ Device tree configuration for i2c-ocores
 
 Required properties:
 - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
+                    "sifive,fu540-c000-i2c" or "sifive,i2c0".
+		    for Opencore based I2C IP block reimplemented in
+		    FU540-C000 SoC.Please refer sifive-blocks-ip-versioning.txt
+		    for additional details.
 - reg             : bus address start and address range size of device
-- interrupts      : interrupt number
 - clocks          : handle to the controller clock; see the note below.
                     Mutually exclusive with opencores,ip-clock-frequency
 - opencores,ip-clock-frequency: frequency of the controller clock in Hz;
@@ -12,6 +15,8 @@ Required properties:
 - #size-cells     : should be <0>
 
 Optional properties:
+- interrupt-parent: handle to interrupt controller.
+- interrupts      : interrupt number.
 - clock-frequency : frequency of bus clock in Hz; see the note below.
                     Defaults to 100 KHz when the property is not specified
 - reg-shift       : device register offsets are shifted by this value
-- 
1.9.1

