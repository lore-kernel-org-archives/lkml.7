Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D8AC32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D43A21873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PWgHHS0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbfHHDmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:42:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42659 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbfHHDmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:42:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so42964970plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 20:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5jMXrFkjRDxZEak/KeRUnh4UCld5MbB91tFVhNYMLPw=;
        b=PWgHHS0qNOhHpCy5KKESZ4GVaCpzQ+fl/ugAs1shJwv7WXYzrXDC7SuAoKMP9VU/tx
         o04A/xw4LcenrEqFf2azeE7WFh2Ewno/7aBRVYv+JJAN8JPRO3h+Kk1LzvAi4JmTiG7X
         z3sn+cKYOGXQUyRqRjEdXPuAqqtsUuaLJeW+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5jMXrFkjRDxZEak/KeRUnh4UCld5MbB91tFVhNYMLPw=;
        b=I3JSgEUBXgZrBt5Vblwzl/d9bTFB9IIkvgyddjh+UEnMnL+IxDFMpKR0wnXdfb3Nvw
         qvupfajwe2XLC3zSX3HpdC28V/BH4oY9Q6IvNYTrG0pyFal2uJU/8daHRl3wSN6yd640
         NL2BHf4JMpjIP+bbS0OJsLWtys/39sFTDcAvAxKDaSiA9aWLHoeonPCc5xEhTSgAhdwj
         M56hkP1axKMwHeDdpWzohv9Pe4mj477DXaL3/MMbdsVq4s6riba5xlxXgROhXdp41X+2
         88svzEHW91/Z87Vy0js827iuSjillWZar1uBEVS1Q+nm1OfaMOHaRtVq9PjOsKwN1tpk
         vJuw==
X-Gm-Message-State: APjAAAW/ZtUnPuHrd/UlQ0MZVnFSieF3B3HpDJ7SLYsEl0Z6ujGg4KF3
        L6OECkLEafty4jAtUTyiCj++Ow==
X-Google-Smtp-Source: APXvYqzJDoCufDWHxxbnj+8ZDUw1mT0489ya33GQJzf7bEfLt/OiDvuJEym/afEPtn37iqiNDeuFOg==
X-Received: by 2002:a17:902:b415:: with SMTP id x21mr11335513plr.287.1565235723861;
        Wed, 07 Aug 2019 20:42:03 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y14sm46425482pge.7.2019.08.07.20.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 20:42:03 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lori Hikichi <lori.hikichi@broadcom.com>
Subject: [PATCH v1 1/2] i2c: iproc: Stop advertising support of SMBUS quick cmd
Date:   Thu,  8 Aug 2019 09:07:52 +0530
Message-Id: <1565235473-28461-2-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
References: <1565235473-28461-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lori Hikichi <lori.hikichi@broadcom.com>

The driver does not support the SMBUS Quick command so remove the
flag that indicates that level of support.
By default the i2c_detect tool uses the quick command to try and
detect devices at some bus addresses.  If the quick command is used
then we will not detect the device, even though it is present.

Fixes: e6e5dd3566e0 (i2c: iproc: Add Broadcom iProc I2C Driver)

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index d7fd76b..19ef2b0 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -790,7 +790,10 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	u32 val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	u32 val;
+
+	/* We do not support the SMBUS Quick command */
+	val = I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 
 	if (adap->algo->reg_slave)
 		val |= I2C_FUNC_SLAVE;
-- 
1.9.1

