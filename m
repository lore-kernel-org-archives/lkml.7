Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50680C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF6420409
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PdwBBOQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfKMS07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:26:59 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38082 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfKMS06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tqYhob/E5epp8M/KG4PYlFii+q6GD8g+aIml5ORUXbM=; b=PdwBBOQliKWOyoJdy1W9WixuaT
        7tLZk99hIt2MfRqgkT3BHWBh1Yx4UR5SWtH5ivhWBFAVizI77f5DCUrH5lG7kb9D6yYKH+HmsXHB6
        CKB6HX7l2l9ejvcuSjVKqDvu4zpJB52S9/43M4cvAJMXo+xmKjawqnE5cb/vezq5C9mQ=;
Received: from p5dcc3bb7.dip0.t-ipconnect.de ([93.204.59.183] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iUxM0-0001tL-HV; Wed, 13 Nov 2019 19:26:56 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1iUxM0-0006E1-5Y; Wed, 13 Nov 2019 19:26:56 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, phh@phh.me, b.galvani@gmail.com,
        stefan@agner.ch
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
Date:   Wed, 13 Nov 2019 19:26:43 +0100
Message-Id: <20191113182643.23885-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LDO9 and LDO10 were listed with the same enable bits.
That looks insane and there are no provisions in the code for handling such
a special case. Also other out-of-tree drivers use a separate bit to
enable it.
Example:
https://github.com/brunotl/kernel-kobo-mx6sl-ntx/blob/master/drivers/regulator/ricoh619-regulator.c
So it seems to be clearly a bug.
I cannot fully check it on my board without schematics and just discovered
this during code analysis for another problem.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/rn5t618-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index eb807a059479..4a91be0ad5ae 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -90,7 +90,7 @@ static const struct regulator_desc rc5t619_regulators[] = {
 	REG(LDO7, LDOEN1, BIT(6), LDO7DAC, 0x7f, 900000, 3500000, 25000),
 	REG(LDO8, LDOEN1, BIT(7), LDO8DAC, 0x7f, 900000, 3500000, 25000),
 	REG(LDO9, LDOEN2, BIT(0), LDO9DAC, 0x7f, 900000, 3500000, 25000),
-	REG(LDO10, LDOEN2, BIT(0), LDO10DAC, 0x7f, 900000, 3500000, 25000),
+	REG(LDO10, LDOEN2, BIT(1), LDO10DAC, 0x7f, 900000, 3500000, 25000),
 	/* LDO RTC */
 	REG(LDORTC1, LDOEN2, BIT(4), LDORTCDAC, 0x7f, 1700000, 3500000, 25000),
 	REG(LDORTC2, LDOEN2, BIT(5), LDORTC2DAC, 0x7f, 900000, 3500000, 25000),
-- 
2.20.1

