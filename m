Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AA8C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26943222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="PpYMhXia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLKWQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:16:07 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:47774 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfLKWQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sx3Dytgqo5C+LNgqXY0egoOHqywNzW6n4++zd/PfXlA=; b=PpYMhXiaBJRY9ys2JzWWpmQIR/
        +nUqDnHHwken4irEMXl/nEDqbATvFcUukdcf6jF7oW2USqBawzAWoHhdGWevrEN63DHa1rWWPfjnq
        gER33pTGB9imiF5u/FDWlQKgMttA7tHY03vF+I+Kvc9gYe2vj1cgHfQkG1db21iHJP4I=;
Received: from p200300ccff0c6f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:6f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ifAH5-0002OO-G1; Wed, 11 Dec 2019 23:16:03 +0100
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1ifAH5-0007fY-5c; Wed, 11 Dec 2019 23:16:03 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lgirdwood@gmail.com, broonie@kernel.org, b.galvani@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] regulator: rn5t618: fix module aliases
Date:   Wed, 11 Dec 2019 23:16:00 +0100
Message-Id: <20191211221600.29438-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform device aliases were missing, preventing
autoloading of module.

Fixes: 811b700630ff ("regulator: rn5t618: add driver for Ricoh RN5T618 regulators")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/rn5t618-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index 4a91be0ad5ae..5c12d57be040 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -148,6 +148,7 @@ static struct platform_driver rn5t618_regulator_driver = {
 
 module_platform_driver(rn5t618_regulator_driver);
 
+MODULE_ALIAS("platform:rn5t618-regulator");
 MODULE_AUTHOR("Beniamino Galvani <b.galvani@gmail.com>");
 MODULE_DESCRIPTION("RN5T618 regulator driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

