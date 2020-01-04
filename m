Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552BDC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2EE24654
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578148436;
	bh=+CZsw4P4VZGl7fEe5o8XsbJqKOGkBgvwPlejrzQsNYA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LEAQ3f6A9D/KEXkyHiqAzOh07CR2XSDX6ahkkvPstASXlyOdFlx19HPOEDdQT5ss2
	 txfxPHvFbbgK/aZfTmTZjmO/vk+JcNaJMgcpFVrTRCUQJ6nNoWhnnkwc4i7Qig4XUr
	 kwpTcXLjNO588pxhL1nDRE3e2hQu1NbWr+MKwoGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgADOdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:33:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgADOdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:33:54 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC6432464E;
        Sat,  4 Jan 2020 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578148434;
        bh=+CZsw4P4VZGl7fEe5o8XsbJqKOGkBgvwPlejrzQsNYA=;
        h=From:To:Cc:Subject:Date:From;
        b=gN63Yo1TBrVz6wg/uF9MQNL8VEI+I6/qc46wwnFJp67QjsuAuU53tT3iNAeIduiZF
         rLZjCCKR+yyxagHAtij1Js/wwkHfx4z4KuYlJuMdOaXOu3Uw5dhkN1GdUMS+qV1olm
         EJR3HSBdJaC49E5WjCoYuWm/w5UgOmfzPkmNexno=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] ide: ht6560b: Fix cast to pointer from integer of different size
Date:   Sat,  4 Jan 2020 15:33:47 +0100
Message-Id: <20200104143348.27842-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integer passed as pointer to drvdata should be cast to unsigned long to
avoid warning (compile testing on alpha architecture):

    drivers/ide/ht6560b.c: In function ‘ht6560b_init_dev’:
    drivers/ide/ht6560b.c:318:27: warning:
        cast to pointer from integer of different size [-Wint-to-pointer-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Only compile tested
---
 drivers/ide/ht6560b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ht6560b.c b/drivers/ide/ht6560b.c
index 0dae65ac7d6d..743bc3693ac8 100644
--- a/drivers/ide/ht6560b.c
+++ b/drivers/ide/ht6560b.c
@@ -310,7 +310,7 @@ static void __init ht6560b_init_dev(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	/* Setting default configurations for drives. */
-	int t = (HT_CONFIG_DEFAULT << 8) | HT_TIMING_DEFAULT;
+	unsigned long t = (HT_CONFIG_DEFAULT << 8) | HT_TIMING_DEFAULT;
 
 	if (hwif->channel)
 		t |= (HT_SECONDARY_IF << 8);
-- 
2.17.1

