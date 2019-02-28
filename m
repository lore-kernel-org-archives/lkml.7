Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB92218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQYF78lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbfB1Q5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:57:51 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39271 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1Q5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:57:50 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so16717036iti.4;
        Thu, 28 Feb 2019 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x41NJ0M0ISDzhYINLlifVt4BbR61KBJ/mAc80ss8IoM=;
        b=YQYF78lrGPsYxhuaUpB/soQHL/mxFq2aawL35kg/ylxXrIsnF0lkwu8PtkUsJDnkYX
         epMQfletN5eMwfcyTjmgk5FwavCEPA50EHT8CG7+IpzCmvn4sf5Z5IHzLyGLHc0VDYAT
         cP7yIENl0F92W2IynViWQQ8ZT0D3IiHKf4Bb0Yel20An49MgbdzNHw/LXlsx67gsx803
         tmSt2j/3MaDsXQLBu4ynLhRxNE7/mX8LpoEAZpWHeXaA3ZPWq1jLK/jekQKF58T775Gz
         VTglJ6VJk8Jo+XQ+VcEuX7J/zyElRUbIcvthqztCt5g0BvIWLG+QREz4+e1b4lTHAC5d
         rvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x41NJ0M0ISDzhYINLlifVt4BbR61KBJ/mAc80ss8IoM=;
        b=tinJAM9sJBHA7CST/8wC5pEJLacOQx85ykTOmKSZs1lnU1YseHweNl/2E2Znn4LGoT
         F4uA1BOzb7KEkDvar5aAT88SK8nxb/6+Bmyg7GDasrrqp6lCcVHGLE+k4erDaGNS/X4t
         2kgbAOdMxr2ESKLB8aTNZDuJ6AcGF1BoFuwgQwdtTsPgsUHXwsjF3LM+8LcxL7g9xw5Q
         5DqWyn4a8PYtvdu5PH6P7Iwd2NzhIUEvw8Ie6dSrbn1YCuihdztJ/701XqEiEjtAIip0
         WyJm5JYEf4MIqr/LDFStxt8mW7Z8B6tXRiwvegcEcKMvoFoBvHL0KYRM47B1bjdY/NoW
         GbhQ==
X-Gm-Message-State: APjAAAW2iqC9Mr84/YcOKubiGqOwtE4O9cmebC2BSrEw6kJ0gxBvZLhP
        iLW8oA7DI3RImyJLWIXmkw==
X-Google-Smtp-Source: APXvYqwo2t7j0cyTmH9GrD8qumynxckpywfk+/YGLiq3e+IDJb974ksOHYq2DsGzUBKDqdrSFWn9fg==
X-Received: by 2002:a02:7e87:: with SMTP id g7mr295jae.92.1551373069987;
        Thu, 28 Feb 2019 08:57:49 -0800 (PST)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id v8sm7226147iop.42.2019.02.28.08.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:57:49 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:57:30 -0500
From:   Robert Yang <decatf@gmail.com>
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH] mfd: tps65910: Properly disable the power on state
Message-ID: <20190228165730.GA14387@r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the tps65910/1 datasheets under "Device POWER ON Disable Conditions".
There are four conditions which can disable power on:
Long press interrupt (PWRON_LP_IT) OR thermal trip OR DEV_OFF bit OR
DEV_OFF_RST bit.

The Ouya game console has TPS65911. Before this patch the device will not
power off through the pm_power_off call. The power light stays on and the
device heatsink is warm. Long pressing the power button can power off the
device. After this patch the device powers off correctly when calling power
off through userspace software.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 drivers/mfd/tps65910.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index aa3d472a10ff..c067dcacbe61 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -445,8 +445,12 @@ static void tps65910_power_off(void)
 			DEVCTRL_PWR_OFF_MASK) < 0)
 		return;
 
-	tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
-			DEVCTRL_DEV_ON_MASK);
+	if (tps65910_reg_clear_bits(tps65910, TPS65910_DEVCTRL,
+			DEVCTRL_DEV_ON_MASK) < 0)
+		return;
+
+	tps65910_reg_set_bits(tps65910, TPS65910_DEVCTRL,
+		DEVCTRL_DEV_OFF_MASK);
 }
 
 static int tps65910_i2c_probe(struct i2c_client *i2c,
-- 
2.17.1

