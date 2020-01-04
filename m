Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05EEC3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC5D2464E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578148439;
	bh=TY8tzadhRyiJ6+S1IFp9ZYRMnkPDrC1RoiunO5LgB3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QwQ4aSxAhpt4EGOZElGzU1gxYVP2cjL+zJqRMU9WU9S32GHvc6libONC3tj6yjs5n
	 3VSGButY59wgebUZ0xl3r86OBqdPo3ofebil9pKGniCU71gPwY6Q9TRnMyzZKmUf2D
	 FQLUjUZtpFFqul6SBqyOA7u5c9MV2t8vwDXkeYJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgADOd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 09:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgADOd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 09:33:56 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4BF24650;
        Sat,  4 Jan 2020 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578148435;
        bh=TY8tzadhRyiJ6+S1IFp9ZYRMnkPDrC1RoiunO5LgB3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/5NW7iBG/d4QgIy1WyJTcdeH0ztNQ9r+ckTUdumvRnwJ3uMwNeU5PVeFINfR9q+2
         ZQ10jQdHJhWATTHnyNN9/69lByNGIjwKWklV7+f2wh2Bs2gEZpy40VzgFkl2xm7lEF
         UqTjUYicIhqkelz91dInmz75uL89vBxCiVGmNkXY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] ide: qd65xx: Fix cast to pointer from integer of different size
Date:   Sat,  4 Jan 2020 15:33:48 +0100
Message-Id: <20200104143348.27842-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104143348.27842-1-krzk@kernel.org>
References: <20200104143348.27842-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integer passed as pointer to drvdata should be cast to unsigned long to
avoid warning (compile testing on alpha architecture):

    drivers/ide/qd65xx.c: In function ‘qd6580_init_dev’:
    drivers/ide/qd65xx.c:312:27: warning:
        cast to pointer from integer of different size [-Wint-to-pointer-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Only compile tested
---
 drivers/ide/qd65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/qd65xx.c b/drivers/ide/qd65xx.c
index 6ce318ebd0cc..ab79b6289464 100644
--- a/drivers/ide/qd65xx.c
+++ b/drivers/ide/qd65xx.c
@@ -299,7 +299,7 @@ static void __init qd6500_init_dev(ide_drive_t *drive)
 static void __init qd6580_init_dev(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	u16 t1, t2;
+	unsigned long t1, t2;
 	u8 base = (hwif->config_data & 0xff00) >> 8;
 	u8 config = QD_CONFIG(hwif);
 
-- 
2.17.1

