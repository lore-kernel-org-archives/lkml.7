Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304C6C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED21E205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330067;
	bh=DDpCkessD1dH3aLZ3m3+GnJ5ar8B5dcualD5Zvo0mos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E659umaAPLqxRA4k3mC1rH/w+bE8JDjtkBKPrXoXc1dUOwoJwAHWU8ir4RFwCNDZI
	 hNUOUbrbj68UDRONgid7Z+AUaRyF/FlNVYCTWkFr6LcHXBZXo14gMI5Ob9uOz5fcNO
	 z7SEQPj950rpfhQ3utaaJ2lJRGX2zGYg+VksANv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfD0Bjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727736AbfD0Bjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB904208CB;
        Sat, 27 Apr 2019 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329185;
        bh=DDpCkessD1dH3aLZ3m3+GnJ5ar8B5dcualD5Zvo0mos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HoeKEi7pNIC+15XtlVJPKhiMijoklz268nzUY9Zj3/+zCm7IKl8a4tsJfh6qEekvq
         LQI7bBPtxlXdJdwupbahZH2CMNBjzoRYFAnueE0TzGRuKSE7svwtMvR1wXH4xWq7dv
         skIgZqxXQhbFczsh+w+oxPe/6C812bYaBZo9sY4k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 42/79] ASoC: cs35l35: Disable regulators on driver removal
Date:   Fri, 26 Apr 2019 21:38:01 -0400
Message-Id: <20190427013838.6596-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 47c4cc08cb5b34e93ab337b924c5ede77ca3c936 ]

The chips main power supplies VA and VP are enabled during probe but
then never disabled, this will cause warnings from the regulator
framework on driver removal. Fix this by adding a remove callback and
disabling the supplies, whilst doing so follow best practice and put the
chip back into reset as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l35.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 9f4a59871cee..c71696146c5e 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1635,6 +1635,16 @@ err:
 	return ret;
 }
 
+static int cs35l35_i2c_remove(struct i2c_client *i2c_client)
+{
+	struct cs35l35_private *cs35l35 = i2c_get_clientdata(i2c_client);
+
+	regulator_bulk_disable(cs35l35->num_supplies, cs35l35->supplies);
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 0);
+
+	return 0;
+}
+
 static const struct of_device_id cs35l35_of_match[] = {
 	{.compatible = "cirrus,cs35l35"},
 	{},
@@ -1655,6 +1665,7 @@ static struct i2c_driver cs35l35_i2c_driver = {
 	},
 	.id_table = cs35l35_id,
 	.probe = cs35l35_i2c_probe,
+	.remove = cs35l35_i2c_remove,
 };
 
 module_i2c_driver(cs35l35_i2c_driver);
-- 
2.19.1

