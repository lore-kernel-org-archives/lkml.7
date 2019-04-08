Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F675C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C62C20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="UQt9/PLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDHMJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:09:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33585 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfDHMJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:09:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so7244465pgh.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Hf/kpgwZ2qM6jXGMP2EvodaY2K1UQLCGs+stRQgYXmQ=;
        b=UQt9/PLaJk0iXiPpSAPSt4vtiNKvM1BgfdUlA0HPkAazDvuOttZlGJ6Twzfqpj++Bw
         FI2cd8wPV6H47jc8VpTSCON1L5G81ffzSuh3Rw8C/17GdHDFsqVLHIlw252Ul0ICaMC3
         vfu+IyXXZQ/LkFQbuuHdKQR1yoUurZ/htMn9c+stkQTpQo4o5U6MBUcc4FrckTjO0x6V
         bqTCRJKkDJCncu5jPvp+TdaCye9sD1iLytDQRvybdyMNXYCDXWs3KIzrzrMsCNchcS2W
         xEBMsf2JGXlXxfZ2V+IZCbMt5XmdTF7abKTZbphSK/SD4skUiIhbLliF9GHuYVjmAd4j
         oa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hf/kpgwZ2qM6jXGMP2EvodaY2K1UQLCGs+stRQgYXmQ=;
        b=ezTjVT0I2YdZuZKHWv4vY0I74wtxTwDn7yH6+awPwatAFVZGC8izimVkTSd77teTDm
         4tcONMYKPHYMyq//DtPwiD0OSNKQpkyb85cOhdi8LAhjf3u5LrFfJlwE2wEoXwSigMDv
         YSghkv09+CM0ggLs5yRcDQeDtClyzdnwyw7xGEmaJ6MYHXE0F04NdGSweJY8wChjXD+t
         l1UcjnGdpqXdg71OZS9zhrM67mJZ3igfgAmdA/2UFt/SJPJ5MmVCd1nqvn3jE2MIPeJy
         rF4eseYFiYStaN/bsd1CS+Y/klVFEhU2llJHDjrkRu9Ey+ggvQHbEN4VgRedrpd68TS8
         gceA==
X-Gm-Message-State: APjAAAWy9G+hsyoNbIz8hYwsQ8kc3n4oCDfKB0u5HK9bpt+vdCLiC3wK
        fJsvWT7TIvlreT1RiW36TXWWZA==
X-Google-Smtp-Source: APXvYqyUc10mIUDtg6UMRtGdToeKyQbENT94NOiDP25oMoySOB8VeAxCuYWJXhVfWj1bfDjasdWe2w==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr29850801pfe.163.1554725386530;
        Mon, 08 Apr 2019 05:09:46 -0700 (PDT)
Received: from localhost.localdomain (36-239-234-159.dynamic-ip.hinet.net. [36.239.234.159])
        by smtp.gmail.com with ESMTPSA id a17sm50006562pfj.123.2019.04.08.05.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 05:09:45 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: hi655x: Constify regulators array
Date:   Mon,  8 Apr 2019 20:09:32 +0800
Message-Id: <20190408120933.29945-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulators array should never need to be modified, make it const so
compiler can put it to .rodata.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi655x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index bba24a6fdb1e..460ae70d8b04 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -158,7 +158,7 @@ static const struct regulator_ops hi655x_ldo_linear_ops = {
 	.ctrl_mask = cmask,                                      \
 }
 
-static struct hi655x_regulator regulators[] = {
+static const struct hi655x_regulator regulators[] = {
 	HI655X_LDO_LINEAR(LDO2, 0x72, 0x07, 0x29, 0x2a, 0x2b, 0x01,
 			  2500000, 8, 100000),
 	HI655X_LDO(LDO7, 0x78, 0x07, 0x29, 0x2a, 0x2b, 0x06, ldo7_voltages),
-- 
2.17.1

