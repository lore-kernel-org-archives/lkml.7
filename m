Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B5C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E64216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nN24I3Kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfEUEp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:45:58 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:41790 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfEUEp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:45:58 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x4L4iwCe021907;
        Tue, 21 May 2019 13:44:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x4L4iwCe021907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558413899;
        bh=N88lxtbnzchnuln3kdpCsIRtX8wQQcLnnyr12+pyEA4=;
        h=From:To:Cc:Subject:Date:From;
        b=nN24I3KcaWzO4XVgA/xvocOFaAthUzPFxiSIjfSsLehlAsUZU4jGu2yxWLX/ALLBF
         IxNjldFTcUBGajHM5nDe/+4dK/Ps6TiO1PpvEgDqDoEE3hfLM6meVgv66oBExTF0lc
         GAnMgw55aiGyb+IH+jGTTHGkYPUWM9U5hjh+O23e0JkHLXVPH2lZRO1sq8bkz/vMiq
         /UkGXBJZ3IrWxUccP06WAu8ZpY33s0/l8NX00PMooZFxX3CP9aL0Kk/U/AkMgjBb4b
         usYZ0gmIZZSxqgRu7sK8eGUB5P6eGh8Y2HuN9xMk09ZeeICFUBlGF5gsnzyZTTRWA4
         gWVxoPFmzsozQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (smsc47m1) fix outside array bounds warnings
Date:   Tue, 21 May 2019 13:44:56 +0900
Message-Id: <20190521044456.26431-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild test robot reports outside array bounds warnings:

  CC [M]  drivers/hwmon/smsc47m1.o
drivers/hwmon/smsc47m1.c: In function 'fan_div_store':
drivers/hwmon/smsc47m1.c:370:49: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
  tmp = 192 - (old_div * (192 - data->fan_preload[nr])
                                ~~~~~~~~~~~~~~~~~^~~~
drivers/hwmon/smsc47m1.c:372:19: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
  data->fan_preload[nr] = clamp_val(tmp, 0, 191);
  ~~~~~~~~~~~~~~~~~^~~~
drivers/hwmon/smsc47m1.c:373:53: warning: array subscript [0, 2] is outside array bounds of 'const u8[3]' {aka 'const unsigned char[3]'} [-Warray-bounds]
  smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
                             ~~~~~~~~~~~~~~~~~~~~~~~~^~~~

The index field in the SENSOR_DEVICE_ATTR_R* defines is 0, 1, or 2.
However, the compiler never knows the fact that the default in the
switch statement is unreachable.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/hwmon/smsc47m1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 5f92eab24c62..e00102e05666 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -364,6 +364,10 @@ static ssize_t fan_div_store(struct device *dev,
 		tmp |= data->fan_div[2] << 4;
 		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
 		break;
+	default:
+		WARN_ON(1);
+		mutex_unlock(&data->update_lock);
+		return -EINVAL;
 	}
 
 	/* Preserve fan min */
-- 
2.17.1

