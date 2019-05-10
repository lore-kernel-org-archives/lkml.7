Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C87BC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E383A217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOb1wsCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfEJTrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:47:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40570 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbfEJTrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:47:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so3750839pfn.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IfPcXD1akliETnngX4RzbCUAQNSW0aGhkf05F42prOc=;
        b=uOb1wsCHOTCPuTsT4oj2wJ1whujJT0Ta1RswwxJPmVcmjL/t6Wdl7NfEO8bapXq1iO
         7cKjTHxVXxhTt2F4ks+vVv7NayRQ7aOFlJJrY2NdHiAE4cD6A68QPoeeT9dgAv5MhhYW
         OCRt8XeHL3tSa/74r2xHY8s+KIJs2sk/A1llqqTCX7ab8Bf+H47htAHqWdT3mojTfoZk
         jZRoR/mYx7Xiud1AlSREjavwaH/HMQ+FgYSNB3659Jj/jNVs58/A3T3YOHdvF5o8Eo4a
         Cn8X/XFFflCMwZRRI/oInMrhk5M48cI0srrpgsQXo0IJazS6UXWu2a4rvbwsHL4xPSDA
         onPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IfPcXD1akliETnngX4RzbCUAQNSW0aGhkf05F42prOc=;
        b=dlectsQ0WqYHQr7ft8sywWI+NK7ObPRR/QJr63vVqutfGRotbnSZ106uh/u4M2TtcH
         QkcUWWoqh4xG5c8uMggf1L0a16G22LcFlqaNJkU5IeipArgSSwkObZmFDW6JQmmqz7Rz
         Ek8ZumRJ7Iflf8s2b8jBr7nm50x2CS31r7df0g4WYKRYh0h/GhsBOoNC/Un0/xxKs0QE
         zwHFYrv/Cf6QJIxmQGSIPpq9Z/Bagw4Lr6TZ3rrJyytUKKvf3/aFUCPy4gYmaXInM2fj
         +2A8almMfm6/Q8atI++Jh0ELejWnNKNbzTUtXjaRpeuzaULTVJfA6dsVN3YWSmbDx/MK
         XoAw==
X-Gm-Message-State: APjAAAXTeQUjWSM0TxVkE4mNKNL8Sn1NtD+6zKm1CLqQbe5QWPXOLB5I
        UrxrF+XCzu/CbvMwFyoOM4JDeOSf
X-Google-Smtp-Source: APXvYqyayuWOzBLJH++KmMAsGgrvzKSWRUD4vKDrwcwt8DOfEjtC+k1fu3AlmfUzAZ5rkc8hBLPBjw==
X-Received: by 2002:a62:d286:: with SMTP id c128mr17141448pfg.159.1557517641213;
        Fri, 10 May 2019 12:47:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z125sm10388377pfb.75.2019.05.10.12.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 12:47:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: bcm: brcmstb: biuctrl: Register writes require a barrier
Date:   Fri, 10 May 2019 12:46:30 -0700
Message-Id: <20190510194633.9761-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BIUCTRL register writes require that a data barrier be inserted
after comitting the write to the register for the block to latch in the
recently written values. Reads have no such requirement and are not
changed.

Fixes: 34642650e5bc ("soc: Move brcmstb to bcm/brcmstb")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index c16273b31b94..20b63bee5b09 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -56,7 +56,7 @@ static inline void cbc_writel(u32 val, int reg)
 	if (offset == -1)
 		return;
 
-	writel_relaxed(val,  cpubiuctrl_base + offset);
+	writel(val, cpubiuctrl_base + offset);
 }
 
 enum cpubiuctrl_regs {
-- 
2.17.1

